import 'package:yamams_market/favouritePage/favourite_model.dart';

class allFavourite_model {
  List<Favourite_model> Favourites = [];
  allFavourite_model({
    required List<Favourite_model> favourites,
  }) {
    this.Favourites = favourites;
  }
  List<Favourite_model> get favourites => Favourites;
  set favourites(List<Favourite_model> favouritess) => Favourites = favouritess;
  factory allFavourite_model.fromJson(List<dynamic> json) => allFavourite_model(
      favourites: List<Favourite_model>.from(
          json.map((x) => Favourite_model.fromJson(x)
          )
      )
  );
}
