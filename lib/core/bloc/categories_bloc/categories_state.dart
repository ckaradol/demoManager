part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

class CategoriesLoad extends CategoriesState {
  final List<CategoryModel> categories;

  CategoriesLoad({required this.categories});
}

class CategoriesError extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}
