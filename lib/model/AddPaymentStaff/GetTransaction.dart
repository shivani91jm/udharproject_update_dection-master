class GetTransaction {
  int? id;
  int? staffId;
  Null? businessManId;
  String? amount;
  String? transactionId;
  String? paymentMethod;
  String? status;
  String? createdAt;
  String? updatedAt;

  GetTransaction(
      {this.id,
        this.staffId,
        this.businessManId,
        this.amount,
        this.transactionId,
        this.paymentMethod,
        this.status,
        this.createdAt,
        this.updatedAt});

  GetTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    businessManId = json['business_man_id'];
    amount = json['amount'];
    transactionId = json['transaction_id'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['business_man_id'] = this.businessManId;
    data['amount'] = this.amount;
    data['transaction_id'] = this.transactionId;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}