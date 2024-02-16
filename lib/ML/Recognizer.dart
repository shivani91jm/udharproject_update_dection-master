import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/model/stafflistattendance/StaffInfoModel.dart';

import 'Recognition.dart';

class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;
  static const int WIDTH = 112;
  static const int HEIGHT = 112;
  Map<String,Recognition> registered = Map();
  @override
  String get modelName => 'assets/mobile_face_net.tflite';
  //final FirebaseService firebaseService = FirebaseService();
  List<StaffInfoModel>? users;
  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
    initDB();
  }

  initDB() async {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var token = prefsdf.getString("token").toString();

    var bussiness_id = prefsdf.getString("bussiness_id").toString();
    var owner_id = prefsdf.getString("user_id").toString();
   var _futureLogin= BooksApi.showStaffListAttendace(owner_id,bussiness_id,token);
    if (_futureLogin != null) {
      _futureLogin!.then((value) {
        var res = value.response.toString();
        if (res == "true") {
          print("ghffsfdfdsdgf"+value.info.toString());
          users= value.info;
          loadRegisteredFaces();
        }
      });



    }
  // users=await firebaseService.fetchDataFromFirestore();
    //loadRegisteredFaces();
  }

  void loadRegisteredFaces() async {
    registered.clear();

    for(int i=0;i<users!.length;i++)
      {
        print("lenfght"+users!.length.toString());

           // List<double> embd = users[i].modelData;
          //  List<double> embd = .map((dynamic value) => value.toDouble()).toList();
             if(users![i].staffImage.toString()!="null" && users![i].staffImage.toString()!=null) {
                try{
                  String name = users![i].staffName.toString();
                  print("cvv"+name);
                  List<double> embd = List<double>.from(
                      json.decode(users![i].staffImage.toString()).map((value) =>
                          value.toDouble()));

                  Recognition recognition = Recognition(
                      name, users![i].id.toString(), Rect.zero, embd, 0,
                      users![i].salaryPaymentType.toString());
                  registered.putIfAbsent(name, () => recognition);
                  print("R=" + name);
                } on FormatException catch(e)
                  {

                  }

             }
      }

  }

  // void registerFaceInDB(String name, List<double> embedding) async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnName: name,
  //     DatabaseHelper.columnEmbedding: embedding.join(",")
  //   };
  //   final id = await dbHelper.insert(row);
  //   print('inserted row id: $id');
  //   loadRegisteredFaces();
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

     return Recognition(pair.name,pair.staff_id,location,outputArray,pair.distance,pair.salary_type);
  }

  //TODO  looks for the nearest embeeding in the database and returns the pair which contain information of registered face with which face is most similar
  findNearest(List<double> emb){
    Pair pair = Pair("Unknown", -5,"","");
    for (MapEntry<String, Recognition> item in registered.entries) {
      final String name = item.key;
      final String saff_id=item.value.staff_id;
      final  String salary_type=item.value.salrytype;
      List<double> knownEmb = item.value.embeddings;
      double distance = 0;
      for (int i = 0; i < emb.length; i++) {
        double diff = emb[i] -
            knownEmb[i];
        distance += diff*diff;
      }
      distance = sqrt(distance);
      if (pair.distance == -5 || distance < pair.distance) {
        pair.distance = distance;
        pair.name = name;
        pair.staff_id=saff_id;
        pair.salary_type=salary_type;
      }
    }
    return pair;
  }

  void close() {
    interpreter.close();
  }

}
class Pair{
  String staff_id;
   String name;
   double distance;
   String salary_type;
   Pair(this.name,this.distance,this.staff_id,this.salary_type);
}


