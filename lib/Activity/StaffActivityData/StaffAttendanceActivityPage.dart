import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udharproject/Controller/StaffAttendanceController.dart';
import 'package:udharproject/Utils/AppContent.dart';
class StaffAttendaceActivity extends StatefulWidget {
  @override
  _StaffAttendaceActivityState createState() => _StaffAttendaceActivityState();
}
class _StaffAttendaceActivityState extends State<StaffAttendaceActivity> {

  Future<void>? _initializeControllerFuture;
  final controller=Get.put(StaffAttendanceController());
  var base64_image;
  @override
  void initState() {
    super.initState();
    // Obtain a list of available cameras on the device.

  }


  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(""+AppContents.markattendance.tr),
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.camera)),
                IconButton(onPressed: (){}, icon: Icon(Icons.flash_on)),
              ])),

      body: Container(),
      // FutureBuilder<void>(
      //   future: _initializeControllerFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       // If the Future is complete, display the camera preview.
      //       return CameraPreview(_controller);
      //     }
      //     else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),

      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async{
              try {
                // Ensure that the camera is initialized before taking a picture.
                await _initializeControllerFuture;

                // Attempt to take a picture and get the XFile (image file).
               // final XFile file = await _controller.takePicture();
              //  _convertImageToBase64(file);

               // print('Photo Path: ${file.path}');
              } catch (e) {
                // If an error occurs, log it to the console.
                print('Error: $e');
              }


              print('Photo submitted!');
            },
            child: Text('Submit'),
          ),
        ),
      ),
    );
  }
  Future<void> _convertImageToBase64(XFile image) async {
    try {
      if (image == null) {
        print('No image selected.');
        return;
      }
      // Read the image file as bytes.
      final bytes = await image!.readAsBytes();
      // Convert the bytes to a base64 string.
      final base64Image = base64Encode(bytes);
        base64_image = base64Image;
      print("" + base64Image.toString());
      controller.staffAttendace(base64_image);
    } catch (e) {
      print('Error converting image to base64: $e');
    }
  }



}
