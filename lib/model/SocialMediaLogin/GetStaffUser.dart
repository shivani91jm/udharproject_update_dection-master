import 'dart:convert';

import 'package:udharproject/model/SocialMediaLogin/StaffGetBusinessManList.dart';

class GetStaffUser {
  int? id;
  int? staffId;
  String? staffName;
  int? businessId;
  int? ownerId;
  String? salaryPaymentType;
  String? salaryAmount;
  String? salaryCycle;
  String? createdAt;
  String? updatedAt;
  List<StaffGetBusinessList>? getBusiness;

  GetStaffUser(
      {this.id,
        this.staffId,
        this.staffName,
        this.businessId,
        this.ownerId,
        this.salaryPaymentType,
        this.salaryAmount,
        this.salaryCycle,
        this.createdAt,
        this.updatedAt,
        this.getBusiness});

  GetStaffUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    businessId = json['business_id'];
    ownerId = json['owner_id'];
    salaryPaymentType = json['salary_payment_type'];
    salaryAmount = json['salary_amount'];
    salaryCycle = json['salary_cycle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['get_business'] != null) {
      getBusiness = <StaffGetBusinessList>[];
      json['get_business'].forEach((v) {
        getBusiness!.add(new StaffGetBusinessList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['business_id'] = this.businessId;
    data['owner_id'] = this.ownerId;
    data['salary_payment_type'] = this.salaryPaymentType;
    data['salary_amount'] = this.salaryAmount;
    data['salary_cycle'] = this.salaryCycle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getBusiness != null) {
      data['get_business'] = this.getBusiness!.map((v) => v.toJson()).toList();
    }
    return data;
  }



  static Map<String, dynamic> toMap(GetStaffUser music) => {
    'id' : music.id,
    'staff_id': music.staffId,
    'business_id':music.businessId,
    'owner_id':music.ownerId,
    'salary_payment_type': music.salaryPaymentType.toString(),
    'salary_amount': music.salaryAmount.toString(),
    'staff_name':music.staffName.toString(),
    'salary_cycle': music.salaryCycle.toString(),
    'created_at': music.createdAt.toString(),
    'get_business':music.getBusiness
  };
  static dynamic encode(List<GetStaffUser> musics) => json.encode(
    musics.map<Map<String, dynamic>>((music) => GetStaffUser.toMap(music)).toList(),
  );

  static List<GetStaffUser> decode(dynamic musics) =>
      (json.decode(musics) as List<dynamic>).map<GetStaffUser>((item) => GetStaffUser.fromJson(item)).toList();
}