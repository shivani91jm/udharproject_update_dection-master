import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Contents/Urls.dart';
import 'package:http/http.dart' as http;

class StaffAttendanceMothlyWiseController extends GetxController{
  TextEditingController et_addressOne = TextEditingController();
  TextEditingController et_addressOptional = TextEditingController();
  TextEditingController et_bussiness= TextEditingController();
  TextEditingController et_mobile = TextEditingController();
  Rx<DateTime> selectedDatess = DateTime.now().obs;
  RxBool isLoading=false.obs;
  //---------------------------update staff normal Details--------------------------------------------
   void UpdateStaffDeatils(BuildContext context,String staff_id) async
   {
     isLoading.value=true;
     SharedPreferences prefsdf = await SharedPreferences.getInstance();
     var token= prefsdf.getString("token").toString();
     try {
       final result = await InternetAddress.lookup('google.com');
       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         var body = jsonEncode(<String, String>{
           'user_id': staff_id,
           'name': et_bussiness.text,
           'dob': DateFormat('yyyy-MM-dd').format(selectedDatess.value!),
           'mobile': et_mobile.text,
           'address': et_addressOne.text,
           'gender': selected.value
         });
         print("body res" + body.toString());
         final response = await http.post(Uri.parse(Urls.UpdateStaffDetails), headers: <String, String>{
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
                   msg: "Update Profile",
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.CENTER,
                   timeInSecForIosWeb: 1,
                   backgroundColor: Colors.deepPurpleAccent,
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
                   textColor: Colors.white,
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

//--------------------------date picker value-----------------------------------------------

  void selectDateMthod(BuildContext context) async {
     final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDatess.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: (DateTime date) {
          // Disable current date and upcoming dates
          return date.isBefore(DateTime.now());
        }
    );
     if (selectedDate != null) {
      selectedDatess.value = selectedDate;
    }
  }
  //--------------------gender value check---------------------------
  var selected = "Female".obs;
  RxList<String> items = ['Male', 'Female', 'Other'].obs;

}