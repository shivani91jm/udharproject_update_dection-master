import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/model/AttendanceHistory/AttendanceHistoryModel.dart';
import 'package:udharproject/model/AttendanceHistory/HistoryInfoModel.dart';

class HistoryAttendaceController extends GetxController{
RxList<HistoryInfo> getAttendanceHistory = <HistoryInfo>[].obs;
var name="".obs;
final TextEditingController notecontroller = TextEditingController();
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    storeLocalData();
  }
 void  getHistoryAttendace(BuildContext context,String staff_id,String create_date,String id) async{
   getAttendanceHistory.clear();
   print("staff_d"+id+"createdtae"+create_date);
   SharedPreferences prefsdf = await SharedPreferences.getInstance();
   var   token= prefsdf.getString("token").toString();

   try{
     var _futureLogin = BooksApi.historyAttendance(context,token,id,create_date);
     if (_futureLogin != null) {
       _futureLogin!.then((value) {
         var res = value.response.toString();
         if (res == "true") {
           var info= value.info;
           if(info!=null)
           {
             getAttendanceHistory.value=info;
             getAttendanceHistory.refresh();
             print(""+getAttendanceHistory.toString());
             getAttendanceHistory.sort((a, b) => b!.createdAt!.compareTo(a.createdAt.toString()));
             update();
           }

         }

       });
     }
   }catch( e)
   {
     print("error"+e.toString());
   }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getAttendanceHistory.clear();
    notecontroller.dispose();
  }
void storeLocalData() async {
  SharedPreferences prefsdf = await SharedPreferences.getInstance();
  name = prefsdf.getString("name").toString().obs;

}

//----------------------------------add note api --------------------------------------------

  void  addNoteApi(BuildContext context,String staff_id,String create_date) async{
    print("staff_d"+staff_id+"createdtae"+create_date);
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();

    try{
      var _futureLogin = BooksApi.addnoteAttedance(context,token,staff_id,notecontroller.text.toString(),create_date);
      if (_futureLogin != null) {
        _futureLogin!.then((value) {
          var res = value.response.toString();
          if (res == "true") {
            var info= value.info;
            if(info!=null)
            {
              update();
              Navigator.pop(context,"Cancel");
            }

          }

        });
      }
    }catch( e)
    {
      print("error"+e.toString());
    }
  }

  //--------------------------------------delete note api -------------------------------
  void  deleteNoteApi(BuildContext context,String staff_id,String create_date) async{
    print("staff_d"+staff_id+"createdtae"+create_date);
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();

    try{
      var _futureLogin = BooksApi.deletenoteattendace(context,token,staff_id,create_date);
      if (_futureLogin != null) {
        _futureLogin!.then((value) {
          var res = value.response.toString();
          if (res == "true") {
            update();
            Navigator.pop(context,"Cancel");

          }
        });
      }
    }catch( e)
    {
      print("error"+e.toString());
    }
  }

}