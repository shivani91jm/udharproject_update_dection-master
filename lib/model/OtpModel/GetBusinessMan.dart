class GetBusinessMan {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  Null? mobile;
  String? otp;
  int? businessRoleId;
  Null? staffRoleId;
  String? status;
  String? createdAt;
  String? updatedAt;

  GetBusinessMan(
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
        this.updatedAt});

  GetBusinessMan.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}