import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:yamams_market/homePage/allAdvertisment_model.dart';
import 'package:yamams_market/homePage/allCategories_model.dart';
import 'package:yamams_market/homePage/allStores_model.dart';
import 'package:yamams_market/homePage/allStores_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamams_market/homePage/events_types.dart';
import 'package:yamams_market/homePage/home_screen.dart';
import 'package:yamams_market/homePage/offer_model.dart';
import 'package:yamams_market/homePage/store_model.dart';

import 'fitch_output.dart';

allAdvertisment advertisments = new allAdvertisment(advertisments: []);
allStores stores = new allStores(stores: []);
allCategories Categories = new allCategories(categories: []);
class home_bloc {
  static final home_bloc _home_bloc = home_bloc._Home_bloc();
  factory home_bloc() {
    return _home_bloc;
  }

  //the stream for output
  final _stateStreamController = StreamController<fitch_output>.broadcast();
  StreamSink<fitch_output> get productSink => _stateStreamController.sink;
  Stream<fitch_output> get productStrem => _stateStreamController.stream;
  //the stream for event
  final _eventSteamContrller = StreamController<events_types>.broadcast();
  StreamSink<events_types> get eventSink => _eventSteamContrller.sink;
  Stream<events_types> get eventstream => _eventSteamContrller.stream;
  home_bloc._Home_bloc() {

    eventstream.listen((event) async {
      if (event is fitch) {
        try {
          await getcategories().then((value) {
            Categories = value;
          });
          await gitOffers().then((value) {
            advertisments = value;
          });
          gitStores().then((value) {
            stores = value;
          }).whenComplete(() {
            fitch_output fitchOutput1 =
            fitch_output(Categories, advertisments, stores);
            productSink.add(fitchOutput1);
            print(stores.stores.length.toString() + "###################");
          });
        } on Exception catch (e) {
          // TODO
          productSink.addError('some thing is error');
        }
      }
      else
      if (event is fitchCategoryStoress) {
        await gitCategoryStores(event.id).then((value) {
          stores = value;
        });
        await gitOffers().then((value) {
          advertisments = value;
        });
        await getcategories().then((value) {
          Categories = value;
        });
        fitch_output fitch_output2 =
        fitch_output(Categories, advertisments, stores);
        productSink.add(fitch_output2);
      }
      else if (event is search) {
        var _products = await gitStores();
        List<Store_model> data= _products.stores.where((store) => (store.nameAr.contains(event.content))).toList();
        allStores _data = new allStores(stores: data);
        var categoriess = await getcategories();
        var offerss = await gitOffers();
        fitch_output fitchOutput1 =
        fitch_output(categoriess, offerss, _data);
        print("(((((((((((((((((((((" + _data.stores   .length.toString());
        productSink.add(fitchOutput1);
      }
    });


  }

  Future<allCategories> getcategories() async {
    final String apiLink =
        "http://yamamstore.fingerprint.ml/api/Category/getAllCategory";
    var result = await http.get(Uri.parse(apiLink));
    if (result.statusCode == 200) {
      json.decode(result.body)['dataList'];
    }

    return allCategories.fromJson(json.decode(result.body)['dataList']);
  }

  Future<allAdvertisment> gitOffers() async {
    final String apiLink =
        "http://yamamstore.fingerprint.ml/api/Advertisement/getAllAdvertisement";
    var result = await http.get(Uri.parse(apiLink));
    if (result.statusCode == 200) {
      json.decode(result.body)['dataList'];
    }
    print(allAdvertisment
        .fromJson(json.decode(result.body)['dataList'])
        .Advertisments[0]
        .toJson()
        .toString());
    return allAdvertisment.fromJson(json.decode(result.body)['dataList']);
  }

  Future<allStores> gitStores() async {
    final String apiLink =
        "http://yamamstore.fingerprint.ml/api/Store/getAllStore";
    var result = await http.get(Uri.parse(apiLink));
    if (result.statusCode == 200) {
      json.decode(result.body)['dataList'];
    }
    // print("the leeength" +
    //     allStores
    //         .fromJson(json.decode(result.body)['dataList'])
    //         .stores[0]
    //         .toJson()
    //         .toString());
    return allStores.fromJson(json.decode(result.body)['dataList']);
  }

  Future<allStores> gitCategoryStores(id) async {
    print("#################" + id.toString());
    final String apiLink =
        "http://yamamstore.fingerprint.ml/api/Category/getCategoryStore?Caid=$id";
    var result = await http.get(Uri.parse(apiLink));
    if (result.statusCode == 200) {
      json.decode(result.body)['dataList'];
    }
    // print("lllllllllllllllllllllllllllll" +
    //     allStores
    //         .fromJson(json.decode(result.body)['dataList'])
    //         .stores[0]
    //         .toJson()
    //         .toString());
    // print("lllllllllllllllllllllllllllll" +
    //     allStores
    //         .fromJson(json.decode(result.body)['dataList'])
    //         .stores.length
    //         .toString());
    return allStores.fromJson(json.decode(result.body)['dataList']);
  }

  void dispose() {
    _eventSteamContrller.close();
    _stateStreamController.close();
    // if(_home_bloc._eventSteamContrller.isPaused || _home_bloc._stateStreamController.isPaused){
    //   y = false;
    // }
    // print("yyyyyyyyyyyyyyyyyyyyyyyyyy" + y.toString());
    //  _eventSteamContrller.close();
    //_stateStreamController.close();
  }
}
