import 'package:udharproject/model/AddOverTimeRateModel/Info.dart';

class AddOverTimeRateModel {
  String? response;
  String? msg;
  List<AddOverTimeInfo>? info;
  Null? errors;
  int? statusCode;

  AddOverTimeRateModel(
      {this.response, this.msg, this.info, this.errors, this.statusCode});

  AddOverTimeRateModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    if (json['info'] != null) {
      info = <AddOverTimeInfo>[];
      json['info'].forEach((v) {
        info!.add(new AddOverTimeInfo.fromJson(v));
      });
    }
    errors = json['errors'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    data['status_code'] = this.statusCode;
    return data;
  }
}