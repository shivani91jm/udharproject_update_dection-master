import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/AddOverTimePageActivity.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/AddPaymentPageActvity.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/AttendanceByPaticularStaff.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/SalarySlipShareActivity.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/StaffProfileDeatilsPage.dart';
import 'package:udharproject/Activity/HelpActivity/HelpActivityPage.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/StaffSalaryManualCalculationController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
class AddStaffInformationUpdate extends StatefulWidget {
  var staffname,staffid,totalamount,staff_email,staff_mob,salary_type,staff_joiingdate,id;
  AddStaffInformationUpdate(this.staffname,this.staffid,this.totalamount,this.staff_email,this.staff_mob,this.salary_type,this.staff_joiingdate,this.id);
  @override
  State<AddStaffInformationUpdate> createState() => _AddStaffInformationUpdateState(this.staffname,this.staffid,this.totalamount,this.staff_email,this.staff_mob,this.salary_type,this.staff_joiingdate,this.id);
}
class _AddStaffInformationUpdateState extends State<AddStaffInformationUpdate> {
  var staffname,staffid,totalamount,staff_email,staff_mob,salary_type,staff_joiingdate,id;
  _AddStaffInformationUpdateState(this.staffname,this.staffid,this.totalamount,this.staff_email,this.staff_mob,this.salary_type,this.staff_joiingdate,this.id);
  final _formkey = GlobalKey<FormState>();
  final controller=Get.put(StaffSalaryManualCalculationController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
  }
  @override
  Widget build(BuildContext context) {
    print("value data"+staffid+"id:"+id);
    controller.staaff_id.value=staffid;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return  Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(""+staffname,style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppSize.medium,
                    fontWeight: FontWeight.bold
                ),),
                Text(""+staff_email,style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppSize.small,
                    fontWeight: FontWeight.bold
                ),)
              ],
            ),
            GestureDetector(
              onTap: ()async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StaffProfileDeatilsPage(staffname,staffid,staff_email,staff_mob,id)),);
              },
              child: Text(AppContents.edit.tr,style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppSize.fitlarge,
                  fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //---------------------------------------total advance and salary slip container-------------------------------------------------------------
              Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                            child: Text(AppContents.totaladvance.tr,
                              style: TextStyle(
                                color: AppColors.textColorsBlack,
                                fontSize: AppSize.fitlarge,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                            child: Text('Rs. '+totalamount,style: TextStyle(
                               color: AppColors.green,
                                fontSize: AppSize.seventin,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async{
                          Navigator.pushNamed(context, RoutesNamess.salarySlip);

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.currency_rupee,size: 16,),
                                Text(AppContents.SalarySlip.tr,style: TextStyle(
                                    color: AppColors.textColorsBlack,
                                    fontSize: AppSize.fitlarge,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//-----------------------add payment and attedance-------------------------------------------------------------------
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async{
                          Navigator.pushNamed(context, RoutesNamess.staffPayment,arguments: {
                         "staff_id":id,
                          "email":staff_email,
                         "staff_name":staffname,
                          "bussiness_mob":staff_mob
                          });
                            },
                        child: Row(
                          children: [
                            Icon(Icons.payments_sharp,color: Color.fromRGBO(143, 148, 251, 6),),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppContents.addPayment.tr,style: TextStyle(
                                      color: AppColors.textColorsBlack,
                                      fontSize: AppSize.fitlarge,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text(AppContents.adavncesalry.tr,style: TextStyle(
                                      color: AppColors.lightTextColorsBlack,
                                      fontSize: AppSize.small,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ],
                              ),
                            ),
                          ],

                        ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          Navigator.pushNamed(context, RoutesNamess.attendenceMonthwisebysaff,arguments: {
                            "staff_id":staffid,
                            "salary_type":salary_type,
                            "staff_create_date":staff_joiingdate,
                            "staff_name":staffname,
                            "id":id,
                          });
                        },
                        child: Row(
                          children: [
                            Icon(Icons.present_to_all,color: Color.fromRGBO(143, 148, 251, 6),),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppContents.Attendance.tr,style: TextStyle(
                                      color: AppColors.textColorsBlack,
                                      fontSize: AppSize.fitlarge,
                                      fontWeight: FontWeight.bold
                                  ),),

                                  Text(AppContents.overtimelateline.tr,style: TextStyle(
                                      color: AppColors.lightTextColorsBlack,
                                      fontSize: AppSize.small,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ],
                              ),
                            ),
                          ],

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //--------------------------over time and allowance bonus and deduction and loan entry-----------------------------------------
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Row(
                    children: [
                     //----------over time-------------
                     GestureDetector(
                       onTap: () async {

                         var staffname,present_date,attendance_marks,list_type,staff_id,activity_attandance_type,staff_working_time;
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => AddOverTimeActivity(staffname,staffid,staff_email,staff_mob,id)),);
                       },
                       child: Column(
                         children: [
                           Image.asset('assets/images/overtime.png',height: 30,width: 30,),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(AppContents.Overtime.tr,style: TextStyle(
                                 color: AppColors.lightTextColorsBlack,
                                 fontSize: AppSize.small,
                                 fontWeight: FontWeight.bold
                             ),),
                           ),
                         ],
                       ),
                     ),
                     //-----------------allowance-------------------
                   Expanded(child:   GestureDetector(
                     onTap: () async{
                       print("id"+id+"staff_id"+staffid);
                       Navigator.pushNamed(context, RoutesNamess.staffShowbonuspage,arguments: {
                         "staff_id":id,
                         "staff_name":staffname,
                         "staff_email":staff_email,
                       });
                     },
                     child: Column(
                       children: [
                         Image.asset('assets/images/motorbike.png',height: 25,width: 25,),

                         Container(
                           margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                           child: Text(AppContents.allowancebonushm.tr,style: TextStyle(
                               color: Colors.black87,
                               fontSize: 13,
                               fontWeight: FontWeight.bold
                           ),),
                         ),
                       ],
                     ),
                   ),),
                     //-------------------deduction ----------------------
                     GestureDetector(
                       onTap: (){
                         Navigator.pushNamed(context, RoutesNamess.salaryDeduction,arguments: {

                           "salary_type":salary_type,
                           "staff_create_date":staff_joiingdate,
                           "staff_name":staffname,
                           "staff_id":id,

                         });
                       },
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: [
                             Image.asset('assets/images/scissors.png',height: 20,width: 20,),
                             Container(
                               margin: EdgeInsets.fromLTRB(10, 15, 0, 0),
                               child: Text(AppContents.deductionpf.tr,style: TextStyle(
                                   color: Colors.black87,
                                   fontSize: 13,
                                   fontWeight: FontWeight.bold
                               ),),
                             ),
                           ],
                         ),
                       ),
                     ),
                     // //-----------loan entry ---------------------------
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                         child: Column(
                           children: [
                             Image.asset('assets/images/rupee.png',height: 30,width: 30),
                             Container(
                               margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                               child: Text(AppContents.loanentry.tr,style: TextStyle(
                                   color: Colors.black87,
                                   fontSize: 13,
                                   fontWeight: FontWeight.bold
                               ),),
                             ),
                           ],
                         ),
                       ),
                     )
                   ],
                    ),
                ),
              ),
              //-------------------------apr net salary---------------------------------
           Obx(() =>    Container(
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

              //----------------- add previous mounth  --------------------------------
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(AppContents.addprivousmonth.tr,style: TextStyle(
                      color: Color.fromRGBO(143, 148, 251, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ),
              //---------------help continer ------------------------------------
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: GestureDetector(
                  onTap: (){
                   Navigator.pushNamed(context, RoutesNamess.helppage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(AppContents.Help.tr,style: TextStyle(
                            color: AppColors.textColorsBlack,
                            fontSize: AppSize.fitlarge,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 18,
                          splashColor: AppColors.drakColorTheme ,
                          icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                          onPressed: (){
                           Navigator.pushNamed(context, RoutesNamess.helppage);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
