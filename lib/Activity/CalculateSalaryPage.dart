import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/UpdateBusniessNameController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';

import 'package:udharproject/model/SocialMediaLogin/SocialMedialLoginModel.dart';

class CalculateMonthlySaleryPage extends StatefulWidget {
  var bussinessname,no_of_sattf,account_status,page_flag;
  CalculateMonthlySaleryPage(this.bussinessname,this.no_of_sattf,this.account_status,this.page_flag);
  @override
  State<CalculateMonthlySaleryPage> createState() => _CalculateMonthlySaleryPageState(this.bussinessname,this.no_of_sattf,this.account_status,this.page_flag);
}
class _CalculateMonthlySaleryPageState extends State<CalculateMonthlySaleryPage> {
  var bussinessname,no_of_sattf,account_status,page_flag;

  _CalculateMonthlySaleryPageState(this.bussinessname,this.no_of_sattf,this.account_status,this.page_flag);
//  SingingCharacter? _character = SingingCharacter.Monthly;
  Object? _character="";
  Future<SocialMediaLoginModel>? _futureData;
  Color _color = Colors.grey;
  DateTime selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  final _formkey = GlobalKey<FormState>();
  final   _Datecontroller = TextEditingController();
  BusinessNameController controller = Get.put(BusinessNameController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Datecontroller.text=""+_selectedTime.toString();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
        title: page_flag=="1"?Text(""): Text("Update"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // title declartion
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 10, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('',style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ),
            // --------------------------------canclate month--------------------------
            Container(
              margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: _color,
                  ),

                  // border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(1))),
              child:  RadioListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,5.0,0.0,0.0),
                      child: Text(AppContents.calendermonth.tr,style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.fitlarge
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,5.0,8.0,8.0),
                      child: Text(AppContents.calenderdetails.tr,style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                      ),),
                    )
                  ],
                ),
                value: "Monthly",
                groupValue: _character,
                onChanged: (value) {
                  setState(() {
                    _character = value;
                    _color= AppColors.drakColorTheme;
                  });
                },
              ),
            ),
            // calculate every 30 month
            Container(
              margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    // assign the color to the border color
                    color: _color,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(1))),
              child:  RadioListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,5.0,0.0,0.0),
                      child: Text(AppContents.caleverymonth.tr,style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,5.0,8.0,8.0),
                      child: Text(AppContents.calmonthdata,style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                      ),),
                    ),
                  ],
                ),
                value: "Daily",
                groupValue: _character,
                onChanged: (value) {
                  setState(() {
                    _character = value;
                    _color= AppColors.drakColorTheme;
                  });
                },
              ),
            ),
            // calculte weekly  offs
            Container(
              margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    // assign the color to the border color
                    color: _color,
                  ),

                  // border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(1))),
              child:  RadioListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,5.0,0.0,0.0),
                      child: Text(AppContents.excludeweeklyoffs.tr,style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,5.0,8.0,8.0),
                      child: Text(AppContents.excludeweeklyoffsdetails.tr,
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0
                        ),),
                    )
                  ],
                ),
                value: "Weekly",
                groupValue: _character,
                onChanged: (value) {
                  setState(() {
                    _character = value;
                    _color= AppColors.drakColorTheme;
                  });
                },
              ),
            ),
          // title of staff work
          Container(margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Column(
                children: [
                  Text(AppContents.staffwork.tr,style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                  ),),

                ],
              )
          ),
          GestureDetector(
            onTap: () async{
              showTimePickerWidget();
            },
            child: Column(
              children: [
                Container(
                  margin:  EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(border: Border.all(width: 1,
                    color:   Color.fromRGBO(143, 148, 251, .6),),
                      borderRadius: BorderRadius.all(Radius.circular(1))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                          child: Text(AppContents.shifthours.tr,style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),),
                        ),
                        Row(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
                              child: Text('${_selectedTime.hour}:${_selectedTime.minute}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child:Padding(
                                padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
                                child: Text(AppContents.edit.tr,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async{
              if(account_status=="false") {
                _validationForm();
              }
              else {
                if(page_flag=="2")
                  {
                     controller.updateBusniessName(context);
                  }
                 else
                    {
                      api_handle_second_bussiness_create();
                    }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ])),
                  child: Center(child: Text(AppContents.continues.tr, style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                  ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
  void _validationForm() async{
    var datecontroller=  "${_selectedTime.hour}:${_selectedTime.minute}";
    var dtata=  _character.toString();
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();
      print("token"+token);
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_is=prefsdf.getString("bussiness_id").toString();
    _futureData = BooksApi.updateBussinessDetails(user_id,datecontroller.toString(),_character.toString(),no_of_sattf,bussinessname,bussiness_is,token,context);
    {
      if(_futureData!=null) {

        _futureData!.then((value) {
           var code = value.response.toString();
           print("dataresponse"+code);
           var msg=value.msg.toString();
           if(code=="true")
          {
            Fluttertoast.showToast(
                msg: AppContents.uploadbusiness.tr,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepPurpleAccent,
                textColor: Colors.white,
                fontSize: 16.0
            );

            Navigator.pushNamed(context, RoutesNamess.businessmandashboard);
          }
          else
          {
            if(msg=="unsuccess")
            {
                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>  BusinessDetails("false")),);
                  Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
                  'status':"false"
                  });

            }
            else
            {
                Fluttertoast.showToast(msg: "" +msg,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }

          }

        });
      }
    }

  }

  void api_handle_second_bussiness_create() async{
    var datecontroller=  "${_selectedTime.hour}:${_selectedTime.minute}";
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();
    print("token"+token);
    var user_id = prefsdf.getString("user_id").toString();

    _futureData = BooksApi.addBussinessMan(user_id,datecontroller.toString(),_character.toString(),no_of_sattf,bussinessname,token,context);
    {
      if(_futureData!=null) {

        _futureData!.then((value) {
          var code = value.response.toString();
          print("dataresponse"+code);
          var msg=value.msg.toString();
          if(code=="true")
          {
            Fluttertoast.showToast(
                msg: AppContents.createbusiness.tr,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepPurpleAccent,
                textColor: Colors.white,
                fontSize: 16.0
            );

            Navigator.pushNamed(context, RoutesNamess.businessmandashboard);
          }
          else
          {
            if(msg=="unsuccess")
            {

              Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
                'status':"false"
              });
            }
            else
            {
              Fluttertoast.showToast(msg: "" +msg,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }

          }

        });
      }
    }





  }

  void showTimePickerWidget() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(AppContents.shifthours.tr,style: TextStyle(
                              color: AppColors.textColorsBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                          ),),
                          Text(AppContents.noshifthours.tr,style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0
                          ),),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppContents.hrs.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),),
                            TimePickerSpinner(
                              is24HourMode: false,
                              normalTextStyle: TextStyle(fontSize: 16, color: Colors.grey),
                              highlightedTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
                              spacing: 10,
                              itemHeight: 40,
                              onTimeChange: (time) {
                                setState(() {
                                  _selectedTime = time;
                                });
                              },
                            ),
                            Text(AppContents.mins.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    GestureDetector(
                        onTap: () async{
                          Navigator.pop(context, "",);
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(child: Text(AppContents.continues.tr, style: TextStyle(color: AppColors.white, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                          ),
                          ),
                        )),
                  ]));

        });
  }

}

