import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udharproject/Activity/CalculateSalaryPage.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
class BusinessDetails extends StatefulWidget {
  var data;
  BusinessDetails(this.data);
  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  var bussiness_account_status;
  _BusinessDetailsState();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _BussinessNamecontroller = TextEditingController();
  final TextEditingController _NoofStaffController = TextEditingController();
  var email="";
  var mobile="";
  var username="";
  int state=0;
  @override
  void dispose() {
    super.dispose();
    _BussinessNamecontroller.dispose();
    _NoofStaffController.dispose();
  }
  @override
  void initState()
  {
    super.initState();
    bussiness_account_status=widget.data['status'];
     setvalue();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      return Scaffold(
        appBar: AppBar(leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
          GestureDetector(
            onTap: (){
              if(bussiness_account_status=="false") {
              Navigator.pushNamed(context, RoutesNamess.businessmandashboard);
              }
            },
            child: bussiness_account_status=="false"?Container(
              margin: EdgeInsets.fromLTRB(10, 15, 15, 10),
              child: Text(AppContents.Skip.tr,style:  TextStyle(color: AppColors.white,fontSize: 18,fontWeight: FontWeight.w800),),
            ):Container(),
          )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,30,8.0,0.0),
                        child: Text(AppContents.BusinessDeatils.tr,style: TextStyle(color: AppColors.textColorsBlack,fontSize: AppSize.large,fontWeight: FontWeight.w800)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,5,8.0,0.0),
                      child: Text(AppContents.businessdata.tr,style:
                      TextStyle(color: AppColors.lightTextColorsBlack,fontSize: AppSize.small,fontWeight: FontWeight.w800)),
                    ),
                    //name container
                    SizedBox(height: 30,),

                    //busniess container
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          new LengthLimitingTextInputFormatter(50)
                        ],
                        controller: _BussinessNamecontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppContents.businessnameEmpty.tr;
                          }
                          return null;
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            labelText: AppContents.businessName.tr,
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                            )  ),
                      ),
                    ),
                    //no of staff
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppContents.noofstaffemp.tr;
                          }
                          return null;
                        },
                        controller: _NoofStaffController,

                        autofocus: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            labelText: AppContents.noofstaff.tr,
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
                      padding: const EdgeInsets.fromLTRB(8.0,50,8,0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppContents.byContaine.tr,style: TextStyle(color: AppColors.lightTextColorsBlack,fontSize: AppSize.small,fontWeight: FontWeight.w800)),
                          Text(AppContents.temsandcondition.tr,style:  TextStyle(color: AppColors.drakColorTheme,fontSize: AppSize.small,fontWeight: FontWeight.w800))
                        ],
                      ),
                    ),
                    //submit btn...
                    GestureDetector(
                      onTap: (){
                        _validationData();
                      },
                      child:   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
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
                    ),
                  ],
                ),
              ),
            ),
          )
        ),

      );
  }
//-------------------------------------------------validation form ----------------------------------------------------------------------------------------
  void _validationData() async{
    //validation
    if(_formkey.currentState!.validate())
    {
      var busnessControll=_BussinessNamecontroller.text;
        var noofsatffController=_NoofStaffController.text;
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  CalculateMonthlySaleryPage(busnessControll,noofsatffController,bussiness_account_status,"1")),);
    }
  }

  void setvalue() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    email =  sharedPreferences.getString("email").toString();

  }
}
