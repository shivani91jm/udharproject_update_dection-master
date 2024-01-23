import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/model/AddOverTimeRateModel/Info.dart';


class AddOverTimeActivity extends StatefulWidget {
  var staffname,present_date,attendance_marks,list_type,staff_id,activity_attandance_type,staff_working_time;
  AddOverTimeActivity(this.staffname,this.present_date,this.attendance_marks,this.list_type,this.staff_id,this.activity_attandance_type,this.staff_working_time);
  @override
  State<AddOverTimeActivity> createState() => _AddOverTimeActivityState(this.staffname,this.present_date,this.attendance_marks,this.list_type,this.staff_id,this.activity_attandance_type,this.staff_working_time);
}
class _AddOverTimeActivityState extends State<AddOverTimeActivity> {
  var staffname,present_date,attendance_marks,list_type,staff_id,activity_attandance_type,staff_working_time;
  _AddOverTimeActivityState(this.staffname,this.present_date,this.attendance_marks,this.list_type,this.staff_id,this.activity_attandance_type,this.staff_working_time);
  DateTime _selectedTime = DateTime.now();
  final   _AmountController = TextEditingController();
  final   _Datecontroller = TextEditingController();
  TextEditingController   _MultipleAmountcontroller = TextEditingController();
  String? selectedValue = "Type";
  List<AddOverTimeInfo>? overrateList=[];
  bool isChecked = false;
  int _state=0;
  bool btn_visible_check=false;
  var dropdwonOpen=false;
  var mutipleAmountVisibility=false;
   var total_time="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Datecontroller.text=""+_selectedTime.toString();
    fetchovertimeRate();
    setState(() {
      this.btn_visible_check=btn_visible_check;
    });
    _MultipleAmountcontroller.addListener(() {
     final  mutipleAmountVisibility =_MultipleAmountcontroller.text.isNotEmpty;
         setState(() {
            this.mutipleAmountVisibility=mutipleAmountVisibility;
          });


    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _AmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppContents.Overtime.tr,style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal
              ),),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,0.0,8,0),
                    child: Text(""+staffname,style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,

                    ),),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black38,
                  ),
                  Text(""+present_date,style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),),

                ],
              )
            ],
          ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child: attendance_marks=="present"?_buildPresntWidget(): _buildAbsentWidget(),
          ),
        ),
      ),

    );
  }

  void _showFinHorsDialog() async{
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
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppContents.shifthours.tr,style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppContents.hrs.tr,style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0
                              ),),
                              TimePickerSpinner(
                                is24HourMode: false,
                                normalTextStyle: TextStyle(fontSize: 24, color: Colors.grey),
                                highlightedTextStyle: TextStyle(fontSize: 30, color: Colors.black),
                                spacing: 10,
                                itemHeight: 40,
                                onTimeChange: (time) {
                                  setState(() {
                                    _selectedTime = time;
                                  });
                                },
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 40,),
                        GestureDetector(
                            onTap: (){},
                            child: Container(
                              margin: EdgeInsets.all(20),
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
                            )),
                      ])));

        });
  }
  //--------------------- salary type over time rate (per hour)---------------------
  void fetchovertimeRate() async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.StaffOverTimeRateFetch( context,token,user_id,bussiness_id);

    if(_futureLogin!=null)
    {
      _futureLogin.then((value){
        var res = value.response;
        if(res=="true")
        {
          overrateList =value.info;
        }
      });
    }
  }
  //-------------==============submit button widget=========================-------------------------------
  Widget setSubmitBtn() {
                if (_state == 0) {
                  return new Text(
                    "Apply Overtime",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold
                    ),
                  );
                }
          else if (_state == 1) {
            return Center(
              child: Container(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );
          }

         else if (_state == 1) {
            return Center(
              child: Container(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );
          }
          else {
            return Icon(Icons.check, color: Colors.white);
          }
        }

  void _addOverTimeApiMethod() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token = prefsdf.getString("token").toString();
    print("token" + token);
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var overtime_hours="1";
   var overtime_type="gfghgh";
   var overtime_slab_amount=_AmountController.text;
   var overtime_total_amount="2000";
    var datetime = DateTime.now();
    print(datetime);
    var createdate=DateFormat('yyyy-MM-dd').format(datetime);
    var _futureLogin = BooksApi.AddAttendanceapi(context,token,user_id,bussiness_id,"present","20:55","20:01","faffa",
        "dfsadfdgfdg","","business_man","","","","","","","","","",overtime_hours,overtime_type,
        overtime_slab_amount,overtime_total_amount,list_type,activity_attandance_type,createdate ,staff_id,"","approved");
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if (value.info != null) {
          var  info = value.info;
            if (info != null) {
              Fluttertoast.showToast(
                  msg: "Over Time Added Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        }
        else {
          String data = value.msg.toString();
          Fluttertoast.showToast(
              msg: ""+data,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: AppSize.medium
          );

        }
      });
    }
    else {
      _futureLogin.then((value) {
        String data = value.msg.toString();
        Fluttertoast.showToast(
            msg: ""+data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );

      });
    }
  }

 Widget _buildPresntWidget() {
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(AppContents.noofhours.tr,style: TextStyle(
              color: AppColors.textColorsBlack,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  btn_visible_check=true;
                });
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("("+AppContents.HalfDay.tr+staff_working_time+"Hrs )",style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  btn_visible_check=true;
                });
              },
              child: Container(
                  margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Full Day(8:00 Hrs)",style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                  )),
            ),
          ],
        ),
        //-------------------over time hours conatiner------------------------------cc
        GestureDetector(
          onTap: (){
            _showFinHorsDialog();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black38,
                boxShadow: [
                  BoxShadow(color:  Color.fromRGBO(143, 148, 251, .1), spreadRadius: 1)
                ]
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,8.0,15.0,0),
                    child: Text("Over time Hours",style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontStyle: FontStyle.normal

                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,1.0,15.0,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_selectedTime.hour} : ${_selectedTime.minute}',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            fontStyle: FontStyle.normal
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(AppContents.hrs.tr,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                fontStyle: FontStyle.normal
                            ),),
                            Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Over time Rate (per hour)
        Container(
          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Overtime Rate(per hour)",style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),),
              ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  //-------------custom drop dwon  --------
                  InkWell(
                    onTap: (){
                      setState(() {
                        dropdwonOpen=!dropdwonOpen;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.drakColorTheme,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(selectedValue.toString(),style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: AppSize.medium
                              ),),
                            ),
                            Icon(dropdwonOpen?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_outlined,color: AppColors.white,)
                          ],
                        )
                    ),
                  ),
                  if(dropdwonOpen)...
                  {
                    Column(children: [
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: overrateList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: (){
                              selectedValue=overrateList![index].salaryType.toString();
                              dropdwonOpen=false;
                              setState(() {
                              });
                            },
                            title:  Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if(overrateList![index].businessId==0)...
                                  {
                                    Text("" + overrateList![index].salaryType.toString()),
                                  }
                                  else...
                                  {
                                    Text("" + overrateList![index].salaryType.toString()),
                                    GestureDetector(
                                      onTap:(){
                                        var overtime_id=overrateList![index].id.toString();
                                        deleteOverTimeRate(overtime_id);
                                      },
                                      child:  Container(
                                        child: Column(
                                          children: [
                                            Icon(Icons.cancel),
                                          ],
                                        ),
                                      ),
                                    )
                                  }

                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(height: 1,color: Colors.grey,);
                        },

                      ),
                      GestureDetector(
                        onTap: () async{

                          addOverTimeDialogShow(context);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 80, 20, 20),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                AppColors.drakColorTheme,
                                AppColors.lightColorTheme
                              ])),
                          child: Center(
                            child: Text(AppContents.continues, style: TextStyle(
                                color: AppColors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),

                    ],)
                  }
                ],
              ),
            ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],

                  controller: _AmountController,
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      labelText: 'Amount',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                      )  ),
                ),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Amount",style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Rs 0",style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text('Send SMS to staff',style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    if(btn_visible_check)
                    {
                      setState(() {
                        btn_visible_check=true;
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: btn_visible_check?[
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ]: [Color.fromRGBO(143, 148, 251, .2), Color.fromRGBO(143, 148, 251, .2)] )),
                    child: new MaterialButton(
                      highlightElevation: 50,
                      child: setSubmitBtn(),
                      onPressed: btn_visible_check ? () {
                        setState(() {
                          if (_state == 0) {
                            btn_visible_check=true;
                            _addOverTimeApiMethod();

                          }
                        });
                      }: null,
                      elevation: 4.0,
                      minWidth: double.infinity,
                      height: 48.0,

                    ),
                  ),
                ),
              ],
            )
        ),
      ],
    ),);
 }
 Widget _buildAbsentWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0,20,12,20),
          child: Center(
            child: Text("Please marks attendance first",style: TextStyle(
              color: Colors.black38,
                fontSize: 17,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal
            ),),
          ),
        ),
      ),
    );
 }
//-----------------------------------add over time api ------------------------------
  void dataloading(String salary_type) async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();

   var _futureLogin = BooksApi.StaffOverTimeRateAdd(context,token,user_id,bussiness_id,salary_type);
    if (_futureLogin != null) {
      _futureLogin!.then((value) {
        var res = value.response.toString();
        var msg = value.msg.toString();
        if (res == "true") {
          Fluttertoast.showToast(
              msg: " add successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if (res == "false") {
          if (msg == "unsuccess") {}
          else {
            Fluttertoast.showToast(msg: "" + msg,
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
  //-----------------------delete over time api --------------------------------

void deleteOverTimeRate(String overtime_id) async
{
  SharedPreferences prefsdf = await SharedPreferences.getInstance();
  var token= prefsdf.getString("token").toString();
  var user_id = prefsdf.getString("user_id").toString();
  var bussiness_id=prefsdf.getString("bussiness_id").toString();
  var _futureLogin = BooksApi.StaffOverTimeRatedelete(context,token,user_id,bussiness_id,overtime_id);
  if (_futureLogin != null) {
    _futureLogin!.then((value) {
      var res = value.response.toString();
      var msg = value.msg.toString();
      if (res == "true") {
          fetchovertimeRate();
      }
      else if (res == "false") {
        if (msg == "unsuccess") {}
        else {
          Fluttertoast.showToast(msg: "" + msg,
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

void addOverTimeDialogShow(BuildContext context)
{
  showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        elevation: 10,
        title: const Text(AppContents.addmutipletitle,style: TextStyle(
            fontSize: AppSize.large,
            color: AppColors.textColorsBlack,
            fontWeight: FontWeight.bold
        ),),
        content: Container(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppContents.Multiple,style: TextStyle(
                color: AppColors.dartTextColorsBlack,
                fontWeight: FontWeight.bold,
                fontSize: AppSize.small,
              ),),
              Container(
                margin: EdgeInsets.fromLTRB(0,10,0,10),
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: _MultipleAmountcontroller,
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      labelText: AppContents.Multiple ,
                      labelStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold),
                      hintStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                      )  ),
                ),
              ),
              //-----------
              SizedBox(
                height: 10,
              ),
              Text("0.00 x Rs. 200= Rs. 0/ hr",style: TextStyle(
                color: AppColors.textColorsBlack,
                fontSize: AppSize.medium,
                fontWeight: FontWeight.bold,

              ),),

            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async{
                  Navigator.pop(context, 'Cancel');
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 80, 20, 20),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [AppColors.textColorsBlack,AppColors.textColorsBlack])),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(AppContents.cancel, style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppSize.small,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: mutipleAmountVisibility==false?null:() async{
                  dataloading(selectedValue.toString());
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 80, 20, 20),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: mutipleAmountVisibility==false?[AppColors.disbaleBtn,AppColors.disbaleBtn]:[
                        AppColors.drakColorTheme,
                        AppColors.lightColorTheme
                      ])),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppContents.continues, style: TextStyle(
                          color: AppColors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ));
}

}