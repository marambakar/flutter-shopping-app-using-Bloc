import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/favouritePage/allFavourite_model.dart';
import 'package:yamams_market/favouritePage/favouriteEvents_type.dart';
import 'package:yamams_market/favouritePage/favouriteOutput.dart';
import 'package:yamams_market/homePage/allAdvertisment_model.dart';
import 'package:yamams_market/homePage/allCategories_model.dart';
import 'package:yamams_market/homePage/allStores_model.dart';
import 'package:yamams_market/homePage/allStores_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamams_market/homePage/events_types.dart';
import 'package:yamams_market/homePage/home_screen.dart';
import 'package:yamams_market/homePage/offer_model.dart';
import 'package:yamams_market/orderPage/ordersView_model.dart';
import 'package:yamams_market/productPage/product_bloc.dart';

late allFavourite_model allfavourites;

class favourite_bloc {
  static final favourite_bloc _home_bloc = favourite_bloc._favourite_bloc();
  product_bloc producrBloc = new product_bloc();
  factory favourite_bloc() {
    return _home_bloc;
  }
  //the stream for output
  final _stateStreamController = StreamController<favouriteoutput>.broadcast();
  StreamSink<favouriteoutput> get favouriteSink => _stateStreamController.sink;
  Stream<favouriteoutput> get favouriteStrem => _stateStreamController.stream;
  //the stream for event
  final _eventSteamContrller =
  StreamController<favouriteEvents_type>.broadcast();
  StreamSink<favouriteEvents_type> get eventSink => _eventSteamContrller.sink;
  Stream<favouriteEvents_type> get eventstream => _eventSteamContrller.stream;
  favourite_bloc._favourite_bloc() {
    eventstream.listen((event) async {
      if (event is fitchFavourite) {
        allfavourites = await fitchFavourites();
        print("&&&&&&&&&&&&&" +
            allfavourites.favourites.length.toString() +
            SplashScreen.user.customer.cuid.toString());
        favouriteoutput favouriteoutputt = favouriteoutput(allfavourites);
        favouriteSink.add(favouriteoutputt);
      }
      else if (event is removeFromfavourite) {
        //   allfavourites = await fitchFavourites();
        allfavourites.favourites.removeWhere((element) => element.prid == event.removedId);
        favouriteoutput favouriteoutputt2 = favouriteoutput(allfavourites);
        favouriteSink.add(favouriteoutputt2);
        await deleteFromFavourite(event.removedId);

      }
      else if (event is addToCardFromFavourite)

      {
        odersView_model viewModel = new odersView_model(
            dis: "",
            imageurl: event.addedProductFromFavourite.photo,
            name: event.addedProductFromFavourite.nameAr,
            pId: event.addedProductFromFavourite.prid,
            price: event.addedProductFromFavourite.price,
            quantity: 1,
            totalPrice: event.addedProductFromFavourite.price,check: true,
          name_en: event.addedProductFromFavourite.nameAr,
          dis_en: "",
        );


        if(producrBloc.allorders.map((item) => item.pId).contains(viewModel.pId))
        {

        }
        else{
          producrBloc.allorders.add(viewModel);
          producrBloc.allTotal = producrBloc.allTotal + viewModel.price;
          print("BBBBBBBBBBBBBBBBBBBBBBBBBB" + producrBloc.allTotal.toString());
        }




      }

    });
  }

  Future<allFavourite_model> fitchFavourites() async {
    int customerId = SplashScreen.user.customer.cuid;
    print("RTTTTTTTTTTTTTTTTT" + SplashScreen.user.customer.cuid.toString());
    final String apiLink =
        "http://yamamstore.fingerprint.ml/api/Customer/getCustomerFavorites?Cuid=$customerId";
    var result = await http.get(Uri.parse(apiLink));
    if (result.statusCode == 200) {
      json.decode(result.body)['dataList'];
      print(json.decode(result.body)['dataList'].toString());
    }
    return allFavourite_model.fromJson(json.decode(result.body)['dataList']);
  }

  Future<http.Response> deleteFromFavourite(int productDeleted) async {
    int customerId = SplashScreen.user.customer.cuid;

    return http.post(
      Uri.parse(
          "http://yamamstore.fingerprint.ml/api/CustomerFavorite/deleteProductFavorite?Cuid=$customerId&Prid=$productDeleted"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  void dispose() {
    _eventSteamContrller.close();
    _stateStreamController.close();
  }
}
