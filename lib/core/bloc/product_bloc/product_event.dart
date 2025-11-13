part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductInitialEvent extends ProductEvent {
  final String? filter;
  final String? catId;

  ProductInitialEvent({this.filter, this.catId});
}

class ProductLoadEvent extends ProductEvent {
  final List<ProductModel> products;

  ProductLoadEvent({required this.products});
}
