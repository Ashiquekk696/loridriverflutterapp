class CashSubmittedModel {
  bool? error;
  int? total;
  List<CashSubmittedDataModel>? cashSubmitted;
  String? msg;

  CashSubmittedModel({this.error, this.total, this.cashSubmitted, this.msg});

  CashSubmittedModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    total = json['total'];
    if (json['cash_submitted'] != null) {
      cashSubmitted = <CashSubmittedDataModel>[];
      json['cash_submitted'].forEach((v) {
        cashSubmitted!.add(new CashSubmittedDataModel.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['total'] = this.total;

    data['msg'] = this.msg;
    return data;
  }
}

class CashSubmittedDataModel {
  int? id;
  int? driverId;
  int? userType;
  int? bookingId;
  String? cash;
  String? date;
  int? submitted;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CashSubmittedDataModel(
      {this.id,
      this.driverId,
      this.userType,
      this.bookingId,
      this.cash,
      this.date,
      this.submitted,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CashSubmittedDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    userType = json['user_type'];
    bookingId = json['booking_id'];
    cash = json['cash'];
    date = json['date'];
    submitted = json['submitted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
}
