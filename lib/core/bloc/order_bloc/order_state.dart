part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class OrderLoad extends OrderState {
  final List<SaleModel> sales;

  OrderLoad({required this.sales});
}
