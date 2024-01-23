import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/Registration/RegistartionModelResponse.dart';

class Registation extends StatefulWidget {
  const Registation({Key? key}) : super(key: key);
  @override
  State<Registation> createState() => _RegistationState();
}

class _RegistationState extends State<Registation> {
  final TextEditingController _Mobilecontroller = TextEditingController();
  final TextEditingController _Emailcontroller = TextEditingController();
  final TextEditingController _Namecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Future<Regitration>? _futureData;
  int _state = 0;
  var email="";
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    _Mobilecontroller.dispose();
    _Emailcontroller.dispose();
    _Namecontroller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setvalue();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>
              [
                Container(
                  height: 400,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/images/light-1.png'))),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/light-2.png'))),
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
                                  image: AssetImage('assets/images/clock.png'))),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(AppContents.Registration.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              //name conatiiner
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[

                                    new LengthLimitingTextInputFormatter(30)
                                  ],
                                  controller: _Namecontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppContents.namerequired.tr;
                                    }

                                    return null;
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppContents.entername.tr,
                                      hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                                ),

                              ),
                              //email conatner
                                  Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  inputFormatters: <TextInputFormatter>[

                                    new LengthLimitingTextInputFormatter(30)
                                  ],
                                  controller: _Emailcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppContents.email_validation.tr;
                                    }
                                    if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$").hasMatch(value)) {
                                      return AppContents.entervalidemail.tr;
                                    }
                                    return null;
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppContents.enteremail.tr,
                                      hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              //mobile number conatiner
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(10)
                                  ],
                                  controller: _Mobilecontroller,
                                  validator: (value)
                                  {
                                    if (value == null || value.isEmpty) {
                                      return AppContents.mobileRequredd.tr;
                                    }
                                    else if(value.length!=10)
                                    {
                                      return AppContents.mobiletendigit.tr;
                                    }
                                    return null;
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppContents.mobileEmpty.tr,
                                      hintStyle: TextStyle(color: Colors.grey[400])),
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                       // --------------------------registration button-------------------------------------
                        Container(
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
                                  _validationForm();
                                }
                              });
                            },
                            elevation: 4.0,
                            minWidth: double.infinity,
                            height: 48.0,

                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()),);
                          },
                          child: Text(AppContents.alreadysingin.tr,
                              style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1))),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _validationForm() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(_formkey.currentState!.validate())
      {
        setState(() {
          _state = 1;
        });
        var usermobile=_Mobilecontroller.text;
        var useremail=_Emailcontroller.text;
        var username=_Namecontroller.text;
        _futureData = BooksApi.createRegistrationPage(usermobile,useremail,"","",username,"","","",context);

          if(_futureData!=null) {

            _futureData!.then((value) {
              var res = value.response.toString();

              var msg=value.msg.toString();
              if(res=="true")
              {

                Fluttertoast.showToast(
                    msg:AppContents.otpvertification.tr,
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
                  "email":useremail
                });

              }
              else
              {
                if(msg=="The email has already been taken.")
                {
                  sharedPreferences.setString("email", useremail);
                  Fluttertoast.showToast(
                      msg: "Email already register ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  sharedPreferences.remove('email');
                  Navigator.pushNamed(context, RoutesNamess.loginscreen);

                }
                else
                {
                  sharedPreferences.remove('email');
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
  void setvalue() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    email=sharedPreferences.getString("email").toString();
    if(email=="null" || email=="")
    {
      _Emailcontroller.text = "";
    }
    else
    {
      _Emailcontroller.text = "" + email;
    }
  }
  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(AppContents.Registration.tr,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 17.0,
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


}
