import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/model/StaffWeeklyHolidayModel.dart';

class StaffWeeklyHolidayController extends GetxController{
  var checkboxItems = <StaffWeeklyWiseHoliday>[].obs;

  // Method to initialize the checkbox items
  void initializeItems() {
    checkboxItems.value = [
      StaffWeeklyWiseHoliday('Sunday'),
      StaffWeeklyWiseHoliday('Monday'),
      StaffWeeklyWiseHoliday('Tuesday'),
      StaffWeeklyWiseHoliday('Wednesday'),
      StaffWeeklyWiseHoliday('Thursday'),
      StaffWeeklyWiseHoliday('Friday'),
      StaffWeeklyWiseHoliday('Saturday'),
    ];
  }

  void toggleCheckbox(int index) {
    checkboxItems[index].isChecked!.toggle();
  }

  void UpadteWeekly(BuildContext context,String staff_id, List<dynamic> weekname ) async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var _futureLogin = BooksApi.updateWeeklyHoliday(context, token, staff_id, weekname);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if(res!=null)
        {
          if (res== "true") {
            Fluttertoast.showToast(
                msg: "Update Successfully",
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
        }
      });
    }
    else {
      _futureLogin.then((value) {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: AppColors.white,
            fontSize: AppSize.medium
        );
      });
    }
  }

}

