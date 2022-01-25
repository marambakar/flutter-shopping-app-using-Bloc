import 'store_model.dart';
class allStores{
  List<Store_model> Stores = [];
  allStores ({
    required List<Store_model> stores
  })
  {
    this.Stores = stores;
  }
  List<Store_model> get stores => Stores;
  set stores(List<Store_model> storess) => Stores = storess;
  factory allStores.fromJson(List<dynamic> json) => allStores(
      stores: List<Store_model>.from(json.map((x) => Store_model.fromJson(x))));
}