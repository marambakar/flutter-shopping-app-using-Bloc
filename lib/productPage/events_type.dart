import 'package:yamams_market/service/model/product.dart';

class product_events_type
{}
class fitch_products extends product_events_type
{
  int storeId;
  fitch_products({required this.storeId});
}
class delete_product extends product_events_type{
  int productId;
  int storeId;
  delete_product({required this.productId , required this.storeId});
}
class addTofavourite extends product_events_type
{
  int Cid;
  int Pid;
  addTofavourite({required this.Cid,required this.Pid});
}
class addTocard extends product_events_type
{
  Product addedProduct;

  addTocard({required this.addedProduct});
}
class deleteProductFromFavourite extends product_events_type
{
  int productDeleted ;
  deleteProductFromFavourite({required this.productDeleted});
}
class searchh extends product_events_type {
  final String content;
  searchh({required this.content});
}