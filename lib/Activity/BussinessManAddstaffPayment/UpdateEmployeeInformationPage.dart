import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/EmploymentInformationDeatilsPage.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/StaffPersonalInformationPage.dart';
class UpdateEmployeeInformation extends StatefulWidget {
  var staff_id;
   UpdateEmployeeInformation(this.staff_id);
  @override
  State<UpdateEmployeeInformation> createState() => _UpdateEmployeeInformationState(this.staff_id);
}

class _UpdateEmployeeInformationState extends State<UpdateEmployeeInformation> {
  var staff_id;
  _UpdateEmployeeInformationState(this.staff_id);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Staff Deatils"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------personal information container--------------------------------
            GestureDetector(
              onTap: () async{
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  StaffPersonalInformationPage(staff_id)),);
              },
              child: Card(
                elevation: 1,
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(3),side: BorderSide( color: Color.fromRGBO(143, 148, 251, .6), width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0),
                              child: Text("Personal Information",style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Text("DOB,Gender,Address",style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Add",style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      )
                    ],

                  ),
                ),
              ),
            ),
            //----------------------------Employment information-----------------------------------
            GestureDetector(
              onTap: () async{
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  EmploymentInformationPage(staff_id,'MOnthly')),);
              },
              child: Card(
                elevation: 1,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(3),side: BorderSide( color: Color.fromRGBO(143, 148, 251, .6), width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0),
                              child: Text("Employment Information",style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Text("Staff ID,Designation,Dept,UAN,PAN,ESI",style: TextStyle(
                                color: Colors.black38,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color:  Color.fromRGBO(143, 148, 251, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Add",style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      )
                    ],

                  ),
                ),
              ),
            ),
            //--------------------Document Card---------------------------------------
            Card(
              elevation: 1,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(3),side: BorderSide( color: Color.fromRGBO(143, 148, 251, .6), width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0),
                            child: Text("Documents",style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.upload,color:  Colors.white,size: 12,),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text("Add",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
