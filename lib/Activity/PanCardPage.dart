import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Widget/CameraAndGalleryPickBottomSheet.dart';

class PanCardPage extends StatefulWidget {
  const PanCardPage({Key? key}) : super(key: key);
  @override
  State<PanCardPage> createState() => _PanCardPageState();
}

class _PanCardPageState extends State<PanCardPage> {
  final _formkey = GlobalKey<FormState>();
  File? image;
  File? image1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setvaluestore();
  }
  Future pickImage(ImageSource source) async{
    try{
      final image= await ImagePicker().pickImage(source: source);
      if(image==null)
        return;
      final imageTemporory=File(image.path);
      setState(() {
        this.image=imageTemporory;

      });
      _convertImageToBase64();

    }
    on PlatformException catch (e)
    {
      print("failed to pick image $e");
    }
  }
  Future pickImage2(ImageSource source) async{
    try{
      final image1= await ImagePicker().pickImage(source: source);
      if(image1==null)
        return;
      final imageTemporory=File(image1.path);
      setState(() {
        this.image1=imageTemporory;
      });
      _convertImageToBase64Back();
    }
    on PlatformException catch (e)
    {
      print("failed to pick image $e");
    }
  }
  String _base64Image="";
  String _base64BackImage="";

  Future<void> _convertImageToBase64() async {
    try {
      if (image == null) {
        print('No image selected.');
        return;
      }

      // Read the image file as bytes.
      final bytes = await image!.readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        _base64Image = base64Image;
        print(""+_base64Image.toString());

        // uploadImage();
      });
    } catch (e) {
      print('Error converting image to base64: $e');
    }
  }
  Future<void> _convertImageToBase64Back() async {
    try {
      if (image1 == null) {
        print('No image selected.');
        return;
      }
      final bytes = await image1!.readAsBytes();

      // Convert the bytes to a base64 string.
      final base64Image = base64Encode(bytes);

      setState(() {
        _base64BackImage = base64Image;
        print(""+_base64BackImage.toString());

        // uploadImage();
      });
    } catch (e) {
      print('Error converting image to base64: $e');
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
  }

  void setvaluestore() async{
  final  SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _base64Image=  prefs.getString("pan_front_image")??"";
      _base64BackImage =  prefs.getString("pan_back_image")??"";
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppContents.continues.tr, style: TextStyle(
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
                      msg: "Please Select PAN Card Front Image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
                else if(image1==null)
                {
                  Fluttertoast.showToast(
                      msg: "Please Select PAN Card Back Image",
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
                  prefs.setString("pan_front_image",_base64Image.toString());
                  prefs.setString("pan_back_image",_base64BackImage.toString());
                  Navigator.of(context).pop();
                }
              }
            },
            child: Text(AppContents.continues.tr,
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
                  Text("Upload Id font image",style: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 18,fontWeight: FontWeight.w800)),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async{
                      final source = await show(context);
                      pickImage(source!);
                    },
                    child: (_base64Image != "null" && _base64Image!="")? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        base64Decode(_base64Image),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                    ) :Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 400,
                        child: Image.asset(ImagesAssets.bankdoc,
                            fit:BoxFit.fitHeight
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Upload Id back image",style: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 18,fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async{
                      final source = await show(context);
                      pickImage2(source!);
                    },
                    child: (_base64BackImage != "null" &&_base64BackImage!="")? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        base64Decode(_base64BackImage),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                    ) :Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 400,
                        child: Image.asset('assets/images/uploadbankdocs.png',
                            fit:BoxFit.fitHeight
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
