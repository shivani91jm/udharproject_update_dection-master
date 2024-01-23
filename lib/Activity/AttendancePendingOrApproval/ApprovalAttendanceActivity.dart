import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Activity/StaffActivityData/ShowAllStaffListSearchPageActivity.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Contents/Urls.dart';
import 'package:udharproject/Controller/ApprovalAttendaceController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/model/DayWiseStaffList/MarkAttendanceInfo.dart';

class ApprovalAttendaceActivity extends StatefulWidget {
  const ApprovalAttendaceActivity({Key? key}) : super(key: key);
  @override
  State<ApprovalAttendaceActivity> createState() => _ApprovalAttendaceActivityState();
}

class _ApprovalAttendaceActivityState extends State<ApprovalAttendaceActivity> {
  final ApprovalAttendaceController controller = Get.put(ApprovalAttendaceController());
  var seleted = false;
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  List<String> staff_list=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Row(
                children: [
                  Text(AppContents.approvalAttendace.tr, style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSize.seventin,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),)
                ])
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
         child: Form(
           child: Column(
             children: [
               ListView(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 children: [
                   Column(
                     children: [
                       //================================date container ==============================
                       Card(
                         elevation: 5,
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Obx(() =>   IconButton(
                                   icon: new Icon(Icons.arrow_back_ios,
                                       color: controller.isButtonEnabled.value? Colors
                                           .black87 : Colors.black12),
                                   onPressed: controller.isButtonEnabled.value ?  ()async  {
                                     controller.getPreviousMonthData();
                                   }:null
                                 )),
                                 Obx(() => Text("" + DateFormat('dd MMM, EEE').format(controller.currentDate.value),
                                     style: TextStyle(
                                         color: Colors.black87,
                                         fontSize: 16,
                                         fontStyle: FontStyle.normal,
                                         fontWeight: FontWeight.bold)
                                 ),),
                                 Obx(() =>  new IconButton(
                                   icon: new Icon(Icons.arrow_forward_ios,
                                       color: controller.isButtonEnabled.value? Colors
                                           .black87 : Colors.black12),
                                   onPressed: controller.isButtonEnabled.value ? () async {
                                     controller.isLoading = false.obs;
                                     controller.getCurrentMonthData();
                                   } : null,),),
                               ],
                             ),
                           ],
                         ),
                       ),
                       //=========================search box container ====================
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           GestureDetector(
                             onTap: () async {
                               Navigator.push(context, MaterialPageRoute(
                                   builder: (context) => AllStaffListShowAndSearchStaff()),);
                             },
                             child: Container(
                               width: 350,
                               margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                               decoration: BoxDecoration(
                                 border: Border.all(width: 1, color: Colors.black38),
                                 borderRadius: BorderRadius.all(Radius.circular(3)),
                               ),
                               child: Padding(
                                 padding: EdgeInsets.fromLTRB(15, 12, 10, 12),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(AppContents.searchstaff.tr, style: TextStyle(
                                         color: Colors.black38,
                                         fontSize: 14.0,
                                         fontStyle: FontStyle.normal,
                                         fontWeight: FontWeight.bold),),
                                     Icon(Icons.search, color: Colors.black38,)
                                   ],
                                 ),
                               ),
                             ),
                           ),

                         ],
                       ),

                     ],
                   ),

                 ],
               ),
               staffListWidget(),
             ],
           ),
         ));
            }),
      bottomNavigationBar: Container(
        color: AppColors.dartTextColorsBlack,
      margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async{
                  _showRejectDilaog(context,staff_list);
                  print("cdgsdg"+staff_list.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius:BorderRadius.circular(5),
                    border: Border.all(
                      width:1,
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(AppContents.Reject.tr),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  _showApprovalDilaog(context,staff_list);
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius:BorderRadius.circular(5),
                    border: Border.all(
                      width:1,
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(AppContents.approval.tr),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
  //================== progress bar ==========================
  Widget ErrowDialogsss() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(90),
            height: 50,
            width: 50,
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

//============================= mark attedance list show =====================
  Widget staffListWidget() {
    return Obx(() => ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var data = controller.markAttendanceInfo[index];
        selectedItem?[index] = selectedItem?[index] ?? false;
        bool? isSelectedData = selectedItem[index];
        return Card(
          elevation: 3,
          child: ListTile(
            onTap: () {
              // if (isSelectItem) {
              setState(() {
                selectedItem[index] = !isSelectedData!;
                isSelectItem = selectedItem.containsValue(true);
                if(isSelectItem)
                {
                  staff_list.add(data.id.toString());
                }
              });
              // } else {
              //   // Open Detail Page
              // }
            },
            title:  _mainUI(isSelectedData!, data),
            subtitle: Container(
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      alignment: Alignment.center,
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(image: NetworkImage(Urls.AttendanceUrls+data.pendingAttedance!.attedancTimePic,), fit: BoxFit.cover)
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(data.pendingAttedance!.punchingInTiming!=null && data.pendingAttedance!.punchingInTiming!="")...
                        {
                          Text("" + data.pendingAttedance!.punchingInTiming,
                            style: TextStyle(
                                color: AppColors.dartTextColorsBlack,
                                fontSize: AppSize.small,
                                fontWeight: FontWeight.bold
                            ),),
                        }
                      else...
                        {
                          Text("No Punching Time",
                            style: TextStyle(
                                color: AppColors.dartTextColorsBlack,
                                fontSize: AppSize.small,
                                fontWeight: FontWeight.bold
                            ),),
                        },
                      if(data.pendingAttedance!.punchingInAddress!=null && data.pendingAttedance!.punchingInAddress!="")...
                        {
                          Text(""+data.pendingAttedance!.punchingInAddress,
                            style: TextStyle(
                                color: AppColors.lightTextColorsBlack,
                                fontSize: AppSize.tw,
                                fontWeight: FontWeight.bold
                            ),),
                        }
                      else...
                      {
                        Text("No address",
                          style: TextStyle(
                              color: AppColors.lightTextColorsBlack,
                              fontSize: AppSize.tw,
                              fontWeight: FontWeight.bold
                          ),),
                      }
                    ],
                  )
                ],
              ),
            ),),
        );
      },

      itemCount: controller.markAttendanceInfo.length,

    ));

  }

  Widget _mainUI(bool isSelected, MarkAttendanceInfo ourdata) {
    // if (isSelectItem) {
      return GestureDetector(
        onTap: (){
         // selectAllAtOnceGo();
          if(isSelectItem)
          {
            staff_list.add(ourdata.id.toString());
          }

        },
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: Theme.of(context).primaryColor,
            ),
            Text(""+ourdata.staffName.toString(),style: TextStyle(
              color: AppColors.dartTextColorsBlack,
              fontWeight: FontWeight.bold

            ),),


          ],
        ),
      );
    // } else {
    //   return CircleAvatar(
    //     child: Text('${ourdata}'),
    //   );
    // }
  }
  //============================
Widget buildSingleSelectionMarker(MarkAttendanceInfo markAttendanceInfo){
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: markAttendanceInfo.seledted, onChanged: (seleted){
          setState(() {
            this.seleted=seleted!;
          });
    },
        title: Text(""+markAttendanceInfo.staffName.toString()),
        activeColor: AppColors.drakColorTheme);
}
  selectAllAtOnceGo() {
    bool isFalseAvailable = selectedItem.containsValue(false);
    selectedItem.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectItem = selectedItem.containsValue(true);
    });
  }
  void _showRejectDilaog(BuildContext context,List<String> staff_id_list) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text(AppContents.reject.tr,style: TextStyle(
              fontSize: AppSize.medium,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),),
          content:  Text(AppContents.rejectAttendance.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:  Text(AppContents.cancel.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async {
                 controller.StaffApprovalAttendance(staff_id_list,"rejected");
              } ,
              child:  Text(AppContents.ok.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }
  void _showApprovalDilaog(BuildContext context,List<String> staff_id_list) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text(AppContents.approva.tr,style: TextStyle(
              fontSize: AppSize.medium,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),),
          content:  Text(AppContents.approvalAttendace.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:  Text(AppContents.cancel.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async {
                 controller.StaffApprovalAttendance(staff_id_list,"approved");
              } ,
              child:  Text(AppContents.ok.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }
}
