import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/FaceDetection/camera_view.dart';
import 'package:udharproject/FaceDetection/extract_face_feature.dart';
import 'package:udharproject/ML/user_model.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class RegisterFaceView extends StatefulWidget {
  const RegisterFaceView({Key? key}) : super(key: key);

  @override
  State<RegisterFaceView> createState() => _RegisterFaceViewState();
}

class _RegisterFaceViewState extends State<RegisterFaceView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  String? _image;
  FaceFeatures? _faceFeatures;
  int _state = 0;
  var btn_color_visiblity=false;
  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,

        title: const Text("Register User"),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff8D8AD3),
              Color(0xff454362),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 800,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                decoration: BoxDecoration(
                  color: Color(0xff2E2E2E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(

                      child: CameraView(
                        onImage: (image) {
                          setState(() {
                            _image = base64Encode(image);
                          });
                        },
                        onInputImage: (inputImage) async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff55BD94),
                              ),
                            ),
                          );
                          _faceFeatures = await extractFaceFeatures(inputImage, _faceDetector);
                          setState(() {});
                          if (mounted) Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const Spacer(),
                    if (_image != null)

                      GestureDetector(
                        onTap: () {

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
                              colors: [Color.fromRGBO(143, 148, 251, .2), Color.fromRGBO(143, 148, 251, .2)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),

                          child:  MaterialButton(
                            child: setUpButtonChild(),
                            onPressed: () async{
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              setState(() {
                                btn_color_visiblity=true;

                                if(_state==0)
                                {

                                  var staffname=     prefs.getString('staffname')??"";
                                  String userId = Uuid().v1();
                                  UserModel user = UserModel(
                                    id: userId,
                                    name: staffname.toUpperCase(),
                                    image: _image,
                                    registeredOn: DateTime.now().millisecondsSinceEpoch,
                                    faceFeatures: _faceFeatures,
                                  );

                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(userId)
                                      .set(user.toJson())
                                      .catchError((e) {
                                    log("Registration Error: $e");
                                    Navigator.of(context).pop();

                                    Fluttertoast.showToast(
                                        msg: "Registration Failed! Try Again.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.deepPurpleAccent,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }).whenComplete(() {

                                    _validationFormData(_image.toString());

                                  });




                                }
                              });
                            },
                            elevation: 4.0,
                            minWidth: double.infinity,
                            height: 48.0,

                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _validationFormData(String image) async{
    setState(() {
      _state = 1;
    });
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var assign_to_owner_id = prefsdf.getString("user_id").toString();
    var  assgin_to_bussinesses_id = prefsdf.getString("bussiness_id").toString();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var staffname=     prefs.getString('staffname')??"";
    var staffmob=   await prefs.getString('staffmob')??"";
    var staffpassw =  await prefs.getString('staffpassw')??"";
    var staffemail =     await prefs.getString('staffemail')??"";
    var salary_amount=  await prefs.getString('salary_amount')??"";
    var staff_cycle=    await prefs.getString('staff_cycle')??"";
    var monthyly=     await prefs.getString('monthyly')??"";

    var _futureLogin = BooksApi.addStaff(staffname,staffmob,staffpassw,staffemail,staff_cycle,monthyly,salary_amount,assign_to_owner_id,assgin_to_bussinesses_id,token,context,image.toString() );
    _futureLogin.then((value) {
      var res = value.response;
      if (res == "true") {
        setState(() {
          _state = 0;
        });
        Fluttertoast.showToast(
            msg: "Add Staff Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
      }
      else
        {
          setState(() {
            _state = 0;
          });
        }
    });

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
