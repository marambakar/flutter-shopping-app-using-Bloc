// import 'dart:async';
// import 'dart:convert';
// import 'dart:core';
// import 'package:http/http.dart' as http;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yamams_market/homePage/offer_model.dart';
// import 'package:yamams_market/orderPage/allOrders_model.dart';
// import 'package:yamams_market/orderPage/order_model.dart';
// import 'package:yamams_market/orderPage/event_types.dart';
// import 'package:yamams_market/orderPage/order_outbut.dart';
// import 'package:yamams_market/orderPage/ordersView_model.dart';
// import 'package:yamams_market/paymentPage/event_payment.dart';
// import 'package:yamams_market/paymentPage/payment_bloc.dart';
// import 'package:yamams_market/productPage/product_bloc.dart';
// import 'package:yamams_market/service/model/products.dart';
//
// enum orderEvents { Fetch, Delete, Search }
// String query = '';
// product_bloc product_blocc = product_bloc();
// Products finalProducts = new Products();
// allOrders_model finalOrders = new allOrders_model(orders: []);
// List<odersView_model> finalUnshowOrders = [];
//
// class orderBloc {
//
//   static final orderBloc _orderBloc = orderBloc._internal();
//
//
//   factory orderBloc() {
//     return _orderBloc;
//   }
//
//   final _stateStremController = StreamController<order_outbut>.broadcast();
//   StreamSink<order_outbut> get _sinkOrder => _stateStremController.sink;
//   Stream<order_outbut> get productStrem => _stateStremController.stream;
//
//   final _eventStreamController = StreamController<eventt>.broadcast();
//   StreamSink<eventt> get eventSink => _eventStreamController.sink;
//   Stream<eventt> get eventStream => _eventStreamController.stream;
//   // PaymntBloc? pam;
//   orderBloc._internal() {
//     //  pam= PaymntBloc();
//     eventStream.listen((event) async {
//       {
//           // var orderss = await gitOrders();
//           // order_outbut outbut = order_outbut(allorders: orderss);
//           // _sinkOrder.add(outbut);
//           // print(orderss.prods.length);
//           // for(int i = 0 ; i<orderss.prods.length ; i++)
//           //   {          print(orderss.prods[i].prid);
//           //   }
//           if (event is Fitch) {
//
//          await getdara("all_order");
//           order_outbut outbut = order_outbut(allorders: product_blocc.allorders);
//           _sinkOrder.add(outbut);
//
//         }
//         // else if (event is Search) {
//         //   var orderss1 = await gitOrders();
//         //   var orders2 = orderss1.where((order) {
//         //     //here we define the thing we need to search depend on it
//         //     final name = order.name.contains(event.content);
//         //     // final price = order.price.contains(event.content);
//         //     return name;
//         //   }).toList();
//         //   //
//         //   _sinkOrder.add(orders2);
//         // }
//         else if (event is Delete) {
//
//
//
//           product_blocc.allorders
//               .removeWhere((element) => element.pId == event.id);
//           finalUnshowOrders.removeWhere((element) => element.pId == event.id);
//           finalOrders.orders.removeWhere((element) => element.prid == event.id);
//           SaveData(product_blocc.allorders, "all_order");
//           order_outbut outbutAfterDelete =
//           order_outbut(allorders: product_blocc.allorders);
//           _sinkOrder.add(outbutAfterDelete);
//         }
//         else if (event is deleteFromPayments) {
//           for (int i = 0; i < product_blocc.allorders.length; i++) {
//             if (product_blocc.allorders[i].pId == event.deletedOrder) {
//               product_blocc.allorders[i].check = false;
//
//             }
//             print("firstonr" +product_blocc.allorders[i].check.toString());
//             SaveData(product_blocc.allorders, "all_order");
//           }
//
//
//         }
//         else if (event is addedToPayments) {
//           for (int i = 0; i < product_blocc.allorders.length; i++) {
//             if (product_blocc.allorders[i].pId == event.addedOrder) {
//               product_blocc.allorders[i].check = true;
//
//             }
//             print("adddddddddd" +product_blocc.allorders[i].check.toString());
//             SaveData(product_blocc.allorders, "all_order");
//
//           }
//         }
//         else if(event is checkAll)
//         {
//           for(int i = 0 ;i<product_blocc.allorders.length ; i++)
//           {
//             if(product_blocc.allorders[i].check == false){
//               product_blocc.allorders[i].check = true;
//               product_blocc.allTotal = product_blocc.allTotal + product_blocc.allorders[i].totalPrice;
//               print("checl alllllll" + product_blocc.allorders[i].check.toString());
//             }
//
//           }
//           SaveData(product_blocc.allorders, "all_order");
//
//         }
//         else if(event is updateQuantity)
//         {
//           for(int i = 0 ;i<product_blocc.allorders.length ; i++)
//           {
//             if(product_blocc.allorders[i].pId == event.orderQuantity)
//             {
//               product_blocc.allorders[i].quantity =  product_blocc.allorders[i].quantity + 1;
//             }
//             print("quantity alllllll" + product_blocc.allorders[i].quantity.toString());
//             print("quantity alllllll" + product_blocc.allorders[i].pId.toString());
//
//           }
//           SaveData(product_blocc.allorders, "all_order");
//
//         }
//         else if(event is updateQuantity2)
//         {
//           for(int i = 0 ;i<product_blocc.allorders.length ; i++)
//           {
//             if(product_blocc.allorders[i].pId == event.orderQuantity2)
//             {
//               product_blocc.allorders[i].quantity =  product_blocc.allorders[i].quantity - 1;
//             }
//             print("quantity alllllll" + product_blocc.allorders[i].quantity.toString());
//             print("quantity alllllll" + product_blocc.allorders[i].pId.toString());
//
//           }
//           SaveData(product_blocc.allorders, "all_order");
//
//         }
//
//         else if(event is updateTotalPrice)
//         {
//           for(int i = 0 ;i<product_blocc.allorders.length ; i++)
//           {
//             if(product_blocc.allorders[i].pId == event.orderPrice)
//             {
//               product_blocc.allorders[i].totalPrice =  product_blocc.allorders[i].totalPrice + product_blocc.allorders[i].price;
//             }
//             print("alllll total in order" + product_blocc.allTotal.toString());
//             print(" alllllll price" + product_blocc.allorders[i].totalPrice.toString());
//             print("alllllll price" + product_blocc.allorders[i].totalPrice.toString());
//
//           }
//           PaymntBloc payBloc=PaymntBloc();
//           payBloc.eventSink.add(addsum());
//           SaveData(product_blocc.allorders, "all_order");
//
//         }
//         else if(event is updateTotalPrice2)
//         {
//           for(int i = 0 ;i<product_blocc.allorders.length ; i++)
//           {
//             if(product_blocc.allorders[i].pId == event.orderPrice)
//             {
//               product_blocc.allorders[i].totalPrice =  product_blocc.allorders[i].totalPrice - product_blocc.allorders[i].price;
//             }
//             print(" alllllll price" + product_blocc.allorders[i].totalPrice.toString());
//             print("alllllll price" + product_blocc.allorders[i].totalPrice.toString());
//
//           }
//           PaymntBloc payBloc=PaymntBloc();
//           payBloc.eventSink.add(addsum());
//           SaveData(product_blocc.allorders, "all_order");
//
//         }
//         else if(event is finalOrder)
//         {
//           finalUnshowOrders=[];
//           finalOrders.orders=[];
//           for(int i =0 ; i<product_blocc.allorders.length ;i++)
//           {
//             if(product_blocc.allorders[i].check == true)
//             {
//               finalUnshowOrders.add(product_blocc.allorders[i]);
//               print("nivooo check"+product_blocc.allorders[i].check.toString());
//               Order_model lastOrder = new Order_model();
//               lastOrder.prid = product_blocc.allorders[i].pId;
//               lastOrder.total = product_blocc.allorders[i].totalPrice;
//               lastOrder.quantity = product_blocc.allorders[i].quantity;
//               finalOrders.orders.add(lastOrder);
//
//             }
//
//
//           }
//
//
//
//           print( finalOrders.orders.length.toString() + "kkkkkkkkkkkkkk");
//           // print( finalOrders.orders[0].toString() + "kkkkkkkkkkkkkk");
//           // print( finalOrders.orders[1].toString() + "kkkkkkkkkkkkkk");
//
//
//           // pam!.stateStremPayController.sink.add( StatePaymentclass.instancStateordr);
//         }
//         else if(event is deleteAll)
//         {
//
//           product_blocc.allorders.clear();
//           print("afteeeer delete" + product_blocc.allorders.length.toString());
//           SaveData(product_blocc.allorders, "all_order");
//
//         }
//       }
//     });
//   }
//   Future<List<odersView_model>> gitOrders() async {
//     print("git all orders" + product_blocc.allorders.length.toString());
//     return product_blocc.allorders;
//   }
//
//
//
//   void dispose() {
//     // _eventStreamController.close();
//     // _stateStremController.close();
//   }
//
//      static Future<void> SaveData(List temp,String name) async {
//     print("in shared"+  temp.map((i) => json.encode(i.toJson())).toList().toString());
//     List<String> strList = temp.map((i) => json.encode(i.toJson())).toList();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList(name, strList);
//
//
//   }
//   getdara(String nam)
//   async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//         List<String>? savedStrList = prefs.getStringList(nam);
//         print("loooooooooooool shared"+savedStrList.toString());
//         if(savedStrList!=null)
//       {
//         product_blocc.allorders= List<odersView_model>.from(savedStrList.map((x) => odersView_model.fromJson(jsonDecode(x))));
//       }
//
//        // print("loooooooooooool22 shared"+product_blocc.allorders[0].toJson().toString());
//
//
//     }
//   static Future<void>  removeData(String name)
//   async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(name);
//   }
// }
//
//
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamams_market/homePage/offer_model.dart';
import 'package:yamams_market/orderPage/allOrders_model.dart';
import 'package:yamams_market/orderPage/order_model.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/order_outbut.dart';
import 'package:yamams_market/orderPage/ordersView_model.dart';
import 'package:yamams_market/paymentPage/event_payment.dart';
import 'package:yamams_market/paymentPage/payment_bloc.dart';
import 'package:yamams_market/productPage/product_bloc.dart';
import 'package:yamams_market/service/model/products.dart';

enum orderEvents { Fetch, Delete, Search }
String query = '';
product_bloc product_blocc = product_bloc();
Products finalProducts = new Products();
allOrders_model finalOrders = new allOrders_model(orders: []);
List<odersView_model> finalUnshowOrders = [];

class orderBloc {

  static final orderBloc _orderBloc = orderBloc._internal();


  factory orderBloc() {
    return _orderBloc;
  }

  final _stateStremController = StreamController<order_outbut>.broadcast();
  StreamSink<order_outbut> get _sinkOrder => _stateStremController.sink;
  Stream<order_outbut> get productStrem => _stateStremController.stream;

  final _eventStreamController = StreamController<eventt>.broadcast();
  StreamSink<eventt> get eventSink => _eventStreamController.sink;
  Stream<eventt> get eventStream => _eventStreamController.stream;
  // PaymntBloc? pam;
  orderBloc._internal() {
    //  pam= PaymntBloc();
    eventStream.listen((event) async {
      {
        if (event is Fitch) {

         await getdara("all_order");
          order_outbut outbut = order_outbut(allorders: product_blocc.allorders);
          _sinkOrder.add(outbut);

        }
        // else if (event is Search) {
        //   var orderss1 = await gitOrders();
        //   var orders2 = orderss1.where((order) {
        //     //here we define the thing we need to search depend on it
        //     final name = order.name.contains(event.content);
        //     // final price = order.price.contains(event.content);
        //     return name;
        //   }).toList();
        //   //
        //   _sinkOrder.add(orders2);
        // }
        else if (event is Delete) {
          product_blocc.allorders
              .removeWhere((element) => element.pId == event.id);
          finalUnshowOrders.removeWhere((element) => element.pId == event.id);
          finalOrders.orders.removeWhere((element) => element.prid == event.id);
          SaveData(product_blocc.allorders, "all_order");
          order_outbut outbutAfterDelete =
          order_outbut(allorders: product_blocc.allorders);
          _sinkOrder.add(outbutAfterDelete);


        }
        else if (event is deleteFromPayments) {

          for (int i = 0; i < product_blocc.allorders.length; i++) {
            if (product_blocc.allorders[i].pId == event.deletedOrder) {
              product_blocc.allorders[i].check = false;

            }
            print("firstonr" +product_blocc.allorders[i].check.toString());
            SaveData(product_blocc.allorders, "all_order");
          }



        }
        else if (event is addedToPayments) {
          for (int i = 0; i < product_blocc.allorders.length; i++) {
            if (product_blocc.allorders[i].pId == event.addedOrder) {
              product_blocc.allorders[i].check = true;

            }
            print("adddddddddd" +product_blocc.allorders[i].check.toString());
            SaveData(product_blocc.allorders, "all_order");

          }

        }
        else if(event is checkAll)
        {
          for(int i = 0 ;i<product_blocc.allorders.length ; i++)
          {
            if(product_blocc.allorders[i].check == false){
              product_blocc.allorders[i].check = true;
              product_blocc.allTotal = product_blocc.allTotal + product_blocc.allorders[i].totalPrice;
              print("checl alllllll" + product_blocc.allorders[i].check.toString());
            }

          }
          SaveData(product_blocc.allorders, "all_order");



        }
        else if(event is updateQuantity)
        {
          for(int i = 0 ;i<product_blocc.allorders.length ; i++)
          {
            if(product_blocc.allorders[i].pId == event.orderQuantity)
            {
              product_blocc.allorders[i].quantity =  product_blocc.allorders[i].quantity + 1;
            }
            print("quantity alllllll" + product_blocc.allorders[i].quantity.toString());
            print("quantity alllllll" + product_blocc.allorders[i].pId.toString());

          }
          SaveData(product_blocc.allorders, "all_order");


        }
        else if(event is updateQuantity2)
        {
          for(int i = 0 ;i<product_blocc.allorders.length ; i++)
          {
            if(product_blocc.allorders[i].pId == event.orderQuantity2)
            {
              product_blocc.allorders[i].quantity =  product_blocc.allorders[i].quantity - 1;
            }
            print("quantity alllllll" + product_blocc.allorders[i].quantity.toString());
            print("quantity alllllll" + product_blocc.allorders[i].pId.toString());

          }
          SaveData(product_blocc.allorders, "all_order");



        }

        else if(event is updateTotalPrice)
        {

          for(int i = 0 ;i<product_blocc.allorders.length ; i++)
          {
            if(product_blocc.allorders[i].pId == event.orderPrice)
            {
              product_blocc.allorders[i].totalPrice =  product_blocc.allorders[i].totalPrice + product_blocc.allorders[i].price;
            }
            print("alllll total in order" + product_blocc.allTotal.toString());
            print(" alllllll price" + product_blocc.allorders[i].totalPrice.toString());
            print("alllllll price" + product_blocc.allorders[i].totalPrice.toString());

          }
          PaymntBloc payBloc=PaymntBloc();
          payBloc.eventSink.add(addsum());
          SaveData(product_blocc.allorders, "all_order");
        }
        else if(event is updateTotalPrice2)
        {
          for(int i = 0 ;i<product_blocc.allorders.length ; i++)
          {
            if(product_blocc.allorders[i].pId == event.orderPrice)
            {
              product_blocc.allorders[i].totalPrice =  product_blocc.allorders[i].totalPrice - product_blocc.allorders[i].price;
            }
            print(" alllllll price" + product_blocc.allorders[i].totalPrice.toString());
            print("alllllll price" + product_blocc.allorders[i].totalPrice.toString());

          }
          PaymntBloc payBloc=PaymntBloc();
          payBloc.eventSink.add(addsum());
          SaveData(product_blocc.allorders, "all_order");
        }
        else if(event is finalOrder)
        {
          finalUnshowOrders=[];
          finalOrders.orders=[];
          for(int i =0 ; i<product_blocc.allorders.length ;i++)
          {
            if(product_blocc.allorders[i].check == true)
            {
              finalUnshowOrders.add(product_blocc.allorders[i]);
              print("nivooo check"+product_blocc.allorders[i].check.toString());
              Order_model lastOrder = new Order_model();
              lastOrder.prid = product_blocc.allorders[i].pId;
              lastOrder.total = product_blocc.allorders[i].totalPrice;
              lastOrder.quantity = product_blocc.allorders[i].quantity;
              finalOrders.orders.add(lastOrder);

            }


          }



          print( finalOrders.orders.length.toString() + "kkkkkkkkkkkkkk");
          // print( finalOrders.orders[0].toString() + "kkkkkkkkkkkkkk");
          // print( finalOrders.orders[1].toString() + "kkkkkkkkkkkkkk");


          // pam!.stateStremPayController.sink.add( StatePaymentclass.instancStateordr);
        }

        else if(event is deleteAll)
        {

          product_blocc.allorders.clear();
          print("afteeeer delete" + product_blocc.allorders.length.toString());
          SaveData(product_blocc.allorders, "all_order");
        }
      }
    });
  }
  Future<List<odersView_model>> gitOrders() async {
    print("git all orders" + product_blocc.allorders.length.toString());
    return product_blocc.allorders;
  }



  void dispose() {
    // _eventStreamController.close();
    // _stateStremController.close();
  }


     static Future<void> SaveData(List temp,String name) async {
    print("in shared"+  temp.map((i) => json.encode(i.toJson())).toList().toString());
    List<String> strList = temp.map((i) => json.encode(i.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(name, strList);


  }
  getdara(String nam)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

        List<String>? savedStrList = prefs.getStringList(nam);
        print("loooooooooooool shared"+savedStrList.toString());
        if(savedStrList!=null)
      {
        product_blocc.allorders= List<odersView_model>.from(savedStrList.map((x) => odersView_model.fromJson(jsonDecode(x))));
      }

       // print("loooooooooooool22 shared"+product_blocc.allorders[0].toJson().toString());


    }
  static Future<void>  removeData(String name)
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(name);
  }
}

