import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';

import 'package:udharproject/ML/Recognition.dart';
import 'package:udharproject/ML/Recognizer.dart';
import 'package:udharproject/model/MonthlyWiseStaffListModel/Monthly.dart';

import '../model/MonthlyWiseStaffListModel/Info.dart';
import 'package:http/http.dart' as http;

class AutoDectionPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  final Recognizer? recognizer;

   AutoDectionPage({Key? key,required this.cameras,required this.recognizer}) : super(key: key);

  @override
  State<AutoDectionPage> createState() => _HomePageState();
}

class _HomePageState extends State<AutoDectionPage> {

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

  bool isDetecting = false;
  CameraImage? cameraImage;
  dynamic _scanResults;
  late Size size;
  CameraLensDirection camDirec = CameraLensDirection.front;
  bool _isLoading=false;
  List<Monthly> getMonthlyConaList =[];
  var images;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();

    //TODO initialize detector
    faceDetector =FaceDetector(options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast));

    //TODO initalize face recognizer
   // widget.recognizer = Recognizer();
 //   showStaffListData();
     initCamera(widget.cameras![1]);
  }
  void showStaffListData() async{
    _isLoading=true;
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.ShowStffListAccordingToMonthly(user_id,bussiness_id, token, context);
    if (_futureLogin != null) {
      _futureLogin.then((value) async{
        var res = value.response;
        if (res == "true") {
          if (value.info!= null) {
            _isLoading=false;
            Info ? info = value.info;
            getMonthlyConaList= info!.monthly!;
            if (getMonthlyConaList.isNotEmpty != null) {
                storeimage();
            }
          }
        }
        else
        {
          setState(() {
            _isLoading=false;
          });
        }
      });
    }
    else {
      _futureLogin.then((value) {
        String data = value.msg.toString();

        setState(() {
          _isLoading=true;
          // staffListFlag=true;
        });
        Fluttertoast.showToast(
            msg: "" + data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.drakColorTheme,
            textColor: AppColors.white,
            fontSize: 16.0
        );
      });
    }
  }
  Future initCamera(CameraDescription cameraDescription) async {
// create a CameraController
    _cameraController = CameraController(
        cameraDescription, ResolutionPreset.high);
// Next, initialize the controller. This returns a Future.
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
            performFaceRecognition2(cropImage,context);

            // setState(() {
            //   _scanResults = cropImage;
            //   isDetecting = false;
            // });

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
      return const Center(child: Text('Camera is not initialized'));
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
      _image=picture as File;
      _image=   File(picture.path);
     doFaceDetection();

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
     // doFaceDetection();
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
    XFile? pickedFile =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
     // doFaceDetection();
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
    // setState(() {
    //   _scanResults=faces;
    // });
    //TODO call the method to perform face recognition on detected faces
   // performFaceRecognition2(faces);


  }

  //TODO remove rotation of camera images
  removeRotation(File inputImage) async {
    final img.Image? capturedImage = img.decodeImage(await File(inputImage!.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  //TODO perform Face Recognition
  performFaceRecognition() async {

    images = await _image?.readAsBytes();

    images = await decodeImageFromList(images);
    print("${images.width}   ${images.height}");

    recognitions.clear();
    for (Face face in faces) {
      Rect faceRect = face.boundingBox;
      num left = faceRect.left<0?0:faceRect.left;
      num top = faceRect.top<0?0:faceRect.top;
      num right = faceRect.right>images.width?images.width-1:faceRect.right;
      num bottom = faceRect.bottom>images.height?images.height-1:faceRect.bottom;
      num width = right - left;
      num height = bottom - top;

      //TODO crop face
      File cropedFace = await FlutterNativeImage.cropImage(_image!.path,
          left.toInt(),top.toInt(),width.toInt(),height.toInt());
      final bytes = await File(cropedFace!.path).readAsBytes();
      final img.Image? faceImg = img.decodeImage(bytes);
      Recognition recognition = widget.recognizer!.recognize(faceImg!, face.boundingBox);
      if(recognition.distance>1) {
        recognition.name = "Unknown";
      }
      recognitions.add(recognition);
    }
    drawRectangleAroundFaces();
  }

  //TODO draw rectangles
  drawRectangleAroundFaces() async {
    setState(() {
      images;
      faces;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                            takePicture();
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
            children: stackChildren
        ));
  }
  img.Image? image;
  bool register = false;
  performFaceRecognition2(List<Face> faces,BuildContext context) async {
    recognitions.clear();

    //TODO convert CameraImage to Image and rotate it so that our frame will be in a portrait
    image = convertYUV420ToImage(cameraImage!);
    image =img.copyRotate(image!, angle: camDirec == CameraLensDirection.front?270:90);

    for (Face face in faces) {
      Rect faceRect = face.boundingBox;
      //TODO crop face
     // img.Image cropimage = img.copyCrop(image!, faceRect.left.toInt(),faceRect.top.toInt(),faceRect.width.toInt(),faceRect.height.toInt());
      img.Image cropimage = img.copyCrop(image!, x:faceRect.left.toInt(),y:faceRect.top.toInt(),width:faceRect.width.toInt(),height:faceRect.height.toInt());
      //TODO pass cropped face to face recognition model
      print("vvb");
      Recognition recognition = widget.recognizer!.recognize(cropimage, faceRect);

      if(recognition.distance>1.25){
        recognition.name = "Unknown";
      }
      recognitions.add(recognition);

      //TODO show face registration dialogue
      if(register){
        print("if gdhjd workinh");
        showFaceRegistrationDialogue(cropimage,recognition,context);
        register = false;
      }
      else
      {
        print("else workinh");
      }


    }
    setState(() {
      isDetecting  = false;
      _scanResults = recognitions;
    });
  }

  showFaceRegistrationDialogue(img.Image croppedFace, Recognition recognition, BuildContext context){
    showDialog(
      context: context!,
      builder: (ctx) => AlertDialog(
        title: const Text("Face Registration",textAlign: TextAlign.center),alignment: Alignment.center,
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
                  onPressed: () {
                    // _recognizer.registered.putIfAbsent(
                    //     textEditingController.text, () => recognition);
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


////TODO method to convert CameraImage to Image
  img.Image convertYUV420ToImage(CameraImage cameraImage) {
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

  void storeimage() async {
    for(int i=0;i<getMonthlyConaList.length;i++)
    {
      var images=getMonthlyConaList[i].staff_image;
      var name=getMonthlyConaList[i].staffName;
      try{
        final http.Response responseData = await http.get(Uri.parse(images.toString()));
        var  uint8list = responseData.bodyBytes;
        var buffer = uint8list.buffer;
        ByteData byteData = ByteData.view(buffer);
        var tempDir = await getTemporaryDirectory();
        // //  image="https://crm.shivagroupind.com//img//image_656f137d1e904.png"";
        _image=  await File('${tempDir.path}/img').writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
        doFaceDetection();
      }on Exception catch(_){
        print("catch working...");
      }
    }

  }
}

class FacePainter extends CustomPainter {
  List<Recognition> facesList;
  dynamic imageFile;
  FacePainter({required this.facesList, @required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      Paint p = Paint();
      p.color = Colors.red;
      p.style = PaintingStyle.stroke;
      p.strokeWidth = 3;
      canvas.drawImage(imageFile, Offset.zero, p);
    }
    print("hii"+imageFile.toString());

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
      print("heellllllllllll${rectangle.name}");
      canvas.drawRect(rectangle.location, p2);
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
  final List<Recognition> faces;
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

    for (Recognition face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.location.right) * scaleX
              : face.location.left * scaleX,
          face.location.top * scaleY,
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.location.left) * scaleX
              : face.location.right * scaleX,
          face.location.bottom * scaleY,
        ),
        p3,
      );

      TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.white, fontSize: 20),
          text: "${face.name}  ${face!.distance.toStringAsFixed(2)}");
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(face.location.left*scaleX, face.location.top*scaleY));
    }

  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return true;
  }

}
