import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/AddOverTimePageActivity.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/FineActivitypage.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/model/MonthlyWiseAttendance/AttendanceListInfo.dart';
import 'package:udharproject/model/MonthlyWiseAttendance/StaffAttendanceDetails.dart';

class AttendanceByParticularStaff extends StatefulWidget {
var data;
  AttendanceByParticularStaff(this.data);
  @override
  State<AttendanceByParticularStaff> createState() => _AttendanceByParticularStaffState();
}

class _AttendanceByParticularStaffState extends State<AttendanceByParticularStaff> {
  var staffid,salary_type,staff_create_date,staff_name,id;

  var _isLoading=false;
  List<AttendanceListInfo> datesList = [];
  var totalpresent="",totalabsent="",totalhalfday="",totalpaidleave="",totalpaidfine="",totalpaidovertime="";
  DateTime currentDate = DateTime.now();
  var nextDate="";
  bool isButtonEnabled = false;
  bool previousBackEnable=false;
  Position? _currentPosition;
  String? _currentAddress;
  DateTime _selectedTime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    staffid=widget.data['staff_id'].toString();
    salary_type=widget.data['salary_type'].toString();
    staff_create_date=widget.data['staff_create_date'].toString();
    staff_create_date="2023-06-01";
    print("staff_create_date"+staff_create_date.toString());
    staff_name=widget.data['staff_name'].toString();
    id=widget.data['id'].toString();
    getCurrentMonthData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    datesList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppContents.staffDetails.tr),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        return SingleChildScrollView(
        child:  Column(
          children: [
            Container(
              child: _isLoading==true? ErrowDialogsss(): staffListWidget(),

            )
          ],),
        );
     },
    ));
  }
  Widget ErrowDialogsss() {
    return Padding(
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
  Widget  staffListWidget() {
    return Column(
      children: [
        //-----------------------------previous month and current month---------------------------------
        Card(
          elevation: 5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new IconButton(
                    icon: new Icon(Icons.arrow_back_ios,
                        color: previousBackEnable==true?AppColors.textColorsBlack: AppColors.disableIcon ),
                    onPressed:previousBackEnable==true? () async {
                      setState(() {
                        _isLoading=false;
                        getPreviousMonthData();
                      });
                    }: null,
                  ),
                  Text(""+DateFormat('MMMM yyyy').format(currentDate), style: TextStyle(
                      color:  AppColors.textColorsBlack,
                      fontSize: AppSize.medium,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold)
                  ),
                  new IconButton(
                    icon: new Icon(Icons.arrow_forward_ios,
                        color: isButtonEnabled == true ? AppColors.textColorsBlack: AppColors.disableIcon),
                    onPressed: isButtonEnabled == true ? () async {
                      setState(() {
                        _isLoading=false;
                        getCurrentMonthDataBack();
                      });
                    } : null,),
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
                                fontSize: AppSize.small,
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
        if(salary_type=="Hourly")...
          {
             _buildHourlyContrainer(),
          }
        else...
          {

            _buildMonthlyContrainer(),
          }

      ],
    );
  }
  Widget  _buildHourlyContrainer() {
    return  ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: datesList.length,
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
                            child: Text(""+datesList[index].staffName.toString(),style: TextStyle(
                                color: Colors.black87,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              //-------------------punch in conatiner------------
                              GestureDetector(
                                onTap: () async{
                                  _getCurrentPosition();
                                  _showTimeDialog("punching_in",datesList[index].staffId.toString(),"Hourly","Punch In Time",DateFormat('dd MMM, EEE').format(DateTime.parse(datesList[index].date.toString())),"punche_in",datesList[index].id.toString(),datesList[index].date.toString());
                                },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: datesList[index].staffAttendanceDetails!.isNotEmpty && (datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_in" || datesList[index].staffAttendanceDetails!.isNotEmpty && datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_out")?
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
                                        color: datesList[index].staffAttendanceDetails!.isNotEmpty && (datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_in" || datesList[index].staffAttendanceDetails!.isNotEmpty && datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_out")?AppColors.white:AppColors.lightTextColorsBlack,
                                        fontSize: AppSize.nine,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              //----------------punch out conatiner ----------------------
                              GestureDetector(
                                onTap: datesList[index].staffAttendanceDetails!.isNotEmpty && datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_in"?() async{
                                  _showTimeDialog("punching_out",datesList[index].staffId.toString(),"Hourly","Punch Out Time",DateFormat('dd MMM, EEE').format(DateTime.parse(datesList[index].date.toString())),"activity_attandance_type",datesList[index].id.toString(),datesList[index].date.toString());
                                }: null,
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: datesList[index].staffAttendanceDetails!.isNotEmpty && datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_out"?
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
                                        color: datesList[index].staffAttendanceDetails!.isNotEmpty && datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_out"?Colors.white:Colors.black38,
                                        fontSize: AppSize.nine,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              // ----------------------------delete staff punch -----------------------
                              GestureDetector(
                                onTap: datesList[index].staffAttendanceDetails!.isNotEmpty && (datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_in" || datesList[index].staffAttendanceDetails!.last.punchStatus=="punching_out")? ()async{
                                  String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
                                  print("date"+formattedDate.toString());
                                  _addAttendanceMethod("absent",datesList[index].staffId.toString(),"absent",_currentAddress.toString(),"",formattedDate.toString(),"","Hourly","absent",datesList[index].date.toString(),datesList[index].id.toString());
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
                                  if(datesList[index].attandancStatus=="false")...
                                  {
                                    Text(AppContents.Absent.tr,style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  }
                                  else...
                                  {
                                    if(datesList[index].staffAttendanceDetails!=null && datesList[index].staffAttendanceDetails!.isNotEmpty)...
                                    {
                                      if(datesList[index].staffAttendanceDetails!.last.attendanceMarks=="absent")...
                                      {
                                        Text(AppContents.Absent.tr,style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(datesList[index].staffAttendanceDetails!.last.attendanceMarks=="present")...
                                      {
                                        Text(""+datesList[index].staffAttendanceDetails!.last.working_staff_total_timing.toString()+":00 Hrs",style: TextStyle(
                                            color: AppColors.green,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(datesList[index].staffAttendanceDetails!.last.attendanceMarks=="half_day")...
                                        {

                                          Text(""+(int.parse(datesList[index].staffAttendanceDetails!.last.working_staff_total_timing.toString())/2).toString()+":00 Hrs",style: TextStyle(
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
                              String id = datesList[index].id.toString();
                              String staffname=datesList[index].staffName.toString();
                              String present_date=datesList[index].createdAt.toString();
                              String staff_id=datesList[index].staffId.toString();
                              var date= DateFormat('yyyy-MM-dd').format(currentDate);
                             // attendaceHistoryCont.getHistoryAttendace(context, staff_id, date,id);
                              if(datesList[index].attandancStatus=="true") {
                                String attendance_marker = datesList[index].staffAttendanceDetails!.last.attendanceMarks.toString();
                                String working_time_staff = datesList[index].staffAttendanceDetails!.last.working_staff_total_timing.toString();
                                _showBootomSheet(context,id, staffname,attendance_marker, present_date, "Hourly", staff_id, "delete_attendance", working_time_staff);
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
  void getStaffAttendanceList() async{
    _isLoading=true;
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.StaffAttendanceListMonthyWise(context,token,user_id,bussiness_id,salary_type,DateFormat('yyyy-MM-dd').format(currentDate),id);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.Zero;

        if(res!=null)
          {
            if (res!.response== "true") {
              if (value.Zero!= null) {
                var info  = value.Zero;
                totalabsent=info!.totalAbsent.toString();
                totalpresent=info.totalPresent.toString();
                totalhalfday=info.totalHalfDay.toString();
                totalpaidleave=info.totalPaidLeave.toString();
                totalpaidovertime=info.totalPaidOvertime.toString();
                totalpaidfine=info.totalPaidFine.toString();
              }
              if(value.info!=null)
              {
                _isLoading=false;
                var info=value.info;
                setState(() {
                  datesList=info!;
                  datesList.sort((a, b) => b.date!.compareTo(a!.date.toString()));

                });
              }
            }
            else
            {
              setState(() {
                _isLoading=false;
              });
            }
          }
      });
    }
    else {
      _futureLogin.then((value) {
        setState(() {
          _isLoading=true;
        });
      });
    }

  }
  // current mouth day get
//   void getCurrentMonthData() {
//     // Get the start of the previous month
//     DateTime currentmoth = DateTime(currentDate.year, currentDate.month);
//     // Get the number of days in the previous month
//     int maxDays = DateTime(currentmoth.year, currentmoth.month + 1, 0).day;
//
//     // Loop through the days of the previous month
//     for (int day = 1; day <= maxDays; day++) {
//       DateTime previousDate = DateTime(currentmoth.year, currentmoth.month, day);
//
//       if (previousDate.isBefore(currentDate)) {
//         datesList.add(previousDate.toString());
//       }
//     }
//
//     // Print the dates in the list
//     // for (DateTime date in datesList) {
//     //   print(DateFormat('yyyy-MM-dd').format(date));
//     // }
//   }
//   void getPreviousMonthData() {
//     // Get the start of the previous month
//     DateTime currentmoth = DateTime(currentDate.year, currentDate.month-1);
//
//     // Get the number of days in the previous month
//     int maxDays = DateTime(currentmoth.year, currentmoth.month + 1, 0).day;
//
//     // Loop through the days of the previous month
//     for (int day = 1; day <= maxDays; day++) {
//       DateTime previousDate = DateTime(currentmoth.year, currentmoth.month, day);
//
//       if (previousDate.isBefore(currentDate)) {
//         //datesList.add(previousDate);
//       }
//     }
//
//     // // Print the dates in the list
//     // for (DateTime date in datesList) {
//     //   print(DateFormat('yyyy-MM-dd').format(date));
//     // }
//   }

  // -------------------------------------previous month  staff list show------------------------------------------
  void getPreviousMonthData() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
     currentDate = DateTime(currentDate.year, currentDate.month-1, 1);
    String formattedDate = dateFormat.format(currentDate);
    print("condition matched"+formattedDate.toString());
    var nextDate=DateFormat('yyyy-MM').format(DateTime.parse(formattedDate));
    setState(() {
      isButtonEnabled=true;
      var staff_create_adte= DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
      if(nextDate==staff_create_adte)
      {
        print("condition matched");
        previousBackEnable=false;
        isButtonEnabled=true;
        getStaffAttendanceList();
      }
      else
      {
        setState(() {
          isButtonEnabled=true;
          previousBackEnable=true;
          print("condition not matched");
          getCurrentMonthDataBack();
        });
      }
    });
    print("current date decrement"+currentDate.toString());

  }
  // ------------------------------next date according staff list show ---------------------------------------------
  void getCurrentMonthDataBack() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    currentDate = DateTime(currentDate.year, currentDate.month+1, 1);
    var date = dateFormat.format(currentDate);
    currentDate=DateTime.parse(date);
    print("staff current"+currentDate.toString());
    nextDate=DateFormat('yyyy-MM').format(currentDate);
    var currentmonth=DateFormat('yyyy-MM').format(DateTime.now());
    var staff_create_adte=DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
    if(nextDate==staff_create_adte)
      {
      if(nextDate==currentmonth) {
      setState(() {
        isButtonEnabled = false;
        previousBackEnable = false;
      });
    }
      print("condition match"+currentDate.toString()+"date"+date);
    }
    else
    {
      setState(() {
        isButtonEnabled=false;
        previousBackEnable=true;
        getStaffAttendanceList();
      });
      print("condition not match"+currentDate.toString()+"date"+date);
    }
  }
  //-------------------------------- montly ,weekly -----------------------------------
  Widget  _buildMonthlyContrainer() {
    return  ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: datesList.length,
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
                            child: Text(""+DateFormat('dd MMM, EEE').format(DateTime.parse(datesList[index].date.toString())),style: TextStyle(
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
                                  _addAttendanceMethod("present",datesList[index].staffId.toString(),"punching_in",_currentAddress.toString(),"",formattedDate.toString(),"","Monthly","present",datesList[index].date.toString(),datesList[index].id.toString());

                                },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: datesList[index].staffAttendanceDetails!=null&& datesList[index].staffAttendanceDetails!.isNotEmpty?datesList[index].staffAttendanceDetails?.first.attendanceMarks=="present"?BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:BorderRadius.circular(5),
                                    border: Border.all(
                                      width:1,
                                      color: Colors.green,
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
                                        color:  datesList[index].staffAttendanceDetails!=null &&datesList[index].staffAttendanceDetails!.isNotEmpty ?datesList[index].staffAttendanceDetails?.first.attendanceMarks=="present"?Colors.white: Colors.black38: Colors.black45,
                                        fontSize: 9.0,
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
                                  var date=DateFormat('dd MMM, EEE').format(DateTime.parse(datesList[index].date.toString()));
                                  _addAttendanceMethod("half_day",datesList[index].staffId.toString(),"punching_in",_currentAddress.toString(),"",formattedDate.toString(),"","Monthly","half_day",datesList[index].date.toString(),datesList[index].id.toString());
                                },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: datesList[index].staffAttendanceDetails!=null&& datesList[index].staffAttendanceDetails!.isNotEmpty?datesList[index].staffAttendanceDetails?.first.attendanceMarks=="half_day"?BoxDecoration(
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
                                        color:  datesList[index].staffAttendanceDetails!=null &&datesList[index].staffAttendanceDetails!.isNotEmpty ?datesList[index].staffAttendanceDetails?.first.attendanceMarks=="half_day"?Colors.white: Colors.black38: Colors.black45,
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
                                  var date=DateFormat('dd MMM, EEE').format(DateTime.parse(datesList[index].date.toString()));
                                  _addAttendanceMethod("absent",datesList[index].staffId.toString(),"absent",_currentAddress.toString(),"",formattedDate.toString(),"","Monthly","absent",datesList[index].date.toString(),datesList[index].id.toString());
                                },
                                child: Container(
                                  width: 70,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  decoration: datesList[index].staffAttendanceDetails!=null&& datesList[index].staffAttendanceDetails!.isNotEmpty?datesList[index].staffAttendanceDetails?.first.attendanceMarks=="absent"?BoxDecoration(
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
                                        color:  datesList[index].staffAttendanceDetails!=null &&datesList[index].staffAttendanceDetails!.isNotEmpty?datesList[index].staffAttendanceDetails?.first.attendanceMarks=="absent"?AppColors.white: AppColors.lightTextColorsBlack: Colors.black45,
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
                                  if(datesList[index].attandancStatus=="false")...
                                  {
                                    Text(AppContents.notmarked.tr,style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  }
                                  else...
                                  {
                                    if(datesList[index].staffAttendanceDetails!=null && datesList[index].staffAttendanceDetails!.isNotEmpty)...
                                    {
                                      if(datesList[index].staffAttendanceDetails!.first.attendanceMarks=="absent")...
                                      {
                                        Text(AppContents.Absent.tr,style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(datesList[index].staffAttendanceDetails!.first.attendanceMarks=="present")...
                                      {
                                        Text(""+datesList[index].staffAttendanceDetails!.first.working_staff_total_timing.toString()+":00 Hrs",style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      }
                                      else if(datesList[index].staffAttendanceDetails!.first.attendanceMarks=="half_day")...
                                        {

                                          Text(""+(int.parse(datesList[index].staffAttendanceDetails!.first.working_staff_total_timing.toString())/2).toString()+":00 Hrs",style: TextStyle(
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
                              var date=DateFormat('dd MMM, EEE').format(DateTime.parse(datesList[index].date.toString()));
                              String id = datesList[index].id.toString();
                            // attendaceHistoryCont.getHistoryAttendace(context, id, date);
                              String staffname=datesList[index].staffName.toString();
                              String staff_id=datesList[index].staffId.toString();

                              if(datesList[index].attandancStatus=="true") {
                                String attendance_mark= datesList[index].staffAttendanceDetails!.last.attendanceMarks.toString();
                                String working_time = datesList[index].staffAttendanceDetails!.last.working_staff_total_timing.toString();
                                _showBootomSheet(context, id, staffname, attendance_mark, date, salary_type, staff_id, "delete_attendance",working_time);
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
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
          content: Text(AppContents.LOCATIONENABLEDISBALE.tr)));
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
  void _addAttendanceMethod(String aatendance_sataus,String staff_id,String punch_status,String punch_in_add,String puch_out_add,String puch_in_time,String punch_out_time,String type,String activity_attandance_type,String present_date,String id) async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token = prefsdf.getString("token").toString();
    print("token" + token);
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    String datetime = DateTime.now().toString();
    print(datetime);
    print("prsent date"+present_date);
   var present_dates= DateFormat('yyyy-MM-dd').format(DateTime.parse(present_date));
   var _futureLogin = BooksApi.AddAttendanceapi(context,token,user_id,bussiness_id,aatendance_sataus,
        puch_in_time,punch_out_time,punch_in_add,puch_out_add,punch_status,"business_man","","","","","","","","","","","","","",type,punch_status,present_dates,id,"","approved");
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
                getStaffAttendanceList();
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
              backgroundColor: AppColors.drakColorTheme,
              textColor: AppColors.white,
              fontSize: AppSize.medium
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
  void _showBootomSheet(BuildContext context,String id,String staffname,String attendance_mark,String present_date,String typw,String staff_id,String activity_attandance_type,String working_staff_time) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
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
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(""+staffname,style: TextStyle(
                                      color: AppColors.textColorsBlack,
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(""+present_date,style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 14.0,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,10.0,5,8),
                              child: Text(AppContents.paidLeave.tr,style: TextStyle(
                                  color: AppColors.drakColorTheme,
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        //conatiner contest
                        Row(
                          children: [

                          ],
                        ),
                        Row(
                          children: [
                            Container(
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
                                onTap: () async
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddOverTimeActivity(staffname,present_date,attendance_mark,typw,staff_id,activity_attandance_type,working_staff_time)));
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
                                            child: Text(AppContents.ot.tr,style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,10.0,5,8),
                                        child: Text(AppContents.addovertime.tr,style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
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
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  FineActivitypage(staffname,present_date,attendance_mark,typw,activity_attandance_type,id)),);
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
                                            child: Text(AppContents.F.tr,style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,10.0,5,8),
                                        child: Text(AppContents.Fine.tr,style: TextStyle(
                                            color: Colors.black87,
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

                              _addAttendanceMethod("present",staff_id.toString(),"paid_holiday",_currentAddress.toString(),"",formattedDate,"",typw,"paid_holiday",present_date,id);
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
                                  Expanded(child:  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,10.0,5,8),
                                    child: Text(AppContents.paidLeave.tr,style: TextStyle(
                                        color: AppColors.textColorsBlack,
                                        fontSize: 16.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),),
                                  ),),

                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
  void _showTimeDialog(String status,String staff_id,String type,String hoursType,String date,String activity_attandance_type,String id, String present_date_index) async{
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
                              color: AppColors.textColorsBlack,
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
                            _addAttendanceMethod("present",staff_id,"punching_in",_currentAddress.toString(),"",time,"",type,activity_attandance_type,present_date_index,id);
                          }
                          else if(status=="punching_out"){
                            _addAttendanceMethod("present",staff_id,"punching_out","",_currentAddress.toString(),"",time,type,activity_attandance_type,present_date_index,id);
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

  void getCurrentMonthData() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    currentDate = DateTime(currentDate.year, currentDate.month, 1);
    var date = dateFormat.format(currentDate);
    currentDate=DateTime.parse(date);
    print("staff current"+currentDate.toString());
    nextDate=DateFormat('yyyy-MM').format(currentDate);
    var currentmonth=DateFormat('yyyy-MM').format(DateTime.now());
    var staff_create_adte=DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
    if(nextDate==staff_create_adte)
    {
      if(nextDate==currentmonth) {
        setState(() {
          isButtonEnabled = false;
          previousBackEnable = false;
        });
      }
      print("condition match"+currentDate.toString()+"date"+date);
    }
    else
    {
      setState(() {
        isButtonEnabled=false;
        previousBackEnable=true;
        getStaffAttendanceList();
      });
      print("condition not match"+currentDate.toString()+"date"+date);
    }
  }

}
