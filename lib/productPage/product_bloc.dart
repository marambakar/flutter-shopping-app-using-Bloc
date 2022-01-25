



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/favouritePage/allFavourite_model.dart';
import 'package:yamams_market/favouritePage/favourite_bloc.dart';
import 'package:yamams_market/orderPage/allOrders_model.dart';
import 'package:yamams_market/orderPage/order_bloc.dart';
import 'package:yamams_market/orderPage/order_model.dart';
import 'package:yamams_market/orderPage/ordersView_model.dart';
import 'package:yamams_market/productPage/events_type.dart';
import 'package:yamams_market/productPage/output.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:yamams_market/productPage/productView_model.dart';
import 'package:yamams_market/service/model/product.dart';
import 'package:yamams_market/service/model/products.dart';

Products products = new Products();
orderBloc orderBlocc = new orderBloc();


class product_bloc {
  allFavourite_model fav = new allFavourite_model(favourites: []);

  allFavourite_model allfavourites = new allFavourite_model(favourites: []);
  List<productView_model> listShow = [];
  allOrders_model allOrders = new allOrders_model(orders: []);
  final Products addedProducts = new Products();
  double allTotal = 0;
  List<odersView_model> allorders = [];
  final _StateStreamController = StreamController<output>.broadcast();
  StreamSink<output> get productSink => _StateStreamController.sink;
  Stream<output> get productStream => _StateStreamController.stream;
  final _EventStreamController =
  StreamController<product_events_type>.broadcast();
  StreamSink<product_events_type> get eventSink => _EventStreamController.sink;
  Stream<product_events_type> get eventstream => _EventStreamController.stream;
  static final product_bloc product_blocc = product_bloc._product_Bloc();
  factory product_bloc() {
    return product_blocc;
  }
  product_bloc._product_Bloc() {
    eventstream.listen((event) async {
      if (event is fitch_products) {
        listShow = [];
        fav =  await fitchFavourites();

        await gitProducrts(event.storeId).then((value) {
          products = value;

          print(products.prods.length );
          if(fav.favourites.length == 0)
          {
            for(int i = 0; i <products.prods.length ; i++)
            {
              productView_model productview = new productView_model(isFavourite: false, Viewproduct: products.prods[i]);
              listShow.add(productview);
              print("id in bloc " + productview.Viewproduct.prid.toString());
              print(listShow.length.toString() + " NNNNNNNNNNNN");}
            output outputt = output(productss: listShow);
            productSink.add(outputt);
          }
          else{
            for(int i = 0; i <products.prods.length ; i++)
            {
              if(fav.favourites.any((element) => element.prid == products.prods[i].prid))
              {
                productView_model productview = new productView_model(isFavourite: true, Viewproduct: products.prods[i]);
                listShow.add(productview);
                print("here favourite equal product" + listShow.length.toString());
              }
              else
              {
                productView_model productview = new productView_model(isFavourite: false, Viewproduct: products.prods[i]);
                listShow.add(productview);}


              // else
              // {
              //   //productView_model productview2 = new productView_model(isFavourite: false, Viewproduct: products.prods[j]);
              // //  listShow.add(productview2);
              //   //print("here favourite nooooooooooot equal product" + listShow.length.toString());
              //
              // }
              output outputt = output(productss: listShow);
              productSink.add(outputt);


            }}

        });

        // allfavourites = await fitchFavourites();
        //
        // await gitProducrts(event.storeId).then((value) {
        //   products = value;
        // });
        // output outputt = output(productss: products);
        // productSink.add(outputt);
      }
      // else if (event is delete_product) {
      //   // we should always edit on  the same array
      //   products.prods
      //       .removeWhere((element) => element.prid == event.productId);
      //   output outputt = output(productss: products);
      //   productSink.add(outputt);
      // }
      else if (event is addTofavourite) {

        allfavourites = await fitchFavourites();
        print("allllllllll favourites" + allfavourites.favourites.length.toString());
        if(allfavourites.favourites.length == 0 )
        {
          var result = await addTofavouritee(
              SplashScreen.user.customer.cuid, event.Pid);
          var  allfavourites4 = await fitchFavourites();
          print("FFFFFFFFFFF" + allfavourites4.favourites.length.toString());
          if (result.statusCode == 200) {
            print("yeeeeeeeeeeeees" + result.body.toString());
          } else
            print("NNNNNNNNNNNNNNOOOOOOOOOOOO");}
        else{
          for(int i = 0 ; i<= allfavourites.favourites.length ; i++)
          {
            if (event.Pid != allfavourites.favourites[i].prid)
            {
              var result = await addTofavouritee(
                  SplashScreen.user.customer.cuid, event.Pid);
              if (result.statusCode == 200) {
                print("yeeeeeeeeeeeees" + result.body.toString());
              } else
                print("NNNNNNNNNNNNNNOOOOOOOOOOOO");
            }
          }}

      }
      else if (event is addTocard) {
        odersView_model viewModel = new odersView_model(
            dis: event.addedProduct.descriptionAr,
            imageurl: event.addedProduct.photo,
            name: event.addedProduct.nameAr,
            pId: event.addedProduct.prid,
            price: event.addedProduct.price,
            quantity: 1,
            totalPrice: event.addedProduct.price,
            check: true,
        name_en:  event.addedProduct.nameEn,
        dis_en:  event.addedProduct.descriptionEn);
// viewModel.price = event.addedProduct.price;
// viewModel.totalPrice = event.addedProduct.price;
// viewModel.quantity = 1;
// viewModel.pId = event.addedProduct.prid;
// viewModel.imageurl = event.addedProduct.photo;
// viewModel.name = event.addedProduct.nameAr;
// viewModel.dis = event.addedProduct.descriptionAr;
// viewModel.check = true;
//           for(int i =0;i<allorders.length;i++)
//             {
//               if(allorders[i].pId != viewModel.pId)
//                 {
//                 }
//             }

        if (allorders.map((item) => item.pId).contains(viewModel.pId)) {
        } else {
          allorders.add(viewModel);
          orderBloc.SaveData(product_blocc.allorders, "all_order");
          allTotal = allTotal + viewModel.price;
          print("BBBBBBBBBBBBBBBBBBBBBBBBBB" + allTotal.toString());
        }

        print("RRRRRRRRRR" + allorders.length.toString());

        //
        //  addedProducts.prods.add(event.addedProduct);
        // print("RRRRRRRRRR" +addedProducts.prods.length.toString() );
        //
        //
        //
        //
        //
        //
        //  Order_model oderModel = new Order_model();
        //  oderModel.prid = event.addedProduct.prid;
        //  oderModel.total=1;
        //  allOrders.orders.add(oderModel);
        // allOrders_model(orders: allOrders.orders);
        //  //addedProducts.prods.add(event.addedProduct);
        //  print("RRRRRRRRRR" + allOrders.orders.length.toString() );
        //  print(allOrders.orders[0].prid);
        //  print(allOrders.orders[1].prid);

      }
      else if (event is deleteProductFromFavourite)
      {
        allfavourites.favourites.removeWhere((element) => element.prid == event.productDeleted);
        await deleteFromFavourite(event.productDeleted);


      }
      else if (event is searchh) {
        var data = listShow;
        List<productView_model> _data = data.where((prod) => (prod.Viewproduct.nameAr.contains(event.content))).toList();
        output outputt2 = output(productss: _data);
        productSink.add(outputt2);
      }
    });
  }
  Future<Products> gitProducrts(int storeId) async {
    final String apiLink =
        "http://yamamstore.fingerprint.ml/api/Product/GetStoreProducts?Sid=$storeId";
    var result = await http.get(Uri.parse(apiLink));
    if (result.statusCode == 200) {
      json.decode(result.body)['dataList'];
    }
    return Products.fromJson(json.decode(result.body)['dataList']);
  }

  Future<http.Response> addTofavouritee(int customerId, int prductId) async {
    return http.post(
        Uri.parse(
            "http://yamamstore.fingerprint.ml/api/CustomerFavorite/AddCustomerFavorite"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          'CUID': customerId,
          'PRID': prductId,
          'Status': 1
        }));
  }
  Future<allFavourite_model> fitchFavourites() async {
    int customerId = SplashScreen.user.customer.cuid;
    print("RTTTTTTTTTTTTTTTTT" + SplashScreen.user.customer.cuid.toString());
    final String apiLink =
        "http://yamamstore.fingerprint.ml/api/Customer/getCustomerFavorites?Cuid=$customerId";
    var result = await http.get(Uri.parse(apiLink));
    if (result.statusCode == 200) {
      json.decode(result.body)['dataList'];
      print(json.decode(result.body)['dataList'].toString() + "FFFFFFFFFFFFFF");
    }
    return allFavourite_model.fromJson(json.decode(result.body)['dataList']) ;
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


}

