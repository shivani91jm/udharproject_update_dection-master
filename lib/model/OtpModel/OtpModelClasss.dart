import 'package:udharproject/model/OtpModel/GetBusiness.dart';
import 'package:udharproject/model/OtpModel/OtpErrorModel.dart';
import 'package:udharproject/model/OtpModel/OtpInfoModel.dart';

class OTPModalClass
{
  String? response;
  String? msg;
  OtpInfoModel? info;
  int? statusCode;
  List<GetBusiness>? getBusiness;
  OTPModalClass({this.response, this.msg, this.info,  this.statusCode, this.getBusiness});

  OTPModalClass.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    info = json['info'] != null ? new OtpInfoModel.fromJson(json['info']) : null;

    statusCode = json['status_code'];
    if (json['get_business'] != null) {
      getBusiness = <GetBusiness>[];
      json['get_business'].forEach((v) {
        getBusiness!.add(new GetBusiness.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['msg'] = this.msg;
    if (this.info != null)
    {
      data['info'] = this.info!.toJson();
    }
    data['status_code'] = this.statusCode;
    if (this.getBusiness != null) {
      data['get_business'] = this.getBusiness!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}