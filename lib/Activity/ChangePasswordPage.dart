import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:udharproject/Utils/AppContent.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}
class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Change Password", style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Container(
                    child: Image.asset(
                        'assets/images/changepassword.jpg',
                        height: 200,
                        fit:BoxFit.fill
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      new LengthLimitingTextInputFormatter(50)
                    ],
                    obscureText: true,
                    autofocus: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        enabledBorder: OutlineInputBorder(

                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        ),
                        labelText: "Create New Password",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      new LengthLimitingTextInputFormatter(50)
                    ],
                    obscureText: true,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        labelText: 'Enter confirm Password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                        )  ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard()),);
                  },
                  child:   Padding(
                    padding: const EdgeInsets.all(8.0),
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

              ],
            ),
          )

        ),
      ),
    );
  }
}
