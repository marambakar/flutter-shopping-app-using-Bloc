import 'category_model.dart';
class allCategories{
  List<Category_model> Categories = [];
  allCategories({
    required List<Category_model> categories
  })
  {
    this.Categories = categories;
  }
  List<Category_model> get categories => Categories;
  set categories(List<Category_model> categoriess) => Categories = categoriess;
  factory allCategories.fromJson(List<dynamic> json) => allCategories(
      categories: List<Category_model>.from(json.map((x) => Category_model.fromJson(x))));
}