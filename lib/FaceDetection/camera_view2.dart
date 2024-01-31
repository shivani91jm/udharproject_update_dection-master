import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraView extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraView({Key? key, required this.onImage, required this.onInputImage,required this.cameras}) : super(key: key);
  final Function(Uint8List image) onImage;
  final Function(InputImage inputImage) onInputImage;
  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? _image;
  late ImagePicker _imagePicker;
  late CameraController _cameraController;
  CameraLensDirection camDirec = CameraLensDirection.front;
  var isDetecting=false;
  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    initstaion();
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
        _image != null?
        //     ? CircleAvatar(
        //         radius:150,
        //         backgroundColor: const Color(0xffD9D9D9),
        //          backgroundImage: (_image == null) ? AssetImage('assets/images/background.png') : FileImage(_image!) as ImageProvider,
        //       )
        //     :

        Container(
          height: 350,
          width: 350,
          child: (_cameraController.value.isInitialized)
              ? AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: ClipOval(
              child: CameraPreview(_cameraController),
            ),
          )
              : Container(),
        ): CircleAvatar(
                radius:150,
                backgroundColor: const Color(0xffD9D9D9),
                 backgroundImage:  AssetImage('assets/images/background.png'),
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

  Future<void> _getImage() async {
    setState(() {
      _image = null;
    });
    try{
      // final pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.camera,maxWidth: 400,
      //   maxHeight: 400,);
      if (!_cameraController.value.isInitialized) {
        return null;
      }
      if (_cameraController.value.isTakingPicture) {
        return null;
      }

      await _cameraController.setFlashMode(FlashMode.off);
      XFile pickedFile = await _cameraController.takePicture();
      // final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 400,
      //   maxHeight: 400,);

      final path = pickedFile?.path;
      //  XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });

        Uint8List imageBytes = _image!.readAsBytesSync();
        widget.onImage(imageBytes);

        InputImage inputImage = InputImage.fromFilePath(
            path.toString());
        widget.onInputImage(inputImage);


      }
    } on CameraException catch(e){
      print("gvfhghfd");
    }





    // if (pickedFile != null) {
    //   _setPickedFile(pickedFile);
    // }
    // setState(() {});
  }

  Future _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      print("path not founfd......");
    }
  }
  void initstaion() async {

    _cameraController = CameraController(
        widget.cameras![1], ResolutionPreset.high);
     _cameraController.initialize();
    // await _cameraController.initialize().then((_) {
    //   if (!mounted) return;
    //
    //   _cameraController.startImageStream((image) async {
    //     if (!isDetecting) {
    //       isDetecting = true;
    //       var cameraImage = image;
    //
    //       img.Image convertedImage = await _convertCameraImage(image);
    //
    //       // Save the converted image to a file
    //       final String path = await _saveImageToFile(convertedImage);
    //       print("fhdhf" + path);
    //
    //
    //       setState(() {
    //         _image = File(path);
    //       });
    //
    //       Uint8List imageBytes = _image!.readAsBytesSync();
    //       widget.onImage(imageBytes);
    //
    //       InputImage inputImage = InputImage.fromFilePath(
    //           path.toString());
    //       widget.onInputImage(inputImage);
    //       isDetecting=false;
    //
    //     }
    //   });


   // });
  }
  Future<String> _saveImageToFile(img.Image image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final String filePath = '${appDir.path}/captured_image.jpg';

    File(filePath).writeAsBytesSync(img.encodeJpg(image));

    return filePath;
  }

  img.Image _convertCameraImage(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;

    final yRowStride = cameraImage.planes[0].bytesPerRow;
    final uvRowStride = cameraImage.planes[1].bytesPerRow;
    final uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image = img.Image(width:width, height:height);

    for (var w = 0; w < width; w++) {
      for (var h = 0; h < height; h++) {
        final uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
        final index = h * width + w;
        final yIndex = h * yRowStride + w;

        final y = cameraImage.planes[0].bytes[yIndex];
        final u = cameraImage.planes[1].bytes[uvIndex];
        final v = cameraImage.planes[2].bytes[uvIndex];

        image.data!.setPixelR(w, h, yuv2rgb(y, u, v));//= yuv2rgb(y, u, v);
      }
    }
    return image;
  }
  int yuv2rgb(int y, int u, int v) {
    // Convert yuv pixel to rgb
    var r = (y + v * 1436 / 1024 - 179).round();
    var g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
    var b = (y + u * 1814 / 1024 - 227).round();

    // Clipping RGB values to be inside boundaries [ 0 , 255 ]
    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return 0xff000000 |
    ((b << 16) & 0xff0000) |
    ((g << 8) & 0xff00) |
    (r & 0xff);
  }
}



