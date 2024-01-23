import 'package:udharproject/model/SocialMediaLogin/GetBussiness.dart';
import 'package:udharproject/model/SocialMediaLogin/GetStaffUser.dart';
class SocialInfo{
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? mobile;
  String? otp;
  int? businessRoleId;
  int? staffRoleId;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<GetBusiness>? getBusiness;
  List<GetStaffUser>? getStaffUser;

  SocialInfo(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.mobile,
        this.otp,
        this.businessRoleId,
        this.staffRoleId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.getBusiness,
        this.getStaffUser});

  SocialInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    otp = json['otp'];
    businessRoleId = json['business_role_id'];
    staffRoleId = json['staff_role_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['get_business'] != null) {
      getBusiness = <GetBusiness>[];
      json['get_business'].forEach((v) {
        getBusiness!.add(new GetBusiness.fromJson(v));
      });
    }
    if (json['get_staff_user'] != null) {
      getStaffUser = <GetStaffUser>[];
      json['get_staff_user'].forEach((v) {
        getStaffUser!.add(new GetStaffUser.fromJson(v));
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
    data['business_role_id'] = this.businessRoleId;
    data['staff_role_id'] = this.staffRoleId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getBusiness != null) {
      data['get_business'] = this.getBusiness!.map((v) => v.toJson()).toList();
    }
    if (this.getStaffUser != null) {
      data['get_staff_user'] = this.getStaffUser!.map((v) => v.toJson()).toList();
    }

    return data;
  }




}