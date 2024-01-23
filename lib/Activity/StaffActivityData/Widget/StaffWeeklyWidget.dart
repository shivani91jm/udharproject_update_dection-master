import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/StaffActivityData/Controller/StaffWeeklyHolidayController.dart';
import 'package:udharproject/Activity/StaffActivityData/Widget/CategoryWidget.dart';

class CategoryFilter extends StatefulWidget {
  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final checkboxController = Get.put(StaffWeeklyHolidayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Checkboxes Example'),
      ),
      body: Obx(() => ListView.builder(
        itemCount: checkboxController.checkboxItems.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(checkboxController.checkboxItems[index].label.toString()),
            value: checkboxController.checkboxItems[index].isChecked!.value,
            onChanged: (value) {
              checkboxController.toggleCheckbox(index);
            },
          );
        },
      )),
    );
  }
}