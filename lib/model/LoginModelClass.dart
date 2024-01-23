import 'package:udharproject/model/LoginErrorModel.dart';
import 'package:udharproject/model/LoginInfo.dart';

class LoginModelClass{
   String? response;
  String? msg;
  LoginInfo? info;

  int? statusCode;
  LoginModelClass({this.response, this.msg, this.info,this.statusCode});

  LoginModelClass.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    info = json['info'] != null ? new LoginInfo.fromJson(json['info']) : null;

    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }

    data['status_code'] = this.statusCode;
    return data;
  }
}





