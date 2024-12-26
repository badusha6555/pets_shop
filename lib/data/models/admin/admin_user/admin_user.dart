class AdminUser {
  String? status;
  String? message;
  List<Data>? data;

  AdminUser({this.status, this.message, this.data});

  AdminUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['status'] = status;
  //   data['message'] = message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Data {
  String? sId;
  String? name;
  String? username;
  String? email;
  String? password;
  Null token;
  List<String>? cart;
  List<String>? wishlist;
  int? iV;

  Data(
      {this.sId,
      this.name,
      this.username,
      this.email,
      this.password,
      this.token,
      this.cart,
      this.wishlist,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    cart = json['cart'].cast<String>();
    wishlist = json['wishlist'].cast<String>();
    iV = json['__v'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['_id'] = sId;
  //   data['name'] = name;
  //   data['username'] = username;
  //   data['email'] = email;
  //   data['password'] = password;
  //   data['token'] = token;
  //   data['cart'] = cart;
  //   data['wishlist'] = wishlist;
  //   data['__v'] = iV;
  //   return data;
  // }
}
