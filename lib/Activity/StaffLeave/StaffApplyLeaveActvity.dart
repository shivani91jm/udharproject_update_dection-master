import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/AddStaffLeaveController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
class StaffApplyLeaveActivity extends StatefulWidget {
  var data;
   StaffApplyLeaveActivity(this.data);

  @override
  State<StaffApplyLeaveActivity> createState() => _StaffApplyLeaveActivityState();
}

class _StaffApplyLeaveActivityState extends State<StaffApplyLeaveActivity> {
  final AddStaffLeaveController controller = Get.put(AddStaffLeaveController());
  final formkey = GlobalKey<FormState>();
  var leave_id="";
  @override
  Widget build(BuildContext context) {
  leave_id = widget.data['leave_id'];
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: GestureDetector(
          onTap: () async{
            if(formkey.currentState!.validate()) {
              if (controller.et_reason.text.isNotEmpty) {
                controller.requestStaffLeaveCat("Pending", leave_id);
              }
              else {
                Fluttertoast.showToast(
                    msg: "Please any reason",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.deepPurpleAccent,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            }
            else {
              Fluttertoast.showToast(
                  msg: "Please any reason",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }

          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ])),
              height: 50,
              width: 300,
              child: Center(
                child: Text(AppContents.save.tr,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSize.medium,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ),),
          )
      )   ,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Container(
            margin: EdgeInsets.fromLTRB(15,30,15,20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(""+AppContents.formdate.tr,style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.fitlarge
                  ),),
                ),
                //============== form date =====================
                GestureDetector(
                  onTap: () async{
                    controller.selectFormDateMthod();
                  },
                  child: Container(
                    width: 350,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    decoration: BoxDecoration(border: Border.all(width: 1,
                      color:  AppColors.dartTextColorsBlack),
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    padding: EdgeInsets.all(8.0),
                    child:  Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() =>   Text(controller.formDatess.value == null ? AppContents.dateofJoin.tr : '${DateFormat('dd/MM/yyyy').format(controller.formDatess.value)},',style: TextStyle(
                              color: AppColors.dartTextColorsBlack,fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),),),
                          Icon(Icons.calendar_month,color:  AppColors.dartTextColorsBlack)
                        ],
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(""+AppContents.tomdate.tr,style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.fitlarge
                  ),),
                ),
                //================== to date ===================
                GestureDetector(
                  onTap: (){
                    controller.selectFormDateMthod();
                  },
                  child: Container(
                    width: 350,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    decoration: BoxDecoration(border: Border.all(width: 1,
                      color:   AppColors.dartTextColorsBlack),
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    padding: EdgeInsets.all(8.0),
                    child:  Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Obx(() =>   Text(controller.toDatess.value == null ? AppContents.dateofJoin.tr : '${DateFormat('dd/MM/yyyy').format(controller.toDatess.value)},',style: TextStyle(
                            color: AppColors.dartTextColorsBlack,fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),),),
                          Icon(Icons.calendar_month,color:  AppColors.dartTextColorsBlack)
                        ],
                      ),
                    ),

                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppContents.reason.tr;
                      }
                      return null;
                    },
                    controller: controller.et_reason,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        labelText: AppContents.reason.tr,
                        hintStyle: TextStyle(color:AppColors.dartTextColorsBlack,),
                        labelStyle: TextStyle(
                          color: AppColors.dartTextColorsBlack
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: AppColors.dartTextColorsBlack),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: AppColors.dartTextColorsBlack),

                        )  ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
