import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/CustomDialog.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/Utils/custom_snackbar.dart';

class StaffAttendanceController extends GetxController {
  RxString _base64Image = "".obs;
  File? image;
  var path;
  RxBool pictureTake = false.obs;
  BuildContext? context = Get.key.currentContext;
  RxBool isLoading = false.obs;
  var user_pic = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //takePhoto();
    _getCurrentPosition();
  }
  Future<void> takePhoto() async {
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      path = image.path;
      pictureTake = true.obs;
      print('Photo Path: ${image.path}');
    } else {
      Get.snackbar(
        'Error',
        'No photo was taken or selection was canceled.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Position? _currentPosition;
  String? _currentAddress;


  void staffAttendace(String user_pic) async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token = prefsdf.getString("token").toString();
    var staff_id = prefsdf.getString("user_id").toString();
    var bussiness_id = prefsdf.getString("bussiness_id").toString();
    var owner_id = prefsdf.getString("businessman_id").toString();
    var salary_type = prefsdf.getString("salary_payment_type").toString();
    String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("date" + formattedDate.toString());
    var _futureLogin = BooksApi.AddAttendanceapi(context!, token,  owner_id,
        bussiness_id, "present", formattedDate, "", _currentAddress.toString(), "", "punching_in", "staff",
        "", "", "", "", "", "", "", "", "", "", "", "", "", salary_type, "", date,staff_id, user_pic, "pending"
    );
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res != null) {
          if (res == "true") {
            isLoading.value = false;

          //  RingtoneSet.setAlarm("assets/attendancemark.mp3");
            //=========================dialog page=====================
            showGeneralDialog(
              barrierDismissible: false,
              context: context!,
              barrierColor: AppColors.textColorsBlack, // space around dialog
              transitionDuration: Duration(milliseconds: 800),
              transitionBuilder: (context, a1, a2, child) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                      parent: a1,
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.easeOutCubic),
                  child: CustomDialog( // our custom dialog
                    title: "MarKed Attendance",
                    content:"Add Attendance Successfully",
                    positiveBtnText: AppContents.Done.tr,
                    negativeBtnText: AppContents.cancel.tr,
                    positiveBtnPressed: () {
                      Navigator.pushNamed(context!, RoutesNamess.staffdashboard);
                    },
                  ),
                );
              },
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return Text("gfhghf");
              },
            );


          }
          else {
            isLoading.value = false;
          }
        }
      });
    }
    else {
      _futureLogin.then((value) {
        isLoading.value = false;
      });
    }
  }
  void allstaffAttendance(String user_pic, String staff_id,String salary_type,String name) async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token = prefsdf.getString("token").toString();

    var bussiness_id = prefsdf.getString("bussiness_id").toString();
    var owner_id = prefsdf.getString("user_id").toString();
    String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("date" + formattedDate.toString());
    var _futureLogin = BooksApi.AddAttendanceapi(context!, token,  owner_id,
        bussiness_id, "present", formattedDate, "", _currentAddress.toString(), "", "punching_in", "business_man",
        "", "", "", "", "", "", "", "", "", "", "", "", "", salary_type, "", date,staff_id, user_pic, "approved"
    );
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res != null) {
          if (res == "true") {
            isLoading.value = false;

            //  RingtoneSet.setAlarm("assets/attendancemark.mp3");
            //=========================dialog page=====================
            // showGeneralDialog(
            //   barrierDismissible: false,
            //   context: context!,
            //   barrierColor: AppColors.textColorsBlack, // space around dialog
            //   transitionDuration: Duration(milliseconds: 800),
            //   transitionBuilder: (context, a1, a2, child) {
            //     return ScaleTransition(
            //       scale: CurvedAnimation(
            //           parent: a1,
            //           curve: Curves.elasticOut,
            //           reverseCurve: Curves.easeOutCubic),
            //       child: CustomDialog( // our custom dialog
            //         title: "Hey ${name} !MarKed Attendance",
            //         content:"Add Attendance Successfully",
            //         positiveBtnText: AppContents.Done.tr,
            //         negativeBtnText: AppContents.cancel.tr,
            //         positiveBtnPressed: () {
            //           Navigator.pushNamed(context!, RoutesNamess.businessmandashboard);
            //         },
            //       ),
            //     );

            //   },
            //   pageBuilder: (BuildContext context, Animation animation,
            //       Animation secondaryAnimation) {
            //     return Text("gfhghf");
            //   },
            // );
            CustomSnackBar.successSnackBar("Hey ${name} Attendance Successfully",context!);
            Navigator.pushReplacementNamed(context!, RoutesNamess.businessmandashboard);
          }
          else {
            isLoading.value = false;
          }
        }
      });
    }
    else {
      _futureLogin.then((value) {
        isLoading.value = false;
      });
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      print("err" + e.toString());
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      print("" + place.toString());
      _currentAddress = '${place.street}, ${place.subLocality}, ${place
          .subAdministrativeArea}, ${place.postalCode}';
      print('LAT: ${_currentPosition?.latitude ?? ""}');
      print('LNG: ${_currentPosition?.longitude ?? ""}');
      print('ADDRESS: ${_currentAddress ?? ""}');
    }).catchError((e) {
      print("excaption" + e.toString());
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(content: Text("" + AppContents.LOCATIONENABLEDISBALE.tr)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
}