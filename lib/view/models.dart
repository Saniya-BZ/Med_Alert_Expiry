// import 'dart:convert';
//
// List<PostsModel> postsModelFromJson(String str) => List<PostsModel>.from(json.decode(str).map((x) => PostsModel.fromJson(x)));
//
// String postsModelToJson(List<PostsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class PostsModel {
//   String id;
//   List<Medicine> medicine;
//
//   PostsModel({
//     required this.id,
//     required this.medicine,
//   });
//
//   factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
//     id: json["_id"],
//     medicine: List<Medicine>.from(json["medicine"].map((x) => Medicine.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "medicine": List<dynamic>.from(medicine.map((x) => x.toJson())),
//   };
// }
//
// class Medicine {
//   int id;
//   String name;
//   String type;
//   String description;
//   String dosage;
//   String price;
//
//   Medicine({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.description,
//     required this.dosage,
//     required this.price,
//   });
//
//   factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
//     id: json["id"],
//     name: json["name"],
//     type: json["type"],
//     description: json["description"],
//     dosage: json["dosage"],
//     price: json["price"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "type": type,
//     "description": description,
//     "dosage": dosage,
//     "price": price,
//   };
// }