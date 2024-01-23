import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Activity/StaffActivityData/Controller/StaffDeductionController.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
class StaffSalryDeductionActivity extends StatefulWidget {
  var data;
   StaffSalryDeductionActivity(this.data);

  @override
  State<StaffSalryDeductionActivity> createState() => _StaffSalryDeductionActivityState();
}

class _StaffSalryDeductionActivityState extends State<StaffSalryDeductionActivity> {
  StaffSalaryDeduction controller=Get.put(StaffSalaryDeduction());



  @override
  Widget build(BuildContext context) {
    var salary_type=widget.data['salary_type'];
    var staff_id=widget.data['staff_id'];
    var staff_create_date=widget.data['staff_create_date'];
    var staff_name=widget.data['staff_name'];
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppContents.deduction.tr, style: TextStyle(
                    color: AppColors.white,
                    fontStyle: FontStyle.normal,
                    fontSize: AppSize.medium,
                    fontWeight: FontWeight.bold),
                ),
                Text(staff_name, style: TextStyle(
                    color: AppColors.white,
                    fontStyle: FontStyle.normal,
                    fontSize: AppSize.small,
                    fontWeight: FontWeight.bold),),
              ])),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            //-----------------date picker -------------------------
            GestureDetector(
              onTap: (){
                controller.selectDateMthod();
              },
              child: Container(
                width: 360,
                margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                decoration: BoxDecoration(border: Border.all(width: 1,
                  color:   Color.fromRGBO(143, 148, 251, .6),),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                padding: EdgeInsets.all(8.0),
                child:  Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() =>   Text(controller.selectedDatess.value == null ? 'Date of Birth' : '${DateFormat('dd/MM/yyyy').format(controller.selectedDatess.value!)},',style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                      ),),),
                      Icon(Icons.calendar_month,color:  Color.fromRGBO(143, 148, 251, 6),)
                    ],
                  ),
                ),

              ),
            ),
            //------------------------amount container -------------------------
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(10, 0, 10,0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                 // new LengthLimitingTextInputFormatter(50)

                ],
                controller: controller.et_amount,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppContents.amountEmpty.tr;
                  }
                  return null;
                },
                autofocus: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                    labelText: AppContents.amount.tr,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    )  ),
              ),
            ),
            //--------------------select deduction reason ---------------------------
            SizedBox(
              height: 10,
            ),
//------------------------------------select deduction reason -----------------------------------
          Container(
            margin: EdgeInsets.fromLTRB(20,0,20,5),
            child: Text(AppContents.deductionReason.tr,style: TextStyle(
                color: AppColors.textColorsBlack,
                fontStyle: FontStyle.normal,
                fontSize: AppSize.small,
                fontWeight: FontWeight.bold),
            ),
          ),
            Row(
              children: [
                //--------------------------account transfer--------------------------------------
                Obx(() =>   Expanded(
                  child: Container(

                      margin: EdgeInsets.fromLTRB(15, 10, 5, 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),

                      child:  RadioListTile(
                        title:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppContents.PF.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: AppSize.small
                            ),),

                          ],
                        ),
                        value: "PF",
                        groupValue:controller.selectedPaymentType.value,
                        onChanged:(value) =>controller.updatePaymentTypeValue(value),
                      )
                  ),
                ),),
                //------------------------ESI --------------------------
                Obx(() =>  Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),

                      child: RadioListTile(
                          title:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppContents.ESI.tr,style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                              ),),

                            ],
                          ),
                          value:"ESI",
                          groupValue: controller.selectedPaymentType.value,
                          onChanged: (value)=> controller.updatePaymentTypeValue(value)
                      )),
                ),),
                //--------------------other -------------------
                Obx(() =>  Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(5, 10, 10,5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),

                      child: RadioListTile(
                          title:  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppContents.Other.tr,style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                              ),),

                            ],
                          ),
                          value:"Other",
                          groupValue: controller.selectedPaymentType.value,
                          onChanged: (value)=> controller.updatePaymentTypeValue(value)
                      )),
                ),),

              ],
            ),

            //------------------------note(optional)--------------------------------
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(10, 0, 10,0),
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  new LengthLimitingTextInputFormatter(50)
                ],
                controller: controller.et_noe,

                autofocus: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                    labelText: AppContents.enterNote.tr,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    )  ),
              ),
            ),
            //----------------send sms staff------------------------------
            // Row(
            //   children: [
            //     Checkbox(
            //       checkColor: Colors.white,
            //       value: isChecked,
            //       onChanged: (bool? value) {
            //         setState(() {
            //           isChecked = value!;
            //         });
            //       },
            //     ),
            //     Text(AppContents.sendsms.tr,style: TextStyle(
            //         color: Colors.black38,
            //         fontSize: 12,
            //         fontWeight: FontWeight.bold
            //     ),),
            //
            //
            //   ],
            // ),
            Center(
              child: GetBuilder<StaffSalaryDeduction>(
                builder: (controller) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.checkboxes.length,
                          (index) => CheckboxListTile(
                        title: Text(controller.checkboxes[index].label),
                        value: controller.checkboxes[index].isSelected.value,
                        onChanged: (value) => controller.toggleCheckbox(index),
                      ),
                    ),
                  );
                },
              ),
            ),



    //-----------------save button container---------------------

          GestureDetector(
            onTap: () async{
              controller.getStaffSalaryDeduction(staff_id);
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 80, 20, 20),
              height: 50,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                AppColors.lightColorTheme,
                AppColors.drakColorTheme
              ])),
              child: Center(
              child: Text(AppContents.continues.tr, style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
              ),
          ),
          ),
          ),

          ],
        ),
      ),
    );
  }
}
