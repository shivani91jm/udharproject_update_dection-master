import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/StaffBankAccountDetailController.dart';
import 'package:udharproject/Utils/AppContent.dart';

class StaffBankAccountDetailsPage extends StatefulWidget {
  @override
  State<StaffBankAccountDetailsPage> createState() => _StaffBankAccountDetailsPageState();
}

class _StaffBankAccountDetailsPageState extends State<StaffBankAccountDetailsPage> {
  var staffName="",staff_id="";

  //-------------------staff bank accont controller----------------------
  StaffBankAccountDeatilsController controller=Get.put(StaffBankAccountDeatilsController());
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppContents.accountDetails.tr,style: TextStyle(
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
                //---------------------payment type controller------------------------------
                   Row(
                  children: [
                    //--------------------------account transfer--------------------------------------
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
                              Text(AppContents.acconttransfer.tr,style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                              ),),

                            ],
                          ),
                          value: "AccountTransfer",
                          groupValue:controller.selectedPaymentType.value,
                          onChanged:(value) =>controller.updatePaymentTypeValue(value),
                        )
                  ),
                     ),),
                    //------------------------upi payment --------------------------
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
                                Text(AppContents.upiPayment.tr,style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0
                                ),),
                               
                              ],
                            ),
                            value:"UPI",
                            groupValue: controller.selectedPaymentType.value,
                            onChanged: (value)=> controller.updatePaymentTypeValue(value)
                          )),
                    ),),
                  ],
                ),
                  //-------------------bank transfer containers------------------------
                  Obx(() =>   Visibility(
                      visible: controller.paymenttypeflag.isTrue,
                      child: Column(
                        children: [
                          //------------------holder name---------------------------------
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onTap: controller.onTextFieldTap,
                              inputFormatters: <TextInputFormatter>[
                                new LengthLimitingTextInputFormatter(50)
                              ],
                              validator: (value){

                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(width: 1, color: AppColors.textColorsBlack),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                                ),
                                labelText: "Holder Name",
                                labelStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              controller: controller.et_holderName,
                            ),
                          ),
                          //---------------------account number controller -----------------------
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                new LengthLimitingTextInputFormatter(50)
                              ],
                              showCursor: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Account Number is Requires!!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                                ),
                                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),),
                                labelText: "Account Number",
                                labelStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                              controller: controller.et_accountNumer,
                            ),
                          ),
                          //----------------- confirm account numer controller ------------------
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                new LengthLimitingTextInputFormatter(50)
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm Account Number is Requires!!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                                ),
                                labelText: "Confirm Account Number",
                                labelStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                              controller: controller.et_confirmAccountNumber,
                            ),
                          ),
                          //--------------------- ifsc code controller----------------------------
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                new LengthLimitingTextInputFormatter(50)
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'IFSC Code is Requires!!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                                ),
                                labelText: "IFSC Code",
                                labelStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                              controller: controller.et_ifsc_code,
                            ),
                          ),
                          //---------------------submit button ----------------------------------
                          Obx(() {
                            return GestureDetector(
                              onTap: controller.isButtonEnabled.value?controller.onButtonPressed:null,
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
                                      child: controller.isLoading.value?Center(child: Container(height:20,width:20,child: CircularProgressIndicator(color: AppColors.white,))):Text(AppContents.savewithoutveriyig.tr,
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
                          })

                        ],
                      ))),
                //-------------------------- upi controller-------------------------
                Obx(() => Visibility(
                  visible: controller.paymenttypeflag.isFalse,
                    child: Column(
                  children: [
                    //----------------------- month container ----------------------------
                    GestureDetector(
                      onTap: (){
                        _showBootomSheet(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black38,
                            boxShadow: [
                              BoxShadow(color:  Color.fromRGBO(143, 148, 251, .1), spreadRadius: 1)
                            ]
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0,8.0,15.0,0),
                                child: Text("Month",style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal

                                ),),
                              ),
                             Obx(() =>  Padding(
                               padding: const EdgeInsets.fromLTRB(15.0,1.0,15.0,10),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(""+controller.mouth.value,style: TextStyle(
                                       fontSize: 15,
                                       fontWeight: FontWeight.bold,
                                       color: Colors.white,
                                       fontStyle: FontStyle.normal
                                   ),),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Icon(Icons.arrow_drop_down,color: Colors.white,)
                                     ],
                                   ),
                                 ],
                               ),
                             ),)
                            ],
                          ),
                        ),
                      ),
                    ),

                    //-------------------- staff upi id controller ----------------------
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          new LengthLimitingTextInputFormatter(50)
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Staff UPI ID is Requires!!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                          ),
                          labelText: "Staff UPI ID",
                          labelStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontSize: 14,fontWeight: FontWeight.bold),
                        ),
                        controller: controller.et_upi_staff_id,
                      ),
                    ),

                    //---------------submit button conatiner ----------------------------
                    Obx(() {
                      return GestureDetector(
                        onTap: (){},
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
                                child: controller.isLoading.value?Center(child: Container(height:20,width:20,child: CircularProgressIndicator(color: AppColors.white,))):Text("Confirm & Save",
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
                ))),

              ],
            ),
          ),
        ),
      ),

    );
  }
  void _showBootomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    Expanded(child: _bulidListBussinessMan(context)),
                  ],
                );
              });
        });
  }
  Widget  _bulidListBussinessMan(BuildContext context) {
    return Obx(() =>  ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: controller.monthList!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            RadioListTile(
              value: controller.monthList![index].toString(),
              groupValue: controller.mouth.value,
              title: Text(controller.monthList![index].toString(),style: TextStyle(color: AppColors.textColorsBlack,fontWeight: FontWeight.bold,fontSize: 15),),
              onChanged: (val) {
                controller.monthList;
                controller.mouth.value=val.toString();
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaffScreenPage()),);
              },
            ),
          ],
        );
      }, separatorBuilder: (BuildContext context, int index) {
      return Divider(height: 1, color: Colors.grey,);
    },));
  }
}

