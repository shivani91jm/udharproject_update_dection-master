import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';

import 'package:udharproject/ML/Recognition.dart';
import 'package:udharproject/ML/Recognizer.dart';
class RecognitionScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const RecognitionScreen({Key? key,required this.cameras}) : super(key: key);

  @override
  State<RecognitionScreen> createState() => _HomePageState();
}

class _HomePageState extends State<RecognitionScreen> {

  late CameraController _cameraController;
  //TODO declare variables
  late ImagePicker imagePicker;
  File? _image;
  var imagess;
  List<Recognition> recognitions = [];
  List<Face> faces = [];
  //TODO declare detector
  dynamic faceDetector;
  bool _isRearCameraSelected = true;
  //TODO declare face recognizer
  late Recognizer _recognizer;
  bool isDetecting = false;
  CameraImage? cameraImage;
  dynamic _scanResults;
  late Size size;
  CameraLensDirection camDirec = CameraLensDirection.front;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imagePicker = ImagePicker();

    //TODO initialize detector
    final options = FaceDetectorOptions(
        enableClassification: false,
        enableContours: false,
        enableLandmarks: false);

    //TODO initalize face detector
    faceDetector = FaceDetector(options: options);

    //TODO initalize face recognizer
    _recognizer = Recognizer();
    initCamera(widget.cameras![1]);
  }
  Future initCamera(CameraDescription cameraDescription) async {
// create a CameraController
    _cameraController = CameraController(
        cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        _cameraController.startImageStream((image) async {
          if(!isDetecting)
            {
              isDetecting=true;
              cameraImage=image;
              print("object"+cameraImage!.format.toString());

              final WriteBuffer allBytes = WriteBuffer();
              for (final Plane plane in cameraImage!.planes) {
                allBytes.putUint8List(plane.bytes);
              }
              final bytes = allBytes
                  .done()
                  .buffer
                  .asUint8List();
              final Size imageSize = Size(
                  cameraImage!.width.toDouble(), cameraImage!.height.toDouble());
              final camera = widget.cameras![1];
              final imageRotation = InputImageRotationValue.fromRawValue(
                  camera.sensorOrientation);
              // if (imageRotation == null) return;

              final inputImageFormat = InputImageFormatValue.fromRawValue(
                  cameraImage!.format.raw);
              // if (inputImageFormat == null) return null;

              final planeData = cameraImage!.planes.map(
                    (Plane plane) {
                  return InputImagePlaneMetadata(
                    bytesPerRow: plane.bytesPerRow,
                    height: plane.height,
                    width: plane.width,
                  );
                },
              ).toList();

              final inputImageData = InputImageData(
                size: imageSize,
                imageRotation: imageRotation!,
                inputImageFormat: inputImageFormat!,
                planeData: planeData,
              );

              final inputImage = InputImage.fromBytes(
                  bytes: bytes, inputImageData: inputImageData);

              List<Face> cropImage = await faceDetector.processImage(inputImage);
              for(Face face in cropImage)
              {
                print("count=${(face.boundingBox.toString())}");
              }
           //   performFaceRecognition(cropImage,context);

              setState(() {
                _scanResults = cropImage;
                isDetecting = false;
              });

            }
        });
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }
  Widget buildResult() {
    if (_scanResults == null ||
        _cameraController == null ||
        !_cameraController.value.isInitialized) {
      return Container(
          color: Colors.black,
          child: const Center(child: CircularProgressIndicator()));
    }
    final Size imageSize = Size(
      _cameraController.value.previewSize!.height,
      _cameraController.value.previewSize!.width,
    );
    CustomPainter painter = FaceDetectorPainter(imageSize, _scanResults, camDirec);
    return CustomPaint(
      painter: painter,
    );
  }
  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      print("gvg"+picture.toString());
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  //TODO capture image using camera
  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doFaceDetection();
    }
  }
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    super.dispose();
  }
  //TODO choose image using gallery
  _imgFromGallery() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doFaceDetection();
    }
  }


  //TODO face detection code here
  TextEditingController textEditingController = TextEditingController();
  doFaceDetection() async {
    faces.clear();

    //TODO remove rotation of camera images
    _image = await removeRotation(_image!);

    //TODO passing input to face detector and getting detected faces
    final inputImage = InputImage.fromFile(_image!);
    faces = await faceDetector.processImage(inputImage);

    //TODO call the method to perform face recognition on detected faces

  }

  //TODO remove rotation of camera images
  removeRotation(File inputImage) async {
    final img.Image? capturedImage = img.decodeImage(await File(inputImage!.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  //TODO perform Face Recognition
  // performFaceRecognition() async {
  //
  //   image = await _image?.readAsBytes();
  //
  //   image = await decodeImageFromList(image);
  //   print("${image.width}   ${image.height}");
  //
  //   recognitions.clear();
  //   for (Face face in faces) {
  //     Rect faceRect = face.boundingBox;
  //     num left = faceRect.left<0?0:faceRect.left;
  //     num top = faceRect.top<0?0:faceRect.top;
  //     num right = faceRect.right>image.width?image.width-1:faceRect.right;
  //     num bottom = faceRect.bottom>image.height?image.height-1:faceRect.bottom;
  //     num width = right - left;
  //     num height = bottom - top;
  //
  //     //TODO crop face
  //     File cropedFace = await FlutterNativeImage.cropImage(_image!.path,
  //         left.toInt(),top.toInt(),width.toInt(),height.toInt());
  //     final bytes = await File(cropedFace!.path).readAsBytes();
  //     final img.Image? faceImg = img.decodeImage(bytes);
  //     Recognition recognition = _recognizer.recognize(faceImg!, face.boundingBox);
  //     if(recognition.distance>1) {
  //       recognition.name = "Unknown";
  //     }
  //     recognitions.add(recognition);
  //   }
  //   drawRectangleAroundFaces();
  // }

  //TODO draw rectangles
  drawRectangleAroundFaces() async {
    setState(() {
      image;
      faces;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    size = MediaQuery
        .of(context)
        .size;
    if (_cameraController != null) {
      //TODO View for displaying the live camera footage
      stackChildren.add(
        Positioned(
          top: 0.0,
          left: 0.0,
          width: size.width,
          height: size.height,
          child: Container(
            child: (_cameraController.value.isInitialized)
                ? AspectRatio(
              aspectRatio: _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController),
            )
                : Container(),
          ),
        ),
      );

      // //TODO View for displaying rectangles around detected aces
      stackChildren.add(
        Positioned(
            top: 0.0,
            left: 0.0,
            width: size.width,
            height: size.height,
            child: buildResult()),
      );
    }
    stackChildren.add(Positioned(
      top: size.height - 140,
      left: 0,
      width: size.width,
      height: 80,
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blue,
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.cached,
                        color: Colors.white,
                      ),
                      iconSize: 40,
                      color: Colors.black,
                      onPressed: () {

                      },
                    ),
                    Container(
                      width: 30,
                    ),

                    Expanded(
                        child: IconButton(
                          onPressed: (){
                            register = true;
                          },
                          iconSize: 50,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.circle, color: Colors.white),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 0),
              color: Colors.black,
              child: Stack(
                children: stackChildren,
              )),

    ]
      ));



  }
  img.Image? image;
  bool register = false;
  // performFaceRecognition(List<Face> faces,BuildContext context) async {
  //   recognitions.clear();
  //
  //   //TODO convert CameraImage to Image and rotate it so that our frame will be in a portrait
  //  // image = convertYUV420ToImage(cameraImage!);
  // //  image =img.copyRotate(image!, camDirec == CameraLensDirection.front?270:90);
  //
  //   for (Face face in faces) {
  //     Rect faceRect = face.boundingBox;
  //     //TODO crop face
  //  //   img.Image cropimage = img.copyCrop(image!, faceRect.left.toInt(),faceRect.top.toInt(),faceRect.width.toInt(),faceRect.height.toInt());
  //
  //     //TODO pass cropped face to face recognition model
  //     Recognition recognition = _recognizer.recognize(cropimage, faceRect);
  //
  //     if(recognition.distance>1.25){
  //       recognition.id="Unknown";
  //       recognition.name = "Unknown";
  //     }
  //     recognitions.add(recognition);
  //
  //     setState(() {
  //       isDetecting  = false;
  //       _scanResults = cropimage;
  //     });
  //     //TODO show face registration dialogue
  //     if(register){
  //       print("if gdhjd workinh");
  //
  //       showFaceRegistrationDialogue(cropimage,recognition,context);
  //       register = false;
  //     }
  //     else
  //       {
  //         print("else workinh");
  //       }
  //
  //   }
  //
  //
  //
  // }

  showFaceRegistrationDialogue(img.Image croppedFace, Recognition recognition, BuildContext context){
    showDialog(
      context: context!,
      builder: (ctx) => AlertDialog(
        title: const Text("Staff Registration",textAlign: TextAlign.center),alignment: Alignment.center,
        content: SizedBox(
          height: 340,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Image.memory(Uint8List.fromList(img.encodeBmp(croppedFace!)),width: 200,height: 200,),
              SizedBox(
                width: 200,
                child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration( fillColor: Colors.white, filled: true,hintText: "Enter Name")
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () async{

                    List<int> imageBytes = img.encodePng(croppedFace);
                 //   String base64String = base64Encode(imageBytes);
                   _validationFormData(recognition.embeddings);

                    textEditingController.text = "";
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Face Registered"),
                    ));
                  },style: ElevatedButton.styleFrom(primary:Colors.blue,minimumSize: const Size(200,40)),
                  child: const Text("Register"))
            ],
          ),
        ),contentPadding: EdgeInsets.zero,
      ),
    );
  }
  void _validationFormData(List<double> image) async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
      var   token= prefsdf.getString("token").toString();
      var assign_to_owner_id = prefsdf.getString("user_id").toString();
      var  assgin_to_bussinesses_id = prefsdf.getString("bussiness_id").toString();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
          var staffname=     prefs.getString('staffname')??"";
           var staffmob=   await prefs.getString('staffmob')??"";
            var staffpassw =  await prefs.getString('staffpassw')??"";
         var staffemail =     await prefs.getString('staffemail')??"";
            var salary_amount=  await prefs.getString('salary_amount')??"";
          var staff_cycle=    await prefs.getString('staff_cycle')??"";
         var monthyly=     await prefs.getString('monthyly')??"";

         var _futureLogin = BooksApi.addStaff(staffname,staffmob,staffpassw,staffemail,staff_cycle,monthyly,salary_amount,assign_to_owner_id,assgin_to_bussinesses_id,token,context,image.toString() );
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          Fluttertoast.showToast(
              msg: "Add Staff Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DashBoard()));
        }
      });

    }



// ////TODO method to convert CameraImage to Image
//   img.Image convertYUV420ToImage(CameraImage cameraImage) {
//     final width = cameraImage.width;
//     final height = cameraImage.height;
//
//     final yRowStride = cameraImage.planes[0].bytesPerRow;
//     final uvRowStride = cameraImage.planes[1].bytesPerRow;
//     final uvPixelStride = cameraImage.planes[1].bytesPerPixel!;
//
//     final image = img.Image(  width: width, height: height);
//
//     for (var w = 0; w < width; w++) {
//       for (var h = 0; h < height; h++) {
//         final uvIndex =
//             uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
//         final index = h * width + w;
//         final yIndex = h * yRowStride + w;
//
//         final y = cameraImage.planes[0].bytes[yIndex];
//         final u = cameraImage.planes[1].bytes[uvIndex];
//         final v = cameraImage.planes[2].bytes[uvIndex];
//
//         image.data![index] = yuv2rgb(y, u, v);
//       }
//     }
//     return image;
//   }
//   int yuv2rgb(int y, int u, int v) {
//     // Convert yuv pixel to rgb
//     var r = (y + v * 1436 / 1024 - 179).round();
//     var g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
//     var b = (y + u * 1814 / 1024 - 227).round();
//
//     // Clipping RGB values to be inside boundaries [ 0 , 255 ]
//     r = r.clamp(0, 255);
//     g = g.clamp(0, 255);
//     b = b.clamp(0, 255);
//
//     return 0xff000000 |
//     ((b << 16) & 0xff0000) |
//     ((g << 8) & 0xff00) |
//     (r & 0xff);
//   }
}

class FacePainter extends CustomPainter {
  List<Recognition> facesList;
  dynamic imageFile;
  FacePainter({required this.facesList, @required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    Paint p = Paint();
    p.color = Colors.red;
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 3;
    Paint p2 = Paint();
    p2.color = Colors.green;
    p2.style = PaintingStyle.stroke;
    p2.strokeWidth = 3;

    Paint p3 = Paint();
    p3.color = Colors.yellow;
    p3.style = PaintingStyle.stroke;
    p3.strokeWidth = 1;

    for (Recognition rectangle in facesList) {
      canvas.drawRect(rectangle.location, p);
      TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.white, fontSize: 90),
          text: "${rectangle.name}  ${rectangle.distance.toStringAsFixed(2)}");
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(rectangle.location.left, rectangle.location.top));
    }


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.absoluteImageSize, this.faces, this.camDire2);

  final Size absoluteImageSize;
  final List<Face> faces;
  CameraLensDirection camDire2;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;
    Paint p2 = Paint();
    p2.color = Colors.green;
    p2.style = PaintingStyle.stroke;
    p2.strokeWidth = 3;

    Paint p3 = Paint();
    p3.color = Colors.yellow;
    p3.style = PaintingStyle.stroke;
    p3.strokeWidth = 1;

    for (Face face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.boundingBox.right) * scaleX
              : face.boundingBox.left * scaleX,
          face.boundingBox.top * scaleY,
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.boundingBox.left) * scaleX
              : face.boundingBox.right * scaleX,
          face.boundingBox.bottom * scaleY,
        ),
        paint,
      );

      // TextSpan span = TextSpan(
      //     style: const TextStyle(color: Colors.white, fontSize: 20),
      //     text: "${face.name}  ${face!.distance.toStringAsFixed(2)}");
      // TextPainter tp = TextPainter(
      //     text: span,
      //     textAlign: TextAlign.left,
      //     textDirection: TextDirection.ltr);
      // tp.layout();
      // tp.paint(canvas, Offset(face.location.left*scaleX, face.location.top*scaleY));
    }

  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return true;
  }

}