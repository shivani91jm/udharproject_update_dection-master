import 'package:udharproject/model/StaffDocs/Info.dart';
class StaffDocsModelClass {
  String? response;
  String? msg;
  Info? info;
  Null? errors;
  int? statusCode;

  StaffDocsModelClass(
      {this.response, this.msg, this.info, this.errors, this.statusCode});

  StaffDocsModelClass.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    errors = json['errors'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['errors'] = this.errors;
    data['status_code'] = this.statusCode;
    return data;
  }
}
