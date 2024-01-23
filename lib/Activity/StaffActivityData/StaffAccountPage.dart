import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';

class StaffAccountPage extends StatefulWidget {
  const StaffAccountPage({Key? key}) : super(key: key);
  @override
  State<StaffAccountPage> createState() => _StaffAccountPageState();
}

class _StaffAccountPageState extends State<StaffAccountPage> {
  List<String> languageitemList = ['English', 'Hindi'];
  var language="";
  late SharedPreferences loginData;
  var businessMob="",bussinessName="",bussinessEmail="",name="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(AppContents.settings.tr),
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
              alignment: Alignment.topCenter,
              child: Column(
                  children: <Widget>
                  [
                    //-----------------------------------------------------Account Settings Conatiner-----------------------------------
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                        child: Column(
                          children: [
                            //title busniness name
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
                                            child: Text(AppContents.accountSetting.tr,style: TextStyle(
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
                            //Chnage Launge
                            GestureDetector(
                              onTap: () async{
                                showdialogLaguage(context);
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
                                              Text(AppContents.Language.tr,style: TextStyle(
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
                                              ),),
                                              Text(language,style: TextStyle(
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
                                          showdialogLaguage(context);
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
                            //Security Password
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
                                            Text("Security Password",style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0
                                            ),),
                                            Text("Password not activated",style: TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0
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
                                       // Navigator.push(context, MaterialPageRoute(builder: (context) => const AdharCardORPanCardPage()),);
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
                            //Business Addd
                            GestureDetector(
                              onTap: (){
                               // Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageBusinessList()),);
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
                                              Text("Businesses",style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0
                                              ),),
                                              Text("Active Businesses",style: TextStyle(
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
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
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageBusinessList()),);
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
                            //KYB
                            GestureDetector(
                              onTap: (){
                                     Navigator.pushNamed(context, RoutesNamess.staffBankAccountDetails);
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
                                              Text("KYB",style: TextStyle(

                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
                                              ),),
                                              Text("Complete KYB to avail online.....",style: TextStyle(
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
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const KCYBusniessPage()),);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //---------------------leave-------------
                            Divider(
                                height: 2,
                                color: Colors.black26
                            ),
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

                                            Text(AppContents.attendanceonholiday.tr,style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0
                                            ),),

                                          ],
                                        ),
                                      ),),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        iconSize: 18,
                                        splashColor: AppColors.drakColorTheme ,
                                        icon: Icon(Icons.arrow_forward_ios_rounded,color:  Colors.black38,),
                                        onPressed: (){
                                          Navigator.pushNamed(context, RoutesNamess.staffAddLeave,arguments: {
                                            "page":"2"
                                          });

                                        },
                                      ),
                                    ),
                                  ]),),


                          ],
                        ),
                      ),
                    ),
                    //--------------------------------Your Bank Details----------------------------------------------------
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
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
                            //Chnage Launge
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
                                            Text("Account Number",style: TextStyle(
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
                                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => const AdharCardORPanCardPage()),);
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
                            //Security Password
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
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const AdharCardORPanCardPage()),);
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
                    //------------------------------------------------------------ Personal Info-------------------------------------
                    Card(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1),
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
                                          Image.asset('assets/images/briefcase.png',
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
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0
                                            ),),
                                            Text(""+name,style: TextStyle(
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
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0
                                            ),),
                                            Text(""+businessMob,style: TextStyle(
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
                                            Text(AppContents.email.tr,style: TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0
                                            ),),
                                            Text(""+bussinessEmail,style: TextStyle(
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
                          ],
                        ),
                      ),
                    ),

      //--------------------------------logout staff-----------------------------------------------------------------
                    Card(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () async{
                          _showLogoutDilaog(context);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(1.0,0.0,0.0,0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(AppContents.logout.tr,style: TextStyle(
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
                                      iconSize: 22,
                                      splashColor: Colors.deepPurpleAccent ,
                                      icon: Icon(Icons.logout_sharp,color:  Colors.red,),
                                      onPressed: (){
                                        _showLogoutDilaog(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    //----------------------------------------our promise:--------------------------------------------
                    Padding(
                      padding:  EdgeInsets.fromLTRB(8.0,0,8.0,8.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                        Text(AppContents.ourPromise.tr,
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
                                              Text(AppContents.safefree.tr,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              Text(AppContents.shivagroupree.tr,
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
                                        Image.asset(ImagesAssets.cloud,
                                            width: 25,
                                            height: 25,
                                            fit:BoxFit.fill
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(AppContents.databackup.tr,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              Text(AppContents.alldatalinkphonenumber.tr,
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
                      ),
                    )
                  ])
          )
      ),
    );
  }
  void _showLogoutDilaog(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Logout',style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),),
          content: const Text('Are you went to sure to logout this app ?'),
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
                _logoutUser();
              } ,
              child: const Text('OK',style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }

  void _logoutUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
    await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeValueGet();
    getValue();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  //----------------------------show language dialog------------------------------------------

  void showdialogLaguage(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context)  {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(30),
                  child: Text(AppContents.Language.tr,
                    style: TextStyle(
                        fontSize: 19,
                        color: AppColors.textColorsBlack,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppColors.lightTextColorsBlack,
                ),
                Expanded(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: languageitemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () async{
                          language=languageitemList[index];
                          SharedPreferences prefrence=await SharedPreferences.getInstance();

                          print("laguage"+language);
                          if(language!=""&& language!="null")
                          {
                            if(language=="English")
                            {
                              print("laguage id "+language);

                              Get.updateLocale(Locale('en','us'));
                              prefrence.setString("laguageValue", "English");
                              Navigator.of(context).pop();

                            }
                            else if(language=="Hindi")
                            {
                              print("laguage else ifs"+language);
                              Get.updateLocale(Locale('hi','In'));
                              prefrence.setString("laguageValue", "Hindi");
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        title: Text(languageitemList[index], style: TextStyle(
                            fontSize: 16,
                            color: AppColors.dartTextColorsBlack,
                            fontWeight: FontWeight.bold
                        ),

                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) { return Divider(
                    height: 1,
                    color: AppColors.lightTextColorsBlack,
                  ); },),
                ),


              ],
            ),
          );
        });
  }

  void storeValueGet() async{
    loginData=await SharedPreferences.getInstance();
    setState(() {
      loginData.getString("token")??"";
      bussinessEmail= loginData.getString("email")??"";
      name=loginData.getString("name")??"";
      businessMob=loginData.getString("mobile")??"";
      bussinessName=loginData.getString("bussiness_name")??"";
    });
  }
  void getValue()  async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    language= sharedPreferences.getString("laguageValue")??"";
  }

}
