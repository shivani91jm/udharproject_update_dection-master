import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/StaffBankAccountDetailsPage.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/UpdateEmployeeInformationPage.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/DeleteStaffController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';


class StaffProfileDeatilsPage extends StatefulWidget {
  var staff_name,staff_id,staff_mobile,staff_email,id;
   StaffProfileDeatilsPage(this.staff_name,this.staff_id,this.staff_email,this.staff_mobile,this.id);
  @override
  State<StaffProfileDeatilsPage> createState() => _StaffProfileDeatilsPageState(this.staff_name,this.staff_id,this.staff_email,this.staff_mobile,this.id);
}
class _StaffProfileDeatilsPageState extends State<StaffProfileDeatilsPage> {
  var staff_name,staff_id,staff_mobile,staff_email,id;
  _StaffProfileDeatilsPageState(this.staff_name,this.staff_id,this.staff_email,this.staff_mobile,this.id);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
  }
  DeleteStaffController controller=Get.put(DeleteStaffController());
  @override
  Widget build(BuildContext context)  {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppContents.ProfileDetails.tr),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                      children: <Widget>[
                        //-----------------------------------------------------Account Settings Conatiner-----------------------------------
                        SizedBox(
                          height: 30,
                        ),
                        //------------------------------------------------------------ Personal Info-------------------------------------
                        Card (
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: AppColors.white, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                            child: Column(
                              children: [
                                //tile busniness name
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Row(
                                            children: [
                                              Image.asset(ImagesAssets.acount1,
                                                  width: 25,
                                                  height: 25,
                                                  fit:BoxFit.fill
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(13.0,8.0,8.0,8.0),
                                                child: Text(AppContents.personalinfo.tr,style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0
                                                ),),
                                              ),
                                              Divider(
                                                color: Colors.black,
                                                height: 1,

                                              )
                                            ],
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                                Divider(
                                    height: 2,
                                    color: Colors.black26
                                ),
                                //User Name
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppContents.name.tr,style: TextStyle(
                                                    color: AppColors.lightTextColorsBlack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppSize.small
                                                ),),
                                                Text(""+staff_name,style: TextStyle(
                                                    color: AppColors.textColorsBlack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppSize.fitlarge
                                                ),),

                                              ],
                                            ),
                                          )
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          iconSize: 18,
                                          splashColor: Colors.deepPurpleAccent ,
                                          icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                          onPressed: (){

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                    height: 2,
                                    color: Colors.black26
                                ),
                                //Phone Number
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppContents.phonenumber.tr,style: TextStyle(
                                                    color: AppColors.lightTextColorsBlack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppSize.small
                                                ),),
                                                Text(""+staff_mobile,style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0
                                                ),),

                                              ],
                                            ),
                                          )
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          iconSize: 18,
                                          splashColor: Colors.deepPurpleAccent ,
                                          icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                          onPressed: (){

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                    height: 2,
                                    color: Colors.black26
                                ),
                                //Email Id
                                GestureDetector(
                                  onTap: () async{
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateEmployeeInformation(staff_id)),);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Staff Details",style: TextStyle(
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14.0
                                                  ),),
                                                  Text("Add Details",style: TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0
                                                  ),),
                                                ],
                                              ),
                                            )
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            iconSize: 18,
                                            splashColor: Colors.deepPurpleAccent ,
                                            icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateEmployeeInformation(staff_id)),);
                                            },
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
                        //--------------------------------Your Bank Details----------------------------------------------------
                        Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                            child: Column(
                              children: [
                                //----------------------------------tile of bank details----------------------------------------
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Row(
                                            children: [
                                              Image.asset('assets/images/briefcase.png',
                                                  width: 25,
                                                  height: 25,
                                                  fit:BoxFit.fill
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(13.0,8.0,8.0,8.0),
                                                child: Text("Your Bank Details",style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0
                                                ),),
                                              ),
                                              Divider(
                                                color: Colors.black,
                                                height: 1,
                                              )
                                            ],
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                                Divider(
                                    height: 2,
                                    color: Colors.black26
                                ),
                                //------------------------bank information---------------------------------
                                GestureDetector(
                                  onTap: (){
                                    paymentbankpage();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("UPI ID",style: TextStyle(
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14.0
                                                  ),),
                                                  Text("Not Added",style: TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0
                                                  ),),

                                                ],
                                              ),
                                            )
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            iconSize: 18,
                                            splashColor: Colors.deepPurpleAccent ,
                                            icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                            onPressed: (){
                                            //payment ppage method
                                              paymentbankpage();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                    height: 2,
                                    color: Colors.black26
                                ),
                                //----------------------bank information------------------------------------------
                                GestureDetector(
                                  onTap: (){
                                    paymentbankpage();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Bank Account",style: TextStyle(
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14.0
                                                  ),),
                                                  Text("Not Added",style: TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0
                                                  ),),

                                                ],
                                              ),
                                            )
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            iconSize: 18,
                                            splashColor: Colors.deepPurpleAccent ,
                                            icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                            onPressed: (){
                                              paymentbankpage();
                                            },
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
//--------------------------------Delete staff-----------------------------------------------------------------
                        Card(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                            child: Column(
                              children: [
                                //-----------share attendance and hisaab----------------------
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Share Attendance & Hisaab",style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0
                                              ),),

                                            ],
                                          ),
                                        )
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        iconSize: 18,
                                        splashColor: Colors.deepPurpleAccent ,
                                        icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                        onPressed: () async{
                                            Navigator.pushNamed(context, RoutesNamess.staffWeeklyHolidayPage,arguments: {
                                              "staff_id":staff_id
                                            });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                               Divider(
                                 height: 1,
                                 color: Colors.grey,
                               ),
                               //----------delete staff ---------------
                                GestureDetector(
                                  onTap: () async{
                                    _showDeleteStaffDilaog(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Delete Staff",style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0
                                                ),),
                                              ],
                                            ),
                                          )
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          iconSize: 18,
                                          splashColor: Colors.deepPurpleAccent ,
                                          icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                          onPressed: (){
                                            _showDeleteStaffDilaog(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //----------------------------------------our promise:--------------------------------------------
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(12.0,20,20,20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Our Promise:",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold
                                            ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset('assets/images/shield.png',
                                              width: 25,
                                              height: 25,
                                              fit:BoxFit.fill
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("100% Safe & Free",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                Text("Shiva is safe and totally free ",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [

                                          Image.asset('assets/images/cloud.png',
                                              width: 25,
                                              height: 25,
                                              fit:BoxFit.fill
                                          ),

                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("100% auto Date Backup",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                Text("All data is linked to your phone number",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),



                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ])
              ))
      ),
    );
  }
  void _showDeleteStaffDilaog(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete Staff',style: TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold
          ),),
          content: const Text('Are you went to sure to  delete staff ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel',style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async{
                controller.deleteStaff(context,id);
              } ,
              child: const Text('OK',style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }



  void paymentbankpage() {
    Navigator.pushNamed(context, RoutesNamess.staffBankAccountDetails);

  }
}
