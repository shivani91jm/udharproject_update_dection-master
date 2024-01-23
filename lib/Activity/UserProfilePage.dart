import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udharproject/Widget/CameraAndGalleryPickBottomSheet.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}
class _UserProfilePageState extends State<UserProfilePage> {
  File? image;
  Future pickImage(ImageSource source) async{
    try{
      final image= await ImagePicker().pickImage(source: source);
      if(image==null)
        return;
      final imageTemporory=File(image.path);
      setState(() {
        this.image=imageTemporory;
      });

    }
    on PlatformException catch (e)
    {
      print("failed to pick image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              SizedBox(
                height: 150,
                width: 150,
                child: GestureDetector(
                  onTap: () async{},
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      // image!=null? ClipOval(child: Image.file(image!,width: 160,height: 160,fit: BoxFit.cover,)): CircleAvatar(backgroundImage: AssetImage("assets/images/uploadbankdocs.png",)),
                      // Positioned(
                      //     bottom: 0,
                      //     right: -25,
                      //     child: RawMaterialButton(
                      //       onPressed: () async{
                      //      final source = await show(context);
                      //          pickImage(source!);
                      //       },
                      //       elevation: 2.0,
                      //       fillColor: Color(0xFFF5F6F9),
                      //       child: Icon(Icons.camera_alt_outlined, color: Color.fromRGBO(143, 148, 251, 1),),
                      //       padding: EdgeInsets.all(15.0),
                      //       shape: CircleBorder(),
                      //     )),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
