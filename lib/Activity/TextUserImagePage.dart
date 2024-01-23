import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class UploadImageServer extends StatefulWidget {
  const UploadImageServer({Key? key}) : super(key: key);

  @override
  State<UploadImageServer> createState() => _UploadImageServerState();
}

class _UploadImageServerState extends State<UploadImageServer> {
  XFile? image;
  String? _base64Image;
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
        uploadImage();
       // uploadImage();
      });
    } catch (e) {
      print('Error converting image to base64: $e');
    }
  }
  Future<void> uploadImage() async {
    var token="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWRlYWUwOTdlN2NlNTRhOTdiNDNlMDg0NTdkNWZhZmE2N2RhYTVkZTgxYmNkYjg1NDMyZDdjY2YxYmVkNzU4MzAzOTFkNGY4NjRhNDQwN2QiLCJpYXQiOjE2ODEyNzc3MDcuMDQ3NTcxODk3NTA2NzEzODY3MTg3NSwibmJmIjoxNjgxMjc3NzA3LjA0NzU3NDk5Njk0ODI0MjE4NzUsImV4cCI6MTY5NzA4ODkwNy4wMzIwNTYwOTMyMTU5NDIzODI4MTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.ue1ydck6t9wAgmQGHEy-DxOVVZTZ5i16pi3L_Ddw8iQ31-jT4e8gHJl9bkUeIkU2y7Ndos4ZhPiDwrFOoMAf2WwHc3R_1_DoOne1kEvMeiW8hOcSSear_gsCqCRp0_GwGLsdMhh5prOIQ5X5EYrzuJxY1a_VUViNRJZoETvQmKOJM9h1BBnq5QAm-A_MDZyMznnlF4kbvQ5ovR1qPX2dKIesL2MYQ-BP_nuYRmncSGY29MUIOJKbKv8cuzhOEh5ypv2dMis9G3TxVJrLH0uDftpyYUNnzgrljpx13jgYWVCiStjMhD7RbtaPS7RzDaVyedZ7v9tyqYzxs5M9gThS4Wq3DIwTQfECeBYNKljyQOEqjn2fTP2zOoyjMX532YfF8bNtMfLMz6L7MvDncou3xUNx9Bgt7hPzngH2PyX1tVyqn1LC4JgwC_07e8v0_v2P6KHg7Hq62TeQKUDaM4Zsbew1_n8sIBCh8vUgArTe9unvYXp37TFriJLecToBIoeUKHKnEQR3UGDAdTRO-Ian6psAlPDQPsm8NBrVX78WPUDZJcyC8K3vHvmUoYbkmQjA-ajov25yVcKXRJ8eH8JEMRiMoRfY7gN_6FUf5zCSlLZWisacB8c8630ImMAM7gAcQISF6RG6OaaKJ7Nm6vhAExUbWp4qckqiwDKI4ewvWYA";
    final response = await http.post(Uri.parse("https://crm.shivagroupind.com/api/upload-docs"),
        headers: <String, String>
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          "profile_pic": _base64Image!,
          "bank_docs": "dsfds",
          "accound_number" :"fdsaf",
          "bank_ifsc": "dfsdf",
          "bank_branch": "dsfds",
          "bank_photo": "dfsasd",
          "adhaar_docs": "dfd",
          "adhaar_number": "fdfs",
          "adhaar_dob": "dfdsf",
          "adhaar_photo_front": "dfsd",
          "adhaar_photo_back" : "dsfds",
          "pan_docs": "dfa",
          "pan_number": "dfsasd",
          "pan_photo_front": "sdfadsf",
          "user_id": "1"
        }),);

        var jsondata = json.decode(response.body);
      print(""+response.body.toString());//decode json data
        if(jsondata["info"]){ //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        }else{
          print(""+response.body.toString());
          print("Upload successful");
        }
      }
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image to Server"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                myAlert();
              },
              child: Text('Upload Photo'),
            ),
            SizedBox(
              height: 10,
            ),
            //if image not null show the image
            //if image null show text
            image != null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  //to show image, you type like this.
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
              ),
            )
                : Text("No Image", style: TextStyle(fontSize: 20),)
          ],
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



}
