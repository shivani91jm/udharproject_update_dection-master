import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Contents/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:udharproject/Services/check_permission.dart';
class SalarySlipController extends GetxController{
RxBool isLoading=false.obs;
var selected = 'Full Slip'.obs;
RxDouble progress=0.0.obs;

BuildContext? context = Get.key.currentContext;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
 void downloadSalarySlip(String staff_id,String date) async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = jsonEncode(<String, String>{
          "staff_id":staff_id,
          "date": date,
          "type":selected.value.toString()
        });
        print("body res" + body.toString());
        final response = await http.post(Uri.parse(Urls.staffSalrySlipDownload), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
            body: body
        );
        if (response.statusCode == 200) {
          // isLoading.value=false;
          // final bytes = response.bodyBytes;
          // return _storeFile(url, bytes);

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
void updateTypeValue(Object? value) {
  selected.value = value.toString();
  }

//
// void startDownloading() async{
//   var file = File('');
//     const String url="https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
//     filename=
//     if (Platform.isAndroid) {
//       var status = await Permission.storage.status;
//       if (status != PermissionStatus.granted) {
//         status = await Permission.storage.request();
//       }
//       if (status.isGranted) {
//         const downloadsFolderPath = '/storage/emulated/0/Download/';
//         Directory dir = Directory(downloadsFolderPath);
//         file = File('${dir.path}/$fileName');
//         final byteData = await rootBundle.load('assets/$fileName');
//         try {
//           await file.writeAsBytes(byteData.buffer
//               .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//         } on FileSystemException catch (err) {
//           // handle error
//         }
//       }
//     }
// }




}