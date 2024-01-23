import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/StaffActivityData/Controller/StaffWeeklyHolidayController.dart';
import 'package:udharproject/Colors/ColorsClass.dart';

class StaffWeeklyHoliday extends StatefulWidget {
  var data;
   StaffWeeklyHoliday({Key? key,required this.data}) : super(key: key);
  @override
  State<StaffWeeklyHoliday> createState() => _StaffWeeklyHolidayState();
}

class _StaffWeeklyHolidayState extends State<StaffWeeklyHoliday> {
  var staff_id;
  var weeklyList=[];
   StaffWeeklyHolidayController controller = Get.put(StaffWeeklyHolidayController());
   Map<String, bool> values = {
     'Sunday': false,
     'Monday': false,
     'Tuesday': false,
     'Wednesday': false,
     'Thursday': false,
     'Friday':false,
     'Saturday':false
   };
   var tmpArray = [];
   getCheckboxItems(){
     values.forEach((key, value) {
       if(value == true)
       {
         tmpArray.add(key);
       }
     });
     print(tmpArray);
     tmpArray.clear();
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    staff_id=widget.data['staff_id'];
    print("staff id"+staff_id);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
        Expanded(
        child : ListView(
        children: values.keys.map((String key) {
      return new CheckboxListTile(

                title: new Text(key),
                value: values[key],
                activeColor: AppColors.drakColorTheme,
                checkColor: AppColors.white,
                onChanged: (bool? value) {
                setState(() {
                values[key] = value!;
                print(""+key.toString());
                weeklyList.add(key);
                controller.UpadteWeekly(context, staff_id, weeklyList);

                });
           },
      );
      }).toList(),
      ),)
        ],
      ),
    );
  }
}

