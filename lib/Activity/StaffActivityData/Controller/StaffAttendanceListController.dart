import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:http/http.dart' as http;
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/model/MonthlyWiseAttendance/AttendanceListInfo.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialInfo.dart';
import '../../../model/SocialMediaLogin/GetBussiness.dart';

class StaffAttendanceListController extends GetxController {
  RxList<dynamic> attendaceList=[].obs;
  RxBool isLoading = false.obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  RxBool isButtonEnabled=false.obs;
  RxBool previousBackEnable=false.obs;
  RxBool LeaveApplyFlag=false.obs;
  var nextDate;
  var totalabsent="0".obs,totalpresent="".obs,totalhalfday="".obs,totalpaidleave="".obs,totalpaidovertime="".obs,totalpaidfine="".obs;
  var isssLoading = false.obs;
  var staffname=''.obs;
  RxList<GetBusiness>? getBusiness=<GetBusiness>[].obs;
  Object? selectedUser;
  var bussinessName="".obs;
  RxList<AttendanceListInfo> datesList = <AttendanceListInfo>[].obs;
  BuildContext? context = Get.key.currentContext;
  RxBool attendace_button_enable=false.obs;
  var selected = ''.obs;
//--------------------------show bussiness man list ---------------------------------
  void getBussinessManList() async {
    getBusiness!.clear();
    print("data"+getBusiness!.length.toString());
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    print("token"+token);
    var user_id = prefsdf.getString("businessman_id").toString();

    print("user_id"+user_id.toString());
    var _futureLogin = BooksApi.bussinessListData(user_id, token,context!);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if(value.info!=null) {
            SocialInfo? info = value.info;
            if(info!.getBusiness!=null && info.getBusiness!.isNotEmpty) {
             getBusiness!.value =info!.getBusiness!;
             bussinessName.value=info!.getBusiness!.first.businessName.toString();
             print("getvalue"+getBusiness!.length.toString());
            }
            getBusiness!.refresh();

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
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }
  //------------------------- bussiness radio button change method -------------------------------------------------
  void updateBusinessSelectedValue(Object? value) {
      selectedUser = value;
  }
        @override
        void onInit() {
          // TODO: implement onInit
          super.onInit();
          getBussinessManList();
          getCurrentMonthData();

          getStaffAttendanceList();

        }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //showStaffListData();
  }
  // -------------------------------------previous month  staff list show------------------------------------------
  void getPreviousMonthData() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   staff_create_date= prefsdf.getString("staff_create_date").toString();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month-1, 1);
    String formattedDate = dateFormat.format(currentDate.value);
    print("condition matched"+formattedDate.toString());
    var nextDate=DateFormat('yyyy-MM').format(DateTime.parse(formattedDate));
      isButtonEnabled=true.obs;
      var staff_create_adte= DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
      if(nextDate==staff_create_adte)
      {
        print("condition matched");
        previousBackEnable=false.obs;
        isButtonEnabled=true.obs;
        getStaffAttendanceList();
      }
      else
      {
          isButtonEnabled=true.obs;
          previousBackEnable=true.obs;
          print("condition not matched");
          getCurrentMonthDataBack();

      }

    print("current date decrement"+currentDate.toString());

  }
  // ------------------------------next date according staff list show ---------------------------------------------
  void getCurrentMonthDataBack() async {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   staff_create_date= prefsdf.getString("staff_create_date").toString();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month+1, 1);
    var date = dateFormat.format(currentDate.value);
    currentDate.value=DateTime.parse(date);
    print("staff current"+currentDate.toString());
    nextDate=DateFormat('yyyy-MM').format(currentDate.value);
    var currentmonth=DateFormat('yyyy-MM').format(DateTime.now());
    var staff_create_adte=DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
    if(nextDate==staff_create_adte)
    {
      if(nextDate==currentmonth) {

          isButtonEnabled = false.obs;
          previousBackEnable = false.obs;
          getStaffAttendanceList();
      }
      print("condition match"+currentDate.toString()+"date"+date);
    }
    else
    {

        isButtonEnabled=false.obs;
        previousBackEnable=true.obs;
        getStaffAttendanceList();

      print("condition not match"+currentDate.toString()+"date"+date);
    }
  }

  //------------------------------staff attendance list -------------------------------------------
  void getStaffAttendanceList() async{
    datesList.clear();
    isLoading.value=true;
    BuildContext? context = Get.key.currentContext;
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var business_owner=prefsdf.getString("businessman_id").toString();
    var staff_id=prefsdf.getString("staff_id").toString();
    var salary_type=prefsdf.getString("salary_payment_type").toString();
    var _futureLogin = BooksApi.StaffAttendanceListMonthyWise(context!,token,business_owner,bussiness_id,salary_type,DateFormat('yyyy-MM-dd').format(currentDate.value),user_id);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.Zero;
        if(res!=null)
        {
          if (res!.response== "true") {
            isLoading.value=false;
            if (value.Zero!= null) {
              var info  = value.Zero;
              totalabsent.value=info!.totalAbsent.toString();
              totalpresent.value=info.totalPresent.toString();
              totalhalfday.value=info.totalHalfDay.toString();
              totalpaidleave.value=info.totalPaidLeave.toString();
              totalpaidovertime.value=info.totalPaidOvertime.toString();
              totalpaidfine.value=info.totalPaidFine.toString();
            }
            if(value.info!=null)
            {
              isLoading.value=false;
              var info=value.info;
              datesList.value=info!;
              datesList.sort((a, b) => b.date!.compareTo(a!.date.toString()));
              datesList.refresh();
              print("attendace_list"+datesList.first.attandancStatus.toString());
              var currentDate=DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
              print("attendace_list"+datesList.first.date.toString()+"vsdgvfsdvf"+currentDate);
              if(datesList.first.attandancStatus.toString()=="false")
                {
                  if(currentDate==datesList.first.date.toString())
                    {
                      attendace_button_enable=true.obs;
                    }
                }
              else
                {
                  attendace_button_enable=false.obs;
                }

            }
          }
          else
          {
            isLoading.value=false;
          }
        }
      });
    }
    else {
      _futureLogin.then((value) {
        isLoading.value=false;
      });
    }

  }

  void storeValue(String ) async{
    SharedPreferences loginData = await SharedPreferences.getInstance();
    // loginData.setString("user_id", info.id.toString());
    // loginData.setString("email", info.email.toString());
    // loginData.setString("name", info.name.toString());
    // loginData.setString("mobile", info.mobile.toString());
    // loginData.setString("bussiness_id", getbusiness_id);

  }

  void getCurrentMonthData() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   staff_create_date= prefsdf.getString("staff_create_date").toString();

    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month, 1);
    var date = dateFormat.format(currentDate.value);
    currentDate.value=DateTime.parse(date);
    print("staff current"+currentDate.toString());
    nextDate=DateFormat('yyyy-MM').format(currentDate.value);
    var currentmonth=DateFormat('yyyy-MM').format(DateTime.now());
    var staff_create_adte=DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
    if(nextDate==staff_create_adte)
    {
      if(nextDate==currentmonth) {
         isButtonEnabled = false.obs;
          previousBackEnable = false.obs;
          getStaffAttendanceList();
      }
      print("condition match"+currentDate.toString()+"date"+date);
    }
    else
    {

        isButtonEnabled=false.obs;
        previousBackEnable=true.obs;
        print("condition not match"+currentDate.toString()+"date"+date);
        getStaffAttendanceList();
    }
  }

  void updateTypeValue(Object? value) {
    selected.value = value.toString();
  }

}
