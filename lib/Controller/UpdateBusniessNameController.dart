import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';

import '../Colors/ColorsClass.dart';
import '../Utils/FontSize/AppSize.dart';

class BusinessNameController extends GetxController {
  TextEditingController et_businessNameController = TextEditingController();
  RxBool isLoading=false.obs;
  void updateBusniessName(BuildContext context) async{
    SharedPreferences loginData = await SharedPreferences.getInstance();
    var   token= loginData.getString("token").toString();
    var user_id = loginData.getString("user_id").toString();
    var  assgin_to_bussinesses_id = loginData.getString("bussiness_id").toString();
    isLoading.value=true;
    var _futureLogin = BooksApi.updateBussinessDetails(user_id,"", "","",et_businessNameController.text,assgin_to_bussinesses_id,token,context);
    if (_futureLogin != null) {
      _futureLogin!.then((value) {
        print(value.response.toString());
        var res = value.response.toString();
        if (res == "true") {
          isLoading.value=false;
          var info=value.info;
          var getBussiness=info!.getBusiness;
          for(int i=0;i<getBussiness!.length;i++)
          {
            var  assgin_to_bussinesses_id = loginData.getString("bussiness_id").toString();
            if(assgin_to_bussinesses_id==getBussiness[i].id.toString())
            {
                loginData.setString("bussiness_id", getBussiness[i].id.toString());
                loginData.setString("bussiness_name",getBussiness[i].businessName.toString());
                refresh();
                Navigator.pushReplacementNamed(context, RoutesNamess.businessmandashboard);
                Fluttertoast.showToast(
                  msg: "Update Value",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.drakColorTheme,
                  textColor: AppColors.white,
                  fontSize: AppSize.medium
              );
            }
          }

        }
        else{
          isLoading.value=false;
        }

      });
    }
  }



}