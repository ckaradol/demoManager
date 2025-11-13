import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String docId;
  final String name;

  const CategoryModel({required this.docId, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json, String documentId) {
    return CategoryModel(docId: documentId, name: json["name"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"name": name};
  }

  @override
  List<Object?> get props => [docId, name];
}
