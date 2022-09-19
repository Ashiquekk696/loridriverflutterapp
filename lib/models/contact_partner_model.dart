class ContactPartnerModel {
  bool? error;
  Partner? partner;
  String? phone;
  String? msg;

  ContactPartnerModel({this.error, this.partner, this.phone, this.msg});

  ContactPartnerModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    partner =
        json['partner'] != null ? new Partner.fromJson(json['partner']) : null;
    phone = json['phone'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.partner != null) {
      data['partner'] = this.partner!.toJson();
    }
    data['phone'] = this.phone;
    data['msg'] = this.msg;
    return data;
  }
}

class Partner {
  int? id;
  String? name;
  String? email;
  String? phone;

  Partner({this.id, this.name, this.email, this.phone});

  Partner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
