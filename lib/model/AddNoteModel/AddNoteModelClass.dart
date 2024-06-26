import 'package:udharproject/model/AddNoteModel/AddNoteInfo.dart';

class AddNoteModelClass {
  String? response;
  String? msg;
  AddNoteInfo? info;
  Null? errors;
  int? statusCode;

  AddNoteModelClass(
      {this.response, this.msg, this.info, this.errors, this.statusCode});

  AddNoteModelClass.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    info = json['info'] != null ? new AddNoteInfo.fromJson(json['info']) : null;
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