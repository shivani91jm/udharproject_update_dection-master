import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/AddStaffInformationPage.dart';
import 'package:udharproject/Activity/StaffActivityData/ShowAllStaffListSearchPageActivity.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/MonthlyWiseStaffListModel/Daily.dart';
import 'package:udharproject/model/MonthlyWiseStaffListModel/Hourly.dart';
import 'package:udharproject/model/MonthlyWiseStaffListModel/Monthly.dart';
import 'package:udharproject/model/MonthlyWiseStaffListModel/Weekly.dart';
import 'package:udharproject/model/SocialMediaLogin/GetStaffUser.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialInfo.dart';
import '../model/MonthlyWiseStaffListModel/Info.dart';
import '../model/SocialMediaLogin/GetBussiness.dart';

class AddStaffScreenPage extends StatefulWidget {
  @override
  State<AddStaffScreenPage> createState() => _AddStaffScreenPageState();
}

class _AddStaffScreenPageState extends State<AddStaffScreenPage> {
  final _formkey = GlobalKey<FormState>();
  List<GetBusiness> getBussiness = [];
  List<GetStaffUser> getStaffList = [];
  List<Monthly> getMonthlyConaList =[];
  List<Daily> getDailyConList =[];
  List<Weekly> getWeeklyConList =[];
  List<Hourly> getHourlyList=[];
  int _selectedRadio = 0;
  Object? selectedUser;
  var bussinessName="";
  bool premiusm=true;
  bool monthlyflag=false;
  bool dailyflag=false;
  bool weeklyflag=false;
  bool hourlyflag=false;
  bool _isLoading=false;
  bool staffListFlag=false;
  SharedPreferences? sharedPreferences;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    bussinessListData();
    showStaffListData();
    setValueLocal();
  }
  @override
  void dispose() {
    getBussiness.clear();
    getStaffList.clear();
    getMonthlyConaList.clear();
    getDailyConList.clear();
    getWeeklyConList.clear();
    getHourlyList.clear();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    if(bussinessName=="null" || bussinessName=="")
                      {

                      }
                    else {
                      _showBootomSheet(context);
                    }
                    },
                  icon: Icon(Icons.expand_circle_down, textDirection: TextDirection.rtl, color: AppColors.white),
                  label: Column(
                    children: [
                      if(bussinessName=="null" || bussinessName=="")...
                        {

                        }
                      else...[
                        Text(""+bussinessName, style: TextStyle(
                            color: AppColors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: AppSize.medium,
                            fontWeight: FontWeight.bold),
                        ),
                      ]

                    ],
                  )),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(onPressed: () {}, label: Align(
                    child: Text(AppContents.Help.tr, style: TextStyle(
                        color: AppColors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                    icon: Icon(Icons.messenger_outline, textDirection: TextDirection.rtl, color: AppColors.white),
                  ),
                )
              ])),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints)
      {
          return   SingleChildScrollView(
          child: Form(
          key: _formkey,
          child: Column(
          children: [
            //----------------------- if user not take subscription --------------------------------------
            if(premiusm==false)...[
                // -------------------add staff or create staff Widget--------------------------
              addstaffWidgetLayout()
            ]
            else ...[
              // check staff create then show all data other wise create staff first -------------------
              Container(
                child:  _isLoading==false? ErrowDialogsss() : AddStaffScreenDataPage(),
              )
            ]
          ],
         ),
       ),
        );
       }));
  }
  void addstaffData(BuildContext context) {
    //-------------------- ContactListPage-----------------------------------------------
    Navigator.pushNamed(context, RoutesNamess.contactpage);
  }
  Widget ErrowDialogsss() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.lightTextColorsBlack,
          valueColor: new AlwaysStoppedAnimation<Color>(AppColors.lightTextColorsBlack),
        ),
      ),
    );
  }
  void bussinessListData() async {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    setState(() {
      var _futureLogin = BooksApi.bussinessListData(user_id, token, context);
      if (_futureLogin != null) {
        _futureLogin.then((value) {
          var res = value.response;
          if (res == "true") {
            if (value.info != null)
            {
              SocialInfo? info = value.info;
              if (info!.getBusiness != null) {
                setState(() {
                   getBussiness = info.getBusiness!;
                   bussinessName=""+getBussiness.first.businessName.toString();
                   if(bussinessName=="null" ||bussinessName=="")
                     {
                       staffListFlag=true;
                       _showBusinessDilaog(context);
                     }

                 });
                var getlenghth= getBussiness.length;
                print("busslenght"+getlenghth.toString());
              }
              if(info!.getStaffUser!=null && info!.getStaffUser!.length>1)
                {
                  setState(() {
                    staffListFlag=false;
                    showStaffListData();

                  });
                }


            }
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
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
      }
    });
  }
  void _showBootomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return Column(
            children: [
              //--------------------------business man list api data-----------------------------------------
              Expanded(child: _bulidListBussinessMan(context)),
              GestureDetector(
                  onTap: (){
                    addBusiness();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            AppColors.drakColorTheme,
                            AppColors.lightColorTheme
                          ])),
                      height: 50,
                      child: Center(
                        child: Text(AppContents.addBusines.tr, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),

                      ),),
                  )
              )

            ],
          );
        });
  }
  void _showBusinessDilaog(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text(AppContents.BusinessDeatils.tr,style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),),
          content:  Text(AppContents.enterBusinessBascDetals.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:  Text(AppContents.cancel.tr,style: TextStyle(
                  fontSize: AppSize.fitlarge,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async{
                Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
                  "status":"false"
                });
              } ,
              child:  Text(AppContents.ok.tr,style: TextStyle(
                  fontSize: 15,
                  color: AppColors.green
              ),),
            ),
          ],
        ));
  }


  Widget  _buildMonthlyContrainer() {
    return  ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: getMonthlyConaList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            onTap: () async{
              var staffname=getMonthlyConaList[index].staffName.toString();
              var stsffId=getMonthlyConaList[index].staffId.toString();
              var id=getMonthlyConaList[index].id.toString();
              var stafftotal_amount=getMonthlyConaList[index].total_money_status.toString();
              var email="shivani91jm@gmail.com";
              var type=getMonthlyConaList[index].salaryPaymentType.toString();
              var staffcreatedate=getMonthlyConaList[index].createdAt.toString();
              SharedPreferences prefsdf = await SharedPreferences.getInstance();
              prefsdf.setString("staff_id",id.toString()).toString();
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaffInformationUpdate(staffname,stsffId,stafftotal_amount,email,"8887885055",type,staffcreatedate,id)),);
        },
          title:Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  alignment: Alignment.center,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/1/iphone-4-closeup.jpg?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",), fit: BoxFit.cover)
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(""+getMonthlyConaList[index].staffName.toString(), style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      if(getMonthlyConaList[index].attandancStatus=="true")...
                        {
                          Text(""+getMonthlyConaList[index].getStaffAttendance!.first.attendanceMarks.toString(), style: TextStyle(
                              color: Colors.black38,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),)
                        }
                      else...
                        {
                          Text(AppContents.notmarked.tr, style: TextStyle(
                              color: Colors.black38,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),)
                        }

                    ],
                  ),
                ),
              ),
              //
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 15, 10),
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Rs."+getMonthlyConaList[index].total_money.toString(),style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),),
                      Text(""+getMonthlyConaList[index].total_money_status,style: TextStyle(
                          color: Colors.black38,
                          fontSize: 14.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ],
        ),
          ));
        }, separatorBuilder: (BuildContext context, int index) {
      return Divider(height: 1, color: Colors.grey,);
    },
    );
    }

   Widget _buildDailyContainerList() {
     return  ListView.separated(
       physics: NeverScrollableScrollPhysics(),
       scrollDirection: Axis.vertical,
       shrinkWrap: true,
       itemCount: getDailyConList.length,
       itemBuilder: (BuildContext context, int index) {
         return ListTile(
             onTap: () async{
               var staffname=getDailyConList[index].staffName.toString();
               var stsffId=getDailyConList[index].staffId.toString();
               var stafftotal_amount=getDailyConList[index].total_money_status.toString();
               var email="shivani91jm@gmail.com";
               var type=getDailyConList[index].salaryPaymentType.toString();
               var staffcreatedate=getDailyConList[index].createdAt.toString();
               var id=getDailyConList[index].id.toString();
               SharedPreferences prefsdf = await SharedPreferences.getInstance();
               prefsdf.setString("staff_id",id.toString()).toString();
               Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaffInformationUpdate(staffname,stsffId,stafftotal_amount,email,"8887885055",type,staffcreatedate,id)),);
             },
             title:Card(
               elevation: 1,
               shape: RoundedRectangleBorder(
                 side: BorderSide(color: Colors.white70, width: 1),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Container(
                       margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                       alignment: Alignment.center,
                       child: Container(
                         width: 50.0,
                         height: 50.0,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(50.0),
                             image: DecorationImage(
                                 image: NetworkImage(
                                   "https://images.unsplash.com/1/iphone-4-closeup.jpg?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                                 ), fit: BoxFit.cover)
                         ),
                       ),
                     ),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Container(
                       margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                       alignment: Alignment.center,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(""+getDailyConList[index].staffName.toString(),
                             style: TextStyle(
                               color: Colors.black87,
                               fontSize: 16,
                               fontWeight: FontWeight.bold
                           ),
                           ),
                           if(getDailyConList[index].attandancStatus=="true")...
                           {
                             Text(""+getDailyConList[index].getStaffAttendance!.first.attendanceMarks.toString(), style: TextStyle(
                                 color: Colors.black38,
                                 fontSize: 13,
                                 fontWeight: FontWeight.bold
                             ),),
                           }
                           else...
                           {
                             Text(AppContents.notmarked.tr, style: TextStyle(
                                 color: Colors.black38,
                                 fontSize: 13,
                                 fontWeight: FontWeight.bold
                             ),)
                           }
                           ],
                       ),
                     ),
                   ),
                   //
                   Spacer(),
                   Align(
                     alignment: Alignment.centerRight,
                     child: Container(
                       margin: EdgeInsets.fromLTRB(10, 15, 15, 10),
                       alignment: Alignment.topRight,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text("Rs."+getDailyConList[index].total_money.toString(),style: TextStyle(
                               color: Colors.black87,
                               fontSize: 14.0,
                               fontStyle: FontStyle.normal,
                               fontWeight: FontWeight.bold),),
                           Text(""+getDailyConList[index].total_money_status,style: TextStyle(
                               color: Colors.black38,
                               fontSize: 14.0,
                               fontStyle: FontStyle.normal,
                               fontWeight: FontWeight.bold),)
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ));
       }, separatorBuilder: (BuildContext context, int index) {
       return Divider(height: 1, color: Colors.grey,);
     },
     );

    }
   Widget _buildWeeklyConTList() {
     return  ListView.separated(
       physics: NeverScrollableScrollPhysics(),
       scrollDirection: Axis.vertical,
       shrinkWrap: true,
       itemCount: getWeeklyConList.length,
       itemBuilder: (BuildContext context, int index) {
         return ListTile(
             onTap: () async{
               var staffname=getWeeklyConList[index].staffName.toString();
               var stsffId=getWeeklyConList[index].staffId.toString();
               var stafftotal_amount=getWeeklyConList[index].total_money_status.toString();
               var email="shivani91jm@gmail.com";
               var type=getWeeklyConList[index].salaryPaymentType.toString();
               var staffcreatedate=getWeeklyConList[index].createdAt.toString();
               var id=getWeeklyConList[index].id.toString();
               SharedPreferences prefsdf = await SharedPreferences.getInstance();
               prefsdf.setString("staff_id",id.toString()).toString();
               Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaffInformationUpdate(staffname,stsffId,stafftotal_amount,email,"8887885055",type,staffcreatedate,id)),);
             },
             title:Card(
               elevation: 1,
               shape: RoundedRectangleBorder(
                 side: BorderSide(color: Colors.white70, width: 1),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Container(
                       margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                       alignment: Alignment.center,
                       child: Container(
                         width: 50.0,
                         height: 50.0,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(50.0),
                             image: DecorationImage(
                                 image: NetworkImage("https://images.unsplash.com/1/iphone-4-closeup.jpg?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                                 ), fit: BoxFit.cover)
                         ),
                       ),
                     ),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Container(
                       margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                       alignment: Alignment.center,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(""+getWeeklyConList[index].staffName.toString(), style: TextStyle(
                               color: Colors.black87,
                               fontSize: 16,
                               fontWeight: FontWeight.bold
                           ),),
                           if(getWeeklyConList[index].attandancStatus=="true")...
                           {
                             Text(""+getWeeklyConList[index].getStaffAttendance!.first.attendanceMarks.toString(), style: TextStyle(
                                 color: Colors.black38,
                                 fontSize: 13,
                                 fontWeight: FontWeight.bold
                             ),)
                           }
                           else...
                           {
                             Text(AppContents.notmarked.tr, style: TextStyle(
                                 color: Colors.black38,
                                 fontSize: 13,
                                 fontWeight: FontWeight.bold
                             ),)
                           }

                         ],
                       ),
                     ),
                   ),
                   //
                   Spacer(),
                   Align(
                     alignment: Alignment.centerRight,
                     child: Container(
                       margin: EdgeInsets.fromLTRB(10, 15, 15, 10),
                       alignment: Alignment.topRight,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text("Rs."+getWeeklyConList[index].total_money.toString(),style: TextStyle(
                               color: Colors.black87,
                               fontSize: 14.0,
                               fontStyle: FontStyle.normal,
                               fontWeight: FontWeight.bold),),
                           Text(""+getWeeklyConList[index].total_money_status,style: TextStyle(
                               color: Colors.black38,
                               fontSize: 14.0,
                               fontStyle: FontStyle.normal,
                               fontWeight: FontWeight.bold),)
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ));
       }, separatorBuilder: (BuildContext context, int index) {
       return Divider(height: 1, color: Colors.grey,);
     },
     );

   }
    void showStaffListData() async{
      SharedPreferences prefsdf = await SharedPreferences.getInstance();
      var   token= prefsdf.getString("token").toString();
      var user_id = prefsdf.getString("user_id").toString();
      var bussiness_id=prefsdf.getString("bussiness_id").toString();
      var _futureLogin = BooksApi.ShowStffListAccordingToMonthly(user_id,bussiness_id, token, context);
      if (_futureLogin != null) {
        _futureLogin.then((value) {
          var res = value.response;
          if (res == "true") {
            if (value.info!= null) {
              _isLoading=true;
              Info ? info = value.info;
              setState(() {
                if(info!.monthly!=null && info.monthly!.isNotEmpty) {
                  staffListFlag=false;
                  monthlyflag=true;
                  getMonthlyConaList = info.monthly!;
                }
                if(info.daily!=null && info.daily!.isNotEmpty) {
                  staffListFlag=false;
                  getDailyConList = info.daily!;
                  dailyflag=true;
                }
                if(info.weekly!=null && info.weekly!.isNotEmpty) {
                  staffListFlag=false;
                  getWeeklyConList = info.weekly!;
                  weeklyflag=true;
                }
                if(info.hourly!=null && info.hourly!.isNotEmpty) {
                  staffListFlag=false;
                  getHourlyList = info.hourly!;
                  hourlyflag=true;
                }
              });
            }
          }
          else
          {
           setState(() {
             _isLoading=true;
             staffListFlag=true;
           });
          }
        });
      }
      else {
        _futureLogin.then((value) {
          String data = value.msg.toString();

          setState(() {
            _isLoading=true;
           // staffListFlag=true;
          });
          Fluttertoast.showToast(
              msg: "" + data,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.drakColorTheme,
              textColor: AppColors.white,
              fontSize: 16.0
          );
        });
      }
    }
    Widget  _bulidListBussinessMan(BuildContext context) {
      return  ListView.separated(
       // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: getBussiness.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              RadioListTile(
                value: getBussiness[index].id.toString(),
                groupValue: selectedUser,
                title: Text(getBussiness[index].businessName.toString()),
                onChanged: (val) {
                  print("Radio $val");
                  setState(() {
                    _isLoading=false;
                    selectedUser = val;
                    sharedPreferences!.setString('bussiness_id', selectedUser.toString());
                    sharedPreferences!.setString("bussiness_name",getBussiness[index].businessName.toString());
                    sharedPreferences!.setString("type", "bussinessman");
                    bussinessName=""+getBussiness[index].businessName.toString();
                    showStaffListData();


                  });

                  Navigator.pop(context);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaffScreenPage()),);
                },
              ),
            ],
          );
        }, separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 1, color: Colors.grey,);
      },);
  }

  void addBusiness() {

    Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
      "status":"true"
    });
  }

 Widget _buildHourlyListView(BuildContext context) {
   return  ListView.separated(
     physics: NeverScrollableScrollPhysics(),
     scrollDirection: Axis.vertical,
     shrinkWrap: true,
     itemCount: getHourlyList.length,
     itemBuilder: (BuildContext context, int index) {
       return ListTile(
           onTap: () async{
             var staffname=getHourlyList[index].staffName.toString();
             var stsffId=getHourlyList[index].staffId.toString();
             var stafftotal_amount=getHourlyList[index].total_money_status.toString();
             var email="shivani91jm@gmail.com";
             var type=getHourlyList[index].salaryPaymentType.toString();
             var staffcreatedate=getHourlyList[index].createdAt.toString();
             var id=getHourlyList[index].id.toString();
             SharedPreferences prefsdf = await SharedPreferences.getInstance();
             prefsdf.setString("staff_id",id.toString()).toString();
             Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaffInformationUpdate(staffname,stsffId,stafftotal_amount,email,"8887885055",type,staffcreatedate,id)),);
           },
           title:Card(
             elevation: 1,
             shape: RoundedRectangleBorder(
               side: BorderSide(color: Colors.white70, width: 1),
               borderRadius: BorderRadius.circular(10),
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Container(
                     margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     alignment: Alignment.center,
                     child: Container(
                       width: 50.0,
                       height: 50.0,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(50.0),
                           image: DecorationImage(
                               image: NetworkImage(
                                 "https://images.unsplash.com/1/iphone-4-closeup.jpg?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                               ), fit: BoxFit.cover)
                       ),
                     ),
                   ),
                 ),
                 Align(
                   alignment: Alignment.center,
                   child: Container(
                     margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                     alignment: Alignment.center,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(""+getHourlyList[index].staffName.toString(), style: TextStyle(
                             color: Colors.black87,
                             fontSize: 16,
                             fontWeight: FontWeight.bold
                         ),),
                         if(getHourlyList[index].attandancStatus=="true")...
                         {
                           Text(""+getHourlyList[index].getStaffAttendance!.first.attendanceMarks.toString(), style: TextStyle(
                               color: Colors.black38,
                               fontSize: 13,
                               fontWeight: FontWeight.bold
                           ),)
                         }
                         else...
                         {
                           Text(AppContents.notmarked.tr, style: TextStyle(
                               color: Colors.black38,
                               fontSize: 13,
                               fontWeight: FontWeight.bold
                           ),)
                         }

                       ],
                     ),
                   ),
                 ),
                 //
                 Spacer(),
                 Align(
                   alignment: Alignment.centerRight,
                   child: Container(
                     margin: EdgeInsets.fromLTRB(10, 15, 15, 10),
                     alignment: Alignment.topRight,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Text("Rs."+getHourlyList[index].total_money.toString(),style: TextStyle(
                             color: Colors.black87,
                             fontSize: 14.0,
                             fontStyle: FontStyle.normal,
                             fontWeight: FontWeight.bold),),
                         Text(""+getHourlyList[index].total_money_status,style: TextStyle(
                             color: Colors.black38,
                             fontSize: 14.0,
                             fontStyle: FontStyle.normal,
                             fontWeight: FontWeight.bold),)
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ));
     }, separatorBuilder: (BuildContext context, int index) {
     return Divider(height: 1, color: Colors.grey,);
   },
   );
 }

Widget  _showStaffListData() {
    return Column(
      children: [
        //monthly  Container
        ListView(

          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            if(monthlyflag==true)...[
              Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Montly ( "+getMonthlyConaList.length.toString()+")"),
                ),

              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              _buildMonthlyContrainer(),
            ],
          ],
        ),
        //Daily Conatiner
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            if(dailyflag==true)...[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Daily: ("+getDailyConList.length.toString()+")"),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              _buildDailyContainerList(),
            ],
          ],
        ),
        //======================Weekly Container===================================
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            if(weeklyflag==true)...[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Weekly : ("+getWeeklyConList.length.toString()+")"),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              _buildWeeklyConTList(),
            ],
          ],
        ),
        // hourly Conatiner
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            if(hourlyflag==true)...[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Hourly : ("+getHourlyList.length.toString()+")"),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              _buildHourlyListView(context),
            ],
          ],
        ),
      ],
    );
}

Widget  AddStaffScreenDataPage() {
  return Column(
    children: [
      if(staffListFlag==true)...
      {
        addstaffWidgetLayout()
      }
      else...
      {
        Column(
          children: [
            // //----------------------------total pending amount conatiner------------------------------
            Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Total Pending', style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 7, 10, 0),
                              child: Text(
                                'Rs.2000000', style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(

                            decoration: BoxDecoration(
                              border: Border.all(width: 1,
                                color: Color.fromRGBO(
                                    143, 148, 251, .6),),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('Report', style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.arrow_drop_down, size: 18,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(height: 1, color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                            border: Border(
                              right: BorderSide( //                   <--- left side
                                color: Color.fromRGBO(
                                    143, 148, 251, .6),
                                width: 1.0,
                              ),
                            ),
                            // borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          width: 150,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Payment Log', style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                        Container(
                          width: 150,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Bulk Payment', style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            //--------------------add staff buttocn container------------------------
            //-------------------------submit btn...-----------------------------
            GestureDetector(
                onTap: () async {
                  addstaffData(context);

                }, child: Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(ImagesAssets.loginBackground, height: 20,
                      width: 20,),
                  ),
                  Text(AppContents.addstaff.tr, style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
            ),
            //-------------------------------search conatiner----------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context) => AllStaffListShowAndSearchStaff()),);
                  },
                  child: Container(
                    width: 270,
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,
                        color: Color.fromRGBO(143, 148, 251, .6),),
                      borderRadius: BorderRadius.all(
                          Radius.circular(3)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppContents.searchstaff.tr),
                          Icon(Icons.search)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,
                      color: Color.fromRGBO(143, 148, 251, .6),),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.filter_alt)
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //----------------------------------show staff list container----------------------------
            _showStaffListData(),
          ],)
      }
    ],
  );
}

 Widget addstaffWidgetLayout() {
  return  Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(padding: const EdgeInsets.all(10.0),
                child: Image.asset(ImagesAssets.swear, height: 35, width: 35,),),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                child: Text(AppContents.marksattendancetitle.tr,
                  style: TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(ImagesAssets.calculator, height: 35, width: 35,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                child: Text(AppContents.autosalry.tr,
                  style: TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),),
            ],
          ),
          Row(children: [
            Padding(padding: const EdgeInsets.all(10.0),
              child: Image.asset(ImagesAssets.ticket, height: 35, width: 35,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.fromLTRB(
                  8.0, 0.0, 10.0, 0.0),
                child: Text(AppContents.sendwhatsappsalry.tr,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),),
            ),
          ],
          ),
          GestureDetector(
              onTap: () async{
                if(bussinessName=="null" ||bussinessName=="")
                {
                  staffListFlag=true;
                  _showBusinessDilaog(context);
                }
                else
                  {
                    addstaffData(context);
                  }
                },
              child: Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(ImagesAssets.inivite, height: 20, width: 20,),
                    ),
                    Text(AppContents.addstaff.tr, style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
          )
        ],
      ),),
  );
 }

  void setValueLocal() async{
     sharedPreferences = await SharedPreferences.getInstance();
     bussinessName=  sharedPreferences!.getString("bussiness_name").toString();
  }

}
