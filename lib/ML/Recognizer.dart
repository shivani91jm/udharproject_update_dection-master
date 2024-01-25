import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:udharproject/Activity/SplashScreen.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/model/stafflistattendance/StaffInfoModel.dart';
import 'Recognition.dart';
import '../main.dart';
import 'package:image/image.dart' as img;
class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;
  // late List<int> _inputShape;
  // late List<int> _outputShape;
  // late TensorImage _inputImage;
  // late TensorBuffer _outputBuffer;
  // late TfLiteType _inputType;
  // late TfLiteType _outputType;
  // late var _probabilityProcessor;

  static const int WIDTH = 112;
  static const int HEIGHT = 112;
  @override
  String get modelName => 'mobile_face_net.tflite';

  //  @override
  //  NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);
  // //
  //  @override
  // NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);



  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
    loadstafflist();
  }

  // Future<void> loadModel2() async {
  //   try {
  //     interpreter = await Interpreter.fromAsset(modelName, options: _interpreterOptions);
  //     print('Interpreter Created Successfully');
  //
  //     _inputShape = interpreter.getInputTensor(0).shape;
  //     _outputShape = interpreter.getOutputTensor(0).shape;
  //     _inputType = interpreter.getInputTensor(0).type as TfLiteType ;
  //     _outputType = interpreter.getOutputTensor(0).type as TfLiteType ;
  //
  //     _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
  //     _probabilityProcessor = TensorProcessorBuilder().add(postProcessNormalizeOp).build();
  //   } catch (e) {
  //     print('Unable to create interpreter, Caught Exception: ${e.toString()}');
  //   }
  // }
  // Future<void> loadModel() async {
  //   try {
  //     interpreter = await Interpreter.fromAsset(modelName, options: _interpreterOptions);
  //     print('Interpreter Created Successfully');
  //
  //     _inputShape = interpreter.getInputTensor(0).shape;
  //     _outputShape = interpreter.getOutputTensor(0).shape;
  //     _inputType = interpreter.getInputTensor(0).type;
  //     _outputType = interpreter.getOutputTensor(0).type;
  //     _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
  //     _probabilityProcessor = TensorProcessorBuilder().add(postProcessNormalizeOp).build();
  //   } catch (e) {
  //     print('Unable to create interpreter, Caught Exception: ${e.toString()}');
  //   }
  // }
  //
  // TensorImage _preProcess() {
  //   int cropSize = min(_inputImage.height, _inputImage.width);
  //   return ImageProcessorBuilder()
  //       .add(ResizeWithCropOrPadOp(cropSize, cropSize))
  //       .add(ResizeOp(
  //       _inputShape[1], _inputShape[2], ResizeMethod.nearestneighbour))
  //       .add(preProcessNormalizeOp)
  //       .build()
  //       .process(_inputImage);
  // }
  //
  // Recognition recognize(Image image,Rect location) {
  //   final pres = DateTime.now().millisecondsSinceEpoch;
  //   _inputImage = TensorImage(_inputType);
  //   _inputImage.loadImage(image as Image);
  //   _inputImage = _preProcess();
  //   final pre = DateTime.now().millisecondsSinceEpoch - pres;
  //   print('Time to load image: $pre ms');
  //   final runs = DateTime.now().millisecondsSinceEpoch;
  //   interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());
  //   final run = DateTime.now().millisecondsSinceEpoch - runs;
  //   print('Time to run inference: $run ms');
  //   //
  //    _probabilityProcessor.process(_outputBuffer);
  //      //  .getMapWithFloatValue();
  //   //final pred = getTopProbability(labeledProb);
  //   print(_outputBuffer.getDoubleList());
  //   Pair pair = findNearest(_outputBuffer.getDoubleList());
  //
  //   return Recognition(pair.id,pair.name,location, _outputBuffer.getDoubleList(),pair.distance);
  // }
  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset(modelName);
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  List<dynamic> imageToArray(img.Image inputImage){
    img.Image resizedImage = img.copyResize(inputImage!, width: WIDTH, height: HEIGHT);
    List<double> flattenedList = resizedImage.data!.expand((channel) => [channel.r, channel.g, channel.b]).map((value) => value.toDouble()).toList();
    Float32List float32Array = Float32List.fromList(flattenedList);
    int channels = 3;
    int height = HEIGHT;
    int width = WIDTH;
    Float32List reshapedArray = Float32List(1 * height * width * channels);
    for (int c = 0; c < channels; c++) {
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          int index = c * height * width + h * width + w;
          reshapedArray[index] = (float32Array[c * height * width + h * width + w]-127.5)/127.5;
        }
      }
    }
    return reshapedArray.reshape([1,112,112,3]);
  }

  Recognition recognize(img.Image image,Rect location) {

    //TODO crop face from image resize it and convert it to float array
    var input = imageToArray(image);
    print(input.shape.toString());

    //TODO output array
    List output = List.filled(1*192, 0).reshape([1,192]);

    //TODO performs inference
    final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(input, output);
    final run = DateTime.now().millisecondsSinceEpoch - runs;
    print('Time to run inference: $run ms$output');

    //TODO convert dynamic list to double list
    List<double> outputArray = output.first.cast<double>();

    //TODO looks for the nearest embeeding in the database and returns the pair
    Pair pair = findNearest(outputArray);
    print("distance= ${pair.distance}");

    return Recognition(pair.id,pair.name,location,outputArray,pair.distance);
  }

  void  loadstafflist() async
  {

    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token = prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id = prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.showStaffListAttendace(
        user_id, bussiness_id, token);
    if (_futureLogin != null) {
      _futureLogin.then((value) async {
        var res = value.response;
        if (res == "true") {
          if (value.info != null) {
            List<StaffInfoModel> ? info = value.info;
            for (int i = 0; i < info!.length; i++) {
              if(info[i].staffImage!=null && info[i].staffImage!="") {
                print("ff"+info[i].staffImage.toString());


                // Remove square brackets and split by comma
                List<String> numberStrings = info[i].staffImage.toString().substring(1, info[i].staffImage.toString().length - 1).split(',');

                // Convert strings to doubles
                List<double> embd = numberStrings.map((e) => double.parse(e)).toList();

                print(embd);

                    // .split(',')
                    // .map((e) => double.parse(e)).toList()
                    // .cast<double>();
                var staff_id = info[i].staffId.toString();
                var staff_name = info[i].staffName.toString();
                Recognition recognition = Recognition(
                    info[i].staffId.toString(), info[i].staffName.toString(),
                    Rect.zero, embd as List<double>, 0);
                MyApp().registered.putIfAbsent(staff_name, () => recognition);
              }
            }
          }
        }
      });
    }
  }




 // TODO  looks for the nearest embeeding in the dataset
//  and retrurns the pair <id, distance>
  findNearest(List<double> emb){
    Pair pair = Pair("Unknown","Unknown", -5);
    for (MapEntry<String, Recognition> item in SplashScreen.registered.entries) {
      final String name = item.key;
      final String id=item.key;
      List<double> knownEmb = item.value.embeddings;
      double distance = 0;
      for (int i = 0; i < emb.length; i++) {
        double diff = emb[i] - knownEmb[i];
        distance += diff*diff;
      }
      distance = sqrt(distance);
      if (pair.distance == -5 || distance < pair.distance) {
        pair.distance = distance;
        pair.name = name;
        pair.id=id;

      }
    }
    return pair;
  }

  void close() {
    interpreter.close();
  }

}
class Pair{
  String id;
   String name;
   double distance;
   Pair(this.id,this.name,this.distance);
}


