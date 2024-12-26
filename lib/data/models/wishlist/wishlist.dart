class WishList {
  String? status;
  List<Data>? data;

  WishList({this.status, this.data});

  WishList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  // Null? weight;
  String? size;
  List<String>? productDescription;
  double? sideImg;
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
      // this.weight,
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
    template = json['template'].cast<String>();
    productName = json['productName'];
    actualPrice = (json['actualPrice'] is int)
        ? (json['actualPrice'] as int).toDouble()
        : json['actualPrice']?.toDouble();

    size = json['size'];
    productDescription = json['productDescription'].cast<String>();
    sideImg = (json['sideImg'] is int)
        ? (json['sideImg'] as int).toDouble()
        : json['sideImg']?.toDouble();
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
    // data['weight'] = weight;
    data['size'] = size;
    data['productDescription'] = productDescription;
    data['sideImg'] = sideImg;
    data['key'] = key;
    data['id'] = id;
    return data;
  }
}
