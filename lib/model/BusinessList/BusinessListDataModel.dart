import 'package:udharproject/model/BusinessList/Info.dart';

class BusinessListDataModel {
  String? response;
  String? msg;
  List<Info>? info;
  Null? errors;
  int? statusCode;

  BusinessListDataModel({this.response, this.msg, this.info, this.errors, this.statusCode});

  BusinessListDataModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    if (json['info'] != null) {
      info = <Info>[];
      json['info'].forEach((v) {
        info!.add(new Info.fromJson(v));
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