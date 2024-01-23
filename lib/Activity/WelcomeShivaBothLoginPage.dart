import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';

import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/SocialMediaLogin/GetStaffUser.dart';

class BothLoginPage extends StatefulWidget {
  var data;
 BothLoginPage(this.data);
 @override
  State<BothLoginPage> createState() => _BothLoginPageState();
}

class _BothLoginPageState extends State<BothLoginPage> {
  var bussiness_id;
  _BothLoginPageState();
  Object?  _character;
  Object? selectedUser;
  List<GetStaffUser> getBussiness=[];
  bool _firstpage = false;
  final _formkey = GlobalKey<FormState>();
  var besins_id,staffid;
  int _state = 0;
  bool _isLoading=false;
  bool _isStaffList=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bussiness_id=widget.data['business_id'];
    getStaffValeData();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    return Scaffold(
      appBar: AppBar(
    leading: new IconButton(
      icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
      onPressed: () async{
       // Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BothLoginPage(bussiness_id)));
      },
    ),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ])),
          child: new MaterialButton(
            highlightElevation: 50,
            child: setUpButtonChild(),
            onPressed: () {
              setState(() {
                if (_state == 0) {
                _validationData();
                }
              });
            },
            elevation: 4.0,
            minWidth: double.infinity,
            height: 48.0,

          ),
        ),
      ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints)
      {
        return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        //titile
            Container(
              margin: EdgeInsets.fromLTRB(15, 30, 10, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(""+AppContents.welcometo.tr,style: TextStyle(
                      color: Colors.black87,
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppContents.whoareyou.tr,style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0
                    ),),
                  ),
                ],
              ),
            ),
            //Busniessman conatiner
            Container(
                margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
                padding: EdgeInsets.all(8.0),
                child:  GestureDetector(
                  onTap: () async{},
                  child: RadioListTile(
                    title:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppContents.imabussinessman.tr,style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),),
                        Text(AppContents.salaryattendance.tr,style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0
                        ),),
                      ],
                    ),
                    value: "Bussinessman",
                    groupValue: (_character!= null)
                   ? _character : "Bussinessman",
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                        print("datadsfd"+_character.toString());
                      });
                    },
                  ),
                )
            ),
            // Staff Conatiner
             Container(
                margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
                padding: EdgeInsets.all(8.0),
                child: RadioListTile(
                  title:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppContents.workeryastaff.tr,style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),),
                      Text(AppContents.checkattendanceandsalryrec.tr,style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                      ),),
                    ],
                  ),
                  value:"Staff",
                  groupValue: _character,
                  onChanged: (value){
                    setState(() {
                      _character=value;
                      print("data343"+_character.toString());
                    });
                  },
                )),
            //list of bussiness man
               Visibility(
                 visible: _firstpage,
               child:  Container(
               margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
               decoration: BoxDecoration(
                 border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                 borderRadius: BorderRadius.all(Radius.circular(1)),
               ),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.fromLTRB(15.0,20,15,20),
                     child: Container(
                       child: Text(AppContents.mutiplesamephonenumber.tr,style: TextStyle(
                           color: Colors.black87,
                           fontWeight: FontWeight.bold,
                           fontSize: 15.0
                       ),
                       ),),
                   ),
                   Divider(
                     height: 1,
                     thickness: 1,
                     endIndent: 1,
                     color: Colors.grey,
                   ),

                   _listdata()
                 ],
               ))),
            SizedBox(
              height: 50,
            ),

          ],
        ),
      ),
    );
     }
    ));
  }
  Widget _listdata() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, position) {
          return Divider(
            height: 1,
            thickness: 1,
            endIndent: 1,
            color: Colors.grey,
          );
        },
        shrinkWrap: true,
        itemCount: getBussiness.length,
        itemBuilder: (context, int index){
          if(getBussiness.length==null)
          {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepOrangeAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          }
          else
          {
            return ListTile(
                onTap: () async{
                  Navigator.pushNamed(context, RoutesNamess.businessmandashboard);
                },
                title: Column(
                  children: [
                    RadioListTile(
                      value: getBussiness[index].id.toString(),
                      groupValue: _character,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //staff name
                          Text(getBussiness[index].staffName.toString(),style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),),
                        //bussinessman name
                          if(getBussiness[index].getBusiness!=null && getBussiness[index].getBusiness!.isNotEmpty)...[ Text("${getBussiness[index].getBusiness!.first.getBusinessMan!.name}",style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0

                          ),)]
                          else ...[Text("no data",style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0
                          ),)],
                          //staff create date
                          if(getBussiness[index].createdAt!=null)...[ Text("${DateFormat('dd/MM/yyyy').format(DateTime.parse(getBussiness[index].createdAt.toString()))}",style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0
                          ),
                          )]
                          else ...[Text("no data",style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0
                          ),)],
                        ],
                      ),
                      onChanged: (val) {
                        print("Radio $val");
                        setState(() {
                          _character = val;
                        });
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaffScreenPage()),);
                      },
                    ),
                 ]
                ),
                trailing:   Column(
                children: [
                  if(getBussiness[index]!=null)...[ Text("${getBussiness[index].salaryPaymentType.toString()}",style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0
                  ),
                  )]
                  else ...[Text("no data",style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0

                  ),)],
                ],
              )

            );

          }
        }
    );

  }

  void _validationData() async{
    if(_formkey.currentState!.validate()) {
      setState(() {
        _state = 1;
      });
      besins_id=bussiness_id;
      if(_character==null) {

        verifyBussinessmanapi(besins_id,context,"Bussinessman");
      }
      else if(_character=="Bussinessman")
        {

          verifyBussinessmanapi(besins_id,context,"Bussinessman");
        }
      else if(_character=="Staff")
        {
          verifyBussinessmanapi(besins_id,context,"Staff");
        }
      else
        {
          besins_id=_character.toString();
          print(""+besins_id);
          verifyBussinessmanapi(besins_id,context,"Staff");
        }


    }
  }

  void getStaffValeData() async{
    besins_id=bussiness_id;
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    final String? musicsString =  prefsdf.getString('getStaffListData');
    setState(() {
      getBussiness = GetStaffUser.decode(musicsString);
      var getstafflength=  getBussiness.length;
      _firstpage=true;
      if(getstafflength>1)
        {
          _firstpage=true;
        }
      else
        {
          _firstpage=false;
        }
    });
  }
   void verifyBussinessmanapi(String getBussiness_id,BuildContext context,String type) async {
    print("bussiness_id"+getBussiness_id.toString());
    var _futureSocialLogin= BooksApi.socialmedialverifyapi(getBussiness_id, context);
    SharedPreferences loginData = await SharedPreferences.getInstance();
    if(_futureSocialLogin!=null)
    {
      _futureSocialLogin.then((value) {
        var res=value.response.toString();
        if(res=="true")
        {
          setState(() {
            _state = 0;
          });
          var info=value.info;
          if(info!=null) {
            if(type=="Staff") {
              if (info.getStaffUser != null) {
              var userid= info.getStaffUser!.first.id.toString();
              var business_id=info.getStaffUser!.first.businessId.toString();
              var owner_id=info.getStaffUser!.first.ownerId.toString();
              var staff_create_date=info.getStaffUser!.first.createdAt.toString();
              var staff_salary_type=info.getStaffUser!.first.salaryPaymentType.toString();
              var staff_id=info.getStaffUser!.first.staffId.toString();
                var token = info.accessToken.toString();
                loginData.setString("token", token);
                loginData.setString("user_id",userid);
                loginData.setString("email", info.email.toString());
                loginData.setString("name", info.name.toString());
                loginData.setString("mobile", info.mobile.toString());
                loginData.setString("businessman_id",owner_id);
                loginData.setString("bussiness_id", business_id);
                loginData.setString("staff_create_date",staff_create_date);

                loginData.setString("staff_id",staff_id);
                loginData.setString("type", "staffman");
                loginData.setString("salary_payment_type", staff_salary_type);
                Navigator.pushNamed(context, RoutesNamess.staffdashboard);
              }
            }
            else {
              if (info.getBusiness != null) {
                info.getBusiness?.forEach((element) {
                  var getbusiness_id = element.id.toString();
                  var buss_name = element.businessName;
                  var token = info.accessToken.toString();
                  if (buss_name == null) {
                    loginData.setString("token", token);
                    loginData.setString("user_id", info.id.toString());
                    loginData.setString("email", info.email.toString());
                    loginData.setString("name", info.name.toString());
                    loginData.setString("mobile", info.mobile.toString());
                    loginData.setString("bussiness_name", "");
                    loginData.setString("bussiness_id", getbusiness_id);
                    loginData.setString("type", "bussinessman");
                    Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
                      "status":"false"
                    });

                  }
                  else
                  {
                    loginData.setString("token", token);
                    loginData.setString("user_id", info.id.toString());
                    loginData.setString("email", info.email.toString());
                    loginData.setString("name", info.name.toString());
                    loginData.setString("mobile", info.mobile.toString());
                    loginData.setString("bussiness_name", buss_name.toString());
                    loginData.setString("bussiness_id", getbusiness_id);
                    loginData.setString("type", "bussinessman");

                    Navigator.pushNamed(context, RoutesNamess.businessmandashboard);
                  }
                });
              }
            }
          }
        }
        else
          {
            setState(() {
              _state = 0;
            });
          }
      });
    }
  }
  Widget setUpButtonChild() {
    if (_state == 0) {
      return  Text(AppContents.continues.tr,
        style: const TextStyle(
            color: AppColors.white,
            fontSize: AppSize.seventin,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold
        ),
      );
    } else if (_state == 1) {
      return Center(
        child: Container(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

 Widget _ErrorWidget() {
   return Center(
     child: CircularProgressIndicator(
       backgroundColor: Colors.deepPurpleAccent,
       valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
     ),
   );
 }

}
