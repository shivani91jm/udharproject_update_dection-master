import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/model/StaffSalaryCCalculation/ClossingMonth.dart';
import 'package:udharproject/model/StaffSalaryCCalculation/CurrentMonth.dart';
import 'package:udharproject/model/StaffSalaryCCalculation/StaffSalaryCalculationInfo.dart';


class StaffSalaryManualCalculationController extends GetxController {
  BuildContext? context = Get.key.currentContext;
  RxBool isLoading=false.obs;
  RxString staaff_id=''.obs;
  RxBool previousBackEnable = false.obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  RxList<ClossingMonth> closingMonthList =<ClossingMonth>[].obs;
  RxString net_salary=''.obs;
  RxString month_salary=''.obs;
  RxString month_payment =''.obs;
  RxString month_adjustments=''.obs;
  RxString month_name=''.obs;
  RxString total_fine_amount=''.obs;
  RxString deduction=''.obs;
  RxBool isButtonEnabled=false.obs;
  var nextDate=''.obs;
  RxString closing_month_name=''.obs;
  RxString  closing_month_payment=''.obs;
  RxBool closing_flag=false.obs;
  RxBool payment_flag=false.obs;
  var type=''.obs;
  SharedPreferences? prefsdf;
  @override
  void onInit() async{
     prefsdf = await SharedPreferences.getInstance();
     staaff_id.value= prefsdf!.getString("user_id").toString();
    getCurrentMonthData();
    StaffSalaryCalulation();
    super.onInit();

  }
  //=========================staff salary calculation================================
  void StaffSalaryCalulation() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();

   //  print("token"+token);


    // if(staaff_id.value.toString()==""&& staaff_id.value!="null")
    //   {
    //       staaff_id.value=prefsdf.getString("staff_id").toString();
    //   }
    print("userid"+staaff_id.value);
    var _futureLogin = BooksApi.staffSalaryManualCalculation(context!,token, DateFormat('yyyy-MM-dd').format(currentDate.value),staaff_id.value,);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
          if (res == "true") {
            payment_flag=false.obs;
            isLoading.value=true;
            if (value.info != null) {
              StaffSalryCalculationInfo info=value.info!;
              CurrentMonth? current_month=info.currentMonth;
              if(current_month!=null) {
                deduction.value = current_month!.deduction.toString();
                month_name.value=current_month!.monthName.toString();
                var net_salry=current_month!.netSalary;
                var price = net_salry!.toStringAsFixed(2);
                print(price);
                var month_slary=current_month!.monthSalary;
                var month_slarys = month_slary!.toStringAsFixed(2);
                print(month_slarys);
                month_salary.value=month_slarys;
                month_payment.value=current_month!.monthPayments.toString();
                total_fine_amount.value=current_month!.totalFineAmount.toString();
                month_adjustments.value=current_month!.monthAdjustments.toString();
                net_salary.value=price.toString();
              }
              if(info.clossingMonth!=null && info.clossingMonth!.isNotEmpty) {
                closingMonthList.value = info.clossingMonth!;
                closingMonthList.refresh();
                if( closingMonthList.value.length>1)
                  {
                    closing_flag.value=true;
                  }
              }
            }
          }
          else if(res=="false")
          {
            isLoading.value=false;
            payment_flag=true.obs;
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
            backgroundColor: AppColors.drakColorTheme,
            textColor: AppColors.white,
            fontSize: AppSize.medium
        );
      });
    }
  }

  void getCurrentMonthData() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   staff_create_date= prefsdf.getString("staff_create_date").toString();
    staff_create_date = DateFormat('yyyy-MM-dd').format(DateTime.parse(staff_create_date));
    print(" staff_create_date"+staff_create_date);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month, 1);
    var date = dateFormat.format(currentDate.value);
    currentDate.value=DateTime.parse(date);
    print("staff current"+currentDate.toString());
    nextDate.value=DateFormat('yyyy-MM').format(currentDate.value);
    var currentmonth=DateFormat('yyyy-MM').format(DateTime.now());
    var staff_create_adte=DateFormat('yyyy-MM').format(DateTime.parse(staff_create_date));
    if(nextDate.value==staff_create_adte)
    {
      if(nextDate.value==currentmonth) {
        isButtonEnabled = false.obs;
        previousBackEnable = false.obs;
      }
      print("condition match"+currentDate.toString()+"date"+date);
    }
    else
    {
      isButtonEnabled=false.obs;
      previousBackEnable=true.obs;
      print("condition not match"+currentDate.toString()+"date"+date);
    }
  }



}