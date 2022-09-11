class ShopLoginModel {
  late bool status;
  late String message;

  UserData? data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJaso(json['data']) : null;
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  UserData(
    this.credit,
    this.email,
    this.id,
    this.image,
    this.name,
    this.phone,
    this.points,
    this.token,
  );
//named constractor
  UserData.fromJaso(Map<String, dynamic> json) {
    id = json['id'];
    credit = json['credit'];
    email = json['email'];
    image = json['image'];
    name = json['name'];
    phone = json['phone'];
    points = json['points'];
    token = json['token'];
  }
}
