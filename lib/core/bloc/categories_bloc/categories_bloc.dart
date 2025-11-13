import 'package:bloc/bloc.dart';
import 'package:demomanager/core/models/categories_model.dart';
import 'package:demomanager/core/services/firestore_service/firestore_service.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesInitialEvent>((event, emit) {
      FirestoreService().categorySnapshotStream().listen((value) {
        add(CategoriesLoadEvent(categories: value ?? []));
      });
    });
    on<CategoriesLoadEvent>((event, emit) {
      emit(CategoriesLoad(categories: event.categories));
    });
  }
}
