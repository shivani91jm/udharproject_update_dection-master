import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/StaffAddBonusandAllowanceController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';

class StaffAddBonusAndAllowanceActivity extends StatefulWidget {
 var data;
  StaffAddBonusAndAllowanceActivity(this.data);

  @override
  State<StaffAddBonusAndAllowanceActivity> createState() => _StaffAddBonusAndAllowanceActivityState();
}

class _StaffAddBonusAndAllowanceActivityState extends State<StaffAddBonusAndAllowanceActivity> {
  var staffName="bnmn",staff_id="";

  //-------------------staff bank accont controller----------------------
  StaffBonusController controller=Get.put(StaffBonusController());
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    staff_id=widget.data['staff_id'];
    staffName=widget.data['staff_email'];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppContents.allowanceandbonus.tr,style: TextStyle(
                color: AppColors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold
            ),),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(""+staffName,style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                //---------------------chose of allowance controller------------------------------
                Row(
                  children: [
                    //--------------------------allowance --------------------------------------
                    Obx(() =>   Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),

                          child:  RadioListTile(
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppContents.allowance.tr,style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0
                                ),),

                              ],
                            ),
                            value: "Allowance",
                            groupValue:controller.selectedAllowanceTye.value,
                            onChanged:(value) =>controller.updateAllowanceandBonus(value),
                          )
                      ),
                    ),),
                    //------------------------bonus payment --------------------------
                    Obx(() =>  Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),

                          child: RadioListTile(
                              title:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppContents.bonus.tr,style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0
                                  ),),

                                ],
                              ),
                              value:"Bonus",
                              groupValue: controller.selectedAllowanceTye.value,
                              onChanged: (value)=> controller.updateAllowanceandBonus(value)
                          )),
                    ),),
                  ],
                ),
              //===================date conainer==========================
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

                //=====================choose payment type========================
                Row(
                  children: [
                    //--------------------------allowance --------------------------------------
                    Obx(() =>   Expanded(
                      child: Container(

                          margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),

                          child:  RadioListTile(
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppContents.alreadpaid.tr,style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0
                                ),),

                              ],
                            ),
                            value: "Already Paid",
                            groupValue:controller.selected.value,
                            onChanged:(value) =>controller.updateTypeValue(value),
                          )
                      ),
                    ),),
                    //------------------------bonus payment --------------------------
                    Obx(() =>  Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),

                          child: RadioListTile(
                              title:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppContents.addSalaryCycle.tr,style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSize.fitlarge
                                  ),),

                                ],
                              ),
                              value:"Add to Salary Cycle",
                              groupValue: controller.selected.value,
                              onChanged: (value)=> controller.updateTypeValue(value)
                          )),
                    ),),
                  ],
                ),
      //============================ extra ta, da -------------------------------------
                Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.fromLTRB(10, 0, 10,0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      // new LengthLimitingTextInputFormatter(50)

                    ],
                    controller: controller.et_desc,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppContents.amountEmpty.tr;
                      }
                      return null;
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        labelText: AppContents.addNote.tr,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        )  ),
                  ),
                ),
                //============================save conatiner ==============================

                Obx(() {
                  return GestureDetector(
                    onTap: () async{
                      controller.getStaffSalaryBonus(staff_id);
                    },
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                AppColors.lightColorTheme,
                                AppColors.drakColorTheme
                              ])),
                          child: Center(
                            child: controller.isLoading.value?Center(child: Container(height:20,width:20,child: CircularProgressIndicator(color: AppColors.white,))):Text(AppContents.save.tr,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),

    );
  }

}

