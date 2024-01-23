import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/StaffActivityData/MonthClosingBalancePageActivity.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/StaffSalaryManualCalculationController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
class StaffPaymentsPage extends StatefulWidget {
  const StaffPaymentsPage({Key? key}) : super(key: key);
  @override
  State<StaffPaymentsPage> createState() => _StaffPaymentsPageState();
}

class _StaffPaymentsPageState extends State<StaffPaymentsPage> {
  final controller=Get.put(StaffSalaryManualCalculationController());
  var staff_id='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    staffStorageData();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.grey[200],
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Row(crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton.icon(onPressed: () {}, label: Align(
                      child: Text(AppContents.paymentReport.tr, style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                      icon: Icon(Icons.messenger_outline,
                          textDirection: TextDirection.rtl, color: AppColors.white),
                    ),
                  )
                ])),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   child: Text('Total Pending',style: TextStyle(
                            //       color: Colors.black38,
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold
                            //   ),),
                            // ),
                            // Container(
                            //   margin: EdgeInsets.fromLTRB(0, 7, 10, 0),
                            //   child: Text('Rs.2000000',style: TextStyle(
                            //       color: Colors.red,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold
                            //   ),),
                            // ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
             Obx(() => Visibility(
             visible: controller.payment_flag.value==false,
               child: Column(
                 children: [

                   GestureDetector(
                     onTap: () async{
                       Navigator.pushNamed(context, RoutesNamess.salarySlip);
                     },
                     child: Container(
                       // decoration: BoxDecoration(
                       //   border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                       //   borderRadius: BorderRadius.all(Radius.circular(3)),
                       // ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Center(
                           child: Text(AppContents.SalarySlip.tr,style: TextStyle(
                             color: Colors.black87,
                             fontSize: 15,
                             fontWeight: FontWeight.bold,


                           ),),
                         ),
                       ),
                     ),
                   ),
                   //-------------------------apr net salary---------------------------------
                   Obx(() =>    GestureDetector(
                     onTap: (){
                       Navigator.pushNamed(context, RoutesNamess.monthclosingBalance);
                     }, child: Container(
                       margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                       decoration: BoxDecoration(
                         border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                         borderRadius: BorderRadius.all(Radius.circular(3)),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Card(
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Net Salary",style: TextStyle(
                                     color: AppColors.textColorsBlack,
                                     fontSize: AppSize.fitlarge,
                                     fontWeight: FontWeight.bold
                                 ),),
                                 Text('Rs.'+controller.net_salary.value.toString(),style: TextStyle(
                                     color: AppColors.textColorsBlack,
                                     fontSize: AppSize.fitlarge,
                                     fontWeight: FontWeight.bold
                                 ),),
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                   ),),
                   //-------------------------apr salary---------------------------------
                   Obx(() =>  Container(
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     decoration: BoxDecoration(
                       border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                       borderRadius: BorderRadius.all(Radius.circular(3)),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Card(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(""+controller.month_name.value+" Salary",style: TextStyle(
                                   color: AppColors.textColorsBlack,
                                   fontSize: AppSize.fitlarge,
                                   fontWeight: FontWeight.bold
                               ),),
                               Text('Rs.'+controller.month_salary.value.toString(),style: TextStyle(
                                   color: AppColors.textColorsBlack,
                                   fontSize: AppSize.fitlarge,
                                   fontWeight: FontWeight.bold
                               ),),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),),
                   //---------------------------------apr  payment ------------------------------------
                   Obx(() =>   Container(
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     decoration: BoxDecoration(
                       border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                       borderRadius: BorderRadius.all(Radius.circular(3)),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(""+controller.month_name.value+" Payment",style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.fitlarge,
                                 fontWeight: FontWeight.bold
                             ),),
                             Text('Rs.'+controller.month_payment.value.toString(),style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.fitlarge,
                                 fontWeight: FontWeight.bold
                             ),),
                           ],
                         ),
                       ),
                     ),
                   ),),
                   //============================= total payment ajement ==========================
                   Obx(() =>   Container(
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     decoration: BoxDecoration(
                       border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                       borderRadius: BorderRadius.all(Radius.circular(3)),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(""+controller.month_name.value+" Adjustments",style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.fitlarge,
                                 fontWeight: FontWeight.bold
                             ),),
                             Text('Rs.'+controller.month_adjustments.value.toString(),style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.fitlarge,
                                 fontWeight: FontWeight.bold
                             ),),
                           ],
                         ),
                       ),
                     ),
                   ),),
                   //=================total fine ===========================
                   Obx(() => Container(
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     decoration: BoxDecoration(
                       border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                       borderRadius: BorderRadius.all(Radius.circular(3)),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(""+controller.month_name.value+" Fine",style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.fitlarge,
                                 fontWeight: FontWeight.bold
                             ),),
                             Text('Rs.'+controller.total_fine_amount.value.toString(),style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.fitlarge,
                                 fontWeight: FontWeight.bold
                             ),),
                           ],
                         ),
                       ),
                     ),
                   ),),
                   //==========================total deducation===========================
                   Obx(() =>   Container(
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     decoration: BoxDecoration(
                       border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                       borderRadius: BorderRadius.all(Radius.circular(3)),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(""+controller.month_name.value+" Deduction",style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.fitlarge,
                                 fontWeight: FontWeight.bold
                             ),),
                             Text('Rs.'+controller.deduction.value.toString(),style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.fitlarge,
                                 fontWeight: FontWeight.bold
                             ),),
                           ],
                         ),
                       ),
                     ),
                   ),),
                   //==================closing month list===================================
                   Obx(() => Visibility(
                     visible: controller.closing_flag.value,
                     child:  Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Text(AppContents.closing_month.tr,style: TextStyle(
                         color: AppColors.dartTextColorsBlack,
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                       ),),
                     ),)),
                   _closingMonth(),
                 ],
               ))),
              Obx(() => Visibility(
                  visible: controller.payment_flag.value==true,
                  child: Column(
                    children:[
                      Center(
                        child: Text("No Payment"),
                      )
                    ],
                  ))),

            ],
          ),
        ));
  }
  Widget _closingMonth() {
    return  Obx(() => ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: controller.closingMonthList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () async{},
          title:Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,13,10,8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,8,10,2),
                            child: Text(""+controller.closingMonthList[index].monthName.toString()+"",style: TextStyle(
                                color: AppColors.textColorsBlack,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,8,10,2),
                            child: Row(
                              children: [
                                Text("Rs."+ controller.closingMonthList[index].monthPayments.toString(),style: TextStyle(
                                    color: AppColors.textColorsBlack,
                                    fontSize: AppSize.small,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: AppSize.tw,// Replace this with your desired icon
                                    color: AppColors.lightTextColorsBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                    )),
              ],
            ),
          ),

        );},
    ));
  }

  void staffStorageData() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    staff_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var business_owner=prefsdf.getString("businessman_id").toString();
    var salary_type=prefsdf.getString("salary_payment_type").toString();
  }

}
