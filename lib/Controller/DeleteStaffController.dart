import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';

class DeleteStaffController extends GetxController{

   void deleteStaff(BuildContext context,String staffId) async
   {
      print("staff_d"+staffId);
      SharedPreferences prefsdf = await SharedPreferences.getInstance();
      var   token= prefsdf.getString("token").toString();

      try{
         var _futureLogin = BooksApi.deleteStaffApi(context,token,staffId);
         if (_futureLogin != null) {
            _futureLogin!.then((value) {
               var res = value.response.toString();
               if (res == "true") {
                 Get.back();
               }
            });
         }
      }catch( e)
      {
         print("error"+e.toString());
      }
   }

}