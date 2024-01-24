import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:udharproject/Activity/AddStaffScreenPage.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/model/AddNoteModel/AddNoteModelClass.dart';
import 'package:udharproject/model/AddOverTimeRateModel/AddOverTimeRateModel.dart';
import 'package:udharproject/model/AddPaymentStaff/AddpaymentStaffModel.dart';
import 'package:udharproject/model/AllowanceandBonus/BonusAndallowanceModelClass.dart';
import 'package:udharproject/model/AttendanceHistory/AttendanceHistoryModel.dart';
import 'package:udharproject/model/AttendanceModel/AttendanceModelClass.dart';

import 'package:udharproject/model/Book.dart';
import 'package:udharproject/model/BusinessInfoModel/BussinessInfomationModel.dart';
import 'package:udharproject/model/DayWiseStaffList/DayWiseStaffListModel.dart';
import 'package:udharproject/model/DeparmentList/DeparmentListModel.dart';
import 'package:udharproject/model/KYBDOC/KYBDocumentModelClass.dart';

import 'package:udharproject/model/LoginModelClass.dart';
import 'package:udharproject/Contents/Urls.dart';
import 'package:udharproject/model/MonthlyWiseAttendance/StaffMonthlyWiseAttendanceModel.dart';
import 'package:udharproject/model/MonthlyWiseStaffListModel/StaffListMonthyWiseModelCLass.dart';
import 'package:udharproject/model/OtpModel/OtpModelClasss.dart';
import 'package:udharproject/model/Registration/RegistartionModelResponse.dart';
import 'package:udharproject/model/ShowShiftrMorning/ShowShiffListModel.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialMedialLoginModel.dart';
import 'package:udharproject/model/StaffDelete/StaffDeleteModel.dart';
import 'package:udharproject/model/StaffDocs/StaffDocsModel.dart';
import 'package:udharproject/model/StaffJoiningMonth/StaffJoiningMonthClass.dart';
import 'package:udharproject/model/StaffList/StafflistModelData.dart';
import 'package:udharproject/model/StaffLoginModel/StaffMutipleStaffLoginModel.dart';
import 'package:udharproject/model/StaffSalaryCCalculation/StaffSalryCalculationModel.dart';
import 'package:udharproject/model/StateModelClass/StateModelClass.dart';
import 'package:udharproject/model/SubScritonModel/SubScriptionModelClass.dart';
import 'package:udharproject/model/stafflistattendance/StaffListDetailsFetchModel.dart';

class BooksApi {
  static Future<List<Book>> getBooks(String query) async {
    final url = Uri.parse(
        'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      return books.map((json) => Book.fromJson(json)).where((book) {
        final titleLower = book.title.toLowerCase();
        final authorLower = book.author.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  //------------------------------------Login Api--------------------------------------------------------------------------------
  static Future<LoginModelClass> createLoginPage(String email,BuildContext context) async {
    print('connected' + Urls.loginApi);
    LoginModelClass _apiResponse = new LoginModelClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        final response = await http.post(Uri.parse(Urls.loginApi),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': email,}),);
         print("data" + response.statusCode.toString());
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          print("datalogin" + jsonResponse.toString());

          return LoginModelClass.fromJson(jsonResponse);
        }
        else if(response.statusCode==401)
          {
               Map<String, dynamic> jsonResponse = jsonDecode(response.body);
             print("datalogin" + jsonResponse.toString());

               _apiResponse= LoginModelClass.fromJson(jsonResponse);
          }
        else if(response.statusCode==500) {
          Fluttertoast.showToast(
              msg: "Server Side Error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          print("datalogin" + jsonResponse.toString());

          _apiResponse= LoginModelClass.fromJson(jsonResponse);

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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //--------------------------------------Simaple Regitration ----------------------------------------------------------------------------
  static Future<Regitration> createRegistrationPage(String mobile, String email, String password, String business_name, String name, String number_of_staffs, String cal_monthly_salary, String hours_staff_work,BuildContext context) async
  {
    Regitration _apiResponse = new Regitration();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
     var body=   jsonEncode(<String, String>{
          'mobile': mobile,
          'email': email,
          'password': password,
          'business_name': business_name,
          'name': name,
          'number_of_staffs': number_of_staffs,
          'cal_monthly_salary': cal_monthly_salary,
          'hours_staff_work': hours_staff_work
        });
     print("body"+body);
        final response = await http.post(Uri.parse(Urls.RegistrationApi),

          headers: <String, String>
          {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);


        if (response.statusCode == 200) {
          print("data" + response.statusCode.toString());
          _apiResponse = Regitration.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = Regitration.fromJson(jsonDecode(response.body));
        }
        else if(response.statusCode==500)
          {
            _apiResponse = Regitration.fromJson(jsonDecode(response.body));
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
          print("data" + response.body.toString());
          _apiResponse = Regitration.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  //-----------------------------------facebook and google registration page--------------------------------------------------------------
  static Future<OTPModalClass> createFacebookRegistraion(String mobile, String email,String username,BuildContext context) async
  {
    OTPModalClass _apiResponse = new OTPModalClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await http.post(Uri.parse(Urls.SocialMediaRegistrationUrl),
          headers: <String, String>
          {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'mobile': mobile,
            'email': email,
            'password': "",
            'business_name': "",
            'name': username,
            'number_of_staffs': "",
            'cal_monthly_salary': "",
            'hours_staff_work': ""
          }),);

        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
        }
        else if(response.statusCode==500)
          {
            _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
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
          print("data" + response.body.toString());
          _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
        }
      }
    }
    on SocketException catch (_) {

    }
    return _apiResponse;
  }


//  --------------------------------------------Add Staff Api-----------------------------------------------

 static Future<SocialMediaLoginModel> addStaff(String name,String mobile,String password,String email,String salary_cycle,String salary_payment_type,String salary_amount,String assign_to_owner_id,String assgin_to_bussinesses_id,String token,BuildContext context,String image ) async{
   SocialMediaLoginModel _apiResponse = new SocialMediaLoginModel();
    try {

     final result = await InternetAddress.lookup('google.com');
     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
     {
       var body= jsonEncode(<String, String>{
         'name': name,
         'mobile': mobile,
         'password': password,
         'email': email,
         'salary_cycle': salary_cycle,
         'salary_payment_type': salary_payment_type,
         'salary_amount': salary_amount,
         "assign_to_owner_id": assign_to_owner_id,
         "assgin_to_bussinesses_id": assgin_to_bussinesses_id,
         "image": image
       });
       print("addstffbody"+body.toString());
       final response = await http.post(Uri.parse(Urls.AddStaff),
         headers: <String, String>
         {
           'Content-Type': 'application/json; charset=UTF-8',
             'Accept': 'application/json',
             'Authorization': 'Bearer $token',
         },
         body:body
       );

       if (response.statusCode == 200) {
         print("data" + response.body.toString());
         _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
       }
       else if (response.statusCode == 401) {
         print("data" + response.body.toString());

         _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));

         Fluttertoast.showToast(
             msg: "Your Token has expired!!!",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.deepPurpleAccent,
             textColor: Colors.white,
             fontSize: 16.0
         );
         Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
       }
       else if(response.statusCode==500)
       {
         _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
       var data=response.body.toString();

         print("data" + response.body.toString());
         _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  //---------------------------------------------------------------------------------------------------------------------------------
// --------------------------------- show bussiness list data--------------------------------------------------------------------
static Future<SocialMediaLoginModel>  bussinessListData(String user_id,String token,BuildContext context) async
{
  SocialMediaLoginModel _apiResponse=new SocialMediaLoginModel();
  try {

    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
    {
      final response = await http.post(Uri.parse(Urls.BussinessList),
        headers: <String, String>
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'user_id': user_id,
        }),);

      if (response.statusCode == 200) {
        print("data" + response.body.toString());
        _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {
        print("data" + response.body.toString());

        _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
        Fluttertoast.showToast(
            msg: "Your Token has expired!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
      }
      else if(response.statusCode==500)
      {
        print("data" + response.body.toString());
        _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
           print("data" + response.body.toString());
        _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
  return _apiResponse;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------

// ---------------------------------------------show staff list data-------------------------------------------------------------
static Future<StafflistModelClass> staffListData(String assign_to_owner_id,String assgin_to_bussinesses_id,String token,BuildContext context)  async{
  StafflistModelClass _apiResponse=new StafflistModelClass();
  try {

    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
    {
      final response = await http.post(Uri.parse(Urls.FetchStaffList),
        headers: <String, String>
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "assign_to_owner_id": assign_to_owner_id,
          "assgin_to_bussinesses_id": assgin_to_bussinesses_id
        }),);
      if (response.statusCode == 200) {
        print("data" + response.statusCode.toString());
        _apiResponse = StafflistModelClass.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {
        print("data" + response.body.toString());
        _apiResponse = StafflistModelClass.fromJson(jsonDecode(response.body));
        Fluttertoast.showToast(
            msg: "Your Token has expired!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
      }
      else if(response.statusCode==500)
      {
        _apiResponse = StafflistModelClass.fromJson(jsonDecode(response.body));
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
        var data=response.body.toString();
        print("data" + response.body.toString());
        _apiResponse = StafflistModelClass.fromJson(jsonDecode(response.body));
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
  return _apiResponse;
  }

  //---------------------------------------add bussiness man second time  api----------------------------------------------------------------

  static Future<SocialMediaLoginModel> addBussinessMan(String business_man_id,String hours_staff_work,String cal_monthly_salary,String number_of_staffs,String business_name,String token,BuildContext context) async{
    SocialMediaLoginModel _apiResponse = new SocialMediaLoginModel();
    try {

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var boys=jsonEncode(<String, String>{
          'business_man_id': business_man_id,
          'hours_staff_work': hours_staff_work,
          'cal_monthly_salary': cal_monthly_salary,
          'number_of_staffs': number_of_staffs,
          'business_name': business_name,
        });
        print("bodyres"+boys.toString());
        final response = await http.post(Uri.parse(Urls.AddBussiness),
          headers: <String, String>
          {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: boys
        );

        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());

          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));

          Fluttertoast.showToast(
              msg: "Your Token has expired!!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
          var data=response.body.toString();

          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------upload bussiness man document for kyc----------------------------------------------------------------
  static Future<KYBDocumentModel> uploadDocument(String profile_pic,String bank_docs,String accound_number,String bank_ifsc,String bank_branch,String bank_photo,String adhaar_docs,String adhaar_number,String adhaar_dob,String adhaar_photo_front,String adhaar_photo_back,String pan_docs,String pan_number,String pan_photo_front,String user_id,String gstno,String gstimage,String bussinessass,String token,BuildContext context,String holder_name,String uploaded_by,String upi_key)  async{
    KYBDocumentModel _apiResponse=new KYBDocumentModel();
    BuildContext? context=Get.context;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var url=Urls.UpdateStaffProfileDocs;
        var body=jsonEncode(<String, String>{
          "profile_pic": profile_pic,
          "accound_number" :accound_number,
          "bank_ifsc": bank_ifsc,
          "bank_branch": bank_branch,
          "bank_photo": bank_docs,
          "pan_photo_backend": pan_docs,
          "adhaar_number": adhaar_number,
          "adhaar_dob": adhaar_dob,
          "adhaar_photo_front": adhaar_photo_front,
          "adhaar_photo_back" : adhaar_photo_back,
          "pan_number": pan_number,
          "pan_photo_front": pan_photo_front,
          "user_id": user_id,
          "gst_number": gstno,
          "gst_photo":gstimage,
          "business_address": bussinessass,
          "holder_name":holder_name,
          "uploaded_by": uploaded_by,
          "upi_key":upi_key
        });
        print("body"+body.toString());
        final response = await http.post(Uri.parse(url),
          headers: <String, String>
          {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body,);

        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = KYBDocumentModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());

          _apiResponse = KYBDocumentModel.fromJson(jsonDecode(response.body));

          Navigator.push(context!, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = KYBDocumentModel.fromJson(jsonDecode(response.body));
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
          var data=response.body.toString();
          print("data" + response.body.toString());
          _apiResponse = KYBDocumentModel.fromJson(jsonDecode(response.body));
        }
      }
    }
    on SocketException catch (_) {
        Fluttertoast.showToast(
         msg: "Check Connection!!",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.deepPurpleAccent,
         textColor: Colors.white,
         fontSize: 16.0
     );
    }
    return _apiResponse;

  }
  //--------------------------------------------------------------------------------------------------------------------------------
  //--------------------------------------------bussiness man information--------------------------------------------------------
static Future<BussinessInfomationModel> businessman(String business_user_id, String token,BuildContext context ) async{
  BussinessInfomationModel _apiResponse=new BussinessInfomationModel();
  try {

    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
    { print("token "+token);
      final response = await http.post(Uri.parse(Urls.BussinessInfo),

        headers: <String, String>
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "business_user_id": business_user_id
        }),);

      if (response.statusCode == 200) {
        print("data" + response.body.toString());
        _apiResponse = BussinessInfomationModel.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {
        print("data" + response.body.toString());

        _apiResponse = BussinessInfomationModel.fromJson(jsonDecode(response.body));
        Fluttertoast.showToast(
            msg: "Your Token has expired!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
      }
      else if(response.statusCode==500)
      {
        _apiResponse = BussinessInfomationModel.fromJson(jsonDecode(response.body));
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
        print("data" + response.body.toString());
        _apiResponse = BussinessInfomationModel.fromJson(jsonDecode(response.body));
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
  return _apiResponse;
}
//-------------------------------------------------------------------------------------------------------------------------------------
  //----------------------------------muitple staff login list api---------------------------------------------------------------------
static Future<StaffMutipleLoginModel> mutiplestaffloginlist(String assign_to_owner_id, String token,BuildContext context ) async{
  StaffMutipleLoginModel _apiResponse=new StaffMutipleLoginModel();
  try {

    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
    {
      final response = await http.post(Uri.parse(Urls.MutipleStaffLoginUrl),
        headers: <String, String>
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "assign_to_owner_id": assign_to_owner_id
        }),);

      if (response.statusCode == 200) {
        print("data" + response.body.toString());
        _apiResponse = StaffMutipleLoginModel.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {
        print("data" + response.body.toString());

        _apiResponse = StaffMutipleLoginModel.fromJson(jsonDecode(response.body));
        Fluttertoast.showToast(
            msg: "Your Token has expired!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
      }
      else if(response.statusCode==500)
      {
        _apiResponse = StaffMutipleLoginModel.fromJson(jsonDecode(response.body));
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
        print("data" + response.body.toString());
        _apiResponse = StaffMutipleLoginModel.fromJson(jsonDecode(response.body));
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
  return _apiResponse;
}
//------------------------------------- social media login --------------------------------------------------------------------------
static Future<SocialMediaLoginModel> socialmedialloginpage(String mobileOrEmail, BuildContext context ) async{
  SocialMediaLoginModel _apiResponse=new SocialMediaLoginModel();
  try {

    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
    {
      final response = await http.post(Uri.parse(Urls.SocialMediaLoginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': mobileOrEmail,}),);
      if (response.statusCode == 200) {
        print("data" + response.body.toString());
        _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {

        _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
        Fluttertoast.showToast(
            msg: "Your Token has expired!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
      }
      else if(response.statusCode==500)
      {
        _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
        print("data" + response.body.toString());
        _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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

  return _apiResponse;
}

//-------------------------------------verify social media api------------------------------------------------------------
static Future<OTPModalClass> socialmedialverifyapi(String bussiness_man_id,BuildContext context)async
{

  OTPModalClass _apiResponse=new OTPModalClass();
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
    {
      final response = await http.post(Uri.parse(Urls.SocialMediaVerifyUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_id": bussiness_man_id
        }),);

      if (response.statusCode == 200) {
        print("data" + response.body.toString());
        _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {
        print("data" + response.body.toString());
        _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));

        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
      }
      else if(response.statusCode==500)
      {
        _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
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
          print("data" + response.body.toString());
        _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
  return _apiResponse;
}

//----------------------------------------verify simple login otp --------------------------------------------------------
 static Future<OTPModalClass> verifyOtpPage(String email, String otp,BuildContext context) async
  {
    OTPModalClass _apiResponse=new OTPModalClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.post(Uri.parse(Urls.VerifyOtpApi), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
          body: jsonEncode(<String, String>{'email': email, 'otp': otp}),);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));

          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
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
          print("data" + response.body.toString());
          _apiResponse = OTPModalClass.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;

  }

  //  --------------------------------- update mobile munber-----------------------------------------------------
  static Future<SocialMediaLoginModel> updateMobileNumber(String mobile,String user_id,String token,BuildContext context) async
  {
    SocialMediaLoginModel _apiResponse=new SocialMediaLoginModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.post(Uri.parse(Urls.UpdateMobileNumber), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: jsonEncode(<String, String>{'user_id': user_id, 'mobile_no': mobile}),);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));

          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }


  //-----------------------------------update business details-----------------------------------------
  static Future<SocialMediaLoginModel> updateBussinessDetails(String business_man_id,String hours_staff_work,String cal_monthly_salary, String number_of_staffs,String business_name,String business_id,String token,BuildContext context) async
  {
    SocialMediaLoginModel _apiResponse=new SocialMediaLoginModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var body= jsonEncode(<String, String>{
          'business_man_id': business_man_id,
          'hours_staff_work': hours_staff_work,
          'cal_monthly_salary': cal_monthly_salary,
          'number_of_staffs': number_of_staffs,
          'business_name': business_name,
          'business_id': business_id
        });
        print("ggdhdjhjdjd"+body.toString());
        final response = await http.post(Uri.parse(Urls.BusinessDetailsNullValue), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: body,
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  //----------------------------------------delete bussiness man record---------------------------------------------
//------------------------------------------------delete business details----------------------------------------------
  static Future<SocialMediaLoginModel> deleteBussinessDetails(String business_man_id,String business_id,String token,BuildContext context) async
  {
    SocialMediaLoginModel _apiResponse=new SocialMediaLoginModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.post(Uri.parse(Urls.BusinessDetailsDelete), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: jsonEncode(<String, String>{
            'business_man_id': business_man_id,
            'business_id': business_id
          }),
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
          print("data" + response.body.toString());
          _apiResponse = SocialMediaLoginModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }


  //---------------------------show list staff according to monthly and weekly wise--------------------------------------------
  static Future<StaffListMonthyWiseModelCLass> ShowStffListAccordingToMonthly(String business_man_id,String business_id,String token,BuildContext context) async
  {
    StaffListMonthyWiseModelCLass _apiResponse=new StaffListMonthyWiseModelCLass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.post(Uri.parse(Urls.MothlyWiseStaffList), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: jsonEncode(<String, String>{
            'business_man_id': business_man_id,
            'business_id': business_id
          }),
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = StaffListMonthyWiseModelCLass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = StaffListMonthyWiseModelCLass.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          _apiResponse = StaffListMonthyWiseModelCLass.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = StaffListMonthyWiseModelCLass.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
//-----------------------fetch list attendance------------------------------
  static Future<StaffListDetailsFetchModel> showStaffListAttendace(String business_man_id,String business_id,String token) async
  {
    StaffListDetailsFetchModel _apiResponse=new StaffListDetailsFetchModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.post(Uri.parse(Urls.showAttendanceStaffList), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: jsonEncode(<String, String>{
            'business_man_id': business_man_id,
            'business_id': business_id
          }),
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = StaffListDetailsFetchModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = StaffListDetailsFetchModel.fromJson(jsonDecode(response.body));
         // Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          _apiResponse = StaffListDetailsFetchModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = StaffListDetailsFetchModel.fromJson(jsonDecode(response.body));
        }
      }
    }
    on SocketException catch (_) {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //           title: Text("Checking..", style: TextStyle(
      //             fontSize: 20.0,
      //             fontStyle: FontStyle.normal,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.green[700],
      //           ),),
      //           content: Text(
      //             "No Internet", style: TextStyle(
      //             fontSize: 20.0,
      //             fontStyle: FontStyle.normal,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.deepPurpleAccent,
      //           ),),
      //           actions: <Widget>[
      //             new GestureDetector(
      //               onTap: (){
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
      //               },
      //               child: Padding(
      //                 padding: const EdgeInsets.all(18.0),
      //                 child: new Text("ok", style: TextStyle(
      //                   fontSize: 20.0,
      //                   fontStyle: FontStyle.normal,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.deepPurpleAccent,
      //                 ),),
      //               ),
      //             ),
      //           ]);
      //     }
      // );
    }
    return _apiResponse;
  }

//---------------------------state model class------------------------------------------------------------------------

  static Future<StateModelClass> Stateapi(BuildContext context,String token) async{
  StateModelClass _apiResponse=new StateModelClass();
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
    {
      final response = await http.get(Uri.parse(Urls.GEtSTATEAPI),headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
      },);
      if (response.statusCode == 200) {
        print("data" + response.body.toString());
        _apiResponse = StateModelClass.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {
        print("data" + response.body.toString());
        _apiResponse = StateModelClass.fromJson(jsonDecode(response.body));
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
      }
      else if(response.statusCode==500)
      {
        _apiResponse = StateModelClass.fromJson(jsonDecode(response.body));
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
      else
      {
        print("data" + response.body.toString());
        _apiResponse = StateModelClass.fromJson(jsonDecode(response.body));
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
  return _apiResponse;
}


//-------------------------------------------------get staff details-------------------------------------------------
  static Future<StaffDocsModelClass> GetStaffDeatils(String token,String userid) async
  {
    StaffDocsModelClass _apiResponse=new StaffDocsModelClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.get(Uri.parse(Urls.GetStaffDeails+userid),
          headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = StaffDocsModelClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = StaffDocsModelClass.fromJson(jsonDecode(response.body));
          //Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          _apiResponse = StaffDocsModelClass.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = StaffDocsModelClass.fromJson(jsonDecode(response.body));
        }
      }
    }
    on SocketException catch (_) {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //           title: Text("Checking..", style: TextStyle(
      //             fontSize: 20.0,
      //             fontStyle: FontStyle.normal,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.green[700],
      //           ),),
      //           content: Text(
      //             "No Internet", style: TextStyle(
      //             fontSize: 20.0,
      //             fontStyle: FontStyle.normal,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.deepPurpleAccent,
      //           ),),
      //           actions: <Widget>[
      //             new GestureDetector(
      //               onTap: (){
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
      //               },
      //               child: Padding(
      //                 padding: const EdgeInsets.all(18.0),
      //                 child: new Text("ok", style: TextStyle(
      //                   fontSize: 20.0,
      //                   fontStyle: FontStyle.normal,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.deepPurpleAccent,
      //                 ),),
      //               ),
      //             ),
      //           ]);
      //     }
      // );
    }
    return _apiResponse;
  }

 //------------------------------------------------------Subscription APi ---------------------------------------------------------------

  static Future<SubScriptionModelClass> SubscriptionListAPi(BuildContext context,String token) async
  {
    SubScriptionModelClass _apiResponse=new SubScriptionModelClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.get(Uri.parse(Urls.SubscriptionListAPi), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = SubScriptionModelClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = SubScriptionModelClass.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          _apiResponse = SubScriptionModelClass.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = SubScriptionModelClass.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

//-------------------------------- add attendance user--------------------------------------------------

  static Future<AttendanceModelClass> AddAttendanceapi(BuildContext context,String token,String business_owner_id,String business_id
      ,String attendance_marks,String punching_in_timing,String punching_out_timing, String punching_in_address,String punching_out_address,String punch_status, String who_attendance_make_enter, String late_fine_time,
      String late_fine_amount,String late_fine_type,String exess_breaks_time,String exess_breaks_fine_amount,String exess_breaks_type,String early_out_time,
      String early_fine_amount,String early_type,String overtime_hours,String overtime_type,String overtime_slab_amount,String overtime_total_amount,String Salary_payment_type,String activity_attandance_type,String attendance_date,String id_stafff,String user_pic,String marks_attendance_status) async
  {
    AttendanceModelClass _apiResponse=new AttendanceModelClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var body=jsonEncode(<String, String>{
          'staff_id': id_stafff,
          'business_owner_id': business_owner_id,
          'business_id': business_id,
          'attendance_marks': attendance_marks,
          'punching_in_timing': punching_in_timing,
          'punching_out_timing': punching_out_timing,
          'punching_in_address':punching_in_address,
          'punching_out_address':punching_out_address,
          'punch_status': punch_status,
          'who_attendance_make_enter': who_attendance_make_enter,
          'late_fine_time':late_fine_time,
          'late_fine_amount':late_fine_amount,
          'late_fine_type':late_fine_type,
          'exess_breaks_time':exess_breaks_time,
          'exess_breaks_fine_amount':exess_breaks_fine_amount,
          'exess_breaks_type':exess_breaks_type,
          'early_out_time':early_out_time,
          'early_fine_amount':early_fine_amount,
          'early_type':early_type,
          'overtime_hours':overtime_hours,
          'overtime_type':overtime_type,
          'overtime_slab_amount':overtime_slab_amount,
          'overtime_total_amount':overtime_total_amount,
          "salary_payment_type":Salary_payment_type,
          "activity_attandance_type":activity_attandance_type,
          "created_at": attendance_date,
          "attedanc_time_pic":user_pic,
          "marks_attendance_status":marks_attendance_status,
          "appro_or_reject_status":""
        });
        print("body response"+body.toString());
        var url=Uri.parse(Urls.StaffAttendanceApi);
        print("urlsfdffd"+url.toString());
        final response = await http.post(url, headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: body,

        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = AttendanceModelClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = AttendanceModelClass.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = AttendanceModelClass.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = AttendanceModelClass.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }


  //----------------------------- add staff payment api --------------------------------------------------------

  static Future<AddPaymentStaffModelClass> AddPaymentStaff(BuildContext context,String token, String staff_id,String amount,String payment_method,String status,String payment_key,String des,String date,String type,String salray_cycle) async
  {
    AddPaymentStaffModelClass _apiResponse=new AddPaymentStaffModelClass();
    try {
      final result = await InternetAddress.lookup('google.com');
    var body=  jsonEncode(<String, String>{
        'staff_id': staff_id,
        'amount': amount,
        'payment_method': payment_method,
        'status': status,
        'payment_key': payment_key,
        'description':des,
        "date": date,
        "type":type,
      "salray_cycle":salray_cycle

      });
    print(""+body.toString());
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.post(Uri.parse(Urls.AddPaymentStaff), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body:body,
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = AddPaymentStaffModelClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = AddPaymentStaffModelClass.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = AddPaymentStaffModelClass.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = AddPaymentStaffModelClass.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //------------------------------monthly wise staff -attedance list ------------------------------------------------------
  static Future<MothlyWiseStaffAttendanceModel> StaffAttendanceListMonthyWise(BuildContext context,String token,String business_man_id,String business_id,String salary_payment_type,String date,String id) async
  {
    MothlyWiseStaffAttendanceModel _apiResponse=new MothlyWiseStaffAttendanceModel();
    try {
      String  body = json.encode({
            'staff_id' : id,
            'business_man_id': business_man_id,
            'business_id': business_id,
            'salary_payment_type': salary_payment_type,
            'date': date

            });
      print("body"+body);

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        final response = await http.post(Uri.parse(Urls.AttendaceStaffMothlyList), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: body
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = MothlyWiseStaffAttendanceModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = MothlyWiseStaffAttendanceModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = MothlyWiseStaffAttendanceModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = MothlyWiseStaffAttendanceModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //---------------------------------------today wise attendance list ----------------------------------------------
  static Future<DayWiseStaffListModel> StaffAttendanceListTodayWise(BuildContext context,String token,String business_man_id,String business_id,String date) async
  {
    DayWiseStaffListModel _apiResponse=new DayWiseStaffListModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var body=jsonEncode(<String, String>{
          'business_man_id': business_man_id,
          'business_id': business_id,
          'date': date
        });
        print("body data"+body.toString());
        final response = await http.post(Uri.parse(Urls.AttenceListStaffDayList), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: body,
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DayWiseStaffListModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DayWiseStaffListModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DayWiseStaffListModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DayWiseStaffListModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //-------------------------------over time rate add api ------------------------------------------------------------
  static Future<AddOverTimeRateModel> StaffOverTimeRateAdd(BuildContext context,String token,String business_man_id,String business_id,String salary_type) async
  {
    AddOverTimeRateModel _apiResponse=new AddOverTimeRateModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var body=jsonEncode(<String, String>{
          'business_man_id': business_man_id,
          'business_id': business_id,
          'salary_type': salary_type
        });
        print("body data"+body.toString());
        final response = await http.post(Uri.parse(Urls.OverTimeRate), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: body,
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //------------------------------------ fetch over time rate api-------------------------------------

  static Future<AddOverTimeRateModel> StaffOverTimeRateFetch(BuildContext context,String token,String business_man_id,String business_id) async
  {
    AddOverTimeRateModel _apiResponse=new AddOverTimeRateModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var body=jsonEncode(<String, String>{
          'business_man_id': business_man_id,
          'business_id': business_id

        });
        print("body data"+body.toString());
        final response = await http.post(Uri.parse(Urls.fetchOverTimeRate), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: body,
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //-----------------------------delete over time rate api --------------------------------------------------

  static Future<AddOverTimeRateModel> StaffOverTimeRatedelete(BuildContext context,String token,String business_man_id,String business_id,String overtime_id) async
  {
    AddOverTimeRateModel _apiResponse=new AddOverTimeRateModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var body=jsonEncode(<String, String>{
          'business_man_id': business_man_id,
          'business_id': business_id,
          'overtime_id': overtime_id
        });
        print("body data"+body.toString());
        final response = await http.post(Uri.parse(Urls.deleteOverTimeRate), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: body,
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

//----------------------------------------------add note attedace api ------------------------------------------------
  static Future<AddNoteModelClass> addnoteAttedance(BuildContext context,String token,String staff_id,String note,String create_date) async
  {
    AddNoteModelClass _apiResponse=new AddNoteModelClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "staff_id":staff_id,
            "staff_note":note,
            "date": create_date
        });
        print("body data"+body.toString());
        final response = await http.post(Uri.parse(Urls.addnoteapi), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
          body: body,
        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = AddNoteModelClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = AddNoteModelClass.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = AddNoteModelClass.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = AddNoteModelClass.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  //---------------------------------------delete note atteance api--------------------------------------
  static Future<AddOverTimeRateModel> deletenoteattendace(BuildContext context,String token,String staff_id,String create_date) async
  {
    AddOverTimeRateModel _apiResponse=new AddOverTimeRateModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
       var url=Urls.deletenoteapi+staff_id+"/"+create_date;
        print("body data"+url.toString());
        final response = await http.get(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = AddOverTimeRateModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //---------------------------------------- attendance history api ------------------------------------------------------
  static Future<AttendanceHistoryModel> historyAttendance(BuildContext context,String token,String staff_id,String create_date) async
  {
    AttendanceHistoryModel _apiResponse=new AttendanceHistoryModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
     var url=Urls.fetchAttendanceHistory+staff_id+"/"+create_date;
     final response = await http.get(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },

        );
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = AttendanceHistoryModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = AttendanceHistoryModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = AttendanceHistoryModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = AttendanceHistoryModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
//--------------------------delete staff api -------------------------------------------------------------
  static Future<DeleteStaffModel> deleteStaffApi(BuildContext context,String token,String staff_id) async
  {
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var url=Urls.deleteStaff+staff_id;
        print("body data"+url.toString());
        final response = await http.get(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //---------------------------------add department -----------------------------------
  static Future<DeleteStaffModel> addDepartmment(BuildContext context,String token,String owner_id,String bussiness_id,String  department_name) async
  {
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "owner_id":owner_id,
          "bussiness_id": bussiness_id,
          "department_name": department_name
        });
        print("bodyId"+body.toString());
        var url=Urls.addDepartment;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //------------------------------show department list -----------------------------------------------------------------------
  static Future<DeparmentListModel> showDepartmment(BuildContext context,String token,String owner_id,String bussiness_id) async
  {
    DeparmentListModel _apiResponse=new DeparmentListModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var url=Urls.showDepartment+owner_id+"/"+bussiness_id;
        print("body data"+url.toString());
        final response = await http.get(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeparmentListModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeparmentListModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeparmentListModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeparmentListModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //------------------------------- update staff weekly holiday---------------------------------------------
  static Future<DeleteStaffModel> updateWeeklyHoliday(BuildContext context,String token,String staff_id,List<dynamic> weekname) async
  {

    var datasssss= weekname.map((day) => {"day": day}).toList();
    print("fdgfgdsgd"+datasssss.toString());
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "staff_id": staff_id,
          "weekly_holidays": datasssss
        });
        print("bodyId"+body.toString());
        var url=Urls.updateWeeklyHoliday;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

//--------------------------------- add new Shift (like morning )----------------------------------------------------------

  static Future<DeleteStaffModel> addNewShiftMorningOrNight(BuildContext context,String token,String owner_id,String bussiness_id,String shift_type,String shift_name,String start_time,String end_time,String break_hours,String working_hours,String name,String image ) async
  {
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "owner_id":owner_id,
          "bussiness_id":bussiness_id,
          "shift_type":shift_type,
          "shift_name": shift_name,
          "start_time":start_time,
          "end_time":end_time,
          "break_hours":break_hours,
          "working_hours":working_hours,
          "name":name
        });
        print("bodyId"+body.toString());
        var url=Urls.addShiftTimeMorning;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //----------------------------------  delete shift-------------------------------------------------------------------

  static Future<DeleteStaffModel> deleteShiftMorningOrNight(BuildContext context,String token,String shift_id) async
  {
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var url=Urls.deleteShiftTimeMorning+shift_id;
        print("body data"+url.toString());
        final response = await http.get(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //------------------------------ show shift listing api --------------------------------------

  static Future<ShowShiffListModel> showShiftMorningOrNight(BuildContext context,String token,String shift_id) async
  {
    ShowShiffListModel _apiResponse=new ShowShiffListModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var url=Urls.manageShiftTimeMorning+shift_id;
        print("body data"+url.toString());
        final response = await http.get(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = ShowShiffListModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = ShowShiffListModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = ShowShiffListModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = ShowShiffListModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //--------------------------- staff salary  deduction -------------------------------------
  static Future<DeleteStaffModel> staffSalaryDeduction(BuildContext context,String token,String staff_id,String owner_id,String bussiness_id, String type, String amount,String date,String decs) async
  {
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "staff_id":staff_id,
          "owner_id":owner_id,
          "bussiness_id":bussiness_id,
          "type":type,
          "amount":amount,
          "date": date,
          "desc":decs
        });
        print("bodyId"+body.toString());
        var url=Urls.staffSalryDeduction;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'},
        body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //--------------------------get staff month list (joining date according)---------------------------------
  static Future<StaffJoiningMonthClass> staffMonthListing(BuildContext context,String token,String staff_id,String owner_id,String bussiness_id, String salary_payment_type,String date) async
  {
    StaffJoiningMonthClass _apiResponse=new StaffJoiningMonthClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "owner_id":owner_id,
          "business_id":bussiness_id,
          "salary_payment_type":salary_payment_type,
          "staff_id":staff_id,
          "date":date
        });
        print("bodyId"+body.toString());
        var url=Urls.getStaffJoinMonth;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = StaffJoiningMonthClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = StaffJoiningMonthClass.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = StaffJoiningMonthClass.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = StaffJoiningMonthClass.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }

  //-======================================add bonus==========================================
  static Future<DeleteStaffModel> staffBonusandAllowance(BuildContext context,String token,String staff_id,String owner_id,String bussiness_id, String type,String amount,String payment_type,String date,String desc) async
  {
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "staff_id":staff_id,
          "owner_id":owner_id,
          "bussines_id":bussiness_id,
          "type":type,
          "amount":amount,
          "payment_type":payment_type,
          "desc":desc,
          "date": date,
          "id":""
        });
        print("bodyId"+body.toString());
        var url=Urls.addBonus;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  //========================show allowance and bonus list ========================================

  static Future<BonusAndallowanceModelClass> staffSowBonousandAllowance(BuildContext context,String token,String staff_id,String owner_id,String bussiness_id,String date) async
  {
    BonusAndallowanceModelClass _apiResponse=new BonusAndallowanceModelClass();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "staff_id":staff_id,
          "owner_id":owner_id,
          "bussines_id":bussiness_id,
          "date": date
        });
        print("bodyId"+body.toString());
        var url=Urls.staffshowBonus;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = BonusAndallowanceModelClass.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = BonusAndallowanceModelClass.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = BonusAndallowanceModelClass.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = BonusAndallowanceModelClass.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  static Future<DeleteStaffModel> staffDeleteBonousandAllowance(BuildContext context,String token,String bonus_id) async
  {
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        String  body = json.encode({
          "bonus_id":bonus_id,
        });
        print("bodyId"+body.toString());
        var url=Urls.staffDeleteBonus;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  //=====================================staff Attendance approval ===============================================
  static Future<DeleteStaffModel> staffAttendanceApproval(BuildContext context,String token,String business_owner_id,String business_id, String date, List<dynamic> staff_id,String reject) async
  {
    DeleteStaffModel _apiResponse=new DeleteStaffModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        var datasssss= staff_id.map((day) => {"staff_id": day,"status":reject}).toList();
        print("data value "+datasssss.toString());
        String  body = json.encode({
          "business_owner_id":business_owner_id,
          "business_id": business_id,
          "date": date,
          "staff_list": datasssss
        });
        print("bodyId"+body.toString());
        var url=Urls.staffAttendanceAproved;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = DeleteStaffModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }
  //=====================================staff Salary manual Calculation  ===============================================
  static Future<StaffCalculationMenualModel> staffSalaryManualCalculation(BuildContext context,String token,String date,String id) async
  {
    StaffCalculationMenualModel _apiResponse=new StaffCalculationMenualModel();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
          String  body = json.encode({
          "date": date,
          "id": id
        });
        print("bodyId"+body.toString());
        var url=Urls.staffSalaryCalculation;
        print("body data"+url.toString());
        final response = await http.post(Uri.parse(url), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: body);
        if (response.statusCode == 200) {
          print("data" + response.body.toString());
          _apiResponse = StaffCalculationMenualModel.fromJson(jsonDecode(response.body));
        }
        else if (response.statusCode == 401) {
          print("data" + response.body.toString());
          _apiResponse = StaffCalculationMenualModel.fromJson(jsonDecode(response.body));
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()),);
        }
        else if(response.statusCode==500)
        {
          print("data" + response.body.toString());
          _apiResponse = StaffCalculationMenualModel.fromJson(jsonDecode(response.body));
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
        else
        {
          print("data" + response.body.toString());
          _apiResponse = StaffCalculationMenualModel.fromJson(jsonDecode(response.body));
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffScreenPage()),);
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
    return _apiResponse;
  }




}








