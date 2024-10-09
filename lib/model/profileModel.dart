// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(json.decode(str).map((x) => ProfileModel.fromJson(x)));

String profileModelToJson(List<ProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  String carname;
  String carimg;
  String price;
  String color;
  String id;

  ProfileModel({
    required this.carname,
    required this.carimg,
    required this.price,
    required this.color,
    required this.id,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    carname: json["carname"],
    carimg: json["carimg"],
    price: json["price"],
    color: json["color"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "carname": carname,
    "carimg": carimg,
    "price": price,
    "color": color,
    "id": id,
  };
}
