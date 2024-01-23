import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({Key? key}) : super(key: key);
  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  final List<String> _docs = ["Savings", "Current", "Salary"];
  String? _selecteddocs;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
  }
  final _formkey = GlobalKey<FormState>();
  File? image;
  String _base64Image="";
  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = File(img!.path);
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
    setvalues();
  }
  setvalues() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

     setState(() {
       _base64Image=  prefs.getString("bank_image")??"";
     });

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Bank Information", style: TextStyle(
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
                      msg: "Please Select  Passbook Photo",
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
                  prefs.setString("bank_image",_base64Image.toString());
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
              Text("Bank Passbook Photo Upload",style: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 18,fontWeight: FontWeight.w800)),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: (){
                  myAlert();
                },
                child: (_base64Image != "null" && _base64Image!="")? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    base64Decode(_base64Image),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ) :
                Card(
                 shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),),
                  elevation: 10,
                  child: Container(
                  height: 200,
                    width: 300,
                    child: Image.asset('assets/images/uploadbankdocs.png',
                        fit:BoxFit.fitHeight
                    ),
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              //     width: 400,
              //     height: 45,
              //     decoration: BoxDecoration(
              //
              //       color: Color.fromRGBO(143, 148, 251, .2),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: DropdownButton<String>(
              //       value: _selecteddocs,
              //       onChanged: (value) {
              //         setState(() {
              //           _selecteddocs = value;
              //         });
              //       },
              //       hint: const Center(
              //           child: Text(
              //             'Please Select  Any Account Type',
              //             style: TextStyle(color: Color.fromRGBO(143, 148, 251, 6)),
              //           )),
              //       // Hide the default underline
              //       underline: Container(),
              //       // set the color of the dropdown menu
              //       dropdownColor: Colors.white,
              //       icon: const Icon(
              //         Icons.arrow_drop_down,
              //         color:Colors.black,
              //       ),
              //       isExpanded: true,
              //
              //       // The list of options
              //       items: _docs
              //           .map((e) => DropdownMenuItem(
              //         value: e,
              //         child: Container(
              //           alignment: Alignment.centerLeft,
              //           child: Text(
              //             e,
              //             style: const TextStyle(fontSize: 14),
              //           ),
              //         ),
              //       ))
              //           .toList(),
              //
              //       // Customize the selected item
              //       selectedItemBuilder: (BuildContext context) => _docs
              //           .map((e) => Center(
              //         child: Text(
              //           e,
              //           style: const TextStyle(
              //               fontSize: 14,
              //               color:  Color.fromRGBO(143, 148, 251, 6),
              //               fontStyle: FontStyle.italic,
              //               fontWeight: FontWeight.bold),
              //         ),
              //       ))
              //           .toList(),
              //     ),
              //   ),
              // ),

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
              height: MediaQuery.of(context).size.height / 6,
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
}
