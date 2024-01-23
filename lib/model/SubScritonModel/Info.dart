class Info {
  int? id;
  String? heading;
  String? desc;
  int? days;
  String? price;
  String? paymentType;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  Info(
      {this.id,
        this.heading,
        this.desc,
        this.days,
        this.price,
        this.paymentType,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heading = json['heading'];
    desc = json['desc'];
    days = json['days'];
    price = json['price'];
    paymentType = json['payment_type'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['heading'] = this.heading;
    data['desc'] = this.desc;
    data['days'] = this.days;
    data['price'] = this.price;
    data['payment_type'] = this.paymentType;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}