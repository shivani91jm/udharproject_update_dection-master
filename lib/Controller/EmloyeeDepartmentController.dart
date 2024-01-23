import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Contents/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:udharproject/model/DeparmentList/DeparmentInfoModel.dart';

class EmloyeeDepartmentController extends GetxController{
  final TextEditingController empIDcontroller = TextEditingController();
  final TextEditingController DateOfJoinController = TextEditingController();
  final TextEditingController DesignationController = TextEditingController();
  final TextEditingController DepartmentController = TextEditingController();
  final TextEditingController UANController = TextEditingController();
  final TextEditingController ESINOController = TextEditingController();
  var isLoading=false.obs;
  final _formkey = GlobalKey<FormState>();
  Rx<DateTime> selectedDatess = DateTime.now().obs;
  List<DeparmentInfo> departmentLis = <DeparmentInfo>[].obs;
  var departmentName="".obs;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    empIDcontroller.dispose();
    DateOfJoinController.dispose();
    DesignationController.dispose();
    DepartmentController.dispose();
    UANController.dispose();
    ESINOController.dispose();
  }
  void UpdateEmployeeDeatils(BuildContext context,String staff_id,String salary_payment_type, GlobalKey<FormState> formkey) async
  {

    if(formkey.currentState!.validate())
      {
        isLoading.value=true;
        SharedPreferences prefsdf = await SharedPreferences.getInstance();
        var token= prefsdf.getString("token").toString();
        var assign_to_owner_id = prefsdf.getString("user_id").toString();
        var  assgin_to_bussinesses_id = prefsdf.getString("bussiness_id").toString();
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            var body = jsonEncode(<String, String>{
              'staff_id':staff_id,
              'business_man_id':assign_to_owner_id,
              'business_id':assgin_to_bussinesses_id,
              'designation':DesignationController.text,
              'department_name':DepartmentController.text,
              'una_nubmer':UANController.text,
              'esi_number':ESINOController.text,
              'salary_payment_type':salary_payment_type,
              'date': DateFormat('dd/MM/yyyy').format(selectedDatess.value)
            });
            print("body res" + body.toString());
            final response = await http.post(Uri.parse(Urls.StaffDayListDelinaton), headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
                body: body
            );
            if (response.statusCode == 200) {
              isLoading.value=false;
              // print("data" + response.body.toString());
              var ressss=jsonDecode(response.body);
              if(ressss['response']=="true")
              {

                Fluttertoast.showToast(
                    msg: "New Staff Information added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColors.drakColorTheme,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

              }
              else
              {
                var msg=ressss['msg'];
                Fluttertoast.showToast(
                    msg: ""+msg,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.deepPurpleAccent,
                    textColor: AppColors.white,
                    fontSize: 16.0
                );
              }
              print("resss"+ressss.toString());
            }
            else if (response.statusCode == 401) {
              isLoading.value=false;
              print("data" + response.body.toString());
              Fluttertoast.showToast(
                  msg: "Session Expired!!...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
            }
            else if (response.statusCode == 500) {
              isLoading.value=false;
              print("data" + response.body.toString());
              Fluttertoast.showToast(
                  msg: "Server Side Error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
            else {
              isLoading.value=false;
              print("data" + response.body.toString());

            }
          }
        }
        on SocketException catch (_) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: Text("Checking..", style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),),
                    content: Text(
                      "No Internet", style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),),
                    actions: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: new Text("ok", style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent,
                          ),),
                        ),
                      ),
                    ]);
              }
          );
        }
      }
  }

  void selectJoiningDateMthod(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDatess.value,
        firstDate: DateTime(1800),
        lastDate: DateTime(2900),
        selectableDayPredicate: (DateTime date) {
          // Disable current date and upcoming dates
          return date.isBefore(DateTime.now());
        }
    );
    if (selectedDate != null) {
          selectedDatess.value = selectedDate;
        }
  }
  //------------------------------------add Department ------------------------------------
    void AddDeparmentMethod(BuildContext context) async
    {
      SharedPreferences prefsdf = await SharedPreferences.getInstance();
      var token= prefsdf.getString("token").toString();
      var assign_to_owner_id = prefsdf.getString("user_id").toString();
      var assgin_to_bussinesses_id = prefsdf.getString("bussiness_id").toString();
      try{
        var _futureLogin = BooksApi.addDepartmment(context,token,assign_to_owner_id,assgin_to_bussinesses_id,DepartmentController.text);
        if (_futureLogin != null) {
          _futureLogin!.then((value) {
            var res = value.response.toString();
            if (res == "true") {
              update();
              Navigator.pop(context,"Cancel");

            }
          });
        }
      }catch( e)
      {
        print("error"+e.toString());
      }
    }

    //----------------------------show Department List ---------------------------------

  void ShowDeparmentMethod(BuildContext context) async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();
    var assign_to_owner_id = prefsdf.getString("user_id").toString();
    var assgin_to_bussinesses_id = prefsdf.getString("bussiness_id").toString();
    try{
      var _futureLogin = BooksApi.showDepartmment(context,token,assign_to_owner_id,assgin_to_bussinesses_id);
      if (_futureLogin != null)
      {
        _futureLogin!.then((value) {
          var res = value.response.toString();
          if (res == "true") {
            if(value.info!=null) {
              departmentLis = value.info!;
            }

          }
        });
      }
    }
    catch( e)
    {
      print("error"+e.toString());
    }
  }



}