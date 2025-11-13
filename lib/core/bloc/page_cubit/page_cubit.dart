import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<int> {
  PageCubit() : super(0);
  PageController controller=PageController();
  void setPage(int page) {
    controller.jumpToPage(page);
    emit(page);
  }
}
