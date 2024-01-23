import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/DayWiseStaffList/MarkAttendanceInfo.dart';

class ApprovalAttendaceController extends GetxController{
  BuildContext? context = Get.key.currentContext;
  RxList<MarkAttendanceInfo> markAttendanceInfo=<MarkAttendanceInfo>[].obs;
  RxBool isLoading=false.obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  var nextDate="";
  var staffjoiningdate="2023-06-01";
  RxBool isButtonEnabled = false.obs;
  HashSet<MarkAttendanceInfo> selectedItem = HashSet();
  RxBool isMultiSelectionEnabled = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    currentDateMethod();
    showStaffListData();
  }
  void currentDateMethod() {
    nextDate=currentDate.toString() ;
    DateFormat('yyyy-MM-dd').format(currentDate.value);
    DateTime startDate = DateTime.parse(nextDate);
    print(startDate);
    if(nextDate==staffjoiningdate)
      {
        isButtonEnabled.value=false;
        showStaffListData();
      }
    else
      {
        isButtonEnabled.value=true;
        showStaffListData();
      }
  }
  void showStaffListData() async{
    markAttendanceInfo.clear();
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token = prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id = prefsdf.getString("bussiness_id").toString();

    var _futureLogin = BooksApi.StaffAttendanceListTodayWise(context!,token,user_id,bussiness_id,DateFormat('yyyy-MM-dd').format(currentDate.value));
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {

          if(value.markAttendanceStatus.toString()=="true")
          {
            if (value.markAttendanceInfo != null)
            {
              markAttendanceInfo.value=value.markAttendanceInfo!;
              markAttendanceInfo.refresh();
            }
          }
          else {

          }
        }
        else{
          isLoading=true.obs;

        }
      });
    }
    else
    {
      _futureLogin.then((value) {
        isLoading=true.obs;
          String data = value.msg.toString();
        Fluttertoast.showToast(
            msg: "" + data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }
  void getPreviousMonthData() {
   isLoading.value=true;
    currentDate.value = currentDate.value.subtract(Duration(days: 1));
    nextDate = DateFormat('yyyy-MM-dd').format(currentDate.value);

    if(nextDate==staffjoiningdate)
    {
      isButtonEnabled.value=false;
      DateTime startDate = DateTime.parse(nextDate);
      print(startDate);
      currentDate.value=startDate;

    }
    else
    {
      isButtonEnabled.value=true;
      DateTime startDate = DateTime.parse(nextDate);
      print(startDate);
      currentDate.value=startDate;
      print("next date"+currentDate.value.toString());
      showStaffListData();
    }

    print("current date decrement"+currentDate.toString());

  }
  // ------------------------------next date according staff list show ---------------------------------------------
  void getCurrentMonthData() {
    currentDate.value = currentDate.value.add(Duration(days: 1));
    nextDate=DateFormat('yyyy-MM-dd').format(currentDate.value);
    print("current date incremnt"+currentDate.toString());
    var currentdatevalue= DateTime.now();
    var date= DateFormat('yyyy-MM-dd').format(currentdatevalue);
    if(nextDate==date)
    {
      DateTime startDate = DateTime.parse(nextDate);
      print(startDate);
      currentDate.value=startDate;
      isButtonEnabled.value=false;
      showStaffListData();
      print("condition match"+nextDate.toString()+"date"+date);
    }
    else
    {
      DateTime startDate = DateTime.parse(nextDate);
      print(startDate);
      currentDate.value=startDate;
      isButtonEnabled.value=true;
      showStaffListData();
      print("condition not match"+nextDate+"date"+date);
    }
  }

  //------------------------------staff approval attendance -------------------------------

  void StaffApprovalAttendance(List<String> staff_id_list,String status) async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.staffAttendanceApproval(context!,token,user_id,bussiness_id,DateFormat('yyyy-MM-dd').format(currentDate.value),staff_id_list,status);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
        Navigator.pushNamed(context!, RoutesNamess.businessmandashboard);
        }
        else{
          isLoading=true.obs;
          var res = value.msg;
          Fluttertoast.showToast(
              msg: "" + res.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      });
    }
    else
    {
      _futureLogin.then((value) {
        isLoading=true.obs;
        String data = value.msg.toString();
        Fluttertoast.showToast(
            msg: "" + data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }

  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ? selectedItem.length.toString() + " item selected"
        : "No item selected";
  }

  void doMultiSelection(MarkAttendanceInfo nature) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(nature)) {
        selectedItem.remove(nature);
      } else {
        selectedItem.add(nature);
      }

    } else {
      //Other logic
    }
  }


}