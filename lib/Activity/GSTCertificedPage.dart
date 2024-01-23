import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/KYCBussinessPage.dart';
import 'package:udharproject/Widget/CameraAndGalleryPickBottomSheet.dart';
import 'package:http/http.dart' as http;

class GSTCerificated extends StatefulWidget {
  const GSTCerificated({Key? key}) : super(key: key);

  @override
  State<GSTCerificated> createState() => _GSTCerificatedState();
}

class _GSTCerificatedState extends State<GSTCerificated> {
  final _formkey = GlobalKey<FormState>();
  File? image;
  String? _base64Image="";
  var _base64DecodeImage;
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
  Future<void> _convertImageToBase64() async {
    try {
      if (image == null) {
        print('No image selected.');
        return;
      }
      final bytes = await image!.readAsBytes();

      // Convert the bytes to a base64 string.
      final base64Image = base64Encode(bytes);

      setState(() {
        _base64Image = base64Image;
        print(""+_base64Image.toString());
        _base64DecodeImage=base64Decode(_base64Image.toString());

        // uploadImage();
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
var imageurl="https://www.pakainfo.com/wp-content/uploads/2021/09/image-url-for-testing.jpg";
  Future<String> imageToBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final base64String = base64Encode(bytes);
    return base64String;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("GSTIN Certificate", style: TextStyle(
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
                          msg: "Please Select Image",
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
                       prefs.setString("gstimage",_base64Image.toString());
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text("GSTIN Certificate",style: TextStyle(color: Color.fromRGBO(143, 148, 251, 6),fontSize: 18,fontWeight: FontWeight.w800)),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async{
                      final source = await show(context);
                      pickImage(source!);
                    },
                    child:( _base64Image != "null"&& _base64Image!="") ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(base64Decode(_base64Image.toString()),
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
                        child: Image.asset(
                            'assets/images/gstimage.png',
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
  void setvaluestore() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {

      _base64Image=  prefs.getString("gstimage")??"";
      _base64DecodeImage=base64Decode(_base64Image.toString());
      print("images"+_base64Image.toString());
     });
  }
}
