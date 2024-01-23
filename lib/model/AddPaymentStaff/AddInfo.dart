import 'package:udharproject/model/AddPaymentStaff/GetTransaction.dart';

class AddInfo {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? mobile;
  String? otp;
  Null? dob;
  String? gender;
  Null? address;
  int? businessRoleId;
  int? staffRoleId;
  String? status;
  String? wallet;
  String? createdAt;
  String? updatedAt;
  List<GetTransaction>? getTransaction;

  AddInfo(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.mobile,
        this.otp,
        this.dob,
        this.gender,
        this.address,
        this.businessRoleId,
        this.staffRoleId,
        this.status,
        this.wallet,
        this.createdAt,
        this.updatedAt,
        this.getTransaction});

  AddInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    otp = json['otp'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    businessRoleId = json['business_role_id'];
    staffRoleId = json['staff_role_id'];
    status = json['status'];
    wallet = json['wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['get_transaction'] != null) {
      getTransaction = <GetTransaction>[];
      json['get_transaction'].forEach((v) {
        getTransaction!.add(new GetTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['business_role_id'] = this.businessRoleId;
    data['staff_role_id'] = this.staffRoleId;
    data['status'] = this.status;
    data['wallet'] = this.wallet;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getTransaction != null) {
      data['get_transaction'] =
          this.getTransaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}