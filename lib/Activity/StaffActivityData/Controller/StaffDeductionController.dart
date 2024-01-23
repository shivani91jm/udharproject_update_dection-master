import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/StaffActivityData/SendSmsModel.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';

class StaffSalaryDeduction extends GetxController {

  Rx<DateTime> selectedDatess = DateTime.now().obs;
  BuildContext? context = Get.key.currentContext;
  TextEditingController et_amount= TextEditingController();
  TextEditingController et_noe= TextEditingController();
  RxBool isLoading=false.obs;
  var selectedPaymentType = 'PF'.obs;
  final sendSmSselectedOption = 1.obs; // Default selected option ID
  final checkboxes = <SendSmsModel>[].obs;
  //---------------get date--------------------------------
  void selectDateMthod() async {

    final DateTime? selectedDate = await showDatePicker(
        context: context!,
        initialDate: selectedDatess.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: (DateTime date) {
          // Disable current date and upcoming dates
          return date.isBefore(DateTime.now());
        }
    );

    if (selectedDate != null) {
      selectedDatess.value = selectedDate;
    }
  }

  //------------------------- api ------------------------------------

  void getStaffSalaryDeduction(String staff_id ) async{
    isLoading.value=true;
    var date=DateFormat('yyyy-MM-dd').format(selectedDatess.value);
  var amount=  et_amount.value.text;
 var note=   et_noe.text;
 print("date"+date+"amount"+amount+"note"+note);
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var business_owner = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.staffSalaryDeduction(context!,token,staff_id,business_owner,bussiness_id,selectedPaymentType.value.toString(),amount,date,note);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if(res!=null)
        {
          if (res== "true") {
            isLoading.value=false;
            Fluttertoast.showToast(
                msg: "Salary Deducted successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepPurpleAccent,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pushNamed(context!, RoutesNamess.businessmandashboard);
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
  void updatePaymentTypeValue(Object? value) {
    selectedPaymentType.value = value.toString();
    print("paymentflag"+  selectedPaymentType.value.toString());
  }
  void setSelectedOption(int optionId) {
    sendSmSselectedOption.value = optionId;
  }
  void toggleCheckbox(int index) {
    checkboxes[index].isSelected.toggle();
  }

}