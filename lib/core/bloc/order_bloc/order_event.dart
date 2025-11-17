part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}
class OrderInitialEvent extends OrderEvent{
  final String userId;
  final bool sale;
  final String? region;

  OrderInitialEvent({required this.userId,this.sale=false,this.region});
}
class OrderLoadEvent extends OrderEvent{
  final List<SaleModel> sales;

  OrderLoadEvent({required this.sales});
}