
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/BusinessDetailsPage.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/CustomDialog.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/WelcomeShivaBothLoginPage.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:http/http.dart' as http;
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/OtpModel/GetStaffUser.dart';

class OtpVerificationPage extends StatefulWidget {
  var data;
OtpVerificationPage(this.data);
  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {

  _OtpVerificationPageState();
  final TextEditingController _OTPfirstController = TextEditingController();
  final TextEditingController _OTPSecondController = TextEditingController();
  final TextEditingController _OTPThiredController = TextEditingController();
  final TextEditingController _OTPfourController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  int _state = 0;
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;
  var btn_color_visiblity=false;
  var email;

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    _OTPfourController.dispose();
    _OTPThiredController.dispose();
    _OTPSecondController.dispose();
    _OTPfirstController.dispose();
    timer?.cancel();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email=widget.data['email'];
    print("data"+email);
    _OTPfirstController.addListener(() {
      final btn_color_visiblity= _OTPfirstController.text.isNotEmpty;
      setState(() {
        this.btn_color_visiblity=btn_color_visiblity;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>
            [
              SizedBox(
                height: 70,
              ),
              Center(
                child: Container(
                  child: Image.asset(
                     ImagesAssets.otpvalidation,
                      height: 250,
                      fit:BoxFit.fill
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  child: Column(
                    children: [
                      Text(AppContents.emailverifi.tr,style: TextStyle(
                          color: AppColors.drakColorTheme,
                          fontSize: AppSize.large,
                          fontWeight: FontWeight.w800
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppContents.sendto.tr,
                                style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: AppSize.fitlarge,
                                    fontWeight: FontWeight.bold
                                ),),
                              Text(""+email, style: TextStyle(
                                    color: AppColors.drakColorTheme,
                                    fontSize: AppSize.fitlarge,
                                    fontWeight: FontWeight.w800
                                ),),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.drakColorTheme,
                                          blurRadius: 5.0,
                                          offset: Offset(5, 5))
                                    ]),
                                child: TextFormField(
                                  textAlign: TextAlign.center,

                                  onChanged: (value){
                                    if(value.length==1)
                                    {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  controller: _OTPfirstController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(1)
                                  ],
                                  style: Theme.of(context).textTheme.headline6,

                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.drakColorTheme,
                                          blurRadius: 5.0,
                                          offset: Offset(5, 5))
                                    ]),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  onChanged: (value){
                                    if(value.length==1)
                                    {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },

                                  controller: _OTPSecondController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(1)
                                  ],
                                  style: Theme.of(context).textTheme.headline6,

                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.drakColorTheme,
                                          blurRadius: 5.0,
                                          offset: Offset(5, 5))
                                    ]),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  onChanged: (value){
                                    if(value.length==1)
                                    {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },

                                  controller: _OTPThiredController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(1)
                                  ],
                                  style: Theme.of(context).textTheme.headline6,

                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.drakColorTheme,
                                            blurRadius: 5.0,
                                            offset: Offset(5, 5))
                                      ]),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    onChanged: (value){
                                      if(value.length==1)
                                      {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    validator: (value)
                                    {
                                      if (value == null || value.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: AppContents.OtpEmpty,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.deepPurpleAccent,
                                            textColor: AppColors.white,
                                            fontSize: AppSize.medium
                                        );
                                      }
                                      return null;
                                    },

                                    controller: _OTPfourController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(1)
                                    ],
                                    style: Theme.of(context).textTheme.headline6,

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //--------------------------- otp verify button-----------------------------
                    GestureDetector(
                      onTap: (){
                        if(btn_color_visiblity)
                        {
                          setState(() {
                            btn_color_visiblity=true;
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: btn_color_visiblity?[
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ]: [Color.fromRGBO(143, 148, 251, .2), Color.fromRGBO(143, 148, 251, .2)] )),
                        child: new MaterialButton(
                          highlightElevation: 50,
                          child: setUpButtonChild(),
                          onPressed: btn_color_visiblity ? () {
                         setState(() {
                           if (_state == 0) {
                             btn_color_visiblity=true;
                             _verifyOtpandLogin();
                           }
                         });
                          }: null,
                          elevation: 4.0,
                          minWidth: double.infinity,
                          height: 48.0,

                        ),
                      ),
                    ),
                    //--------------------------RESEND OTP-------------------
                    SizedBox(
                    height: 20,
                  ),
                    GestureDetector(
                    onTap: () async{
                      if(enableResend==false)
                      {
                          buildWiget();
                      }
                      _resendCode();

                    },
                    child: Column(
                     children: [
                       if(enableResend==false)...
                       {
                         Text(AppContents.ResentOTp.tr,style: TextStyle(color: Colors.black87, fontSize: 16),)

                       }
                       else...
                           [
                              Text('after $secondsRemaining seconds', style: TextStyle(color: Colors.red, fontSize: 16),),
                           ]
                     ],
                    ),
                  )


                  ],
                ),
              )

            ],
          ),
        )
      ),

    );
  }

  // -----------------==========validation with form data value get ---------------------------------------------------------------------------
  _verifyOtpandLogin() async{
    if(_formkey.currentState!.validate())
    {
      var o1 = _OTPfirstController.text;
      print("o1" + o1);
      var o2 = _OTPSecondController.text;
      print("o2" + o1);
      var o3 = _OTPThiredController.text;
      print("o3" + o3);
      var o4 = _OTPfourController.text;
      print("o4" + o4);
      String otp = o1 + o2 + o3 + o4;
      print("otp" + otp);
      verifyOtpPage(email,otp,context);
    }
  }
  void verifyOtpPage(String email, String otp,BuildContext context) async
  {
    setState(() {
      _state=1;
    });
    SharedPreferences loginData = await SharedPreferences.getInstance();
    print("email"+email+"otp"+otp);
    var   _futureLogin = BooksApi.verifyOtpPage(email, otp,context);
    if(_futureLogin!=null)
      {
        _futureLogin.then((value) {
          var res = value.response.toString();
          print("res"+res.toString());
          if (res =="true") {
            setState(() {
              _state=0;
            });
            if (value.info != null) {
              var info = value.info;
              var bussiness_id=info!.id.toString();
              var bussinessList =info.getBusiness;
              var getStaffList=info.getStaffUser;
              if(getStaffList!=null && getStaffList!.isNotEmpty)
              {
                if(bussinessList!=null && bussinessList!.isNotEmpty)
                  {
                    var datastaff=getStaffList;
                    print(""+datastaff.length.toString());
                    if(datastaff!.length>=1)
                    {
                      List<GetStaffUser>sharedGetStaffData = info.getStaffUser!;
                      final String encodedData = GetStaffUser.encode(sharedGetStaffData);
                      loginData.setString("getStaffListData",encodedData);
                      Fluttertoast.showToast(
                          msg: AppContents.otpSucess.tr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.drakColorTheme,
                          textColor: AppColors.white,
                          fontSize: AppSize.medium
                      );
                      Navigator.pushNamed(context, RoutesNamess.bussinessandstaffbothlogin,arguments: {
                        'business_id':bussiness_id
                      });
                    }

                  }
                else
                  {
                    List<GetStaffUser>sharedGetStaffData = info.getStaffUser!;
                  var sh=  sharedGetStaffData.first;
                    var token = info.accessToken.toString();
                    loginData.setString("token", token);
                    loginData.setString("user_id",sh.id.toString());
                    loginData.setString("email", info.email.toString());
                    loginData.setString("name", info.name.toString());
                    loginData.setString("mobile", info.mobile.toString());
                    loginData.setString("businessman_id",sh.ownerId.toString());
                    loginData.setString("bussiness_id", sh.businessId.toString());
                    loginData.setString("staff_create_date",sh.createdAt.toString());
                    loginData.setString("staff_id",sh.staffId.toString());
                    loginData.setString("type", "staffman");
                    loginData.setString("salary_payment_type", sh.salaryPaymentType.toString());
                    Navigator.pushNamed(context, RoutesNamess.staffdashboard);

                  }


              }
              else
                {
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

                        showGeneralDialog(
                          barrierDismissible: false,
                          context: context,
                          barrierColor: AppColors.textColorsBlack, // space around dialog
                          transitionDuration: Duration(milliseconds: 800),
                          transitionBuilder: (context, a1, a2, child) {
                            return ScaleTransition(
                              scale: CurvedAnimation(
                                  parent: a1,
                                  curve: Curves.elasticOut,
                                  reverseCurve: Curves.easeOutCubic),
                              child: CustomDialog( // our custom dialog
                                title: AppContents.login,
                                content:AppContents.loginSucess.tr,
                                positiveBtnText: AppContents.Done.tr,
                                negativeBtnText: AppContents.cancel.tr,
                                positiveBtnPressed: () {
                                  Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
                                    "status":"false"
                                  });
                                },
                              ),
                            );
                          },
                          pageBuilder: (BuildContext context, Animation animation,
                              Animation secondaryAnimation) {
                            return Text("gfhghf");
                          },
                        );

                      }
                      else {
                        loginData.setString("token", token);
                        loginData.setString("user_id", info.id.toString());
                        loginData.setString("email", info.email.toString());
                        loginData.setString("name", info.name.toString());
                        loginData.setString("mobile", info.mobile.toString());
                        loginData.setString("bussiness_name", buss_name.toString());
                        loginData.setString("bussiness_id", getbusiness_id);
                        loginData.setString("type", "bussinessman");
                        showGeneralDialog(
                          barrierDismissible: false,
                          context: context,
                          barrierColor: Colors.black54, // space around dialog
                          transitionDuration: Duration(milliseconds: 800),
                          transitionBuilder: (context, a1, a2, child) {
                            return ScaleTransition(
                              scale: CurvedAnimation(
                                  parent: a1,
                                  curve: Curves.elasticOut,
                                  reverseCurve: Curves.easeOutCubic),
                              child: CustomDialog( // our custom dialog
                                title: AppContents.login.tr,
                                content:
                                AppContents.loginSucess.tr,
                                positiveBtnText: AppContents.Done.tr,
                                negativeBtnText: AppContents.cancel.tr,
                                positiveBtnPressed: () {
                                  Navigator.pushNamed(context, RoutesNamess.businessmandashboard);
                                  },
                              ),
                            );
                          },
                          pageBuilder: (BuildContext context, Animation animation,
                              Animation secondaryAnimation) {
                            return Text("gfhghf");
                          },
                        );

                      }
                    });
                  }
                }
            }
          }
          else if(res=="false")
            {
              setState(() {
                _state=0;
              });
              var token =  value.msg;
              if(token=="Otp Not Match"){
                Fluttertoast.showToast(
                    msg: AppContents.Otpnotmatch.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColors.drakColorTheme,
                    textColor: AppColors.white,
                    fontSize: AppSize.medium
                );
              }
              else {
                Fluttertoast.showToast(
                    msg: AppContents.OtpEmpty.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: AppColors.drakColorTheme,
                    textColor: Colors.white,
                    fontSize: AppSize.medium
                );
              }
            }
        });
      }
  }
  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        AppContents.verfyOtp.tr,
        style: const TextStyle(
            color: AppColors.white,
            fontSize: AppSize.medium,
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
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        ),
      );
    } else {
      return Icon(Icons.check, color: AppColors.white);
    }
  }


  void _resendCode() {

   setState(() {
     enableResend=true;

   });
    timer = Timer.periodic(Duration(seconds: 2), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = false;

        });
      }
    });

    setState((){
      secondsRemaining = 30;
      enableResend = true;
    });
  }

  buildWiget() {
   var _futureLogin = BooksApi.createLoginPage(email, context);
    if (_futureLogin != null) {
      _futureLogin!.then((value) {
        var res = value.response.toString();
        if (res == "true") {
          Fluttertoast.showToast(
              msg: AppContents.otpvertification.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.drakColorTheme,
              textColor: AppColors.white,
              fontSize: AppSize.medium
          );
        }

      });
    }
  }



}
