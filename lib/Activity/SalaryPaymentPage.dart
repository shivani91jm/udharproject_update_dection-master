import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/SalaryCycleAmountPage.dart';
import 'package:udharproject/Utils/AppContent.dart';

class SalayPaymentPage extends StatefulWidget {
  var staffnumber,staffname,staffpassword,staffemail;
  SalayPaymentPage(this.staffnumber,this.staffname,this.staffpassword,this.staffemail);
  @override
  State<SalayPaymentPage> createState() => _SalayPaymentPageState(this.staffnumber,this.staffname,this.staffpassword,this.staffemail);
}
class _SalayPaymentPageState extends State<SalayPaymentPage> {
  var staffnumber,staffname,staffpassword,staffemail;
  _SalayPaymentPageState(this.staffnumber,this.staffname,this.staffpassword,this.staffemail);
  Object? _character;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppContents.addstaff.tr),
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
              //titile
              Container(
                margin: EdgeInsets.fromLTRB(15, 30, 10, 20),
                child: Text(AppContents.selectslarypayment.tr,style: TextStyle(
                    color: Colors.black87,
                    fontSize: 19,
                  fontWeight: FontWeight.bold
                ),),
              ),
              //Monthly conatiner
              Container(
                margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
                padding: EdgeInsets.all(8.0),
                child:  RadioListTile(
                  title:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppContents.Monthly.tr,style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),),
                      Text(AppContents.fixedsalrypayment.tr,style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                      ),),
                    ],
                  ),
                  value: "Monthly",
                  groupValue: _character,
                  onChanged: (value) {
                    setState(() {
                      _character = value;
                    });
                  },
                )
              ),
              // Hourly Conatiner
              Container(
                margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color.fromRGBO(143, 148, 251, .6),),
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
                padding: EdgeInsets.all(8.0),
                child: RadioListTile(
                  title:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppContents.perhourbasic.tr,style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),),
                      Text(AppContents.punchInandpayment.tr,style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                      ),),
                    ],
                  ),
                  value: "Hourly",
                  groupValue: _character,
                  onChanged: (value){
                    setState(() {
                      _character=value;
                    });
                  },
                )),
              //daily cobtainer
              Container(
                margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, .6),),
                    borderRadius: BorderRadius.all(Radius.circular(1))),
                padding: EdgeInsets.all(8.0),
                child:  RadioListTile(
                  title:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppContents.Daily.tr,style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),),
                      Text(AppContents.dailyPayment.tr,style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                      ),),
                    ],
                  ),
                  value: "Daily",
                  groupValue: _character,
                  onChanged: (value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
// --------------------------------work basis conatiner--------------------------------
              Container(
                  margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, 100),),
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: RadioListTile(
                    title:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppContents.workbasis.tr,style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),),
                        Text(AppContents.workbasisPayment.tr,style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0
                        ),),
                      ],
                    ),
                    value: "Work Basis",
                    groupValue: _character,
                      onChanged: (value){
                      setState(() {
                      _character=value;
                      });}
                  )),
              //Weekly
              Container(
                  margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color:   Color.fromRGBO(143, 148, 251, 100),),
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: RadioListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppContents.Weekly.tr,style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),),
                        Text(AppContents.weeklyPayment.tr,style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0
                        ),),
                      ],
                    ),
                    value: "Weekly",
                    groupValue: _character,
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  )),
              GestureDetector(
                onTap: (){
                 _validattionPage();
                },
                child: Padding(
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
                        child: Text(AppContents.continues.tr, style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
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
    );
  }

  void _validattionPage() {
    if(_formkey.currentState!.validate()) {
      var data=_character.toString();
      Navigator.push(context, MaterialPageRoute(builder: (context) => SalaryCycleAmount(data,staffname,staffpassword,staffemail,staffnumber)));
    }
  }
}
