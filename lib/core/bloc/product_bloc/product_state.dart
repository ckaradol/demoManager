part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {}

final class ProductInitial extends ProductState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductLoad extends ProductState {
  final List<ProductModel> products;

  ProductLoad({required this.products});

  @override
  List<Object?> get props => [products];
}
