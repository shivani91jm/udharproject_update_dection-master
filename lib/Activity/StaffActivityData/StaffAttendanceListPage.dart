import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Activity/StaffActivityData/Controller/StaffAttendanceListController.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/AddStaffLeaveController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
class StaffAttendanceListPage extends StatefulWidget {
  const StaffAttendanceListPage({Key? key}) : super(key: key);
  @override
  State<StaffAttendanceListPage> createState() => _StaffAttendanceListPageState();
}

class _StaffAttendanceListPageState extends State<StaffAttendanceListPage> {
  var staff_id;
  var selected = 'Full Slip'.obs;
  StaffAttendanceListController controller= Get.put(StaffAttendanceListController());
  final AddStaffLeaveController leaveController=Get.put(AddStaffLeaveController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  }
  @override
  Widget build(BuildContext context) {
   // ever(controller.getStaffAttendanceList(), (value) => print("$value has been changed"));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: false,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          controller.getBussinessManList();
                          controller.getBusiness!.refresh();
                          _showBootomSheet(context);
                          },
                        icon: Icon(Icons.expand_circle_down,  color: AppColors.white),
                        label: Obx(()=>Text(""+controller.bussinessName.value, style: TextStyle(
                            color: AppColors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: AppSize.medium,
                            fontWeight: FontWeight.bold),))),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: TextButton.icon(onPressed: () {},
                            label: Align(
                              child: Text(AppContents.Help.tr, style: TextStyle(
                                  color: AppColors.white,
                                  fontStyle: FontStyle.normal,
                                  fontSize: AppSize.medium,
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                            icon: Icon(Icons.messenger_outline, color: AppColors.white),
                          ),
                        ),
                      ],
                    )
                    ])),
               bottomNavigationBar:
            // Obx(() => Visibility(visible: controller.attendace_button_enable.value==true,
               // child:
                GestureDetector(
                    onTap: () async{
                      leaveController.showStaffLeaveCat();
                      _showChooseAddAttendanceOrLeave();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              AppColors.drakColorTheme,
                              AppColors.lightColorTheme
                            ])),
                        height: 50,
                        width: 300,
                        child: Center(
                          child: Text(AppContents.addBusines.tr,
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppSize.medium,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                        ),),
                    )
                )   ,
           // ),
           // ),

            body: RefreshIndicator(onRefresh: () async{
              controller.getBussinessManList();
              controller.getStaffAttendanceList();

            },
              child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints)
            {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() =>  Container(
                      child: controller.isLoading.value? ErrowDialogsss(): HomePage(),
                    ))
                  ],
                ),
              );
            }),

            )
        )
    );
  }
  //----------------show bussiness man list ----------------------------------------------------------
  void _showBootomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return showBussinesList();
              });
        });
  }
  //-----------------------------------business list -------------------------------------
 Widget _bulidListStaff() {
    return   Obx(() => ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: controller.getBusiness!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            RadioListTile(
              value: controller.getBusiness![index].id.toString(),
              groupValue: controller.selectedUser,
              title: Text(controller.getBusiness![index].businessName.toString(),style: TextStyle(
                color: AppColors.dartTextColorsBlack,
              ),),
              onChanged: (val) {
                print("Radio $val");
                controller.updateBusinessSelectedValue(val);
                controller.bussinessName.value= controller.getBusiness![index].businessName.toString();
                Navigator.pop(context);
                },
            ),
          ],
        );
      }, separatorBuilder: (BuildContext context, int index) {
      return Divider(height: 1, color: Colors.grey,);
    },));
  }
  //--------------------------------------------listing of attendance-----------------------------------
  Widget  HomePage() {
    return  Column(
      children: [
        //-----------------------------------show date change card------------------------------------------
        Card(
          elevation: 5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Obx(() =>  new IconButton(
                   icon: new Icon(Icons.arrow_back_ios,
                       color: controller.previousBackEnable==true?AppColors.textColorsBlack: AppColors.disableIcon ),
                   onPressed:controller.previousBackEnable==true? () async {
                     controller.isLoading.value=true;
                       controller.getPreviousMonthData();

                   }: null,
                 ),),
                  Obx(() =>   Text(""+DateFormat('dd MMM, EEE').format(controller.currentDate.value), style: TextStyle(
                      color: AppColors.textColorsBlack,
                      fontSize: AppSize.medium,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold)
                  ),),
                  Obx(() =>  new IconButton(
                    icon: new Icon(Icons.arrow_forward_ios,
                        color: controller.isButtonEnabled.value? AppColors.textColorsBlack :AppColors.disableIcon),
                    onPressed: controller.isButtonEnabled.value ? () async {
                      controller.isLoading.value=false;
                      controller.getCurrentMonthDataBack();
                    } : null,))
                ],
              ),
            ],
          ),
        ),
        //-------------------------total present absent card------------------------------------
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //--------------------------- present absent and half day--------------------------
                Row(
                  children: [
                    Container(
                      width: 92,
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:BorderRadius.circular(5),
                        border: Border.all(
                          width:1,
                          color: AppColors.grey,
                          style: BorderStyle.solid,
                        ),),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppContents.Present.tr,style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                            Obx(() =>  Text(""+controller.totalpresent.value,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 92,
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:BorderRadius.circular(5),
                        border: Border.all(
                          width:1,
                          color: Colors.grey,
                          style: BorderStyle.solid,
                        ),),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppContents.Absent.tr,style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                            Obx(() =>  Text(""+controller.totalabsent.value,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 92,
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:BorderRadius.circular(5),
                        border: Border.all(
                          width:1,
                          color: Colors.grey,
                          style: BorderStyle.solid,
                        ),),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppContents.HalfDay.tr,style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                            Obx(() => Text(""+controller.totalhalfday.value,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //--------------------paid leave find and overtime--------------------------------
                Row(
                  children: [
                    Container(
                      width: 92,
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:BorderRadius.circular(5),
                        border: Border.all(
                          width:1,
                          color: Colors.grey,
                          style: BorderStyle.solid,
                        ),),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppContents.paidLeave.tr,style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                            Obx(() =>  Text(""+controller.totalpaidleave.value,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 92,
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:BorderRadius.circular(5),
                        border: Border.all(
                          width:1,
                          color: Colors.grey,
                          style: BorderStyle.solid,
                        ),),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppContents.Fine.tr,style: TextStyle(
                                color: Colors.red,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                            Obx(() => Text(""+controller.totalpaidfine.value,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 92,
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:BorderRadius.circular(5),
                        border: Border.all(
                          width:1,
                          color: Colors.grey,
                          style: BorderStyle.solid,
                        ),),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppContents.Overtime.tr,style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                            Obx(() => Text(""+controller.totalpaidovertime.value,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        //------------------show attendance list ----------------------------------
        _buildMonthlyContrainer(),
        //----------------------------attendace button ---------------


      ],
    );
  }
  //--------------------------------------------------------------show business list ----------------------------
  Widget showBussinesList(){
    return Container(
      height: 300,
      color: AppColors.white,
      child: Column(
        children: [
          Text(AppContents.switchnewBusinessMan.tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Expanded(
            child: _bulidListStaff(),
            ),

        ],
      ),
    );
    }
    Widget  _buildMonthlyContrainer() {
   return Obx(() => ListView.builder(
     physics: NeverScrollableScrollPhysics(),
     scrollDirection: Axis.vertical,
     shrinkWrap: true,
     itemCount: controller.datesList.length,
     itemBuilder: (BuildContext context, int index) {
       return ListTile(
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
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.fromLTRB(10.0,8,10,2),
                           child: Text(""+DateFormat('dd MMM').format(DateTime.parse(controller.datesList[index].date.toString())),style: TextStyle(
                               color: AppColors.textColorsBlack,
                               fontSize: AppSize.small,
                               fontStyle: FontStyle.normal,
                               fontWeight: FontWeight.bold),),
                         ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(10.0,8,10,2),
                           child: Text(""+DateFormat('EEE').format(DateTime.parse(controller.datesList[index].date.toString())),style: TextStyle(
                               color: AppColors.textColorsBlack,
                               fontSize: AppSize.small,
                               fontStyle: FontStyle.normal,
                               fontWeight: FontWeight.bold),),
                         ),
                       ],
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                             padding: const EdgeInsets.fromLTRB(10.0,8.0,10,13),
                             child: controller.datesList[index].attandancStatus.toString()=="false"?
                             Text(AppContents.notmarked.tr,style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.small,
                                 fontStyle: FontStyle.normal,
                                 fontWeight: FontWeight.bold),) :
                             Container(
                               child: Column(
                                 children: [
                                   if(controller.datesList[index].staffAttendanceDetails!.isNotEmpty &&controller.datesList[index].staffAttendanceDetails?.first.attendanceMarks=="present")...
                                   {
                                     Text(AppContents.Present.tr, style: TextStyle(
                                         color: AppColors.textColorsBlack,
                                         fontSize: AppSize.small,
                                         fontStyle: FontStyle.normal,
                                         fontWeight: FontWeight.bold),),
                                   },
                                   if(controller.datesList[index].staffAttendanceDetails!.isNotEmpty &&controller.datesList[index].staffAttendanceDetails?.first.attendanceMarks=="absent")...
                                   {
                                     Text(AppContents.Absent.tr,style: TextStyle(
                                         color: AppColors.textColorsBlack,
                                         fontSize: AppSize.small,
                                         fontStyle: FontStyle.normal,
                                         fontWeight: FontWeight.bold),)
                                   },
                                   if(controller.datesList[index].staffAttendanceDetails!.isNotEmpty &&( controller.datesList[index].staffAttendanceDetails?.first.attendanceMarks=="half_day"))...{
                                     Text(AppContents.HalfDay.tr, style: TextStyle(
                                         color: AppColors.textColorsBlack,
                                         fontSize: AppSize.small,
                                         fontStyle: FontStyle.normal,
                                         fontWeight: FontWeight.bold),)
                                   },

                                 ],
                               ),
                             )
                         ),
                         Padding(
                             padding: const EdgeInsets.fromLTRB(10.0,0,10,13),
                             child: controller.datesList[index].staffAttendanceDetails==null&& controller.datesList[index].staffAttendanceDetails!.length>1?
                             Text(""+ controller.datesList[index].staffAttendanceDetails!.first.working_staff_total_timing.toString()+"Hrs",style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.small,
                                 fontStyle: FontStyle.normal,
                                 fontWeight: FontWeight.bold),):Text("0.00 Hrs",style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.small,
                                 fontStyle: FontStyle.normal,
                                 fontWeight: FontWeight.bold),)
                         ),


                       ],
                     ),
                   ],
                 ),
               )
             ],
           ),
         ),

       );

     },
   ));
  }
   Widget ErrowDialogsss() {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 200, 10, 100),
            child: Align(
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.lightColorTheme,
                  valueColor: new AlwaysStoppedAnimation<Color>(AppColors.lightColorTheme),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
//-------------------------------show mark attendance or leave----------------------------
  void _showChooseAddAttendanceOrLeave() {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return  Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppContents.selectanyone.tr,
                    style: TextStyle(
                        color: AppColors.textColorsBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.large
                    ),),
                ),
                Divider(
                  color: AppColors.grey,
                  height: 1,
                ),
                //--------------------------attendance --------------------------------------
                Obx(() =>
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,
                            color: AppColors.textColorsBlack),
                          borderRadius: BorderRadius.all(
                              Radius.circular(1)),
                        ),
                        child: RadioListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppContents.markattendance.tr,
                                style: TextStyle(
                                    color: AppColors.dartTextColorsBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0
                                ),),

                            ],
                          ),
                          value: "Mark Attendance",
                          groupValue: controller.selected.value,
                          onChanged: (value) {
                            controller.updateTypeValue(value);
                            controller.selected.value="";
                            Navigator.of(context).pop();
                             Navigator.pushNamed(context, RoutesNamess.staffattendacepage);
                          }

                        )
                    ),),
                //------------------------Leave --------------------------
                Obx(() =>
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,
                            color: AppColors.textColorsBlack),
                          borderRadius: BorderRadius.all(
                              Radius.circular(1)),
                        ),
                        child: RadioListTile(
                          activeColor: AppColors.drakColorTheme,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppContents.leave.tr,
                                  style: TextStyle(
                                      color: AppColors.dartTextColorsBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSize.fitlarge
                                  ),),

                              ],
                            ),
                            value: "Leave",
                            groupValue: controller.selected.value,
                            onChanged: (value) {
                              controller.updateTypeValue(value);
                              controller.selected.value="";
                              Navigator.of(context).pop();
                              leaveController.leaveList.refresh();
                              _showLeaveList();
                            }
                        )),),

              ],
            ),
          );
        });
  }

  void _showLeaveList() {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() =>   Visibility(
              visible: leaveController.leaveFlag.value,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppContents.leaveNmae.tr,style: TextStyle(
                      color: AppColors.lightTextColorsBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.medium
                  ),),
                ),
              ),),),
              Obx(() =>   Visibility(
                visible: leaveController.leaveFlag.value==false,
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppContents.nodata.tr,style: TextStyle(
                        color: AppColors.lightTextColorsBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.medium
                    ),),
                  ),
                ),),),
              buildLeaveListData()
            ],
          );
        });
  }
  Widget buildLeaveListData() {
    return Obx(() => ListView.builder(
      itemCount: leaveController.leaveList.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,

      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.white, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () async{
                Navigator.pushNamed(context, RoutesNamess.staffAssignLeave,arguments: {
                  "leave_id":leaveController.leaveList[index].id.toString()
                });
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppContents.leaveNmae.tr,style: TextStyle(
                          color: AppColors.lightTextColorsBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.medium
                      ),),
                      Text(leaveController.leaveList[index].name.toString(),style: TextStyle(
                          color: AppColors.textColorsBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.small
                      ),),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      iconSize: 18,
                      splashColor: AppColors.drakColorTheme ,
                      icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                      onPressed: ()
                      {
                        Navigator.pushNamed(context, RoutesNamess.staffAssignLeave);
                      },
                    ),
                  ),


                ],
              ),
            ),
          ),
        );
      },

    ));
  }




}
