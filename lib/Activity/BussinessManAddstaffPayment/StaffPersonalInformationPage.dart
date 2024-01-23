import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/StaffWiseControllerMonthly.dart';
import 'package:udharproject/Utils/AppContent.dart';


class StaffPersonalInformationPage extends StatefulWidget {
  var staff_id;
   StaffPersonalInformationPage(this.staff_id);

  @override
  State<StaffPersonalInformationPage> createState() => _StaffPersonalInformationPageState(this.staff_id);
}

class _StaffPersonalInformationPageState extends State<StaffPersonalInformationPage> {
  var staff_id;
  _StaffPersonalInformationPageState(this.staff_id);
  StaffAttendanceMothlyWiseController controller=Get.put(StaffAttendanceMothlyWiseController());
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDateMethod();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppContents.personalinfo.tr,style: TextStyle(
            color: AppColors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              //-------------------------------staff name contaroller----------------------------
              Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(10, 0, 10,0),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    new LengthLimitingTextInputFormatter(50)
                  ],
                  controller: controller.et_bussiness,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Staff name is Requires!!';
                    }
                    return null;
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      labelText: 'Staff Name',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                      )  ),
                ),
              ),
              //-----------------------staff mobile number -----------------------------------
              Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(10, 0, 10,0),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    new LengthLimitingTextInputFormatter(50)
                  ],
                  controller: controller.et_mobile,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Staff name is Requires!!';
                    }
                    return null;
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      labelText: 'Staff Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                      )  ),
                ),
              ),
              //----------------------------- date of birth conatiner-------------------------------
              GestureDetector(
                onTap: (){
                  controller.selectDateMthod(context);
                },
                child: Container(
                  width: 360,
                  margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                  decoration: BoxDecoration(border: Border.all(width: 1,
                    color:   Color.fromRGBO(143, 148, 251, .6),),
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  padding: EdgeInsets.all(8.0),
                  child:  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Obx(() =>   Text(controller.selectedDatess.value == null ? 'Date of Birth' : '${DateFormat('dd/MM/yyyy').format(controller.selectedDatess.value!)},',style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                      ),),),
                        Icon(Icons.calendar_month,color:  Color.fromRGBO(143, 148, 251, 6),)
                      ],
                    ),
                  ),

                ),
              ),
                //--------------------gender conatiner------------------------------------
               Obx(() =>   Container(
                decoration: BoxDecoration(border: Border.all(width: 1,
                  color:   Color.fromRGBO(143, 148, 251, .6),),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                width: 360,
                margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
                child:  Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,0,10,0),
                  child: DropdownButton<String>(
                    value: controller.selected.value,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? value) {
                      controller.selected.value = value!;
                      },
                    items: controller.items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                )
            ),),
              // ----------------staff address container-------------------------
              Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(10, 0, 10,0),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    new LengthLimitingTextInputFormatter(50)
                  ],
                  controller: controller.et_addressOne,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is Requires!!';
                    }
                    return null;
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      labelText: 'Address Line 1',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                      )  ),
                ),
              ),
              // -------------------------address 2 optional---------------------------------------
              Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(10, 0, 10,10),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    new LengthLimitingTextInputFormatter(50)
                  ],
                  controller: controller.et_addressOptional,

                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      labelText: 'Address Line 2 (Optional)',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                      )  ),
                ),
              ),
              //---------------------------submit btn...--------------------------------------
              Obx(() {
                return GestureDetector(
                  onTap: (){
                    controller.UpdateStaffDeatils(context,staff_id);
                  },
                  child:  Padding(
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
                          child: controller.isLoading.value?Center(child: Container(height:20,width:20,child: CircularProgressIndicator(color: Colors.white,))):Text("Continue",
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }


  void currentDateMethod() {
    controller.selectDateMthod(context);
  }




}
