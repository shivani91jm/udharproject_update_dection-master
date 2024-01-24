import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Activity/StaffActivityData/StaffDashbroadActvity.dart';
import 'package:udharproject/ML/Recognition.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';


class SplashScreen extends StatefulWidget {
  static Map<String,Recognition> registered = Map();
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    getUserRedirect();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    return Stack(
      children: [
    Positioned.fill(
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 148, 251, 1),
            Color.fromRGBO(143, 148, 251, .6),
          ])),
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            fontWeight: FontWeight.w800,
           fontFamily: 'Agne',
            fontStyle: FontStyle.italic,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Alldone'),
            ],
            onTap: ()
            {
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  new LoginPage()),);
            },
          ),
        ),
      ),
    ),
    ),
    Positioned.fill(
    child: FloatingBubbles(
          noOfBubbles: 25,
          colorsOfBubbles: [
          Colors.white.withAlpha(30),
          Colors.white,
          ],
          sizeFactor: 0.16,
          duration: 50, // 120 seconds.
          opacity: 70,
          paintingStyle: PaintingStyle.stroke,
          strokeWidth: 8,
          shape: BubbleShape.circle,
          )
    )]
    );
  }
  void getUserRedirect() {
    Timer(Duration(seconds: 3), () async
    {
      SharedPreferences prefsdf = await SharedPreferences.getInstance();
      var   go = prefsdf.getString("token").toString();
      var   type = prefsdf.getString("type").toString();
      if(go=="null")
      {
        Navigator.pushNamed(context, RoutesNamess.languagePage);
      }
      else if(go!=null && go!="")
      {
        if(type=="staffman")
        {
          Navigator.pushNamed(context, RoutesNamess.staffdashboard);

        }
        else {
          Navigator.pushNamed(context, RoutesNamess.businessmandashboard);

        }
      }
      else
      {
        Navigator.pushNamed(context, RoutesNamess.languagePage);
        //Navigator.pushNamed(context, RoutesNamess.loginscreen);
      }

    });
  }
}
