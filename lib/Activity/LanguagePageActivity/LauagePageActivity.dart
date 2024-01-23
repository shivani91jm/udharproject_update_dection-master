import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Colors/ColorsClass.dart';

import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';


class LanguageChangePage extends StatefulWidget {
  const LanguageChangePage({Key? key}) : super(key: key);
  @override
  State<LanguageChangePage> createState() => _LanguageChangePageState();
}

class _LanguageChangePageState extends State<LanguageChangePage> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
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
                          child: Text(AppContents.chooseChnage.tr,
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
              //---------------------english container ------------------------------
              Padding(
                padding: EdgeInsets.fromLTRB(30.0,30,30,10),
                child: Column(
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
                          GestureDetector(
                            onTap: () async{
                              Get.updateLocale(Locale('en','us'));
                             SharedPreferences pre=await SharedPreferences.getInstance();
                             pre.setString("laguageValue", "English");
                              Navigator.pushNamed(context, RoutesNamess.loginscreen);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text("English",style: TextStyle(
                                                color: AppColors.textColorsBlack,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppSize.fitlarge
                                            ),),

                                          ],
                                        ),
                                      )
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      iconSize: 18,
                                      splashColor: AppColors.drakColorTheme ,
                                      icon: Icon(Icons.arrow_forward_ios_rounded,color:  AppColors.lightTextColorsBlack,),
                                      onPressed: () async
                                      {
                                        Get.updateLocale(Locale('en','us'));
                                        SharedPreferences pre=await SharedPreferences.getInstance();
                                        pre.setString("laguageValue", "English");
                                        Navigator.pushNamed(context, RoutesNamess.loginscreen);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                  ],
                ),
              ),
              //--------------------hindi conatiner -------------------------
              Padding(
                padding: EdgeInsets.fromLTRB(30.0,0,30,10),
                child: Column(
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
                          GestureDetector(
                            onTap: () async{
                              Get.updateLocale(Locale('hi','In'));
                              SharedPreferences pre=await SharedPreferences.getInstance();
                              pre.setString("laguageValue", "Hindi");
                              Navigator.pushNamed(context, RoutesNamess.loginscreen);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Hindi",style: TextStyle(
                                                color: AppColors.textColorsBlack,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppSize.fitlarge
                                            ),),

                                          ],
                                        ),
                                      )
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      iconSize: 18,
                                      splashColor: AppColors.drakColorTheme ,
                                      icon: Icon(Icons.arrow_forward_ios_rounded,color:  AppColors.lightTextColorsBlack,),
                                      onPressed: () async
                                      {
                                        Get.updateLocale(Locale('hi','In'));
                                        SharedPreferences pre=await SharedPreferences.getInstance();
                                        pre.setString("laguageValue", "Hindi");
                                        Navigator.pushNamed(context, RoutesNamess.loginscreen);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                  ],
                ),
              ),


            ],
          ),
        ));
  }






}
