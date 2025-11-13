import 'package:bloc/bloc.dart';
import 'package:demomanager/core/models/product_model.dart';
import 'package:demomanager/core/services/firestore_service/firestore_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  String? filter;
  String? docId;

  ProductBloc() : super(ProductInitial()) {
    on<ProductInitialEvent>((event, emit) {
      if(!(event.filter==null&&event.catId==null)) {
        filter = event.filter ?? filter;
        docId = event.catId ?? docId;
      }else{
        filter=null;
        docId=null;
      }
      FirestoreService().productsSnapshotStream(catId: docId!="all"?docId:null, fields:filter).listen((value) {
        add(ProductLoadEvent(products: value ?? []));
      });
    });
    on<ProductLoadEvent>((event, emit) {
      emit(ProductLoad(products: event.products));
    });
  }
}
