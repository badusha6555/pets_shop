class AdminProductsss {
  String? status;
  String? message;
  List<Data>? data;

  AdminProductsss({
    this.status,
    this.message,
    this.data,
  });

  AdminProductsss.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? src;
  List<dynamic>? template;
  List<dynamic>? productDescription;
  int? v;

  Data({
    this.id,
    this.src,
    this.template,
    this.productDescription,
    this.v,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    src = json['src'];
    template = json['template'].cast<dynamic>();
    productDescription = json['productDescription'].cast<dynamic>();
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['src'] = src;
    data['template'] = template;
    data['productDescription'] = productDescription;

    return data;
  }
}
