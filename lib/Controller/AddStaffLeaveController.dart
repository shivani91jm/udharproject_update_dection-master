import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Contents/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/LeaveCatAddModel/LeaveCatAddInfo.dart';
import 'package:udharproject/model/LeaveCatAddModel/LeaveCatAddModelClass.dart';
import 'package:udharproject/model/StaffDelete/StaffDeleteModel.dart';

class AddStaffLeaveController extends GetxController{
  BuildContext? context = Get.key.currentContext;
  RxBool isLoading=false.obs;
  RxList<LeaveCatAddInfo> leaveList=<LeaveCatAddInfo>[].obs;
  RxBool isSwitched = false.obs;
  final et_leaveName=TextEditingController();
  final et_reason=TextEditingController();

  RxBool leaveFlag=false.obs;
  Rx<DateTime> formDatess=DateTime.now().obs;
  Rx<DateTime> toDatess=DateTime.now().obs;
  final formkey = GlobalKey<FormState>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    showStaffLeaveCat();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  //========================add leave ==================
  void addStaffLeaveCat(String name,String status,String cat_id) async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();
    var  bussiness_id=prefsdf.getString("bussiness_id").toString();
    var  businessman_id=prefsdf.getString("user_id").toString();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "business_man_id":businessman_id,
          "name": name,
          "business_id":bussiness_id,
          "status":status,
          "id":cat_id
        });
        print("res body"+body.toString());

        final response = await http.post(Uri.parse(Urls.staffAddLeave), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
            body: body
        );
        if (response.statusCode == 200) {
           isLoading.value=false;
           LeaveCatAddModel res =LeaveCatAddModel.fromJson(jsonDecode(response.body));
           print("vdbvsbd"+res.response.toString());
           if(res!=null)
             {
               var info= res.response;
               var msg=res.msg;
               if(info=="true")
                 {
                   Fluttertoast.showToast(
                       msg:" Add Successfully",
                       toastLength: Toast.LENGTH_SHORT,
                       gravity: ToastGravity.CENTER,
                       timeInSecForIosWeb: 1,
                       backgroundColor: AppColors.drakColorTheme,
                       textColor: AppColors.white,
                       fontSize: AppSize.medium
                   );
                   Navigator.pushNamed(context!, RoutesNamess.businessmandashboard);
                   showStaffLeaveCat();
                 }
               else
                 {
                   Fluttertoast.showToast(
                       msg: ""+msg.toString(),
                       toastLength: Toast.LENGTH_SHORT,
                       gravity: ToastGravity.CENTER,
                       timeInSecForIosWeb: 1,
                       backgroundColor: AppColors.drakColorTheme,
                       textColor: AppColors.white,
                       fontSize: AppSize.medium
                   );

                 }

             }
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
          Navigator.push(context!, MaterialPageRoute(builder: (context) => LoginPage()),);
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
           context: context!,
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
  //============show leave list=========================================
  void showStaffLeaveCat() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();
    var  bussiness_id=prefsdf.getString("bussiness_id").toString();
    var  businessman_id=prefsdf.getString("user_id").toString();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "business_man_id":businessman_id,
          "business_id":bussiness_id,
        });
        print("res body"+body.toString());

        final response = await http.post(Uri.parse(Urls.staffShowLeave), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
            body: body
        );
        if (response.statusCode == 200) {
          isLoading.value=false;
          LeaveCatAddModel res =LeaveCatAddModel.fromJson(jsonDecode(response.body));
          print("vdbvsbd"+res.response.toString());
          if(res!=null)
          {
            var reso= res.response;
            var msg=res.msg;
            if(reso=="true")
            {
              leaveFlag=true.obs;
               leaveList.value=res.info!;
               print(""+leaveList.value.length.toString());
               leaveList.refresh();
            }
            else
            {
              leaveFlag=false.obs;
            }

          }

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
          Navigator.push(context!, MaterialPageRoute(builder: (context) => LoginPage()),);
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
          context: context!,
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

  //==========================status active and incative======================
  void toggleSwitch(bool value,String name,String cat_d) {
    print("value"+value.toString());
    isSwitched.value=value;
    addStaffLeaveCat(name,value.toString(),cat_d);


  }

  //============delete leave=========================
  void deleteStaffLeaveCat(String cat_id) async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "id":cat_id
        });
        print("res body"+body.toString());

        final response = await http.post(Uri.parse(Urls.staffDeleteLeave), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
            body: body
        );
        if (response.statusCode == 200) {
          isLoading.value=false;
          DeleteStaffModel res =DeleteStaffModel.fromJson(jsonDecode(response.body));
          print("vdbvsbd"+res.response.toString());
          if(res!=null)
          {
            var info= res.response;
            var msg=res.msg;
            if(info=="true")
            {
              Fluttertoast.showToast(
                  msg:" Delete Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.drakColorTheme,
                  textColor: AppColors.white,
                  fontSize: AppSize.medium
              );
              showStaffLeaveCat();
            }
            else
            {
              Fluttertoast.showToast(
                  msg: ""+msg.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.drakColorTheme,
                  textColor: AppColors.white,
                  fontSize: AppSize.medium
              );

            }

          }



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
          Navigator.push(context!, MaterialPageRoute(builder: (context) => LoginPage()),);
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
          context: context!,
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

  //================assign or request to leave ==========================
  void requestStaffLeaveCat(String status,String leave_id) async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();
    var  bussiness_id=prefsdf.getString("bussiness_id").toString();
    var business_owner=prefsdf.getString("businessman_id").toString();
    var staff_id=prefsdf.getString("staff_id").toString();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "status":status,
          "staff_id":staff_id,
          "owner_id":business_owner,
          "bussiness_id":bussiness_id,
          "leave_type":leave_id,
          "description":et_reason.text,
          "form_date":DateFormat('yyyy-MM-dd').format(formDatess.value),
          "to_date":DateFormat('yyyy-MM-dd').format(toDatess.value)
        });
        print("res body"+body.toString());

        final response = await http.post(Uri.parse(Urls.staffRequestLeave), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
            body: body
        );
        if (response.statusCode == 200) {
          isLoading.value=false;
          LeaveCatAddModel res =LeaveCatAddModel.fromJson(jsonDecode(response.body));
          print("vdbvsbd"+res.response.toString());
          if(res!=null)
          {
            var info= res.response;
            var msg=res.msg;
            if(info=="true")
            {
              Fluttertoast.showToast(
                  msg:" Add Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.drakColorTheme,
                  textColor: AppColors.white,
                  fontSize: AppSize.medium
              );
              showStaffLeaveCat();
            }
            else
            {
              Fluttertoast.showToast(
                  msg: ""+msg.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.drakColorTheme,
                  textColor: AppColors.white,
                  fontSize: AppSize.medium
              );

            }

          }
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
          Navigator.push(context!, MaterialPageRoute(builder: (context) => LoginPage()),);
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
          context: context!,
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
  //---------------form  date--------------------------------
  void selectFormDateMthod() async {
    final DateTime? picked = await showDatePicker(
      context: context!,
      initialDate: formDatess.value ?? DateTime.now(),
      firstDate:  formDatess.value,
      lastDate: DateTime(formDatess.value.year + 1),

    );

    if (picked != null) {
      formDatess.value = picked;
    }
  }
//==============to date ==========================
  void selectToDateMthod() async {
    final DateTime? picked = await showDatePicker(
      context: context!,
      initialDate: formDatess.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      formDatess.value = picked;
    }
  }


}