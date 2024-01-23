import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/SalaryPaymentPage.dart';
import 'package:udharproject/Utils/AppContent.dart';

class AddStaffFormPage extends StatefulWidget {
  var mobile,username;
   AddStaffFormPage(this.mobile,this.username) ;
  @override
  State<AddStaffFormPage> createState() => _AddStaffFormPageState(this.mobile,this.username);
}
class _AddStaffFormPageState extends State<AddStaffFormPage> {
  var mobile,username;
  _AddStaffFormPageState(this.mobile,this.username);
  final _formkey = GlobalKey<FormState>();
  final   _Mobilecontroller = TextEditingController();
  final TextEditingController _Staffcontroller = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  List<Contact> contacts = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    checkprermissionData();
    _Mobilecontroller.text=""+mobile;
    if(username!=null && username=="null") {
      _Staffcontroller.text = "" + username;
    }
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    _Mobilecontroller.dispose();
    _Staffcontroller.dispose();
    _EmailController.dispose();
    _PasswordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Row(children: [])
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                //============staff name container===========
                Container(
                  padding: const EdgeInsets.fromLTRB(8.0,30.0,8.0,0.0),
                       child: TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      new LengthLimitingTextInputFormatter(30)
                    ],
                    controller: _Staffcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppContents.staffnameety.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppContents.staffname.tr,
                        hintStyle: TextStyle(color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                        ),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),)  ),
                       ),
                ),
                //staff mobile controller
                Container(
                  padding: EdgeInsets.all(8.0),

                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      new LengthLimitingTextInputFormatter(30)
                    ],
                    controller: _Mobilecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppContents.staffmobileety.tr;
                      }
                      // else if(value.length!=10)
                      // {
                      //   return 'Mobile Number must be 10 digit is required!!';
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppContents.staffmobile.tr,
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                  ),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),)  ),
                  ),
                ),
                SizedBox(height: 10,),
                // Email Id
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: <TextInputFormatter>[
                      new LengthLimitingTextInputFormatter(50)
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppContents.email_validation;
                      }
                      if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$").hasMatch(value)) {
                        return 'email_not_validate'.tr;
                      }
                      return null;
                    },
                    controller: _EmailController,
                    autofocus: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        labelText: AppContents.email.tr,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        )  ),
                  ),
                ),
                SizedBox(height: 10,),
                //password container
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      new LengthLimitingTextInputFormatter(15)
                    ],
                    controller: _PasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is  Requires!!';
                      }
                      else if (value.length < 6) {
                        return "Password should be atleast 6 characters";
                      } else if (value.length > 15) {
                        return "Password should not be greater than 15 characters";
                      }
                      return null;
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        labelText: AppContents.enterpassword.tr,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        )  ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,5,8.0,0.0),
                  child: Container(
                    child: Text(AppContents.staffwillregulare.tr,style: TextStyle(color: Color.fromRGBO(170, 152, 169,50),fontSize: 14,fontWeight: FontWeight.w800)),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,5,8.0,0.0),
                    child: Row(
                      children: [
                        Text(AppContents.byContaine.tr,style: TextStyle(color: Color.fromRGBO(170, 152, 169,50),fontSize: 14,fontWeight: FontWeight.w800)),
                        Text(AppContents.temsandcondition.tr,style: TextStyle(color: Color.fromRGBO(170, 152, 169,50),fontSize: 14,fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
                //btn
                GestureDetector(
                  onTap: () async{
                    _validation();
                    },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 80, 20, 20),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ])),
                    child: Center(
                      child: Text(AppContents.continues.tr, style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validation() async {
    ApiAddSaffResponse();
  }
void  ApiAddSaffResponse() async
  {
    if(_formkey.currentState!.validate())
    {
      var staffname="";
      if(username==null || username=="null" || username=="")
        {
         staffname= _Staffcontroller.text;
        }
      else
        {
          staffname = _Staffcontroller.text=""+username;
        }

      var staffno = _Mobilecontroller.text=""+mobile;

      var staffpass=_PasswordController.text;
    var staffemail=_EmailController.text;
     Navigator.push(context, MaterialPageRoute(builder: (context) =>  SalayPaymentPage(staffno,staffname,staffpass,staffemail)),);

    }
  }

  void checkprermissionData() async{
    // if (await Permission.contacts.isGranted) {
      fetchContacts();
    // } else {
    //   await Permission.contacts.request();
    // }
  }

  void fetchContacts() async {
    // contacts = await ContactsService.getContacts();
    // setState(() {
    //   isLoading = false;
    // });

  }
}
