import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/model/AllowanceandBonus/BounsInfo.dart';

class StaffShowBonusandAllowanceController extends GetxController{
  RxBool isLoading=false.obs;
  var user_id="";
  var bussiness_id="";
  var staff_id ="".obs;
  //RxList getBussiness = [].obs;
  RxList<BonusInfo> getBonusandAllowans=<BonusInfo>[].obs;
  BuildContext? context = Get.key.currentContext;
  RxBool isButtonEnabled = false.obs;
  RxBool previousBackEnable = false.obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  var nextDate=''.obs;
  var totalallowance="".obs;
  var total_bonus="".obs;
  RxBool closingMonth=false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentMonthData();
    showListAllowanceandBounus();
  }
  @override
  void onReady() async {
    super.onReady();
    showListAllowanceandBounus();
  }
  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => super.onStart;


//---------------------show allowance list or bonus list------------------------------

  void showListAllowanceandBounus() async{
    getBonusandAllowans.clear();
    isLoading=false.obs;
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    print("token"+token);
    user_id = prefsdf.getString("user_id").toString();
    bussiness_id=prefsdf.getString("bussiness_id").toString();
    print("userid"+user_id);
    var _futureLogin = BooksApi.staffSowBonousandAllowance(context!,token,staff_id.value.toString(),user_id,bussiness_id,DateFormat('yyyy-MM').format(DateTime.parse(currentDate.toString())));
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          isLoading=true.obs;
          if (value.info != null) {
            getBonusandAllowans.value = value.info!;
            getBonusandAllowans.refresh();
            totalallowance.value=value.totalAllowance.toString();
            total_bonus.value=value.totalBonus.toString();

            //Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
          }
        }
        else if(res=="false")
        {
          isLoading=true.obs;
        }
      });
    }
    else {
      isLoading=true.obs;
      _futureLogin.then((value) {
        String data = value.msg.toString();
        Fluttertoast.showToast(
            msg: "" + data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.drakColorTheme,
            textColor: AppColors.white,
            fontSize: AppSize.medium
        );
      });
    }
  }


  // -------------------------------------previous month  staff list show------------------------------------------
  void getPreviousMonthData() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   staff_create_date= prefsdf.getString("staff_create_date").toString();
    DateFormat dateFormat = DateFormat('yyyy-MM');
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
      showListAllowanceandBounus();
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
    DateFormat dateFormat = DateFormat('yyyy-MM');
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month+1, 1);
    var date = dateFormat.format(currentDate.value);
    currentDate.value=DateTime.parse(date);
    print("staff current"+currentDate.toString());
    nextDate.value=DateFormat('yyyy-MM').format(currentDate.value);
    var currentmonth=DateFormat('yyyy-MM').format(DateTime.now());
    var staff_create_adte=DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
    if(nextDate==staff_create_adte)
    {
      if(nextDate==currentmonth) {

        isButtonEnabled = false.obs;
        previousBackEnable = false.obs;
        showListAllowanceandBounus();
      }
      print("condition match"+currentDate.toString()+"date"+date);
    }
    else
    {

      isButtonEnabled=false.obs;
      previousBackEnable=true.obs;
      showListAllowanceandBounus();

      print("condition not match"+currentDate.toString()+"date"+date);
    }
  }
  void getCurrentMonthData() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   staff_create_date= prefsdf.getString("staff_create_date").toString();

    DateFormat dateFormat = DateFormat('yyyy-MM');
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month, 1);
    var date = dateFormat.format(currentDate.value);
    currentDate.value=DateTime.parse(date);
    print("staff current"+currentDate.toString());
    nextDate.value=DateFormat('yyyy-MM').format(currentDate.value);
    var currentmonth=DateFormat('yyyy-MM').format(DateTime.now());
    var staff_create_adte=DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
    if(nextDate==staff_create_adte)
    {
      if(nextDate==currentmonth) {
        isButtonEnabled = false.obs;
        previousBackEnable = false.obs;
        showListAllowanceandBounus();
      }
      print("condition match"+currentDate.toString()+"date"+date);
    }
    else
    {

      isButtonEnabled=false.obs;
      previousBackEnable=true.obs;
      print("condition not match"+currentDate.toString()+"date"+date);
      showListAllowanceandBounus();
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}