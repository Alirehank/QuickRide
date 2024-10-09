// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'dart:convert';

List<CarModel> carModelFromJson(String str) => List<CarModel>.from(json.decode(str).map((x) => CarModel.fromJson(x)));

String carModelToJson(List<CarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarModel {
  String name;
  String ownerimg;
  String owner;
  String carname;
  String color;
  int price;
  String image;
  String id;

  CarModel({
    required this.name,
    required this.ownerimg,
    required this.owner,
    required this.carname,
    required this.color,
    required this.price,
    required this.image,
    required this.id,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    name: json["name"],
    ownerimg: json["ownerimg"],
    owner: json["owner"],
    carname: json["carname"],
    color: json["color"],
    price: json["price"],
    image: json["image"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "ownerimg": ownerimg,
    "owner": owner,
    "carname": carname,
    "color": color,
    "price": price,
    "image": image,
    "id": id,
  };
}
