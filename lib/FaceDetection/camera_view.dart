import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {Key? key, required this.onImage, required this.onInputImage})
      : super(key: key);

  final Function(Uint8List image) onImage;
  final Function(InputImage inputImage) onInputImage;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color:  Color(0xffD9D9D9),
              size: 50,
            ),
          ],
        ),
        SizedBox(height: 20),
        _image != null
            ? CircleAvatar(
                radius:150,
                backgroundColor: const Color(0xffD9D9D9),
                backgroundImage: FileImage(_image!),
              )
            : CircleAvatar(
                radius: 150,
                backgroundColor: const Color(0xffD9D9D9),
                child: Icon(
                  Icons.camera_alt,
                  size:70,
                  color: const Color(0xff2E2E2E),
                ),
              ),
        GestureDetector(
          onTap: _getImage,
          child: Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(top: 44, bottom: 20),
            decoration: const BoxDecoration(
              color:  Color(0xffD9D9D9),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Text(
          "Click here to Capture",
          style: TextStyle(
            fontSize: 16,
            color:  Color(0xffD9D9D9).withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Future _getImage() async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
      // imageQuality: 50,
    );
    if (pickedFile != null) {
      _setPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      print("path not founfd......");


    }
    setState(() {
      _image = File(path.toString());
    });

    Uint8List imageBytes = _image!.readAsBytesSync();
    widget.onImage(imageBytes);

    InputImage inputImage = InputImage.fromFilePath(path.toString());
    widget.onInputImage(inputImage);
  }
}
