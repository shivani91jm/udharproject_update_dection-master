import 'package:flutter/material.dart';
import 'package:get/get.dart';
class StaffWeeklyWiseHoliday{
 // final String name;
  // final Color? color;
  // StaffWeeklyWiseHoliday(this.name, this.color);
  String ?label;
  RxBool ? isChecked;

  StaffWeeklyWiseHoliday(this.label, {bool initialValue = false}) {
    isChecked = initialValue.obs;
  }
}