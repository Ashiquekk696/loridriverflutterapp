class FaqModel {
  bool? error;
  String? msg;
  List<FaqDataModel>? faq;

  FaqModel({this.error, this.msg, this.faq});

  FaqModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['faq'] != null) {
      faq = <FaqDataModel>[];
      json['faq'].forEach((v) {
        faq!.add(new FaqDataModel.fromJson(v));
      });
    }
  }
}

class FaqDataModel {
  int? id;
  String? title;
  String? description;
  String? category;

  FaqDataModel({this.id, this.title, this.description, this.category});

  FaqDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
  }
}
