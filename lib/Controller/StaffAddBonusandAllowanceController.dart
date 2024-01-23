import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';

class StaffBonusController extends GetxController
{

  TextEditingController et_amount = TextEditingController();
  TextEditingController et_desc= TextEditingController();
  Rx<DateTime> selectedDatess = DateTime.now().obs;
  var selected = 'Already Paid'.obs;
  var selectedAllowanceTye = 'Allowance'.obs;
  BuildContext? context = Get.key.currentContext;
  RxBool paymenttypeflag=true.obs;
  RxBool isLoading=false.obs;
  RxInt state=0.obs;
  var isButtonEnabled = false.obs;


  void updateTypeValue(Object? value) {
    selected.value = value.toString();
    print("paymentflag"+  paymenttypeflag.value.toString());
  }
  void updateAllowanceandBonus(Object? value) {
    selectedAllowanceTye.value = value.toString();
    paymenttypeflag.value = !paymenttypeflag.value;
    print("paymentflag"+  paymenttypeflag.value.toString());
  }

  void statevisibilty()
  {
    state=1.obs;
  }
  void onTextFieldTap() {
    isButtonEnabled.value = true;
  }

  void onButtonPressed() {
    String text = et_amount.text;
    et_amount.clear();
    isButtonEnabled.value = false;
  }
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
  void getStaffSalaryBonus(String staff_id ) async{
    isLoading.value=true;
    var date=DateFormat('yyyy-MM-dd').format(selectedDatess.value);
    var amount=  et_amount.value.text;
    var note=   et_desc.text;
    print("date"+date+"amount"+amount+"note"+note);
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var business_owner = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.staffBonusandAllowance(context!,token,staff_id,business_owner,bussiness_id,selectedAllowanceTye.value,amount,selected.value,date,note);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if(res!=null)
        {
          if (res== "true") {
            isLoading.value=false;
            Fluttertoast.showToast(
                msg: "Add  successfully",
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

}