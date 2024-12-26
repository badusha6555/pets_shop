class Product {
  String? status;
  List<Data>? data;

  Product({this.status, this.data});

  Product.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = (json['data'] as List<dynamic>)
          .map((item) => Data.fromJson(item))
          .toList();
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? category;
  String? src;
  String? link;
  List<String>? template;
  String? productName;
  double? actualPrice;
  String? size;
  List<String>? productDescription;
  int? sideImg;
  String? key;
  String? id;

  Data(
      {this.sId,
      this.title,
      this.category,
      this.src,
      this.link,
      this.template,
      this.productName,
      this.actualPrice,
      this.size,
      this.productDescription,
      this.sideImg,
      this.key,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    category = json['category'];
    src = json['src'];
    link = json['link'];
    template = json['template']?.cast<String>();
    productName = json['productName'];
    actualPrice = (json['actualPrice'] is int)
        ? (json['actualPrice'] as int).toDouble()
        : json['actualPrice'];
    size = json['size'];
    productDescription = json['productDescription']?.cast<String>();
    sideImg = json['sideImg'];
    key = json['key'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['category'] = category;
    data['src'] = src;
    data['link'] = link;
    data['template'] = template;
    data['productName'] = productName;
    data['actualPrice'] = actualPrice;
    data['size'] = size;
    data['productDescription'] = productDescription;
    data['sideImg'] = sideImg;
    data['key'] = key;
    data['id'] = id;
    return data;
  }
}
