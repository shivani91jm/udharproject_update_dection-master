import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/AdharCardOrPancardPage.dart';
import 'package:udharproject/Activity/CalculateSalaryPage.dart';
import 'package:udharproject/Activity/KYCBussinessPage.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Activity/ManngeBusinessList.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/FaceDetection/AutoDectionPage.dart';
import 'package:udharproject/FaceDetection/RecognitionScreen.dart';
import 'package:udharproject/ML/Recognition.dart';
import 'package:udharproject/ML/Recognizer.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/main.dart';
import 'package:udharproject/model/MonthlyWiseStaffListModel/Monthly.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialInfo.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import '../model/MonthlyWiseStaffListModel/Info.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late SharedPreferences loginData;
  var businessMob="",bussinessName="",bussinessEmail="",name="";
  var no_of_active_bussiness="";
  final TextEditingController _MobileController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  List<String> languageitemList = ['English', 'Hindi'];
  var language="";
  List<Recognition> recognitions = [];
   Recognizer? _recognizer;
  dynamic faceDetector;
  List<Monthly> getMonthlyConaList =[];
  var images;
  File? _image;
  List<Face> faces = [];
  dynamic _scanResults;
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    _MobileController.dispose();
    languageitemList.clear();
    super.dispose();

  }
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    faceDetector =FaceDetector(options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast));
    //TODO initialize face recognizer
    _recognizer=Recognizer();
    showStaffListData();
    getValueOfSharedPrefrence();
    bussinessListData();
    getValue();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    bool isSwitched = false;
    bool light = true;
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(AppContents.settings.tr),
          actions: [
            new IconButton(
                icon: new Icon(Icons.logout_rounded, color: Colors.white),
                onPressed: () async{
                 _showLogoutDilaog(context);
                }
            )]
          ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 40),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Column(
                  children: [
                    //-----------------------------Business Settings Container------------------------------------
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                      child: Column(
                        children: [
                          //----------------------------------title busniness name-------------------------------------
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    child: Row(
                                      children: [
                                        Image.asset(ImagesAssets.acount1,
                                            width: 25,
                                            height: 25,
                                            fit:BoxFit.fill
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(13.0,8.0,8.0,8.0),
                                          child: Text(AppContents.businessSetting.tr,style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0
                                          ),),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          height: 1,
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                         Divider(
                           height: 2,
                           color: Colors.black26
                         ),
                          //----------------------------bussiness name-------------------------------
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, RoutesNamess.updapBusinessNamepage);
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
                                            Text(AppContents.businessName.tr,style: TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0
                                            ),),
                                            Text(""+bussinessName,style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0
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
                                      icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                      onPressed: ()
                                      {
                                        Navigator.pushNamed(context, RoutesNamess.updapBusinessNamepage);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //-----------------------month calculation---------------------------------------
                          GestureDetector(
                            onTap: () async{
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  CalculateMonthlySaleryPage(bussinessName,"","","2")),);
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
                                            Text(AppContents.MonthCalculation.tr,style: TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0
                                            ),),
                                            Text(AppContents.caleverymonth.tr,style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0
                                            ),),

                                          ],
                                        ),
                                      )
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      iconSize: 18,
                                      splashColor:AppColors.drakColorTheme ,
                                      icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                      onPressed: () async{
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  CalculateMonthlySaleryPage(bussinessName,"","","2")),);

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                              height: 2,
                              color: Colors.black26
                          ),
                          //shiflt Settings
                          Padding(
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
                                          Text(AppContents.shiftSeting.tr,style: TextStyle(
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0
                                          ),),
                                          Text(AppContents.noshiiftaddSeting.tr,style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0
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
                                    icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                    onPressed: () async
                                    {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdharCardORPanCardPage()),);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                              height: 2,
                              color: Colors.black26
                          ),
                          //================Attendance Settings=================
                          Padding(
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
                                          Text(AppContents.attendanceSetting.tr,style: TextStyle(
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0
                                          ),),
                                          Text(AppContents.autoattendaceRule.tr,style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0
                                          ),),

                                        ],
                                      ),
                                    ),),
                                Switch(
                                  value: light,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                    setState(() {
                                     light = value;
                                });
                              },
                        ),
                       ]),),
                          Divider(
                              height: 2,
                              color: Colors.black26
                          ),
                          //Attendance on Holidays
                          Padding(
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

                                          Text(AppContents.attendanceonholiday.tr,style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0
                                          ),),

                                        ],
                                      ),
                                    ),),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      iconSize: 18,
                                      splashColor: AppColors.drakColorTheme ,
                                      icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                      onPressed: (){
                                        Navigator.pushNamed(context, RoutesNamess.staffAddLeave,arguments: {
                                          "page":"1"
                                        });

                                      },
                                    ),
                                  ),
                                ]),),

                          Divider(
                              height: 2,
                              color: Colors.black26
                          ),
                          //---------------aatendance scan-----------
                          Padding(
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
                                          Text(AppContents.scan.tr,style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0
                                          ),),

                                        ],
                                      ),
                                    ),),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      iconSize: 18,
                                      splashColor: AppColors.drakColorTheme ,
                                      icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                      onPressed: () async{
                                      var camera=  await availableCameras();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  AutoDectionPage(cameras: camera, recognizer: _recognizer,)),
                                      );
                                      // Navigator.push(context, MaterialPageRoute(builder: (_) => AutoDectionPage(cameras: value,_recognizer))));
                                        },
                                    ),
                                  ),
                                ]),),

                          Divider(
                              height: 2,
                              color: Colors.black26
                          ),
                          //Business bank account
                          Padding(
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
                                          Text(AppContents.businessBankAccount.tr,style: TextStyle(
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0
                                          ),),
                                          Text("Enter Details for Instant Refunds",style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0
                                          ),),

                                        ],
                                      ),
                                    ),),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      iconSize: 18,
                                      splashColor: AppColors.drakColorTheme ,
                                      icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AdharCardORPanCardPage()),);
                                      },
                                    ),
                                  ),
                                ]

                            ),

                          ),

                        ],
                ),
              ),

                  ],
          ),
        ),
              //-----------------------------------------------------
              //Account Settings Conatiner
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  child: Column(
                    children: [
                      //----------------------------title busniness name------------------------------------
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                child: Row(
                                  children: [
                                    Image.asset(ImagesAssets.acount1,
                                        width: 25,
                                        height: 25,
                                        fit:BoxFit.fill
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(13.0,8.0,8.0,8.0),
                                      child: Text(AppContents.accountSetting.tr,style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      height: 1,

                                    )
                                  ],
                                )
                            ),

                          ],
                        ),
                      ),
                      Divider(
                          height: 2,
                          color: Colors.black26
                      ),
                      //--------------------------Chanage Launge-----------------------------------------
                      GestureDetector(
                        onTap: (){
                          showdialogLaguage(context);
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
                                        Text(AppContents.Language.tr,style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0
                                        ),),
                                        Text(language.tr,style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0
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
                                  icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                  onPressed: (){
                                   showdialogLaguage(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                          height: 2,
                          color: Colors.black26
                      ),
                      //Security Password
                      Padding(
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
                                      Text(AppContents.secuitypass.tr,style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0
                                      ),),
                                      Text(AppContents.passwordnotactive.tr,style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0
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
                                icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AdharCardORPanCardPage()),);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                          height: 2,
                          color: Colors.black26
                      ),
                      //=============================Business Add====================================
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageBusinessList()),);
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
                                        Text(AppContents.Businesses.tr,style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0
                                        ),),
                                        Text(" "+no_of_active_bussiness+""+AppContents.activebusiness.tr,style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0
                                        ),),

                                      ],
                                    ),
                                  )
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  iconSize: 18,
                                  splashColor: AppColors.drakColorTheme,
                                  icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageBusinessList()),);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                          height: 2,
                          color: Colors.black26
                      ),
                      //KYB
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const KCYBusniessPage()),);
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
                                        Text(AppContents.KYB.tr,style: TextStyle(

                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0
                                        ),),
                                        Text(AppContents.completeKYB.tr,style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0
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
                                  icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                  onPressed: () async{
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const KCYBusniessPage()),);
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
              ),
              // ================================Personal Info======================
              Card(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  child: Column(
                    children: [
                      //tile busniness name
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                child: Row(
                                  children: [
                                    Image.asset(ImagesAssets.acount1,
                                        width: 25,
                                        height: 25,
                                        fit:BoxFit.fill
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(13.0,8.0,8.0,8.0),
                                      child: Text(AppContents.personalinfo.tr,style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      height: 1,

                                    )
                                  ],
                                )
                            ),

                          ],
                        ),
                      ),
                      Divider(
                          height: 2,
                          color: Colors.black26
                      ),
                      //User Name
                      Padding(
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
                                      Text(AppContents.name.tr,style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0
                                      ),),
                                      Text(""+name,style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0
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
                                icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                onPressed: (){

                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                          height: 2,
                          color: Colors.black26
                      ),
                      //Phone Number
                      Padding(
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
                                      Text(AppContents.phonenumber.tr,style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0
                                      ),),
                                      Text(""+businessMob,style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0
                                      ),),

                                    ],
                                  ),
                                )
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                iconSize: 18,
                                splashColor: AppColors.drakColorTheme,
                                icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                onPressed: (){

                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                          height: 2,
                          color: Colors.black26
                      ),
                      //Email Id
                      Padding(
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
                                      Text(AppContents.email.tr,style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0
                                      ),),
                                      Text(""+bussinessEmail,style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0
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
                                icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                onPressed: (){},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])
        )
      ),
    );
  }

  void getValueOfSharedPrefrence() async {
    loginData=await SharedPreferences.getInstance();
    setState(() {
      loginData.getString("token");
      bussinessEmail= loginData.getString("email")??"";
      name=loginData.getString("name")??"";
      businessMob=loginData.getString("mobile")??"";
      bussinessName=loginData.getString("bussiness_name")??"";
      if(businessMob=="null" )
        {
          showdialog(context);
        }
       else if(businessMob=="")
        {
          showdialog(context);
        }
       if(bussinessName=="null" || bussinessName==null)
         {
           bussinessName="";
         }

    });
  }
  void bussinessListData() async {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    print("token"+token);
    var user_id = prefsdf.getString("user_id").toString();
    setState(() {
      var _futureLogin = BooksApi.bussinessListData(user_id, token, context);
      if (_futureLogin != null) {
        _futureLogin.then((value) {
          var res = value.response;
          if (res == "true") {
            if(value.info!=null) {
              SocialInfo? info = value.info;
              if(info!.getBusiness!=null) {
                var getBussiness=info.getBusiness;
                setState(() {
                    no_of_active_bussiness = getBussiness!.length.toString();
                    for(int i=0;i<getBussiness.length;i++)
                      {
                        var  assgin_to_bussinesses_id = loginData.getString("bussiness_id").toString();
                        if(assgin_to_bussinesses_id==getBussiness[i].id.toString())
                          {
                            loginData.setString("bussiness_id", getBussiness[i].id.toString());
                            loginData.setString("bussiness_name",getBussiness[i].businessName.toString());
                          }
                      }

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

  void _showLogoutDilaog(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text(AppContents.logout.tr,style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),),
          content:  Text(AppContents.logoutsucesstitle.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:  Text(AppContents.cancel.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async{
                _logoutUser();
              } ,
              child:  Text(AppContents.ok.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }

  void _logoutUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
    GoogleSignIn _googleSignIn = GoogleSignIn();
    bool isSignedIn = await _googleSignIn.isSignedIn();
    _googleSignIn.signOut();
    await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);

  }

  void showdialog(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Center(
            child: Text(AppContents.updatemobile.tr,style: TextStyle(
                fontSize: AppSize.large,
                color: Colors.black87,
                fontWeight: FontWeight.bold
            ),),
          ),
          content: Container(
            height: 150,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                   Text(AppContents.mobileEmpty.tr),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,10,0,10),
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppContents.mobileloginsucess.tr;
                        }
                        else if(value.length!=10)
                        {
                          return AppContents.mobiletendigit.tr;
                        }
                        return null;
                      },
                      controller: _MobileController,

                      autofocus: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                          labelText: AppContents.mobileEmpty.tr,
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                          )  ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:  Text(AppContents.cancel.toString().tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async{
              updateMobileNumber();
              } ,
              child:  Text(AppContents.ok.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }
  //----------------------------show language dialog------------------------------------------

  void showdialogLaguage(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(30),
                  child: Text(AppContents.Language.tr,
                    style: TextStyle(
                    fontSize: 19,
                    color: AppColors.textColorsBlack,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppColors.lightTextColorsBlack,
                ),
                Expanded(
                  child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: languageitemList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () async{
                                language=languageitemList[index];
                                SharedPreferences prefrence=await SharedPreferences.getInstance();

                                print("laguage"+language);
                                if(language!=""&& language!="null")
                                {
                                  if(language=="English")
                                  {
                                    print("laguage id "+language);

                                    Get.updateLocale(Locale('en','us'));
                                    prefrence.setString("laguageValue", "English");
                                    Navigator.of(context).pop();

                                  }
                                  else if(language=="Hindi")
                                  {
                                    print("laguage else ifs"+language);
                                    Get.updateLocale(Locale('hi','In'));
                                    prefrence.setString("laguageValue", "Hindi");
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                              title: Text(languageitemList[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.dartTextColorsBlack,
                                  fontWeight: FontWeight.bold
                              ),
                              ),
                            );
                            }, separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                            height: 1,
                        color: AppColors.lightTextColorsBlack,
                  ); },),
                ),


              ],
            ),
          );
  });
  }
  void updateMobileNumber() async{
    if(_formkey.currentState!.validate()) {
      SharedPreferences prefsdf = await SharedPreferences.getInstance();
      var token = prefsdf.getString("token").toString();
      print("token" + token);
      var user_id = prefsdf.getString("user_id").toString();
      var mobile = _MobileController.text;
      var _futureLogin = BooksApi.updateMobileNumber(
          mobile, user_id, token, context);
      if (_futureLogin != null) {
        _futureLogin.then((value) {
          var res = value.response;
          if (res == "true") {
            if (value.info != null) {
              SocialInfo? info = value.info;
              if (info != null) {
                setState(() {
                  loginData.setString("mobile", info.mobile.toString()).toString();
                  businessMob = loginData.getString("mobile").toString();
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: AppContents.mobileloginsucess.tr,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.drakColorTheme,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );


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
    }
  }

  void getValue()  async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   language= sharedPreferences.getString("laguageValue")??"";
  }
  void showStaffListData() async{
  //  _isLoading=true;
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.ShowStffListAccordingToMonthly(user_id,bussiness_id, token, context);
    if (_futureLogin != null) {
      _futureLogin.then((value) async{
        var res = value.response;
        if (res == "true") {
          if (value.info!= null) {
            //_isLoading=false;
            Info ? info = value.info;
            getMonthlyConaList= info!.monthly!;
            if (getMonthlyConaList.isNotEmpty != null) {
              //storeimage();
            }
          }
        }
        else
        {
          setState(() {
           // _isLoading=false;
          });
        }
      });
    }
    else {
      _futureLogin.then((value) {
        String data = value.msg.toString();

        setState(() {
         // _isLoading=true;
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
  void storeimage() async {
    if(getMonthlyConaList.length!=0) {
      print("if working is zero ");
      for (int i = 0; i < getMonthlyConaList.length; i++) {
        var images = getMonthlyConaList[i].staff_image;
        var name = getMonthlyConaList[i].staffName;
        try {
          final http.Response responseData = await http.get(
              Uri.parse(images.toString()));
          var uint8list = responseData.bodyBytes;
          var buffer = uint8list.buffer;
          ByteData byteData = ByteData.view(buffer);
          var tempDir = await getTemporaryDirectory();
          // //  image="https://crm.shivagroupind.com//img//image_656f137d1e904.png"";
          _image = await File('${tempDir.path}/img').writeAsBytes(
              buffer.asUint8List(
                  byteData.offsetInBytes, byteData.lengthInBytes));
          faces.clear();

          images = await _image?.readAsBytes();
          images = await decodeImageFromList(images);
          print("${images.width}   ${images.height}");

          //  recognitions.clear();
          for (Face face in faces) {
            Rect faceRect = face.boundingBox;
            num left = faceRect.left < 0 ? 0 : faceRect.left;
            num top = faceRect.top < 0 ? 0 : faceRect.top;
            num right = faceRect.right > images.width
                ? images.width - 1
                : faceRect.right;
            num bottom = faceRect.bottom > images.height
                ? images.height - 1
                : faceRect.bottom;
            num width = right - left;
            num height = bottom - top;

            //TODO crop face
            File cropedFace = await FlutterNativeImage.cropImage(_image!.path,
                left.toInt(), top.toInt(), width.toInt(), height.toInt());
            final bytes = await File(cropedFace!.path).readAsBytes();
            final img.Image? faceImg = img.decodeImage(bytes);
            Recognition recognition = _recognizer!.recognize(
                faceImg!, face.boundingBox);
            if (recognition.distance > 1.25) {
              recognition.name = "Unknown";
            }
            recognitions.add(recognition);

            MyApp().registered.putIfAbsent(name.toString(), () => recognition);
            // _recognizer.MyApp().registered.putIfAbsent(name.toString(), () =>
            // recognition
            // );
          }
        } on Exception catch (_) {
          print("catch working...");
        }
      }
    }
    else
      {
        print("size is zero ");
      }

  }
//TODO remove rotation of camera images
  removeRotation(File inputImage) async {
    final img.Image? capturedImage = img.decodeImage(await File(inputImage!.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  //TODO perform Face Recognition
  performFaceRecognition() async {

    images = await _image?.readAsBytes();
    images = await decodeImageFromList(images);
    print("${images.width}   ${images.height}");

    recognitions.clear();
    for (Face face in faces) {
      Rect faceRect = face.boundingBox;
      num left = faceRect.left<0?0:faceRect.left;
      num top = faceRect.top<0?0:faceRect.top;
      num right = faceRect.right>images.width?images.width-1:faceRect.right;
      num bottom = faceRect.bottom>images.height?images.height-1:faceRect.bottom;
      num width = right - left;
      num height = bottom - top;

      //TODO crop face
      File cropedFace = await FlutterNativeImage.cropImage(_image!.path,
          left.toInt(),top.toInt(),width.toInt(),height.toInt());
      final bytes = await File(cropedFace!.path).readAsBytes();
      final img.Image? faceImg = img.decodeImage(bytes);
      Recognition recognition = _recognizer!.recognize(faceImg!, face.boundingBox);
      if(recognition.distance>1.25) {
        recognition.name = "Unknown";
      }
      // recognitions.add(recognition);
      //  _recognizer.registered.putIfAbsent(, () => recognition);
    }
    drawRectangleAroundFaces();
  }

  //TODO draw rectangles
  drawRectangleAroundFaces() async {
    setState(() {
      images;
      faces;
    });
  }

}
