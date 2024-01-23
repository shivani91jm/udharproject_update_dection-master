import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/AdharCardOrPancardPage.dart';
import 'package:udharproject/Activity/BankDetailsPage.dart';
import 'package:udharproject/Activity/GSTCertificedPage.dart';
import 'package:udharproject/Activity/PanCardPage.dart';
import 'package:udharproject/Activity/ProfileImagePage.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:http/http.dart' as http;
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Contents/Urls.dart';
import 'package:udharproject/Controller/KYCController.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';

class KCYBusniessPage extends StatefulWidget {
  const KCYBusniessPage({Key? key}) : super(key: key);
  @override
  State<KCYBusniessPage> createState() => _KCYBusniessPageState();
}

class _KCYBusniessPageState extends State<KCYBusniessPage> {
  var mobile="8887885055";
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _BussinessNamecontroller = TextEditingController();
  final TextEditingController _BussinessAddcontroller = TextEditingController();
  final TextEditingController _PanNocontroller = TextEditingController();
  final TextEditingController _BankAccountNOCOntroller = TextEditingController();
  final TextEditingController _IFSCNoController = TextEditingController();
  final TextEditingController _AdharCardNoController = TextEditingController();
  final TextEditingController _MobileController = TextEditingController();
  final TextEditingController _MobileGSTController = TextEditingController();
  final TextEditingController _DOBController = TextEditingController();
  final TextEditingController _BankBranchController = TextEditingController();
var gstimage="";
var profileimage="";
var adhar_front_image="";
var adhar_back_image="";
var pan_front_image="";
var pan_back_image="";
var bank_image="";
var profile_image="";
var picimage="";
  KYCController controller = Get.put(KYCController());
 @override
  void initState() {
    super.initState();
    _MobileController.text=""+mobile;
    getBussinessInfomationApi();

  }
  Future<String> imageToBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final base64String = base64Encode(bytes);
    return base64String;
  }
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    _BankBranchController.dispose();
    _BussinessNamecontroller.dispose();
    _BussinessAddcontroller.dispose();
    _PanNocontroller.dispose();
    _BankAccountNOCOntroller.dispose();
    _IFSCNoController.dispose();
    _AdharCardNoController.dispose();
    _MobileController.dispose();
    _DOBController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("KYC Registration"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Colors.deepPurpleAccent,
            height: 50,
            width: 325,
            child: ElevatedButton(
              onPressed: ()async
              {
                if(_formkey.currentState!.validate())
                  {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    var userid="1";
                    var token=prefs.getString("token").toString();
                    var bussinessname=_BussinessNamecontroller.text;
                    var bussaddress=_BussinessAddcontroller.text;
                    var panno=_PanNocontroller.text;
                    var adharno=_AdharCardNoController.text;
                    var bankno=_BankAccountNOCOntroller.text;
                    var banbranch=_BankBranchController.text;
                    var ifsccode=_IFSCNoController.text;
                    var gstno=_MobileGSTController.text;
                    var dob=_selectedDate.toString();
                    profile_image = prefs.getString("profile_image")??"";
                    pan_front_image = prefs.getString("pan_front_image")??"";
                    pan_back_image = prefs.getString("pan_back_image")??"";
                    adhar_front_image = prefs.getString("adhar_front_image")??"";
                    adhar_back_image= prefs.getString("adhar_back_image")??"";
                    bank_image = prefs.getString("bank_image")??"";
                    gstimage =   prefs.getString("gstimage")??"";

                    if(profile_image==null && profile_image!="")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Select your profile",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurpleAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(profile_image=="null")
                    {
                      Fluttertoast.showToast(
                          msg: "Please Select your profile",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else if(pan_front_image==null && pan_front_image!="")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Select pan card front side image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurpleAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(pan_front_image=="null")
                    {
                      Fluttertoast.showToast(
                          msg: "Please Select pan  front side image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else if(pan_back_image==null && pan_back_image!="")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Select pan card back side image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurpleAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(pan_back_image=="null")
                    {
                      Fluttertoast.showToast(
                          msg: "Please Select pan card back side image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else if(adhar_front_image==null && adhar_front_image!="")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Select Aadhaar front side image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurpleAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(adhar_front_image=="null")
                    {
                      Fluttertoast.showToast(
                          msg: "Please Select Aadhaar front side image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else if(adhar_back_image==null && adhar_back_image!="")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Select Aadhaar back side image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurpleAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(adhar_back_image=="null")
                    {
                      Fluttertoast.showToast(
                          msg: "Please Select aadhaar back side image ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else if(bank_image==null && bank_image!="")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Select your bank image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurpleAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(bank_image=="null")
                    {
                      Fluttertoast.showToast(
                          msg: "Please Select  bank image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                   else if(gstimage==null && gstimage!="")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Select GST Image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurpleAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(gstimage=="null")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Select GST Image",
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
                        controller.loding.value=true;
                       var furturedata= BooksApi.uploadDocument(profile_image, bank_image,bankno, ifsccode, banbranch, "", "", adharno,dob, adhar_front_image, adhar_back_image, pan_back_image, panno,pan_front_image, userid,gstno,gstimage,bussaddress, token, context,"","bussiness_man","");
                       if(furturedata!=null)
                         {
                           furturedata.then((value) {
                             var res=  value.response;
                             if(res=="true")
                             {
                               controller.loding.value=false;
                               Fluttertoast.showToast(
                                   msg: "Document Uploaded Successfully",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.deepPurpleAccent,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                               getBussinessInfomationApi();

                             }
                             else
                               {
                                 controller.loding.value=false;
                                 Fluttertoast.showToast(
                                     msg: "Something went wrong",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.CENTER,
                                     timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.deepPurpleAccent,
                                     textColor: Colors.white,
                                     fontSize: 16.0
                                 );
                               }
                           });
                         }
                      }

                  }
              },
              child: Text(
               "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),

            ),),

      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //bussiness type
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),),
                elevation: 4,
                margin: EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Business Deatils
                      SizedBox(
                        height: 20,
                      ),
                      //bussiness title
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 15, 10, 20),
                        child: Text('Business Type',style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      //business mobile number
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            new LengthLimitingTextInputFormatter(50)
                          ],
                          enabled: false,
                          showCursor: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mobile is Requires!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme)
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),
                            labelText: "Registered Phone Number",
                            labelStyle: TextStyle(color: Colors.black87,fontSize: 15),
                          ),
                          controller: _MobileController,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              //business details
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),),
                elevation: 4,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Business Deatils
                      //Name Controller
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 15, 10, 20),
                        child: Text('Business Details',style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            new LengthLimitingTextInputFormatter(50)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Business Name is Requires!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.red)
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),
                            labelText: "Business Name",
                            labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14),
                          ),
                          controller: _BussinessNamecontroller,
                        ),
                      ),
                      //Business address
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[

                            new LengthLimitingTextInputFormatter(50)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Business Address is Requires!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(

                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme)
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),
                            labelText: "Business Address",
                            labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14),
                          ),
                          controller: _BussinessAddcontroller,
                        ),
                      ),
                      //proprietor pan number
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[

                            new LengthLimitingTextInputFormatter(50)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pan Number is Requires!!';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(

                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme)
                            ),
                            labelText: "Proprietor PAN Number",
                            labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14),
                          ),
                          controller: _PanNocontroller,
                        ),
                      ),
                      //adhar card no
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(50)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' Aadhaar Card Number is Requires!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(

                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme)
                            ),
                            labelText: "Proprietor Aadhaar Card Number",
                            labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14),
                          ),
                          controller: _AdharCardNoController,
                        ),
                      ),
                      //bank account number
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            new LengthLimitingTextInputFormatter(50)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' Bank Account Number is Requires!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme)
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),
                            labelText: "Bank Account Number(Business / Proprietor)....",
                            labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14),
                          ),
                          controller: _BankAccountNOCOntroller,
                        ),
                      ),
                      //dob container
                      GestureDetector(
                        onTap: (){
                         _selectDate(context);
                        },
                        child: Container(
                          width: 350,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          decoration: BoxDecoration(border: Border.all(width: 1,
                            color:   Color.fromRGBO(143, 148, 251, .6),),
                              borderRadius: BorderRadius.all(Radius.circular(3))),
                          padding: EdgeInsets.all(8.0),
                          child:  Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_selectedDate == null ? 'Please Enter DOB' : '${DateFormat('dd/MM/yyyy').format(_selectedDate!)},',style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                                ),),
                                Icon(Icons.calendar_month,color:  Color.fromRGBO(143, 148, 251, 6),)
                              ],
                            ),
                          ),

                        ),
                      ),
                      //bank branch
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[

                            new LengthLimitingTextInputFormatter(50)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' Bank Branch name is  Requires!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(

                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),
                            labelText: "Bank Branch Name",
                            labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14),
                          ),
                          controller: _BankBranchController,
                        ),
                      ),
                      //bank ifsc code
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0,8,8,10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            new LengthLimitingTextInputFormatter(50)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' IFSc Code is Requires!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),
                            labelText: "IFSC Code (Of Provided Bank Account)",
                            labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14),
                          ),
                          controller: _IFSCNoController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //business documents
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),),
                elevation: 4,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Business Deatils
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 15, 0, 20),
                        child: Text('Business Documents',style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      //profile container
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()),);
                        },
                        child: Container(
                          width: 350,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, 100),),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Profile docs..",style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                                ),),
                                Icon(Icons.upload_file,color: Color.fromRGBO(143, 148, 251, 6) ,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      //pan card container
                      GestureDetector(
                        onTap: () async{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PanCardPage()),);
                        },
                        child: Container(
                         width: 350,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, 100),),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Propritor's PAN Card Photo",style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                                ),),
                                Icon(Icons.upload_file,color: Color.fromRGBO(143, 148, 251, 6) ,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      //adhar card container
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AdharCardORPanCardPage()),);
                        },
                        child: Container(
                          width: 350,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, 100),),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Propritor's Aadhar Card Photo",style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                                ),),
                                Icon(Icons.upload_file,color: Color.fromRGBO(143, 148, 251, 6) ,)
                              ],
                            ),
                          ),
                        ),
                      ),
                     //bank conatiner
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const BankDetailsPage()),);
                        },
                        child: Container(
                          width: 350,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, 100),),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Propritor's Bank Photo",style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                                ),),
                                 Icon(Icons.upload_file,
                                  color: Color.fromRGBO(143, 148, 251, 6) ,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //GSTIN Details
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),),
                elevation: 4,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 15, 10, 20),
                        child: Text('GSTIN Details',style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            new LengthLimitingTextInputFormatter(50)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'GST NO  is Required!!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme)
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                    color: AppColors.drakColorTheme!
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1,color: AppColors.drakColorTheme!)
                            ),

                            labelText: "Business GSTIN No",
                            labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14),
                          ),
                          controller: _MobileGSTController,
                        ),
                      ),
                      //Business address
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const GSTCerificated()),);
                        },
                        child: Container(
                          width: 350,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          decoration: BoxDecoration(border: Border.all(width: 1,
                            color:   Color.fromRGBO(143, 148, 251, 6)),
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("GSTIN Certificate",style: TextStyle(
                                          color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                                      ),),
                                      Icon(Icons.upload_file,color: Color.fromRGBO(143, 148, 251, 6) ,)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }
  void setValueresponse() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var profile_img=picimage.toString();
     if(profile_img!="null" && profile_img!="")
      {
         print("profile_url1"+profile_img);
         profile_img=Urls.ImageUrls+picimage.toString();
        var profile_base64 = await imageToBase64(profile_img);
         prefs.setString("profile_image",profile_base64).toString();
      }
     else
      {
        var base64= await assetsBase64(ImagesAssets.bankdoc.toString());
        prefs.setString("profile_image",base64.toString()).toString();
      }
      var pan_front_img=pan_front_image.toString();
    if(pan_front_img!="null" && pan_front_img!="")
      {
        pan_front_img=Urls.ImageUrls+pan_front_image.toString();
        var pan_front_base64 = await imageToBase64(pan_front_img);
        prefs.setString("pan_front_image",pan_front_base64).toString();
      }
    else {
      var base64= await assetsBase64(ImagesAssets.bankdoc.toString());
      prefs.setString("pan_front_image",base64.toString()).toString();
    }
    var pan_back_img=pan_back_image.toString();
    if(pan_back_img!="null" && pan_back_img!="")
      {
        pan_back_img=Urls.ImageUrls+pan_back_image.toString();
        var pan_back_base64=await imageToBase64(pan_back_img);
        prefs.setString("pan_back_image",pan_back_base64).toString();
      }
    else
      {
        var base64= await assetsBase64(ImagesAssets.bankdoc.toString());
        prefs.setString("pan_back_image",base64).toString();
      }

    print("pan_front_img"+pan_front_img);
    var aadhar_front_img= adhar_front_image.toString();
    if(aadhar_front_img!="null" && aadhar_front_img!="")
    {
      aadhar_front_img=Urls.ImageUrls+adhar_front_image.toString();
      var adhar_front_base64=await imageToBase64(aadhar_front_img);
      prefs.setString("adhar_front_image",adhar_front_base64).toString();
    }
    else
    {
      var adhar_front_base64= await assetsBase64(ImagesAssets.bankdoc.toString());
      prefs.setString("adhar_front_image",adhar_front_base64).toString();
    }
    print("aadhar_front_img"+aadhar_front_img);
    //-----------------------adhar back  image --------------
    var aadhar_back_img= adhar_back_image.toString();
    if(aadhar_back_img!="null" && aadhar_back_img!="")
    {
      aadhar_back_img=Urls.ImageUrls+adhar_back_image.toString();
      var adhar_back_base64=await imageToBase64(aadhar_back_img);
      prefs.setString("adhar_back_image",adhar_back_base64).toString();
    }
    else
    {
      var adhar_back_base64= await assetsBase64(ImagesAssets.bankdoc.toString());
      prefs.setString("adhar_back_image",adhar_back_base64).toString();
    }
    print("aadhar_back_img"+aadhar_back_img);
    var bank_img= bank_image.toString();

    if(bank_img!="null" && bank_img!="")
    {
      bank_img=Urls.ImageUrls+bank_image.toString();
      var bank_base64=await imageToBase64(bank_img);
      prefs.setString("bank_image",bank_base64).toString();
    }
    else
    {
      var bank_base64= await assetsBase64(ImagesAssets.bankdoc.toString());
      prefs.setString("bank_image",bank_base64).toString();
    }
    print("banking"+bank_img);
    var gstimag=gstimage.toString();
    if(gstimag!="null" && gstimag!="")
      {
        gstimag=Urls.ImageUrls+gstimage.toString();
        var gstimagefff_base64=await imageToBase64(gstimag);
         prefs.setString("gstimage",gstimagefff_base64).toString();
      }
     else
      {
        var base64= await assetsBase64("assets/images/gstimage.png");
        prefs.setString("gstimage",base64.toString()).toString();

      }
    print("gstimg"+gstimag);
  }
  void getBussinessInfomationApi() async {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
     setState(() {
      var _futureLogin = BooksApi.businessman(user_id, token, context);

      if (_futureLogin != null) {
        _futureLogin.then((value) {
          print("res"+value.toString());
          var res = value.response;
          if (res == "true") {
            var docs= value.info;
            if(docs!.profilePic!=null) {
              picimage = docs.profilePic!;
            }
            if(docs.adhaarPhotoFront!=null) {
              adhar_front_image = docs.adhaarPhotoFront!;
            }
            if(docs.adhaarPhotoBack!=null) {
              adhar_back_image = docs.adhaarPhotoBack!;
            }
            if(docs.panPhotoFront!=null) {
              pan_front_image = docs.panPhotoFront!;
            }
            if(docs.panPhotoBackend!=null) {
              pan_back_image = docs.panPhotoBackend!;
            }
            if(docs.bankPhoto!=null) {
              bank_image = docs.bankPhoto!;
            }
            if(docs.gstPhoto!=null) {
              gstimage = docs.gstPhoto!;
            }
            if(docs.gstNumber!=null) {
              var gstno = docs.gstNumber!;
            }
            if(docs.panNumber!=null) {
              _PanNocontroller.text=""+docs.panNumber.toString();
            }
            else
              {
                _PanNocontroller.text="";
              }
            if(docs.adhaarNumber!=null)
              {
                _AdharCardNoController.text=""+docs.adhaarNumber.toString();
              }
            else
              {
                _AdharCardNoController.text="";
              }
              if(docs.bankName!=null)
              {
                _BankAccountNOCOntroller.text=""+docs.bankName.toString();
              }
            else
              {
                _BankAccountNOCOntroller.text="";
              }
            if(docs.accoundNumber!=null)
              {
                _BankAccountNOCOntroller.text=""+docs.accoundNumber.toString();
              }
            else
              {
               _BankAccountNOCOntroller.text="";
              }

            if(docs.bankBranch!=null)
            {
              _BankBranchController.text=""+docs.bankBranch.toString();
            }
            else
            {
              _BankBranchController.text="";
            }
            if(docs.bankIfsc!=null)
            {
              _IFSCNoController.text=""+docs.bankIfsc.toString();
            }
            else
            {
              _IFSCNoController.text="";
            }
            if(docs.gstNumber!=null)
            {
              _MobileGSTController.text=""+docs.gstNumber.toString();
            }
            else
            {
              _MobileGSTController.text="";
            }
            if(docs.business_address!=null)
            {
              _BussinessAddcontroller.text=""+docs.business_address.toString();
            }
            else
            {
              _BussinessAddcontroller.text="";
            }
            if(docs.adhaarDob!=null)
            {
              try {
              setState(() {
                _selectedDate = DateTime.parse(docs.adhaarDob.toString());
              });

              } catch (e) {
                print('Error converting date string: $e');
              }
            }
            else
            {
              _MobileGSTController.text="";
            }
                setValueresponse();
               }
          else
            {

            }
            });
      }
    });
  }

  Future<String> assetsBase64(String imageUrl) async {
    final ByteData data = await rootBundle.load(imageUrl); // Replace with your asset path
    final Uint8List uint8List = data.buffer.asUint8List();
    final String base64 = base64Encode(uint8List);

    return base64;
  }

}
