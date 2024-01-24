import 'dart:math';
import 'dart:ui';
import 'package:image/src/image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
import 'package:tflite_flutter_plus/tflite_flutter_plus.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
import 'package:udharproject/Activity/SplashScreen.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/model/stafflistattendance/StaffInfoModel.dart';
import 'Recognition.dart';
import '../main.dart';

class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;
  late List<int> _inputShape;
  late List<int> _outputShape;
  late TensorImage _inputImage;
  late TensorBuffer _outputBuffer;
  late TfLiteType _inputType;
  late TfLiteType _outputType;
  late var _probabilityProcessor;
  Map<String,Recognition> registered = Map();

  @override
  String get modelName => 'mobile_face_net.tflite';

   @override
   NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);
  //
   @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);


  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
  }

  Future<void> loadModel2() async {
    try {
      interpreter = await Interpreter.fromAsset(modelName, options: _interpreterOptions);
      print('Interpreter Created Successfully');

      _inputShape = interpreter.getInputTensor(0).shape;
      _outputShape = interpreter.getOutputTensor(0).shape;
      _inputType = interpreter.getInputTensor(0).type as TfLiteType ;
      _outputType = interpreter.getOutputTensor(0).type as TfLiteType ;

      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
      _probabilityProcessor = TensorProcessorBuilder().add(postProcessNormalizeOp).build();
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }
  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset(modelName, options: _interpreterOptions);
      print('Interpreter Created Successfully');

      _inputShape = interpreter.getInputTensor(0).shape;
      _outputShape = interpreter.getOutputTensor(0).shape;
      _inputType = interpreter.getInputTensor(0).type;
      _outputType = interpreter.getOutputTensor(0).type;
      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
      _probabilityProcessor = TensorProcessorBuilder().add(postProcessNormalizeOp).build();
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  TensorImage _preProcess() {
    int cropSize = min(_inputImage.height, _inputImage.width);
    return ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(
        _inputShape[1], _inputShape[2], ResizeMethod.nearestneighbour))
        .add(preProcessNormalizeOp)
        .build()
        .process(_inputImage);
  }

  Recognition recognize(Image image,Rect location) {
    final pres = DateTime.now().millisecondsSinceEpoch;
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image as Image);
    _inputImage = _preProcess();
    final pre = DateTime.now().millisecondsSinceEpoch - pres;
    print('Time to load image: $pre ms');
    final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());
    final run = DateTime.now().millisecondsSinceEpoch - runs;
    print('Time to run inference: $run ms');
    //
     _probabilityProcessor.process(_outputBuffer);
       //  .getMapWithFloatValue();
    //final pred = getTopProbability(labeledProb);
    print(_outputBuffer.getDoubleList());
    Pair pair = findNearest(_outputBuffer.getDoubleList());

    return Recognition(pair.id,pair.name,location, _outputBuffer.getDoubleList(),pair.distance);
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
              List<double> embd = info[i].staffImage.toString().split(',')
                  .map((e) => double.parse(e)).toList()
                  .cast<double>();
              var staff_id = info[i].staffId.toString();
              var staff_name = info[i].staffName.toString();
              Recognition recognition = Recognition(
                  info[i].staffId.toString(), info[i].staffName.toString(),
                  Rect.zero, embd, 0);
              registered.putIfAbsent(staff_name, () => recognition);
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


