import 'package:demomanager/core/models/product_attributes.dart';
import 'package:demomanager/core/models/region_distribution_model.dart';
import 'package:demomanager/core/models/stock_model.dart';
import 'package:equatable/equatable.dart';

import 'commission_model.dart';

class ProductModel extends Equatable {
  final String id;
  final String docId;
  final String name;
  final String category;
  final String description;
  final double price;
  final String currency;
  final List<String> images;
  final String unit;
  final Stock stock;
  final RegionDistribution regionDistribution;
  final Commission commission;
  final ProductAttributes attributes;
  final String status;

  const ProductModel({
    required this.docId,
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.currency,
    required this.images,
    required this.unit,
    required this.stock,
    required this.regionDistribution,
    required this.commission,
    required this.attributes,
    required this.status,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map,String docId) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      currency: map['currency'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      unit: map['unit'] ?? '',
      stock: Stock.fromMap(map['stock'] ?? {}),
      regionDistribution: RegionDistribution.fromMap(map['regionDistribution'] ?? {}),
      commission: Commission.fromMap(map['commission'] ?? {}),
      attributes: ProductAttributes.fromMap(map['attributes'] ?? {}),
      status: map['status'] ?? 'inactive', docId: docId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "description": description,
      "price": price,
      "currency": currency,
      "images": images,
      "unit": unit,
      "stock": stock.toMap(),
      "regionDistribution": regionDistribution.toMap(),
      "commission": commission.toMap(),
      "attributes": attributes.toMap(),
      "status": status,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, category, price, description, images, unit, stock, status, regionDistribution, commission, attributes];
}
