import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Services/AuthServices.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/LoginModelClass.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _Mobilecontroller = TextEditingController();
  Future<LoginModelClass>? _futureLogin;
  final _formkey = GlobalKey<FormState>();

  bool _isLogin = false;
  Map _userObj = {};
  var email = "";
  var btn_color_visiblity=false;

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    _Mobilecontroller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _Mobilecontroller.addListener(() {
    final btn_color_visiblity= _Mobilecontroller.text.isNotEmpty;
  var  textlengh=  _Mobilecontroller.text;
   if(textlengh.contains("@"))
     {
        setState(() {
          this.btn_color_visiblity=btn_color_visiblity;

        });
     }
    });
  }

  int _state = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImagesAssets.loginBackground),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: Container(decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(ImagesAssets.loginLight))),
                          ),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(ImagesAssets.loginlightsecond))),
                          ),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(ImagesAssets.logincolok))),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(AppContents.login.tr,
                                style: TextStyle(color: AppColors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30.0),
                      child: buildColumn()
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Column buildColumn() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, .2),
                    blurRadius: 20.0,
                    offset: Offset(0, 10))
              ]),
          child: Column(
            children: <Widget>[
              //-----------------------email conatiner ---------------------------
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[100]!))),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: <TextInputFormatter>[
                    new LengthLimitingTextInputFormatter(30)
                  ],
                  autofocus: true,
                  controller: _Mobilecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppContents.email_validation.tr;
                    }
                    if (!RegExp(
                        r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                        .hasMatch(value)) {
                      return 'email_not_validate'.tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppContents.email.tr,
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),

            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        //submit btn
        GestureDetector(
          onTap: () {
            if(btn_color_visiblity)
              {
                setState(() {
                  btn_color_visiblity=true;
                });
              }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 1,
              //     blurRadius: 2,
              //     offset: Offset(0, 1),
              //   ),
              // ],
              gradient: LinearGradient(
                colors: btn_color_visiblity?[
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]: [Color.fromRGBO(143, 148, 251, .2), Color.fromRGBO(143, 148, 251, .2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

            child:  MaterialButton(
              child: setUpButtonChild(),
              onPressed: btn_color_visiblity?(){
                setState(() {
                  btn_color_visiblity=true;
                  if(_state==0)
                    {
                      _validation();
                    }
                });
              }: null,
              elevation: 4.0,
              minWidth: double.infinity,
              height: 48.0,

            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Align(
            alignment: Alignment.topRight,
            child:
            GestureDetector(
              onTap: () async{
               Navigator.pushNamed(context, RoutesNamess.forgetpassword);
              },
              child: Text(AppContents.forgetemail.tr, textAlign: TextAlign.end,
                  style: TextStyle(color: AppColors.drakColorTheme,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,)),
            )),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                AuthServices.signup(context);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(colors: [
                      Colors.grey.shade400,
                      Colors.white30,
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      children: [
                        Image.asset(ImagesAssets.loginGoogle),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Text("", style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FacebookAuth.instance.login(
                    permissions: ["public_profile", "email",]).then((value) {
                  FacebookAuth.instance.getUserData().then((userData) async {
                    setState(() {
                      _isLogin = true;
                      _userObj = userData;
                      _userObj.forEach((key, value) {});
                    });
                  });
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(colors: [
                      Colors.grey.shade400,
                      Colors.white30,
                    ])),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(ImagesAssets.loginFaceBook, height: 40, width: 40,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                          child: Text("",
                            style: TextStyle(
                                color: AppColors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 70,
        ),
        GestureDetector(
          onTap: () {

            Navigator.pushNamed(context, RoutesNamess.registration);
          },
          child: Align(
              alignment: Alignment.topCenter,
              child: Text("donotaccountsignup".tr, textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.drakColorTheme,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,))),
        ),

      ],
    );
  }

  void _validation() async {
    if(_formkey.currentState!.validate())
      {
        setState(() {
          _state = 1;
        });
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        var otemText = _Mobilecontroller.text;
        _futureLogin = BooksApi.createLoginPage(otemText, context);
        if (_futureLogin != null) {
          _futureLogin!.then((value) {
            var res = value.response.toString();
            var msg = value.msg.toString();

            if (res == "true") {
              Fluttertoast.showToast(
                  msg: AppContents.otpvertification.tr,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              setState(() {
                _state = 0;
              });
              Navigator.pushNamed(context, RoutesNamess.otpValidation,arguments: {
                "email":otemText
              });
            }
            else if (res == "false") {
              if (msg == "unsuccess") {
                setState(() {
                  _state = 0;
                });
                _Mobilecontroller.clear();
                sharedPreferences.setString("email", otemText);
                btn_color_visiblity=false;
                Navigator.pushNamed(context, RoutesNamess.registration);
              }
              else {
                setState(() {
                  _state = 0;
                });
                _Mobilecontroller.clear();
                btn_color_visiblity=false;
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
        else
          {
            setState(() {
              _state = 0;
            });
          }
      }
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        AppContents.login.tr,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: AppSize.medium,
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
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        ),
      );
    } else {
      return Icon(Icons.check, color: AppColors.white);
    }
  }


}





