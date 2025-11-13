part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}
class CategoriesInitialEvent extends CategoriesEvent{}
class CategoriesLoadEvent extends CategoriesEvent{
  final List<CategoryModel> categories;

  CategoriesLoadEvent({required this.categories});
}