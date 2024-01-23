import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialInfo.dart';
import 'package:udharproject/Activity/BusinessDetailsPage.dart';

import '../model/SocialMediaLogin/GetBussiness.dart';
class ManageBussinessManCotroller extends GetxController{
  RxBool isLoading=false.obs;
  var user_id="";
  var bussiness_id="";
  //RxList getBussiness = [].obs;
  List<GetBusiness> getBussiness=[].obs as List<GetBusiness>;
  BuildContext? context = Get.key.currentContext;
  RxBool page=false.obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bussinessListData(page.value);
  }
  void bussinessListData(bool page) async {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    print("token"+token);
    user_id = prefsdf.getString("user_id").toString();
    bussiness_id=prefsdf.getString("bussiness_id").toString();
    print("userid"+user_id);
    var _futureLogin = BooksApi.bussinessListData(user_id, token,context!);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          isLoading.value=true;
          if (value.info != null) {
            SocialInfo? info = value.info;
            print("ddgfhhshjhgfdhj"+info.toString());
            if (info!.getBusiness != null) {
              var getBussinessList = info.getBusiness;

                getBussiness = getBussinessList!;

              var getlenghth= getBussiness.length;
              print("dgsdhgshd"+getlenghth.toString());
            }
            //Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
          }
        }
        else if(res=="false")
        {

          isLoading.value=false;

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