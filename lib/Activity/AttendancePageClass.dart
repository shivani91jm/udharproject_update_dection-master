import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/AddOverTimePageActivity.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/FineActivitypage.dart';
import 'package:udharproject/Activity/StaffActivityData/ShowAllStaffListSearchPageActivity.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/StaffAttendanceHistoryController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';

import 'package:udharproject/model/DayWiseStaffList/Daily.dart';
import 'package:udharproject/model/DayWiseStaffList/DayInfo.dart';
import 'package:udharproject/model/DayWiseStaffList/Hourly.dart';
import 'package:udharproject/model/DayWiseStaffList/MarkAttendanceInfo.dart';
import 'package:udharproject/model/DayWiseStaffList/Monthly.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialInfo.dart';
import '../model/DayWiseStaffList/Weekly.dart';
class AttendencePageClass extends StatefulWidget {
  const AttendencePageClass({Key? key}) : super(key: key);
  @override
  State<AttendencePageClass> createState() => _AttendencePageClassState();
}

class _AttendencePageClassState extends State<AttendencePageClass> {
  bool page=false;
  final _formkey = GlobalKey<FormState>();
  var premiusm=true;
  bool monthlyflag=false;
  bool hourly=false;
  bool weekly=false;
  bool daily=false;
  List<Monthly> getMonthlyConaList =[];
  List<Daily> getDailyList= [];
  List<Hourly> getHourlyList =[];
  List<Weekly> getWeekly=[];
  bool _isLoading=false;
  var btn_color_visiblity=false;
  String? _currentAddress;
  Position? _currentPosition;
  DateTime _selectedTime = DateTime.now();
  var totalpresent="",totalabsent="",totalhalfday="",totalpaidleave="",totalpaidfine="",totalpaidovertime="";
  DateTime currentDate = DateTime.now();
  var nextDate="";
  bool isButtonEnabled = false;
  var staffjoiningdate="2023-06-01";
  var noaatendancelistFlag=false;
  var stafflistflag=false;
  int _state = 0;
  var puchOutFlag=false;
  HistoryAttendaceController attendaceHistoryCont= Get.put(HistoryAttendaceController());
  var name="";
  var pandingApproval;
  List<MarkAttendanceInfo>  markAttendanceInfo=[];

  var markAttendanceTotal;
  bool markattendanceStatus=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    markAttendanceInfo.clear();
    getDailyList.clear();
    getHourlyList.clear();
    getMonthlyConaList.clear();
    getWeekly.clear();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBussinessManList(page);
    showStaffListData();
    _getCurrentPosition();
    currentDateMethod();
  }
  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Row(
                children: [
                  Text(AppContents.Attendance.tr,style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSize.seventin,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),)
                ])
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints)
        {
          return   SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  // ----------------------no subscription --------------------------------------------
                  if(premiusm==false)...[
                    addStaffFirstTime()
                  ]
                  else ...[
                    // ------------------take subscription but staff list not create-----------------------
                    Column(
                      children: [
                        // ------------------------------present container list----------------
                        if(stafflistflag==true)...
                        {
                          addStaffFirstTime()
                        }
                        else...
                          {
                            Container(
                              child :_isLoading==false? ErrowDialogsss(): HomePage(),
                            ),
                          }
                        ],)
                  ]

                ],
              ),
            ),
          );
        }));
  }

  void addstaffData(BuildContext context)
  {
    Navigator.pushNamed(context, RoutesNamess.contactpage);
  }
  //-----------------------------------------monthly list widget-----------------------------
   Widget  _buildMonthlyContrainer() {
    return  ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: getMonthlyConaList.length,
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
                  padding: const EdgeInsets.fromLTRB(10.0,13,10,13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(""+getMonthlyConaList[index].staffName.toString(),style: TextStyle(
                                color: AppColors.textColorsBlack,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              //-------------------punch in conatiner-----------------------------------------------------
                              GestureDetector(
                                onTap: () async{
                                  _getCurrentPosition();
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("present",getMonthlyConaList[index].staffId.toString(),"punching_in",_currentAddress.toString(),"",formattedDate.toString(),"","Monthly","present",getMonthlyConaList[index].id.toString());
                                  },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getMonthlyConaList[index].getStaffAttendance!=null&& getMonthlyConaList[index].getStaffAttendance!.isNotEmpty?getMonthlyConaList[index].getStaffAttendance?.last.attendanceMarks=="present"?BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: AppColors.green,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.Present.tr,style: TextStyle(
                                        color:  getMonthlyConaList[index].getStaffAttendance!=null &&getMonthlyConaList[index].getStaffAttendance!.isNotEmpty ?getMonthlyConaList[index].getStaffAttendance?.last.attendanceMarks=="present"?
                                        AppColors.white: AppColors.lightTextColorsBlack: AppColors.dartTextColorsBlack,
                                        fontSize: AppSize.nine,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              //----------------punch out conatiner ----------------------
                              GestureDetector(
                                onTap: () async{
                                  _getCurrentPosition();
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("half_day",getMonthlyConaList[index].staffId.toString(),"punching_in",_currentAddress.toString(),"",formattedDate.toString(),"","Monthly","half_day",getMonthlyConaList[index].id.toString());
                                  },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getMonthlyConaList[index].getStaffAttendance!=null&& getMonthlyConaList[index].getStaffAttendance!.isNotEmpty?getMonthlyConaList[index].getStaffAttendance?.last.attendanceMarks=="half_day"?BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.orangeAccent,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.HalfDay.tr,style: TextStyle(
                                        color:  getMonthlyConaList[index].getStaffAttendance!=null &&getMonthlyConaList[index].getStaffAttendance!.isNotEmpty ?getMonthlyConaList[index].getStaffAttendance?.last.attendanceMarks=="half_day"?Colors.white: Colors.black38: Colors.black45,
                                        fontSize: 9.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              // ----------------------------delete staff punch -----------------------
                              GestureDetector(
                                onTap: ()async{
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("absent",getMonthlyConaList[index].staffId.toString(),"absent",_currentAddress.toString(),"",formattedDate.toString(),"","Monthly","absent",getMonthlyConaList[index].id.toString());
                                },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getMonthlyConaList[index].getStaffAttendance!=null&& getMonthlyConaList[index].getStaffAttendance!.isNotEmpty?getMonthlyConaList[index].getStaffAttendance?.last.attendanceMarks=="absent"?BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.red,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.Absent.tr,style: TextStyle(
                                        color:  getMonthlyConaList[index].getStaffAttendance!=null &&getMonthlyConaList[index].getStaffAttendance!.isNotEmpty?getMonthlyConaList[index].getStaffAttendance?.last.attendanceMarks=="absent"?Colors.white: Colors.black38: Colors.black45,
                                        fontSize: 9.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  if(getMonthlyConaList[index].attandancStatus=="false")...
                                  {
                                    Text(AppContents.notmarked.tr,style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  }
                                  else...
                                  {
                                    if(getMonthlyConaList[index].getStaffAttendance!=null && getMonthlyConaList[index].getStaffAttendance!.isNotEmpty)...
                                    {
                                      if(getMonthlyConaList[index].getStaffAttendance!.first.attendanceMarks=="absent")...
                                      {
                                        Text(AppContents.Absent.tr,style: TextStyle(
                                            color: AppColors.lightTextColorsBlack,
                                            fontSize: AppSize.tw,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(getMonthlyConaList[index].getStaffAttendance!.first.attendanceMarks=="present")...
                                      {
                                        Text(""+getMonthlyConaList[index].getStaffAttendance!.first.working_staff_total_timing.toString()+":00 Hrs",style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(getMonthlyConaList[index].getStaffAttendance!.first.attendanceMarks=="half_day")...
                                        {

                                          Text(""+(int.parse(getMonthlyConaList[index].getStaffAttendance!.first.working_staff_total_timing.toString())/2).toString()+":00 Hrs",style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12.0,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),),
                                        }
                                    }
                                  }
                                ],
                              )
                          ),
                          // ----------------------------delete staff punch -----------------------
                          GestureDetector(
                            onTap: () async{
                              var date= DateFormat('yyyy-MM-dd').format(currentDate);
                              String id = getMonthlyConaList[index].id.toString();
                              String staff_id=getMonthlyConaList[index].staffId.toString();
                              attendaceHistoryCont.getHistoryAttendace(context, staff_id, date,id);
                              String staffname=getMonthlyConaList[index].staffName.toString();
                              String present_date=getMonthlyConaList[index].createdAt.toString();
                              String working_time_staff=getMonthlyConaList[index].getStaffAttendance!.last.working_staff_total_timing.toString();
                                   String attendance_marker=getMonthlyConaList[index].getStaffAttendance!.last.attendanceMarks.toString();
                                   String punch_status=getMonthlyConaList[index].getStaffAttendance!.last.punchStatus.toString();
                                   _showBootomSheet(id,staffname,attendance_marker,present_date,"Monthly",staff_id,"delete_attendance",working_time_staff,punch_status);

                            },
                            child: Container(
                              width: 50,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(5),
                                border: Border.all(
                                  width:1,
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                ),),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_drop_down,color: Colors.black38,size: 15,),
                              ),
                            ),
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
    );
  }

  //------------------------------------hourly list widget--------------------------------------
  Widget  _buildHourlyContrainer() {
    return  ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: getHourlyList.length,
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
                  padding: const EdgeInsets.fromLTRB(10.0,13,10,13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(""+getHourlyList[index].staffName.toString(),style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              //-------------------punch in conatiner------------
                              GestureDetector(
                                onTap: () async{
                                  _getCurrentPosition();
                                  _showTimeDialog("punching_in",getHourlyList[index].staffId.toString(),"Hourly","Punch In Time",DateFormat('dd MMM, EEE').format(currentDate),"punching_in",getHourlyList[index].id.toString());
                                  },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getHourlyList[index].getStaffAttendance!.isNotEmpty && (getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_in" || getHourlyList[index].getStaffAttendance!.isNotEmpty && getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_out")?
                                  BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: AppColors.green,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: AppColors.grey,
                                      style: BorderStyle.solid,
                                    ),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.puchin.tr,style: TextStyle(
                                        color: getHourlyList[index].getStaffAttendance!.isNotEmpty && (getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_in" || getHourlyList[index].getStaffAttendance!.isNotEmpty && getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_out")?AppColors.white:AppColors.lightTextColorsBlack,
                                        fontSize: AppSize.nine,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              //----------------punch out conatiner ----------------------
                              GestureDetector(
                                onTap: getHourlyList[index].getStaffAttendance!.isNotEmpty && getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_in"?() async{
                                  _showTimeDialog("punching_out",getHourlyList[index].staffId.toString(),"Hourly","Punch Out Time",DateFormat('dd MMM, EEE').format(currentDate),"activity_attandance_type",getHourlyList[index].id.toString());
                                }: null,
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getHourlyList[index].getStaffAttendance!.isNotEmpty && getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_out"?
                                  BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                    ),) : BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),) ,

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.puchOut.tr,style: TextStyle(
                                        color: getHourlyList[index].getStaffAttendance!.isNotEmpty && getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_out"?Colors.white:Colors.black38,
                                        fontSize: AppSize.nine,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              // ----------------------------delete staff punch -----------------------
                              GestureDetector(
                                onTap: getHourlyList[index].getStaffAttendance!.isNotEmpty && (getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_in" || getHourlyList[index].getStaffAttendance!.last.punchStatus=="punching_out")? ()async{
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("absent",getHourlyList[index].staffId.toString(),"absent",_currentAddress.toString(),"",formattedDate.toString(),"","Hourly","absent",getHourlyList[index].id.toString());
                                }:null,
                                child: Container(
                                  width: 50,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: BoxDecoration(
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.delete_forever,color:  Colors.black38,size: 15,),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  if(getHourlyList[index].attandancStatus=="false")...
                                  {
                                    Text(AppContents.Absent.tr,style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  }
                                  else...
                                  {
                                    if(getHourlyList[index].getStaffAttendance!=null && getHourlyList[index].getStaffAttendance!.isNotEmpty)...
                                    {
                                      if(getHourlyList[index].getStaffAttendance!.last.attendanceMarks=="absent")...
                                      {
                                        Text(AppContents.Absent.tr,style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(getHourlyList[index].getStaffAttendance!.last.attendanceMarks=="present")...
                                      {
                                        Text(""+getHourlyList[index].getStaffAttendance!.last.working_staff_total_timing.toString()+":00 Hrs",style: TextStyle(
                                            color: AppColors.green,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(getHourlyList[index].getStaffAttendance!.last.attendanceMarks=="half_day")...
                                        {

                                          Text(""+(int.parse(getHourlyList[index].getStaffAttendance!.last.working_staff_total_timing.toString())/2).toString()+":00 Hrs",style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12.0,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),),
                                        }
                                    }
                                  }
                                ],
                              )
                          ),
                          // ----------------------------delete staff punch -----------------------
                          GestureDetector(
                            onTap: () async{
                              String id = getHourlyList[index].id.toString();
                              String staffname=getHourlyList[index].staffName.toString();
                              String present_date=getHourlyList[index].createdAt.toString();
                              String staff_id=getHourlyList[index].staffId.toString();
                              var date= DateFormat('yyyy-MM-dd').format(currentDate);
                              attendaceHistoryCont.getHistoryAttendace(context, staff_id, date,id);
                              if(getHourlyList[index].attandancStatus=="true") {
                                String attendance_marker = getHourlyList[index].getStaffAttendance!.last.attendanceMarks.toString();
                                String working_time_staff = getHourlyList[index].getStaffAttendance!.last.working_staff_total_timing.toString();
                                String punch_status=getHourlyList[index].getStaffAttendance!.last.punchStatus.toString();
                                _showBootomSheet(id, staffname,attendance_marker, present_date, "Hourly", staff_id, "delete_attendance", working_time_staff,punch_status);
                              }
                            },
                            child: Container(
                              width: 50,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(5),
                                border: Border.all(
                                  width:1,
                                  color: AppColors.grey,
                                  style: BorderStyle.solid,
                                ),),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_drop_down,color:  Colors.black38,size: 15,),
                              ),
                            ),
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
    );
  }

  //---------------------------daily List Widget-------------------------------------------------------------------------------

  Widget  _buildDailyContrainer() {
    return  ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: getDailyList.length,
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
                  padding: const EdgeInsets.fromLTRB(10.0,13,10,13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(""+getDailyList[index].staffName.toString(),style: TextStyle(
                                color: AppColors.textColorsBlack,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              //-------------------present in conatiner-----------------------------------------------
                              GestureDetector(
                                onTap: () async{
                                  _getCurrentPosition();
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("present",getDailyList[index].staffId.toString(),"punching_in",_currentAddress.toString(),"",formattedDate.toString(),"","Daily","present",getDailyList[index].id.toString());

                                },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getDailyList[index].getStaffAttendance!=null&& getDailyList[index].getStaffAttendance!.isNotEmpty?getDailyList[index].getStaffAttendance?.last.attendanceMarks=="present"?BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: AppColors.green,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: AppColors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: AppColors.grey,
                                      style: BorderStyle.solid,
                                    ),),

                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child:  Column(
                                        children: [
                                          Text(AppContents.Present.tr,style: TextStyle(
                                              color:  getDailyList[index].getStaffAttendance!=null &&getDailyList[index].getStaffAttendance!.isNotEmpty ?getDailyList[index].getStaffAttendance?.last.attendanceMarks=="present"?Colors.white: Colors.black38: Colors.black45,
                                              fontSize: AppSize.nine,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),),

                                        ],
                                      )

                                  ),
                                ),
                              ),
                              //----------------half day out conatiner ----------------------
                              GestureDetector(
                                onTap: () async{
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("half_day",getDailyList[index].staffId.toString(),"punching_in",_currentAddress.toString(),"",formattedDate.toString(),"","Daily","half_day",getDailyList[index].id.toString());
                                  },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getDailyList[index].getStaffAttendance!=null&& getDailyList[index].getStaffAttendance!.isNotEmpty?getDailyList[index].getStaffAttendance?.last.attendanceMarks=="half_day"?BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.orangeAccent,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.HalfDay.tr,style: TextStyle(
                                        color:  getDailyList[index].getStaffAttendance!=null &&getDailyList[index].getStaffAttendance!.isNotEmpty ?getDailyList[index].getStaffAttendance?.last.attendanceMarks=="half_day"?Colors.white: Colors.black38: Colors.black45,
                                        fontSize: 9.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              // ----------------------------delete staff punch -----------------------
                              GestureDetector(
                                onTap: ()async{
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("absent",getDailyList[index].staffId.toString(),"absent",_currentAddress.toString(),"",formattedDate.toString(),"","Daily","absent",getDailyList[index].id.toString());
                                },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getDailyList[index].getStaffAttendance!=null&& getDailyList[index].getStaffAttendance!.isNotEmpty?getDailyList[index].getStaffAttendance?.last.attendanceMarks=="absent"?BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.red,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.Absent.tr,style: TextStyle(
                                        color:  getDailyList[index].getStaffAttendance!=null &&getDailyList[index].getStaffAttendance!.isNotEmpty ?getDailyList[index].getStaffAttendance?.last.attendanceMarks=="absent"?Colors.white: Colors.black38: Colors.black45,
                                        fontSize: 9.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  if(getDailyList[index].attandancStatus=="false")...
                                  {
                                    Text(AppContents.notmarked.tr,style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  }
                                  else...
                                  {
                                    if(getDailyList[index].getStaffAttendance!=null&& getDailyList[index].getStaffAttendance!.isNotEmpty)...
                                    {
                                      if(getDailyList[index].getStaffAttendance!.last.attendanceMarks=="absent")...
                                      {
                                        Text(AppContents.Absent.tr,style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.normal,))

                                      }
                                      else if(getDailyList[index].getStaffAttendance!.last.attendanceMarks=="present")...
                                      {
                                        Text(""+getDailyList[index].getStaffAttendance!.last.working_staff_total_timing.toString()+":00 Hrs",style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(getDailyList[index].getStaffAttendance!.last.attendanceMarks=="half_day")...
                                        {

                                          Text(""+(int.parse(getDailyList[index].getStaffAttendance!.last.working_staff_total_timing.toString())/2).toString()+":00 Hrs",style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12.0,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),),
                                        }
                                    }
                                  }
                                ],
                              )
                          ),
                          // ----------------------------delete staff punch -----------------------
                          GestureDetector(
                            onTap: () async{
                              String id = getDailyList[index].id.toString();
                              String staffname=getDailyList[index].staffName.toString();
                              String present_date=getDailyList[index].createdAt.toString();
                              String staff_id=getDailyList[index].staffId.toString();
                              var date= DateFormat('yyyy-MM-dd').format(currentDate);
                              attendaceHistoryCont.getHistoryAttendace(context, staff_id, date,id);
                              if(getDailyList[index].attandancStatus=="true") {
                                String attendance_marker = getDailyList[index].getStaffAttendance!.last.attendanceMarks.toString();
                                String working_time_staff = getDailyList[index].getStaffAttendance!.last.working_staff_total_timing.toString();
                                String punch_status=getDailyList[index].getStaffAttendance!.last.punchStatus.toString();
                                _showBootomSheet(id,staffname,attendance_marker,present_date,"Daily",staff_id,"delete_attendance",working_time_staff,punch_status);
                              }


                            },
                            child: Container(
                              width: 50,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(5),
                                border: Border.all(
                                  width:1,
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                ),),

                              child:   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_drop_down,color:  Colors.black38,size: 15,),
                              ),
                            ),
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
    );
  }

  //--------------------weekly list container --------------------------------------------------------------------------------
  Widget  _buildWeeklyContrainer() {
    return  ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: getWeekly.length,
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
                  padding: const EdgeInsets.fromLTRB(10.0,13,10,13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(""+getWeekly[index].staffName.toString(),style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              //-------------------punch in conatiner------------
                              GestureDetector(
                                onTap: () async{
                                  _getCurrentPosition();
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("present",getWeekly[index].staffId.toString(),"punching_in",_currentAddress.toString(),"",formattedDate.toString(),"","Weekly","present",getWeekly[index].id.toString());
                                  },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getWeekly[index].getStaffAttendance!=null&& getWeekly[index].getStaffAttendance!.isNotEmpty?getWeekly[index].getStaffAttendance?.last.attendanceMarks=="present"?BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: AppColors.green,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: AppColors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.Present.tr,style: TextStyle(
                                        color:  getWeekly[index].getStaffAttendance!=null &&getWeekly[index].getStaffAttendance!.isNotEmpty ?getWeekly[index].getStaffAttendance?.last.attendanceMarks=="present"?Colors.white: Colors.black38: Colors.black45,
                                        fontSize: 9.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              //----------------punch out conatiner ----------------------
                              GestureDetector(
                                onTap: () async{
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("half_day",getWeekly[index].staffId.toString(),"punching_in",_currentAddress.toString(),"",formattedDate.toString(),"","Weekly","half_day",getWeekly[index].id.toString());
                                  },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getWeekly[index].getStaffAttendance!=null&& getWeekly[index].getStaffAttendance!.isNotEmpty?getWeekly[index].getStaffAttendance?.last.attendanceMarks=="half_day"?BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.orangeAccent,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.HalfDay.tr,style: TextStyle(
                                        color:  getWeekly[index].getStaffAttendance!=null &&getWeekly[index].getStaffAttendance!.isNotEmpty ?getWeekly[index].getStaffAttendance?.last.attendanceMarks=="half_day"?Colors.white: Colors.black38: Colors.black45,
                                        fontSize: 9.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              // ----------------------------delete staff punch -----------------------
                              GestureDetector(
                                onTap: ()async{
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("absent",getWeekly[index].staffId.toString(),"absent",_currentAddress.toString(),"",formattedDate.toString(),"","Weekly","absent",getWeekly[index].id.toString());
                                },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: getWeekly[index].getStaffAttendance!=null&& getWeekly[index].getStaffAttendance!.isNotEmpty?getWeekly[index].getStaffAttendance?.last.attendanceMarks=="absent"?BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.red,
                                      style: BorderStyle.solid,
                                    ),):BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),): BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:  Text(AppContents.Absent.tr,style: TextStyle(
                                        color:  getWeekly[index].getStaffAttendance!=null &&getWeekly[index].getStaffAttendance!.isNotEmpty ?getWeekly[index].getStaffAttendance?.last.attendanceMarks=="absent"?Colors.white: Colors.black38: Colors.black45,
                                        fontSize: 9.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  if(getWeekly[index].attandancStatus=="false")...
                                  {
                                    Text(AppContents.notmarked.tr,style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  }
                                  else...
                                  {
                                    if(getWeekly[index].getStaffAttendance!=null && getWeekly[index].getStaffAttendance!.isNotEmpty)...
                                    {
                                      if(getWeekly[index].getStaffAttendance!.last.attendanceMarks=="absent")...
                                      {
                                        Text(AppContents.Absent.tr,style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(getWeekly[index].getStaffAttendance!.last.attendanceMarks=="present")...
                                      {
                                        Text(""+getWeekly[index].getStaffAttendance!.last.working_staff_total_timing.toString()+":00 Hrs",style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(getWeekly[index].getStaffAttendance!.last.attendanceMarks=="half_day")...
                                        {

                                          Text(""+(int.parse(getWeekly[index].getStaffAttendance!.last.working_staff_total_timing.toString())/2).toString()+":00 Hrs",style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12.0,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),),
                                        }
                                    }
                                  }
                                ],
                              )
                          ),
                          // ----------------------------delete staff punch -----------------------
                          GestureDetector(
                            onTap: () async{
                              String id = getWeekly[index].id.toString();
                              String staffname=getWeekly[index].staffName.toString();
                              String present_date=getWeekly[index].createdAt.toString();
                              String staff_id=getWeekly[index].staffId.toString();
                              var date= DateFormat('yyyy-MM-dd').format(currentDate);
                              attendaceHistoryCont.getHistoryAttendace(context, staff_id, date,id);

                              if(getWeekly[index].attandancStatus=="true")
                              {
                                String working_time_staff=getWeekly[index].getStaffAttendance!.last.working_staff_total_timing.toString();
                                String attendance_marker=getWeekly[index].getStaffAttendance!.last.attendanceMarks.toString();
                                String punch_status=getWeekly[index].getStaffAttendance!.last.punchStatus.toString();
                                _showBootomSheet(id,staffname,attendance_marker,present_date,"Weekly",staff_id,"delete_attendance",working_time_staff,punch_status);
                              }
                              },
                            child: Container(
                              width: 50,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(5),
                                border: Border.all(
                                  width:1,
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                ),),

                              child:   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_drop_down,color:  Colors.black38,size: 15,),
                              ),
                            ),
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
    );
  }
  void getBussinessManList(bool page) async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    print("token"+token);
    var user_id = prefsdf.getString("user_id").toString();
    var _futureLogin = BooksApi.bussinessListData(user_id, token, context);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if(value.info!=null) {
            SocialInfo? info = value.info;
            if(info!.getBusiness!=null) {
              var getBussiness=info.getBusiness;

              var no_of_active_bussiness = getBussiness!.length;
              var bussinessname=getBussiness.first.businessName.toString();
              if(bussinessname=="null")
              {
                setState(() {
                  _isLoading=true;
                });
                _showLogoutDilaog(context);
              }
              else
              {
                if(page==true) {
                  addstaffData(context);
                }
              }
            }
          }
        }
      });
    }
    else {
      _futureLogin.then((value) {
        String data = value.msg.toString();
        Fluttertoast.showToast(
            msg: "" + data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: AppColors.white,
            fontSize: AppSize.medium
        );
      });
    }
  }
  void _showLogoutDilaog(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text(AppContents.BusinessDeatils.tr,style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),),
          content:  Text(AppContents.enterBusinessBascDetals.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:  Text(AppContents.cancel.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async{
                Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
                  "status":"false"
                });
                      } ,
              child:  Text(AppContents.ok.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }
  void showStaffListData() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();

    var _futureLogin = BooksApi.StaffAttendanceListTodayWise(context,token,user_id,bussiness_id,DateFormat('yyyy-MM-dd').format(currentDate));
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if (value.info!= null) {
            DayInfo ? info = value.info;
            _isLoading=true;
            totalabsent=info!.totalAbsent.toString();
            totalpresent=info.totalPresent.toString();
            totalhalfday=info.totalHalfDay.toString();
            totalpaidleave=info.totalPaidLeave.toString();
            totalpaidovertime=info.totalPaidOvertime.toString();
            totalpaidfine=info.totalPaidFine.toString();
            if(info.staffAttendanceDetails!=null)
            {
              var staffAttendace=info.staffAttendanceDetails;
              setState(() {
                stafflistflag=false;
                if(staffAttendace!.monthly!=null && staffAttendace.monthly!.isNotEmpty) {
                  monthlyflag=true;
                  getMonthlyConaList = staffAttendace!.monthly!;
                }
              if(staffAttendace!.hourly!=null && staffAttendace.hourly!.isNotEmpty) {
                hourly=true;
                getHourlyList = staffAttendace.hourly!;
                 print("gethorly"+getHourlyList.length.toString());
              }

                if(staffAttendace.weekly!=null && staffAttendace.weekly!.isNotEmpty) {
                  weekly=true;
                  getWeekly = staffAttendace.weekly!;
                  print("getweekly"+getWeekly.length.toString());
                }

                if(staffAttendace.daily!=null && staffAttendace.daily!.isNotEmpty) {
                  daily=true;
                  getDailyList = staffAttendace.daily!;
                  print("getdauily"+getDailyList.length.toString());
                }

                if(getMonthlyConaList.length>1)
                {
                  monthlyflag=true;
                }
                if(getHourlyList.length>1)
                {
                  hourly=true;
                //  getHourlyList.
                }
                if(getWeekly.length>1)
                {
                  weekly=true;
                }
                if(getDailyList.length>1)
                {
                  daily=true;
                }

              });
            }
            else
              {
                setState(() {
                  stafflistflag=true;
                });
              }

          }
          if(value.markAttendanceStatus.toString()=="true")
            {

              if (value.markAttendanceInfo != null) {
                setState(() {
                  markAttendanceInfo=value.markAttendanceInfo!;
                  markAttendanceTotal=value.markAttendanceInfo!.length;
                  markattendanceStatus=true;
                });
              }
            }
          else {
             setState(() {
               markattendanceStatus=false;
             });
          }
        }
        else{
          setState(() {
            _isLoading=true;
            stafflistflag=true;
          });
        }
      });
    }
    else
    {
      _futureLogin.then((value) {
        setState(() {
          _isLoading=true;
          stafflistflag=true;
        });
        String data = value.msg.toString();
        Fluttertoast.showToast(
            msg: "" + data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }
  Widget ErrowDialogsss() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(90),
            height:50,
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
  Widget staffListWidget() {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            if(hourly==true)...
            {
              Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppContents.Hourly.tr+"( "+getHourlyList.length.toString()+")",),
                ),

              ),
              Divider(
                height: 1,
                color: AppColors.grey,
              ),
              _buildHourlyContrainer(),
            },
            if(daily==true)...
            {
              Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppContents.Daily.tr+"("+getDailyList.length.toString()+")",),
                ),

              ),
              Divider(
                height: 1,
                color: AppColors.grey,
              ),
              _buildDailyContrainer()
            },
            if(weekly==true)...
            {
              Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppContents.Weekly.tr+"("+getWeekly.length.toString()+")",),
                ),

              ),
              Divider(
                height: 1,
                color: AppColors.grey,
              ),
              _buildWeeklyContrainer()
            },

            if(monthlyflag==true)...[
              Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppContents.Monthly.tr+"("+getMonthlyConaList.length.toString()+")",),
                ),

              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              _buildMonthlyContrainer(),
            ],

          ],
        ),
      ],
    );
  }

 void _showBootomSheet(String id,String staffname,String attendance_mark,String present_date,String typw,String staff_id,String activity_attandance_type,String working_time,String punch_status) {
   showModalBottomSheet<void>(
       context: context,
       backgroundColor: Colors.white,
       elevation: 10,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10.0),
       ),
       builder: (BuildContext context)  {
         return Padding(
           padding: const EdgeInsets.all(6.0),
           child:Container(
             margin: EdgeInsets.all(10),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
             ),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           //-------------------staff name----------------------
                           Padding(
                             padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
                             child: Text(""+staffname,style: TextStyle(
                                 color: AppColors.textColorsBlack,
                                 fontSize: AppSize.medium,
                                 fontStyle: FontStyle.normal,
                                 fontWeight: FontWeight.bold),),
                           ),
                           //============================date----------------
                           Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(8.0,3.0,8.0,8),
                                 child: Text(""+DateFormat('dd MMM, EEE').format(currentDate),style: TextStyle(
                                     color: AppColors.lightTextColorsBlack,
                                     fontSize: AppSize.small,
                                     fontStyle: FontStyle.normal,
                                     fontWeight: FontWeight.bold),),
                               ),
                               GestureDetector(
                                 onTap: () async {},
                                 child: Padding(
                                   padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,8),
                                   child: GestureDetector(
                                     child: Text(""+attendance_mark,style: TextStyle(
                                         color: AppColors.green,
                                         fontSize: AppSize.small,
                                         fontStyle: FontStyle.normal,
                                         fontWeight: FontWeight.bold),),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                       GestureDetector(
                         onTap: () async{
                           Navigator.pop(context, 'Cancel');
                           _showNoteBottomSheet( context,id, staffname, attendance_mark, present_date, typw, staff_id, activity_attandance_type);
                         },
                         child: Padding(
                           padding: const EdgeInsets.fromLTRB(0,10.0,5,8),
                           child: Text(AppContents.addNote.tr,style: TextStyle(
                               color: AppColors.drakColorTheme,
                               fontSize: AppSize.medium,
                               fontStyle: FontStyle.normal,
                               fontWeight: FontWeight.bold),),
                         ),
                       ),
                     ],
                   ),
                   //---------------------------attendance history ----------------------------------------
                    Expanded(child: _attendanceHistoryWidget(),),
                   Row(
                     children: [
                       //====================overtime------------------------------------
                       Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                         decoration: punch_status!=null?punch_status=="overtime" || punch_status=="both"?
                         BoxDecoration(
                           color: AppColors.red,
                           borderRadius:BorderRadius.circular(5),
                           border: Border.all(
                             width:1,
                             color: AppColors.red,
                             style: BorderStyle.solid,
                           ),): BoxDecoration(
                           color: Colors.grey[200],
                           borderRadius:BorderRadius.circular(5),
                           border: Border.all(
                             width:1,
                             color: AppColors.grey,
                             style: BorderStyle.solid,
                           ),): BoxDecoration(
                           color: Colors.grey[200],
                           borderRadius:BorderRadius.circular(5),
                           border: Border.all(
                             width:1,
                             color: AppColors.grey,
                             style: BorderStyle.solid,
                           ),),
                         child: GestureDetector(
                           onTap: () async
                           {
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                     AddOverTimeActivity(
                                         staffname, present_date,
                                         attendance_mark, typw, staff_id,
                                         activity_attandance_type,working_time)));
                           },
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: Container(
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(
                                           5),
                                       color: Colors.black87,
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text(
                                         AppContents.ot.tr, style: TextStyle(
                                           color: AppColors.white,
                                           fontSize: 12.0,
                                           fontStyle: FontStyle.normal,
                                           fontWeight: FontWeight.bold),),
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.fromLTRB(
                                       0, 10.0, 5, 8),
                                   child: Text(AppContents.addovertime.tr,
                                     style: TextStyle(
                                         color: punch_status!=null?punch_status=="overtime" || punch_status=="both"?AppColors.white:AppColors.textColorsBlack:AppColors.textColorsBlack,
                                         fontSize: 16.0,
                                         fontStyle: FontStyle.normal,
                                         fontWeight: FontWeight.bold),),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),
                       //==================fine conatiner------------------------------------
                       Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                         decoration: punch_status!=null?punch_status=="fine" || punch_status=="both"?
                         BoxDecoration(
                           color: AppColors.red,
                           borderRadius:BorderRadius.circular(5),
                           border: Border.all(
                             width:1,
                             color: AppColors.red,
                             style: BorderStyle.solid,
                           ),): BoxDecoration(
                           color: Colors.grey[200],
                           borderRadius:BorderRadius.circular(5),
                           border: Border.all(
                             width:1,
                             color: AppColors.grey,
                             style: BorderStyle.solid,
                           ),): BoxDecoration(
                           color: Colors.grey[200],
                           borderRadius:BorderRadius.circular(5),
                           border: Border.all(
                             width:1,
                             color: AppColors.grey,
                             style: BorderStyle.solid,
                           ),),

                         child: GestureDetector(
                           onTap: () {
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                     FineActivitypage(
                                         staffname, present_date,
                                         attendance_mark, typw,
                                         activity_attandance_type,id)),);
                           },
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: Container(
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(
                                           5),
                                       color: Colors.black87,
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text(
                                         AppContents.F.tr, style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 12.0,
                                           fontStyle: FontStyle.normal,
                                           fontWeight: FontWeight.bold),),
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.fromLTRB(
                                       0, 10.0, 5, 8),
                                   child: Text(
                                     AppContents.Fine.tr, style: TextStyle(
                                       color: punch_status!=null?punch_status=="fine" || punch_status=="both"?AppColors.white:AppColors.textColorsBlack:AppColors.textColorsBlack,
                                       fontSize: 16.0,
                                       fontStyle: FontStyle.normal,
                                       fontWeight: FontWeight.bold),),
                                 ),

                               ],
                             ),
                           ),
                         ),
                       ),
                     ],),
                   Container(
                     width: 180,
                     margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                     decoration: BoxDecoration(
                       color: Colors.grey[200],
                       borderRadius:BorderRadius.circular(5),
                       border: Border.all(
                         width:1,
                         color: Colors.grey,
                         style: BorderStyle.solid,
                       ),),

                     child: GestureDetector(
                       onTap: ()async{
                         String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                         print("date"+formattedDate.toString());
                         print(formattedDate);
                         _addAttendanceMethod("present",staff_id.toString(),"paid_holiday",_currentAddress.toString(),"",formattedDate,"",typw,"paid_holiday",id);
                       },
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(5),
                                   color: Colors.black87,
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text(AppContents.pl.tr,style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 12.0,
                                       fontStyle: FontStyle.normal,
                                       fontWeight: FontWeight.bold),),
                                 ),
                               ),
                             ),
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.fromLTRB(0,10.0,5,8),
                                 child: Text(AppContents.paidLeave.tr,style: TextStyle(
                                     color: Colors.black87,
                                     fontSize: 16.0,
                                     fontStyle: FontStyle.normal,
                                     fontWeight: FontWeight.bold),),
                               ),
                             ),

                           ],
                         ),
                       ),
                     ),
                   )
                 ],
               ),
             ),
           ),
         );
       });
  }
  void _addAttendanceMethod(String aatendance_sataus,String staff_id,String punch_status,String punch_in_add,String puch_out_add,String puch_in_time,String punch_out_time,String type,String activity_attandance_type,String id) async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token = prefsdf.getString("token").toString();
    print("token" + token);
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var datetime = DateTime.now();
    print(datetime);
    var createdate=DateFormat('yyyy-MM-dd').format(currentDate);
    print("createdate"+createdate);

    var _futureLogin = BooksApi.AddAttendanceapi(context,token,user_id,bussiness_id,aatendance_sataus,
        puch_in_time,punch_out_time,punch_in_add,puch_out_add,punch_status,"business_man","","","","","","","","","","","","","",type,punch_status,createdate,id,"","approved");
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if (value.info != null) {
            var  info = value.info;
            if (info != null) {
              Fluttertoast.showToast(
                  msg: "Add Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
             setState(() {
               showStaffListData();
             });
            }
          }
        }
        else {
          String data = value.msg.toString();
          Fluttertoast.showToast(
              msg: ""+data,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      });
    }
    else {
      _futureLogin.then((value) {
        String data = value.msg.toString();
        Fluttertoast.showToast(
            msg: ""+data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );

      });
    }
  }
  //------------------------------------ get current location-----------------------------------------------
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(""+AppContents.LOCATIONENABLEDISBALE.tr)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      print("err"+e.toString());

    });
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        print(""+ place.toString());
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        print('LAT: ${_currentPosition?.latitude ?? ""}');
        print('LNG: ${_currentPosition?.longitude ?? ""}');
        print('ADDRESS: ${_currentAddress ?? ""}');
      });
    }).catchError((e) {
      print("excaption"+e.toString());

    });
  }
  void _showTimeDialog(String status,String staff_id,String type,String hoursType,String date,String activity_attandance_type,String id) async{
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(""+hoursType,style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
                          ),),
                          Text(""+date,style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0
                          ),),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppContents.hrs.tr,style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),),
                          TimePickerSpinner(
                            is24HourMode: false,
                            normalTextStyle: TextStyle(fontSize: 13, color: Colors.grey),
                            highlightedTextStyle: TextStyle(fontSize: 16, color: Colors.black),
                            spacing: 10,
                            itemHeight: 40,
                            onTimeChange: (time) {
                              setState(() {
                                _selectedTime = time;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    GestureDetector(
                        onTap: () async{

                          var time='${_selectedTime.hour}:${_selectedTime.minute}:${_selectedTime.second}';
                          if(status=="punching_in")
                          {
                            _addAttendanceMethod("present",staff_id,"punching_in",_currentAddress.toString(),"",time,"",type,activity_attandance_type,id);
                          }
                          else if(status=="punching_out"){
                            _addAttendanceMethod("present",staff_id,"punching_out","",_currentAddress.toString(),"",time,type,activity_attandance_type,id);
                          }
                          Navigator.pop(context, "",);
                          },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(child: Text(AppContents.continues.tr, style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                          ),
                          ),
                        )),
                  ]));

        });
  }

  // -------------------------------------previous month or day staff list show------------------------------------------
  void getPreviousMonthData() {
    currentDate = currentDate.subtract(Duration(days: 1));
    nextDate = DateFormat('yyyy-MM-dd').format(currentDate);
    setState(() {
      isButtonEnabled=true;
      if(nextDate==staffjoiningdate)
        {
            setState(() {
              DateTime startDate = DateTime.parse(nextDate);
              print(startDate);
              currentDate=startDate;
              noaatendancelistFlag=true;

            });
        }
       else
        {
          setState(() {
            DateTime startDate = DateTime.parse(nextDate);
            print(startDate);
            currentDate=startDate;
            noaatendancelistFlag=false;
            showStaffListData();
          });
        }
    });

    print("current date decrement"+currentDate.toString());

  }
  // ------------------------------next date according staff list show ---------------------------------------------
  void getCurrentMonthData() {
    currentDate = currentDate.add(Duration(days: 1));
    nextDate=DateFormat('yyyy-MM-dd').format(currentDate);
    print("current date incremnt"+currentDate.toString());
   var currentdatevalue= DateTime.now();
   var date= DateFormat('yyyy-MM-dd').format(currentdatevalue);
    if(nextDate==date)
      {
       setState(() {
         DateTime startDate = DateTime.parse(nextDate);
         print(startDate);
         currentDate=startDate;
         isButtonEnabled=false;
         showStaffListData();
       });
        print("condition match"+nextDate.toString()+"date"+date);
      }
    else
      {
        setState(() {
          DateTime startDate = DateTime.parse(nextDate);
          print(startDate);
          currentDate=startDate;
          isButtonEnabled=true;
          showStaffListData();
        });
        print("condition not match"+nextDate+"date"+date);
      }
  }

  Widget  addStaffFirstTime() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0,20,20,20),
                  child: Text(AppContents.addStaffEnjoy.tr,
                    style: TextStyle(
                        color: Colors.black87,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/images/swear.png',height: 35,width: 35,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,0.0,0.0,0.0),
                      child: Text(AppContents.makeAttedanceDeduct.tr, style: TextStyle(
                          color: Colors.black54,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      ),),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(ImagesAssets.calculator,height: 35,width: 35,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,0.0,0.0,0.0),
                      child: Text(AppContents.addovertimeandfime.tr, style: TextStyle(
                          color: Colors.black54,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      ),),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(ImagesAssets.ticket,height: 35,width: 35,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,0.0,0.0,0.0),
                      child: Text(AppContents.dwonloadattendance.tr, style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                      ),),
                  ],
                ),
                GestureDetector(
                    onTap: (){
                      getBussinessManList(true);

                    },
                    child:Container(
                      height: 50,
                      margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(ImagesAssets.inivite,height: 20,width: 20,),
                          ),
                          Text(AppContents.addstaff.tr, style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0,20,20,20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(AppContents.ourPromise.tr,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/shield.png',
                                width: 25,
                                height: 25,
                                fit:BoxFit.fill
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppContents.safefree.tr,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Text(AppContents.shivagroupree.tr,
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(ImagesAssets.cloud,
                                width: 25,
                                height: 25,
                                fit:BoxFit.fill
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppContents.databackup.tr,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Text(AppContents.alldatalinkphonenumber.tr,
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
}

  void currentDateMethod() {
    nextDate=currentDate.toString() ;
    DateFormat('yyyy-MM-dd').format(currentDate);
    DateTime startDate = DateTime.parse(nextDate);
    print(startDate);
  }

 Widget nodatastaffList() {
    return Center(
      child: Column(
        children: [
          Text(AppContents.attendancedate.tr,style: TextStyle(
              color: Colors.black38,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }

 Widget  staffListAttendancePage() {
    return Column(
      children: [
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
                          color: Colors.grey,
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
                            Text(""+totalpresent,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),)
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
                            Text(""+totalabsent,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),)
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
                            Text(""+totalhalfday,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //--------------------paid leave find and overtime----------------------------------------
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
                            Text(""+totalpaidleave,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),)
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
                                fontSize: 14.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                            Text(""+totalpaidfine,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),)
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
                            Text(""+totalpaidovertime,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),)
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
        //-----------------------staff attendance received nd panding or approval------------------
            if(markattendanceStatus==true)...
              {
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
                        //--------------------------- --------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Icon(Icons.pending,color: AppColors.red,),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(" "+ markAttendanceTotal.toString()+" "+AppContents.approvalpanding.tr,style: TextStyle(
                                        color: AppColors.textColorsBlack,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),

                                ],
                              ),
                            ),
                            //--------------------go approval page-----------------
                            GestureDetector(
                              onTap: () async{
                                Navigator.pushNamed(context, RoutesNamess.approvalAttendance);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(AppContents.continues.tr, style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              },
        //---------------------------------------search staff-----------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async{
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllStaffListShowAndSearchStaff()),);
              },
              child: Container(
                width: 339,
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
                      Text(AppContents.searchstaff.tr,style: TextStyle(
                          color: Colors.black38,
                          fontSize: 14.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),),
                      Icon(Icons.search,color: Colors.black38,)
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
        //-----------------------staff listing show  Container-------------------------------
        staffListWidget()
      ],
    );
}

 Widget  HomePage() {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new IconButton(
                    icon: new Icon(Icons.arrow_back_ios,
                        color: Colors.black87),
                    onPressed: () async {
                      setState(() {
                        _isLoading=false;
                        getPreviousMonthData();
                      });
                      },
                  ),
                  Text(""+DateFormat('dd MMM, EEE').format(currentDate),
                      style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold)
                  ),
                  new IconButton(
                    icon: new Icon(Icons.arrow_forward_ios,
                        color: isButtonEnabled == true ? Colors.black87 : Colors.black12),
                    onPressed: isButtonEnabled == true ? ()
                    async {
                      setState(() {
                        _isLoading=false;
                        getCurrentMonthData();
                      });

                    } : null,),
                ],
              ),
            ],
          ),
        ),
        //----------------------------------check staff create date according list show-------------------------------------------
        if(noaatendancelistFlag==true)...
        {
          nodatastaffList()
        }
        else...
        {
          staffListAttendancePage()
        }
      ],
    );
}

  Widget _attendanceHistoryWidget() {
   return  Obx(() => ListView.separated(
    scrollDirection: Axis.vertical,
     itemCount: attendaceHistoryCont.getAttendanceHistory.length,
     itemBuilder: (BuildContext context, int index) {
       return ListTile(
         title:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
               Obx(() =>   Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 3),
                   child: Text("Marked"+attendaceHistoryCont.getAttendanceHistory[index].attendanceMarks.toString(),
                       style: TextStyle(
                           color: AppColors.textColorsBlack,
                           fontSize: AppSize.small,
                           fontStyle: FontStyle.normal,
                           fontWeight: FontWeight.bold)
                   )),
               ),
               Obx(() =>  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 3),
                   child: Text("By"+attendaceHistoryCont.name.value+"on"+attendaceHistoryCont.getAttendanceHistory[index].createdAt.toString(),
                       style: TextStyle(
                           color: AppColors.lightTextColorsBlack,
                           fontSize: AppSize.tw,
                           fontStyle: FontStyle.normal,
                           fontWeight: FontWeight.bold)
                   )),)

             // else...
             // {
             //   Obx(() =>   Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 3),
             //       child: Text(""+attendaceHistoryCont.getAttendanceHistory[index].attendanceMarks.toString(),style: TextStyle(
             //         color: AppColors.lightColorTheme,
             //       ),)),
             //   ),
             //   Obx(() =>  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 3),
             //       child: Text("By"+attendaceHistoryCont.name.value,style: TextStyle(
             //
             //       ),)),)
             // }


           ],
         ),
       );
       }, separatorBuilder: (BuildContext context, int index) {
   return   Divider(
        height: 3,
      color: Colors.black87,
      );
   },
   ));

  }
  void _showNoteBottomSheet(BuildContext context,String id,String staffname,String attendance_mark,String present_date,String typw,String staff_id,String activity_attandance_type) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
                              child: Text(""+staffname,style: TextStyle(
                                  color: AppColors.textColorsBlack,
                                  fontSize: AppSize.medium,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold),),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8.0,3.0,8.0,8),
                                  child: Text(""+DateFormat('dd MMM, EEE').format(DateTime.parse(present_date)),style: TextStyle(
                                      color: AppColors.lightTextColorsBlack,
                                      fontSize: AppSize.small,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,8),
                                  child: Text(""+attendance_mark,style: TextStyle(
                                      color: AppColors.green,
                                      fontSize: AppSize.small,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //----------------------------------delete note ----------------------------
                        GestureDetector(
                          onTap: () async{
                            var date= DateFormat('yyyy-MM-dd').format(currentDate);
                            attendaceHistoryCont.deleteNoteApi(context, id, date);

                          },
                          child: Container(
                            width: 50,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(5),
                              border: Border.all(
                                width:1,
                                color: Colors.grey,
                                style: BorderStyle.solid,
                              ),),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.delete_forever,color: AppColors.lightTextColorsBlack,size: AppSize.fitlarge,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //------------------------------add note controller -------------------------------
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          new LengthLimitingTextInputFormatter(15)
                        ],
                        controller: attendaceHistoryCont.notecontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is  Requires!!';
                          }
                          else if (value.length < 6) {
                            return "Password should be atleast 6 characters";
                          } else if (value.length > 15) {
                            return "Password should not be greater than 15 characters";
                          }
                          return null;
                        },
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
//---------------------------------add note btn--------------------------
                    GestureDetector(
                      onTap: () async{
                        attendaceHistoryCont.addNoteApi(context, id,  DateFormat('yyyy-MM-dd').format(currentDate));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 80, 20, 20),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              AppColors.lightColorTheme,
                              AppColors.drakColorTheme,

                            ])),
                        child: Center(
                          child: Text(AppContents.continues.tr, style: TextStyle(
                              color: AppColors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}
