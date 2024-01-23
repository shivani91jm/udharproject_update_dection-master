import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/model/StaffJoiningMonth/StaffJoingInfo.dart';

class StaffJoingMonthlyCpntroller extends GetxController
{
  RxBool dropdwonOpen=false.obs;
  RxString? selectedValue = "Type".obs;
  BuildContext? context = Get.key.currentContext;
  var user_id,bussiness_id,staff_id="";
  RxList<StaffJoingInfo> monthList = <StaffJoingInfo>[].obs;
  RxString type_of_login="".obs;
  void checkDropDwon() async{
    dropdwonOpen.value=!dropdwonOpen.value;
    print(""+dropdwonOpen.value.toString());
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    showStaffJoingMonth();
  }

  void showStaffJoingMonth() async{

    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    print("token"+token);
    if(type_of_login.value=="staff") {
      user_id = prefsdf.getString("businessman_id").toString();
    }
    else
      {
       user_id = prefsdf.getString("user_id").toString();
      }
    bussiness_id=prefsdf.getString("bussiness_id").toString();
    staff_id=prefsdf.getString("staff_id").toString();
     var  staff_create_date= prefsdf.getString("staff_create_date").toString();
    var salary_type=prefsdf.getString("salary_payment_type").toString();
    print("userid"+user_id);
    var _futureLogin = BooksApi.staffMonthListing(context!,token,staff_id,user_id,bussiness_id,salary_type,staff_create_date);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if (value.info != null) {
           monthList.value= value.info!;
           monthList.refresh();
          }
        }
        else if(res=="false")
        {
          String data = value.msg.toString();
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

}