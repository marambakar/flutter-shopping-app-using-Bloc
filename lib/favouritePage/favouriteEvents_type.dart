import 'package:yamams_market/favouritePage/favourite_model.dart';
import 'package:yamams_market/service/model/product.dart';

class favouriteEvents_type{}
class fitchFavourite extends favouriteEvents_type
{
  final int customerId;
  fitchFavourite({required this.customerId});
}
class removeFromfavourite extends favouriteEvents_type
{
  final int removedId ;
  removeFromfavourite({required this.removedId});
}
class addToCardFromFavourite extends favouriteEvents_type
{Favourite_model addedProductFromFavourite;

addToCardFromFavourite({required this.addedProductFromFavourite});
}