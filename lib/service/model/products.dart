import 'package:yamams_market/service/model/product.dart';

class Products {
  List<Product>? _prodcts;

  Products({
    List<Product>?Prods
  })
  {
    this._prodcts = Prods;
    if(Prods==null){
      this._prodcts=<Product>[];
    }
  }
  List<Product> get prods => _prodcts!;
  set posts(List<Product> prodss) => _prodcts = prodss;

  factory Products.fromJson(List<dynamic> json) => Products(
      Prods: List<Product>.from(json.map((x) => Product.fromJson(x))));
}