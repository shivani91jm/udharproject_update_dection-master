class BonusInfo {
  int? id;
  String? ownerId;
  String? bussinesId;
  String? staffId;
  String? paymentType;
  String? type;
  String? desc;
  String? amount;
  String? createdAt;
  String? updatedAt;

  BonusInfo(
      {this.id,
        this.ownerId,
        this.bussinesId,
        this.staffId,
        this.paymentType,
        this.type,
        this.desc,
        this.amount,
        this.createdAt,
        this.updatedAt});

  BonusInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    bussinesId = json['bussines_id'];
    staffId = json['staff_id'];
    paymentType = json['payment_type'];
    type = json['type'];
    desc = json['desc'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['bussines_id'] = this.bussinesId;
    data['staff_id'] = this.staffId;
    data['payment_type'] = this.paymentType;
    data['type'] = this.type;
    data['desc'] = this.desc;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


