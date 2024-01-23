import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
class FineActivitypage extends StatefulWidget {
  var staffname,present_date,attendance_marks,list_type,activity_attandance_type,staff_id;

  FineActivitypage(this.staffname,this.present_date,this.attendance_marks,this.list_type,this.activity_attandance_type,this.staff_id);
  @override
  State<FineActivitypage> createState() => _FineActivitypageState(this.staffname,this.present_date,this.attendance_marks,this.list_type,this.activity_attandance_type,this.staff_id);
}

class _FineActivitypageState extends State<FineActivitypage> {
  var staffname,present_date,attendance_marks,list_type,activity_attandance_type,staff_id;

  _FineActivitypageState(this.staffname,this.present_date,this.attendance_marks,this.list_type,this.activity_attandance_type ,this.staff_id);
  final   _Datecontroller = TextEditingController();
  DateTime _selectedTime = DateTime.now();
  DateTime _selectExcessBreakTime = DateTime.now();
  DateTime _selectEarlyTime = DateTime.now();
  final   _AmountController = TextEditingController();
  String? selectedValue = "Fixed";
  final _FormKey = GlobalKey<FormState>();
  final   _ExccessController = TextEditingController();
  final   _ExccessAmountController = TextEditingController();
  final   _Amount2Controller = TextEditingController();
  String? excessBreakValue = "Fixed";
  String? earlyValue = "Fixed";
  bool btn_color_visiblity=false;
  int _state=0;
  Position? _currentPosition;
  String? _currentAddress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Datecontroller.text=""+_selectedTime.toString();
    _getCurrentPosition();
    _AmountController.addListener(() {
    final btn_color_visiblity=  _AmountController.text.isNotEmpty;
    setState(() {
      this.btn_color_visiblity=btn_color_visiblity;
    });
    });
    print("activity_attandance_type"+activity_attandance_type.toString());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _Datecontroller.dispose();
    _AmountController.dispose();
    _Amount2Controller.dispose();
    _ExccessController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppContents.Fine.tr,style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal
            ),),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,0.0,8,0),
                  child: Text(""+staffname,style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),),
                ),
                Divider(
                  height: 5,
                  color: Colors.black38,
                ),
                Text(""+present_date,style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),),

              ],
            )
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      body: SingleChildScrollView(
        child: Form(
          key: _FormKey,
          child: Card(
            elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //set border radius more than 50% of height and width to make circle
              ),
           
            child: attendance_marks=="present"? presntWidget(): _buildAbsentWidget(),
          ),
        ),
      ),

    );
  }

  void _showFinHorsDialog() async{
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20,20,15,20),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppContents.shifthours.tr,style: TextStyle(
                              color: AppColors.textColorsBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                          ),),
                          Text(AppContents.noshifthours.tr,style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0
                          ),),

                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppContents.hrs.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),),
                            TimePickerSpinner(
                              is24HourMode: false,
                              normalTextStyle: TextStyle(fontSize: 16, color: Colors.grey),
                              highlightedTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
                              spacing: 10,
                              itemHeight: 40,
                              onTimeChange: (time) {
                                setState(() {
                                  _selectedTime = time;
                                });
                              },
                            ),
                            Text(AppContents.mins.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),

                    //--------------------apply fine button ------------------------------------------
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: btn_color_visiblity?[
                              AppColors.lightColorTheme,
                              AppColors.drakColorTheme
                            ]: [Color.fromRGBO(143, 148, 251, .2), Color.fromRGBO(143, 148, 251, .2)] )),
                        child: new MaterialButton(
                          highlightElevation: 50,
                          child: setUpButtonChild(),
                          onPressed: btn_color_visiblity ? () {
                            setState(() {
                              if (_state == 0) {
                                btn_color_visiblity=true;
                              }
                            });
                          }: null,
                          elevation: 4.0,
                          minWidth: double.infinity,
                          height: 48.0,

                        ),
                      ),
                    ),
                  ]));

        });
  }
  void _showExcessBreakDialog() async{
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(AppContents.shifthours.tr,style: TextStyle(
                              color: AppColors.textColorsBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                          ),),
                          Text(AppContents.noshifthours.tr,style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0
                          ),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppContents.hrs.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),),
                            TimePickerSpinner(
                              is24HourMode: false,
                              normalTextStyle: TextStyle(fontSize: 16, color: Colors.grey),
                              highlightedTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
                              spacing: 10,
                              itemHeight: 40,
                              onTimeChange: (time) {
                                setState(() {
                                  _selectExcessBreakTime = time;
                                });
                              },
                            ),
                            Text(AppContents.mins.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                AppColors.lightColorTheme,
                                AppColors.drakColorTheme
                              ])),
                          child: Center(child: Text(AppContents.continues.tr, style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                          ),
                          ),
                        )),
                  ]));

        });
  }
  void _showEarlyTimeDialog() async{
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(AppContents.shifthours.tr,style: TextStyle(
                              color: AppColors.textColorsBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                          ),),
                          Text(AppContents.noshifthours.tr,style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0
                          ),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppContents.hrs.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),),
                            TimePickerSpinner(
                              is24HourMode: false,
                              normalTextStyle: TextStyle(fontSize: 16, color: Colors.grey),
                              highlightedTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
                              spacing: 10,
                              itemHeight: 40,
                              onTimeChange: (time) {
                                setState(() {
                                  _selectEarlyTime = time;
                                });
                              },
                            ),
                            Text(AppContents.mins.tr,style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                AppColors.lightColorTheme,
                                AppColors.drakColorTheme
                              ])),
                          child: Center(child: Text(AppContents.continues.tr, style: TextStyle(color: AppColors.white, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                          ),
                          ),
                        )),
                  ]));

        });
  }
  //-----------------Late fine dropdwonitem---------------------
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Fixed"),value: "Fixed"),
      DropdownMenuItem(child: Text("Half Day"),value: "Half Day"),
      DropdownMenuItem(child: Text("Full Day"),value: "Full Day"),
      DropdownMenuItem(child: Text("Pardon"),value: "Pardon"),
    ];
    return menuItems;
  }

  //--------------------- excess breaks dropdwon ---------------------------
  // List<DropdownMenuItem<String>> get dropdownItems{
  //   List<DropdownMenuItem<String>> menuItems = [
  //     DropdownMenuItem(child: Text("Fixed"),value: "Fixed"),
  //     DropdownMenuItem(child: Text("Half Day"),value: "Half Day"),
  //     DropdownMenuItem(child: Text("Full Day"),value: "Full Day"),
  //     DropdownMenuItem(child: Text("Pardon"),value: "Pardon"),
  //   ];
  //   return menuItems;
  // }

  //-------------------------early out dropdwon------------------

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(AppContents.ApplyFine.tr,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold
        ),
      );
    } else if (_state == 1) {
      return Center(
        child: Container(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    } else {
      return Icon(Icons.check, color: AppColors.white);
    }
  }
  Widget presntWidget()
  {
    return Column(
      children: [
        SizedBox(height: 30),
        //-----------late Fine Conatiner----------------------------
        GestureDetector(
          onTap: (){
            _showFinHorsDialog();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black38,
                boxShadow: [
                  BoxShadow(color:  Color.fromRGBO(143, 148, 251, .1), spreadRadius: 1)
                ]

              //     gradient: LinearGradient(colors: [
              //   Color.fromRGBO(143, 148, 251, 1),
              //   Color.fromRGBO(143, 148, 251, .6),
              // ])
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,8.0,15.0,0),
                    child: Text(AppContents.latefine.tr,style: TextStyle(
                        fontSize: AppSize.seventin,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.normal

                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,1.0,15.0,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_selectedTime.hour} : ${_selectedTime.minute}',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            fontStyle: FontStyle.normal
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(AppContents.hrs.tr,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.normal
                            ),),
                            Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //---------------------------- fine amount conatinr and type --------------------
        Row(
          children: [
            // ------------fine amount ---------------------------------------
            Container(
              width: 200,
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],

                controller: _AmountController,
                autofocus: true,
                decoration: InputDecoration(

                    contentPadding: EdgeInsets.fromLTRB(25.0, 22.0, 25.0, 22.0),
                    labelText: AppContents.fineAmount.tr,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    )  ),
              ),
            ),
           Expanded(child:  Container(
             width: 150,
             padding: EdgeInsets.all(8.0),
             child: DropdownButtonFormField(
                 decoration: InputDecoration(
                   border: OutlineInputBorder(
                     borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, 6), width: 1),
                     borderRadius: BorderRadius.circular(5),
                   ),
                   filled: true,
                   fillColor: Colors.white10,
                 ),
                 validator: (value) => value == null ? "Select a country" : selectedValue,
                 dropdownColor: Colors.white,
                 value: selectedValue,
                 onChanged: (String? newValue) {
                   setState(() {
                     selectedValue = newValue!;
                   });
                 },
                 items: dropdownItems),
           ),)

          ],
        ),
        //-------------- Excess Breaks container---------------------
        GestureDetector(
          onTap: (){
            _showExcessBreakDialog();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
             //   color: Colors.black38,
                // boxShadow: [
                //   BoxShadow(color:  Color.fromRGBO(143, 148, 251, .1), spreadRadius: 1)
                // ]
                gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ])
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,8.0,15.0,0),
                    child: Text(AppContents.excessBreak.tr,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.normal

                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,1.0,15.0,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_selectedTime.hour} : ${_selectedTime.minute}',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontStyle: FontStyle.normal
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(AppContents.hrs.tr,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.normal
                            ),),
                            Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // fine amount 2 opectional value excess brraks container amount --------------------
        Row(
          children: [
            // ------------fine amount ---------------------------------------
            Container(
              width: 200,
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],

                controller: _ExccessAmountController,
                autofocus: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(25.0, 22.0, 25.0, 22.0),
                    labelText: AppContents.fineAmount.tr,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    )  ),
              ),
            ),

           Expanded(child:  Container(

             padding: EdgeInsets.all(8.0),
             child: DropdownButtonFormField(
                 decoration: InputDecoration(
                   border: OutlineInputBorder(
                     borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, 6), width: 1),
                     borderRadius: BorderRadius.circular(5),
                   ),
                   filled: true,
                   fillColor: Colors.white10,
                 ),
                 validator: (value) => value == null ? "Select a country" : null,
                 dropdownColor: Colors.white,
                 value: excessBreakValue,
                 onChanged: (String? newValue) {
                   setState(() {
                     excessBreakValue = newValue!;
                   });
                 },
                 items: dropdownItems),
           ),)

          ],
        ),
        SizedBox(
          height: 10,
        ),
        //--------------- Early Out Container -----------------------
        GestureDetector(
          onTap: (){
           _showEarlyTimeDialog();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black38,
                boxShadow: [
                  BoxShadow(color:  Color.fromRGBO(143, 148, 251, .1), spreadRadius: 1)
                ]

              //     gradient: LinearGradient(colors: [
              //   Color.fromRGBO(143, 148, 251, 1),
              //   Color.fromRGBO(143, 148, 251, .6),
              // ])
            ),


            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,8.0,15.0,0),
                    child: Text(AppContents.earlyOut.tr,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.normal

                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,1.0,15.0,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_selectedTime.hour} : ${_selectedTime.minute}',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontStyle: FontStyle.normal
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(AppContents.hrs.tr,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.normal
                            ),),
                            Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            // ----------------------fine amount ---------------------------------------
            Container(
              width: 200,
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],

                controller: _Amount2Controller,
                autofocus: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(25.0, 22.0, 25.0, 22.0),
                    labelText: AppContents.fineAmount.tr,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                    )  ),
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(143, 148, 251, 6), width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white10,
                    ),
                    validator: (value) => value == null ? "Select a country" : null,
                    dropdownColor: Colors.white,
                    value: earlyValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        earlyValue = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
            ),

          ],
        ),
        // ---------------------------submit button container----------------------------
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: (){
            if(btn_color_visiblity)
            {
              setState(() {
                btn_color_visiblity=true;
              });
            }
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: btn_color_visiblity?[
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]: [Color.fromRGBO(143, 148, 251, .2), Color.fromRGBO(143, 148, 251, .2)] )),
            child: new MaterialButton(
              highlightElevation: 50,
              child: setUpButtonChild(),
              onPressed: btn_color_visiblity ? () {
                setState(() {
                  if (_state == 0) {
                    btn_color_visiblity=true;
                    _addFineApiMethod();
                  }
                });
              }: null,
              elevation: 4.0,
              minWidth: double.infinity,
              height: 48.0,

            ),
          ),
        ),
      ],
    );
  }
  Widget _buildAbsentWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0,20,12,20),
          child: Center(
            child: Text(AppContents.firstattendance.tr,style: TextStyle(
                color: Colors.black38,fontSize: 17,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal
            ),),
          ),
        ),
      ),
    );
  }
  void _addFineApiMethod() async{
    setState(() {
      _state=1;
    });
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token = prefsdf.getString("token").toString();
    print("token" + token);
    var datetime = DateTime.now();
    print(datetime);
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var late_fine_time=_selectedTime.toString();
    var late_fine_amount=_AmountController.text;
    var  late_fine_type=selectedValue.toString();
    var exess_breaks_time=_selectExcessBreakTime.toString();
    var exess_breaks_fine_amount=_ExccessAmountController.text.toString();
    var exess_breaks_type=excessBreakValue.toString();
    var early_out_time=_selectEarlyTime.toString();
    var early_fine_amount=_Amount2Controller.text.toString();
    var early_type=earlyValue.toString();
    String formattedDate = DateFormat('HH:mm:ss').format(DateTime.now());
    var _futureLogin = BooksApi.AddAttendanceapi(context,token,user_id,bussiness_id,"present",formattedDate,"",_currentAddress.toString(),"","fine","business_man",late_fine_time,late_fine_amount,late_fine_type,exess_breaks_time,exess_breaks_fine_amount,exess_breaks_type,early_out_time,early_fine_amount,early_type,"","","","",list_type,activity_attandance_type,DateFormat('yyyy-MM-dd').format(datetime),staff_id
    ,"","approved");
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if (value.info != null) {
            var  info = value.info;
            if (info != null) {
              setState(() {
                _state=0;
              });
              Fluttertoast.showToast(
                  msg: "Add Fine Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.textColorsBlack,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.pushNamed(context, RoutesNamess.businessmandashboard);

            }
          }
        }
        else {
          String data = value.msg.toString();
          setState(() {
            _state=0;
          });
          Fluttertoast.showToast(
              msg: ""+data,
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
    else {
      setState(() {
        _state=0;
      });
      _futureLogin.then((value) {
        String data = value.msg.toString();
        Fluttertoast.showToast(
            msg: ""+data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );

      });
    }
  }
  //------------------------------------get Current Location=========================================
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      print("err"+e.toString());

    });
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(""+AppContents.LOCATIONENABLEDISBALE.tr)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        print(""+ place.toString());
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        print('LAT: ${_currentPosition?.latitude ?? ""}');
        print('LNG: ${_currentPosition?.longitude ?? ""}');
        print('ADDRESS: ${_currentAddress ?? ""}');
      });
    }).catchError((e) {
      print("excaption"+e.toString());

    });
  }
}