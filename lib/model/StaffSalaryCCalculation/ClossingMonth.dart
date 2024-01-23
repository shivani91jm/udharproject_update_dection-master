class ClossingMonth {
  int? netSalary;
  int? monthSalary;
  int? monthPayments;
  int? monthAdjustments;
  String? monthName;
  int? totalFineAmount;
  int? deduction;

  ClossingMonth(
      {this.netSalary,
        this.monthSalary,
        this.monthPayments,
        this.monthAdjustments,
        this.monthName,
        this.totalFineAmount,
        this.deduction});

  ClossingMonth.fromJson(Map<String, dynamic> json) {
    netSalary = json['net_salary'];
    monthSalary = json['month_salary'];
    monthPayments = json['month_payments'];
    monthAdjustments = json['month_adjustments'];
    monthName = json['month_name'];
    totalFineAmount = json['total-fine-amount'];
    deduction = json['deduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['net_salary'] = this.netSalary;
    data['month_salary'] = this.monthSalary;
    data['month_payments'] = this.monthPayments;
    data['month_adjustments'] = this.monthAdjustments;
    data['month_name'] = this.monthName;
    data['total-fine-amount'] = this.totalFineAmount;
    data['deduction'] = this.deduction;
    return data;
  }
}
