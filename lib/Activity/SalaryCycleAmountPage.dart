import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udharproject/FaceDetection/StaffRegistrationPage.dart';
import 'package:udharproject/Utils/AppContent.dart';


class SalaryCycleAmount extends StatefulWidget {
 var monthyly,staffname,staffpassw,staffmob,staffemail;
 SalaryCycleAmount(this.monthyly,this.staffname,this.staffpassw,this.staffemail,this.staffmob);
  @override
  State<SalaryCycleAmount> createState() => _SalaryCycleAmountState(this.monthyly,this.staffname,this.staffpassw,this.staffemail,this.staffmob);
}
class _SalaryCycleAmountState extends State<SalaryCycleAmount> {
  var monthyly,staffname,staffpassw,staffmob,staffemail;
  _SalaryCycleAmountState(this.monthyly,this.staffname,this.staffpassw,this.staffemail,this.staffmob);
  final TextEditingController _AmonutController = TextEditingController();
  final TextEditingController slaryCycleController= TextEditingController();
  final _formkey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _AmonutController.dispose();
    slaryCycleController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppContents.addstaff.tr),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

        bottomNavigationBar: GestureDetector(
          onTap: () async {
            var salary_amount=_AmonutController.text;
            var staff_cycle =_selectedDate.toString();
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('staffname', staffname);
            await prefs.setString('staffmob', staffmob);
            await prefs.setString('staffpassw', staffpassw);
            await prefs.setString('staffemail', staffemail);
            await prefs.setString('salary_amount', salary_amount);
            await prefs.setString('staff_cycle', staff_cycle);
            await prefs.setString('monthyly', monthyly);

            //
            // await availableCameras().then((value) => Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => RecognitionScreen(cameras: value))));
           final  camera=  await availableCameras();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StaffRegistrationPage(cameras: camera,),
              ),
            );


          },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.deepPurpleAccent,
                height: 50,
                width: 325,
                child: Center(
                  child: Text(AppContents.continues.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ),),
            )
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Container(
                margin: EdgeInsets.fromLTRB(20, 35, 10, 10),
                child: Text("Add staff's salary",style: TextStyle(
                    color: Colors.black87,
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async{
                          _selectDate(context);
                        },
                        child: Column(
                          children: [
                            Container(
                              margin:  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: BoxDecoration(border: Border.all(width: 1,
                                color:   Color.fromRGBO(143, 148, 251, .6),),
                                  borderRadius: BorderRadius.all(Radius.circular(1))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                                      child: Text('Salary Cycle',style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0
                                      ),),
                                    ),
                                    Row(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            _selectDate(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                // Text('${_selectedDate.toString()}',
                                                //   textAlign: TextAlign.center,
                                                //   style: TextStyle(fontSize: 20),
                                                //
                                                Text(' ${_selectedDate.toString()}',
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child:Padding(
                                            padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
                                            child: Text(AppContents.edit.tr,
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value)
                          {
                            if (value == null || value.isEmpty)
                            {
                              return 'Salary Amount is requires!!';
                            }
                            return null;
                          },
                          controller: _AmonutController,
                          autofocus: true,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_view_day),
                              contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                              labelText: 'Salary Amount',
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
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }

}
