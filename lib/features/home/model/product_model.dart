import 'package:market_student/features/profile/model/profile_model.dart';

class ProductModel {
  final int? id;
  final String? name;
  final int? price;
  final List<dynamic>? image;
  final String? description;
  final DateTime? createdAt;
  final String? category;

  final ProfileModel? user;
  final String? status;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.description,

    this.category,

    this.user,
    this.createdAt,
    this.status,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    name: json['name'],
    price: int.parse(json['price']),
    image: json['images'] as List<dynamic>,
    description: json['description'],

    category: json['category'],

    user: ProfileModel().fromJson(json['tb_user']),
    createdAt: DateTime.parse(json['created_at']),
    status: json['status'],
  );
}
