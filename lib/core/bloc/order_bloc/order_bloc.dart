import 'package:bloc/bloc.dart';
import 'package:demomanager/core/models/sale_model.dart';
import 'package:demomanager/core/services/firestore_service/firestore_service.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderInitialEvent>((event, emit) {
      FirestoreService().salesSnapshotStream(event.userId,sale: event.sale,region: event.region).listen((value) {
        add(OrderLoadEvent(sales: value));
      });
    });
    on<OrderLoadEvent>((event, emit) {
      emit(OrderLoad(sales: event.sales));
    });
  }
}
