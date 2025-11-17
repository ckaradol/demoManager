import 'product_model.dart';

class SaleModel {
  final String id;
  final String userId;
  final String productId;
  final String region;
  final DateTime createdDate;
  final int count;
  final ProductModel? product; // 🔹 ilişkilendirilmiş ürün

  SaleModel( {
  required  this.createdDate,
    required this.id,
    required this.userId,
    required this.productId,
    required this.region,
    required this.count,
    this.product,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json, String id, {ProductModel? product}) {
    return SaleModel(
      id: id,
      createdDate:json['createdAt']!=null?DateTime.parse(json['createdAt']):DateTime.now() ,
      userId: json['userId'] ?? '',
      productId: json['productId'] ?? '',
      region: json['region'] ?? '',
      count: json['count'] is int ? json['count'] : int.tryParse(json['count'].toString()) ?? 0,
      product: product,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'region': region,
      'count': count,
    };
  }
}
