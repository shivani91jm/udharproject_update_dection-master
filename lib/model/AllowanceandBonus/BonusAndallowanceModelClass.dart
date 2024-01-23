import 'package:udharproject/model/AllowanceandBonus/BounsInfo.dart';

class BonusAndallowanceModelClass {
  String? response;
  var msg;
  List<BonusInfo>? info;
  Null? errors;
  int? statusCode;
  var totalAllowance;
  var totalBonus;

  BonusAndallowanceModelClass(
      {this.response,
        this.msg,
        this.info,
        this.errors,
        this.statusCode,
        this.totalAllowance,
        this.totalBonus});

  BonusAndallowanceModelClass.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    msg = json['msg'];
    if (json['info'] != null) {
      info = <BonusInfo>[];
      json['info'].forEach((v) {
        info!.add(new BonusInfo.fromJson(v));
      });
    }
    errors = json['errors'];
    statusCode = json['status_code'];
    totalAllowance = json['total-allowance'];
    totalBonus = json['total-bonus'];
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
    data['total-allowance'] = this.totalAllowance;
    data['total-bonus'] = this.totalBonus;
    return data;
  }
}

