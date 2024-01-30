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
import 'package:udharproject/Utils/FontSize/size_extension.dart';
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
                height: 0.82.sh,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0.05.sw, 0.025.sh, 0.05.sw, 0.04.sh),
                decoration: BoxDecoration(
                  color: Color(0xff2E2E2E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.03.sh),
                    topRight: Radius.circular(0.03.sh),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CameraView(
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
                    const Spacer(),
                    if (_image != null)
                      GestureDetector(
                        onTap: () async{
                         setState(() {
                           _validationFormData(_image.toString());
                         });
                        },
                        child:   Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Center(
                              child: Text(AppContents.continues.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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

        var info =value.info.toString();
        print("staff information"+info.toString());
        print("staff information"+value.toString());


        var staffname=     prefs.getString('staffname')??"";
        var monthyly=      prefs.getString('monthyly')??"";
        String userId = Uuid().v1();
        UserModel user = UserModel(
          id: value.info!.id.toString(),
          name: staffname.toUpperCase(),
          image: _image,
          salaryType: monthyly,
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


        });



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
