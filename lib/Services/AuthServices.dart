import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/CustomDialog.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/OtpModel/OtpModelClasss.dart';
import 'package:udharproject/model/OtpModel/OtpInfoModel.dart';
import 'package:udharproject/model/SocialMediaLogin/GetStaffUser.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialMedialLoginModel.dart';
import 'package:udharproject/model/StaffLoginModel/GetStaffModel.dart';

class AuthServices{
  //google sign in with firebase
  // signInwithGoogle() async{
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   final GoogleSignInAccount? gUser= await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication = await gUser!.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  // }


  // function to implement the google signin

// creating google signin (only google registration)


  static Future<void> signup(BuildContext context) async {
    Future<OTPModalClass>? _futureData;
    Future<SocialMediaLoginModel>? _futureSocialLogin;
    List<GetStaffUser> sharedGetStaffData=[];
    SharedPreferences loginData = await SharedPreferences.getInstance();
   final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      if (result != null) {
        User? user = result.user;
        var usermobile="";
        var usesrname="";
        if(user!=null) {
          if(user.phoneNumber!=null) {
            usermobile = user.phoneNumber.toString();
          }
          else
            {
                usermobile="";
            }
          if(user.displayName!=null)
            {
              usesrname=user.displayName.toString();
            }
          else
            {
              usesrname="";
            }
          if(user.email!=null) {
            var useremail=user.email.toString();
            print("user.email"+useremail);
         var   _futureSocialLogin = BooksApi.socialmedialloginpage(useremail, context);
            if (_futureSocialLogin != null) {
              _futureSocialLogin.then((value) {
                var res = value.response.toString();
                print("res"+res.toString());
                if (res =="true") {
                  if (value.info != null) {
                    var info = value.info;
                    var bussiness_id=info!.id.toString();
                    if(info.getStaffUser!=null)
                      {
                        List<GetStaffUser>? getstaff=info.getStaffUser;
                        if(getstaff!.length>1)
                          {
                            sharedGetStaffData= info.getStaffUser!;
                            final String encodedData = GetStaffUser.encode(sharedGetStaffData);
                            loginData.setString("getStaffListData",encodedData);
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
                                      Navigator.pushNamed(context, RoutesNamess.bussinessandstaffbothlogin,arguments: {
                                        "business_id":bussiness_id,
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
                        else
                          {
                            verifyBussinessmanapi(bussiness_id, context);
                          }

                      }
                    else
                      {
                        verifyBussinessmanapi(bussiness_id, context);
                      }
                  }
                }
                else if (res == "false") {
                  registration(usermobile,useremail,usesrname,context);
                }
              });
            }
          }
        }
      }


    }
  }

  static void registration(String usermobile,String email,String name,BuildContext context) async{
 var   _futureData = BooksApi.createFacebookRegistraion(usermobile,email,name,context);
    SharedPreferences loginData = await SharedPreferences.getInstance();
    if(_futureData!=null) {
      _futureData.then((value) {
        var code = value.statusCode.toString();
        print("dataresponse"+code);
        var msg=value.msg.toString();
        if(code=="200")
        {
          var resp=value.response.toString();
          if(resp=="true") {
            Fluttertoast.showToast(
                msg: " Registration Successfully ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepPurpleAccent,
                textColor: Colors.white,
                fontSize: 16.0
            );
            if (value.info != null) {
              var otpInfo = value.info;
              var token = otpInfo!.accessToken.toString();

              if(otpInfo.getBusiness!=null)
                {
                  otpInfo.getBusiness?.forEach((element) {
                    var name=element.businessName.toString();
                    var getbussiness_id=element.id.toString();
                    loginData.setString("token", token);
                    loginData.setString("user_id",otpInfo.id.toString() );
                    loginData.setString("email",otpInfo.email.toString() );
                    loginData.setString("name", otpInfo.name.toString());
                    loginData.setString("mobile",otpInfo.mobile.toString());
                    loginData.setString("bussiness_name",name);
                    loginData.setString("bussiness_id", getbussiness_id);

                    if(name!=null)
                      {
                        Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
                          "status":"false"
                        });
                      }
                    else
                      {
                        Navigator.pushNamed(context, RoutesNamess.businessmandashboard);
                      }
                  });
                }
              else
              {
                loginData.setString("token", token);
                loginData.setString("user_id",otpInfo.id.toString() );
                loginData.setString("email",otpInfo.email.toString() );
                loginData.setString("name", otpInfo.name.toString());
                loginData.setString("mobile",otpInfo.mobile.toString());
                loginData.setString("bussiness_name","");
                loginData.setString("bussiness_id","");
                Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));

              }

            }
          }

        }
        else
        {
          if(msg=="unsuccess")
          {
            Fluttertoast.showToast(msg: "" +msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepPurpleAccent,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else
          {
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
  static void verifyBussinessmanapi(String getBussiness_id,BuildContext context) async{
    var _futureSocialLogin= BooksApi.socialmedialverifyapi(getBussiness_id, context);
    SharedPreferences loginData = await SharedPreferences.getInstance();
    if(_futureSocialLogin!=null)
    {
      _futureSocialLogin.then((value) {
        var res=value.response.toString();
        if(res=="true")
        {
          var info=value.info;
          if(info!=null) {
            var bussiness_id=info!.id.toString();
            var bussinessList =info.getBusiness;
            var getStaffList=info.getStaffUser;
            // if(getStaffList!=null && getStaffList!.isNotEmpty)
            // {
            //   if(bussinessList!=null && bussinessList!.isNotEmpty)
            //   {
            //     var datastaff=getStaffList;
            //     print(""+datastaff.length.toString());
            //     if(datastaff!.length>=1)
            //     {
            //       var sharedGetStaffData = info.getStaffUser!;
            //       final String encodedData = GetStaffUser.encode(sharedGetStaffData);
            //       loginData.setString("getStaffListData",encodedData);
            //       Fluttertoast.showToast(
            //           msg: AppContents.otpSucess.tr,
            //           toastLength: Toast.LENGTH_SHORT,
            //           gravity: ToastGravity.CENTER,
            //           timeInSecForIosWeb: 1,
            //           backgroundColor: AppColors.drakColorTheme,
            //           textColor: AppColors.white,
            //           fontSize: AppSize.medium
            //       );
            //       Navigator.pushNamed(context, RoutesNamess.bussinessandstaffbothlogin,arguments: {
            //         'business_id':bussiness_id
            //       });
            //     }
            //
            //   }
            //   else
            //   {
            //    var sharedGetStaffData = info.getStaffUser!;
            //     var sh=  sharedGetStaffData.first;
            //     var token = info.accessToken.toString();
            //     loginData.setString("token", token);
            //     loginData.setString("user_id",sh.id.toString());
            //     loginData.setString("email", info.email.toString());
            //     loginData.setString("name", info.name.toString());
            //     loginData.setString("mobile", info.mobile.toString());
            //     loginData.setString("businessman_id",sh.ownerId.toString());
            //     loginData.setString("bussiness_id", sh.businessId.toString());
            //     loginData.setString("staff_create_date",sh.createdAt.toString());
            //     loginData.setString("staff_id",sh.staffId.toString());
            //     loginData.setString("type", "staffman");
            //     loginData.setString("salary_payment_type", sh.salaryPaymentType.toString());
            //     Navigator.pushNamed(context, RoutesNamess.staffdashboard);
            //
            //   }
            //
            //
            // }
            // else {
              if (info.getBusiness != null) {
                info.getBusiness?.forEach((element) {
                  var getbusiness_id = element.id.toString();
                  var buss_name = element.businessName;
                  var token = info.accessToken.toString();

                  if (buss_name != null) {
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
                      barrierColor: Colors.black54,
                      // space around dialog
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
                              Navigator.pushNamed(
                                  context, RoutesNamess.businessDetails,
                                  arguments: {
                                    "status": "false"
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
                      barrierColor: Colors.black54,
                      // space around dialog
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
                              Navigator.pushNamed(
                                  context, RoutesNamess.businessmandashboard);
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
            //}
          }
        }
      });
    }
  }



}

