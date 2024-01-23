class ZeroModelClass{
    String? response;
    int? totalPresent;
    int? totalAbsent;
    int? totalPaidLeave;
    var totalPaidFine;
    int? totalPaidOvertime;
    int? totalHalfDay;

    ZeroModelClass({this.response, this.totalPresent, this.totalAbsent, this.totalPaidLeave, this.totalPaidFine, this.totalPaidOvertime,this.totalHalfDay});

    ZeroModelClass.fromJson(Map<String, dynamic> json) {
      response = json['response'];
      totalPresent = json['total-present'];
      totalAbsent = json['total-absent'];
      totalPaidLeave = json['total-paid-leave'];
      totalPaidFine = json['total-paid-fine'];
      totalPaidOvertime = json['total-paid-overtime'];
      totalHalfDay = json['total-half-day'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['response'] = this.response;
      data['total-present'] = this.totalPresent;
      data['total-absent'] = this.totalAbsent;
      data['total-paid-leave'] = this.totalPaidLeave;
      data['total-paid-fine'] = this.totalPaidFine;
      data['total-paid-overtime'] = this.totalPaidOvertime;
      data['total-half-day'] = this.totalHalfDay;
      return data;
    }
}