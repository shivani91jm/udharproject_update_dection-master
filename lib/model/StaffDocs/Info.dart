import 'package:udharproject/model/StaffDocs/GetDocument.dart';

class Info {
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
  String? createdAt;
  String? updatedAt;
  GetDocument? getDocument;

  Info(
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
        this.createdAt,
        this.updatedAt,
        this.getDocument});

  Info.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    getDocument = json['get_document'] != null
        ? new GetDocument.fromJson(json['get_document'])
        : null;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getDocument != null) {
      data['get_document'] = this.getDocument!.toJson();
    }
    return data;
  }
}