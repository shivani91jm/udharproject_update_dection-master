import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
  }
  final _formkey = GlobalKey<FormState>();
  XFile? image;
  var _base64Image="";
  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
    _convertImageToBase64();
  }

  Future<void> _convertImageToBase64() async {
    try {
      if (image == null) {
        print('No image selected.');
        return;
      }
      // Read the image file as bytes.
      final bytes = await image!.readAsBytes();
      // Convert the bytes to a base64 string.
      final base64Image = base64Encode(bytes);

      setState(() {
        _base64Image = base64Image;
        print(""+_base64Image.toString());

      });
    } catch (e) {
      print('Error converting image to base64: $e');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setvaluestore();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Profile  Information ", style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.deepPurpleAccent,
          height: 50,
          width: 325,
          child: ElevatedButton(
            onPressed: ()async
            {
              if(_formkey.currentState!.validate())
              {
                if(image==null)
                {
                  Fluttertoast.showToast(
                      msg: "Please Select Your Picture",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
                else
                {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("profile_image",_base64Image.toString());
                  Navigator.of(context).pop();
                }
              }
            },
            child: Text(
              "Submit",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),

          ),),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text("Upload Your Profile",style: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 18,fontWeight: FontWeight.w800)),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async{
                      myAlert();
                    },
                     child: (_base64Image != "null" && _base64Image!="" )? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                       child: Image.memory(
                        base64Decode(_base64Image.toString()),
                          fit: BoxFit.cover,
                                 width: MediaQuery.of(context).size.width,
                                 height: 300,
                    ),
                      )
                        : Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),),
                          elevation: 10,
                          child: Container(
                            height: 200,
                            width: 400,
                            child: Image.asset(ImagesAssets.bankdoc,
                                fit:BoxFit.fitHeight
                            ),
                          ),)
                    ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void setvaluestore() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     _base64Image=  prefs.getString("profile_image")??"";
   });
  }
}
