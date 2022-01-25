import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/orderPage/allOrders_model.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/order_bloc.dart';
import 'package:yamams_market/orderPage/order_model.dart';

import 'package:yamams_market/orderPage/ordersView_model.dart';
import 'package:yamams_market/paymentPage/event_payment.dart';
import 'package:yamams_market/paymentPage/model/acount.dart';
import 'package:yamams_market/paymentPage/model/acounts.dart';
import 'package:yamams_market/paymentPage/model/oder_payment_product.dart';
import 'package:yamams_market/paymentPage/payment_screen.dart';

import 'package:http/http.dart' as http;

enum orderEvents { Fetch, Delete, Search }
class StatePaymentclass
{
  static StatePaymentclass instancStateordr=new StatePaymentclass();
 List<odersView_model> orderproducts=[];
  List<Acount>? acounts;
  Acount? acount;
  String? Numbercardreeor;
  String? expiryDaterror;
  List<int>? regularDate;
  String? errorCCvString;
  String? errorName;
  String? textLoccation;
  double sum=0;
  double tax=0;
  double all=0;


 List<Order_model> ? ordermod;
 Acount? orderAcount;
  AddorderViewModel? otderview;
}

String query = '';

class PaymntBloc {
  static final PaymntBloc _PayBloc = PaymntBloc._internal();
  orderBloc _orderBloc = orderBloc();
  factory PaymntBloc() {
    return _PayBloc;
  }

  final stateStremPayController = BehaviorSubject<StatePaymentclass>();
  StreamSink<StatePaymentclass> get _sinkOrder => stateStremPayController.sink;
  Stream<StatePaymentclass> get PaytStrem => stateStremPayController.stream;
  List<Acount> acts=[];

  final _eventStreamController = StreamController<eventPaym>();
  StreamSink<eventPaym> get eventSink => _eventStreamController.sink;
  Stream<eventPaym> get eventStream => _eventStreamController.stream;
  PaymntBloc._internal() {
    eventStream.listen((event) async {
      {
       if (event is fetchelement)
         {

           StatePaymentclass.instancStateordr.orderproducts= finalUnshowOrders;
          // print("product_blocc.allorders.first.check"+product_blocc.allorders.first.check.toString());
        //   print("all product payment "+StatePaymentclass.instancStateordr.orderproducts.toString());
           _sinkOrder.add( StatePaymentclass.instancStateordr);
         }
       else if(event is addsum)
         {

           StatePaymentclass.instancStateordr.sum=0;

           for(int i=0;i<StatePaymentclass.instancStateordr.orderproducts.length;i++)
           {
             print("sum****"+StatePaymentclass.instancStateordr.sum.toString());
             StatePaymentclass.instancStateordr.sum+=StatePaymentclass.instancStateordr.orderproducts[i].totalPrice;



           }
           StatePaymentclass.instancStateordr.all= StatePaymentclass.instancStateordr.sum+0.4;
           print("alllllllll"+  StatePaymentclass.instancStateordr.all.toString());

           _sinkOrder.add(StatePaymentclass.instancStateordr);

         }
       if(event is fetchAcount)
        {
   fetchacountt(SplashScreen.user.customer.cuid);
     bool isfind=false;



        }
        else if(event is addAcount)
        {
          methodAddAcount(event.acount!);
        }
        else if (event is addname)
          {
            if(event.text!.isEmpty)
              {
                StatePaymentclass.instancStateordr.errorName="Please enter your Name";
                _sinkOrder.add( StatePaymentclass.instancStateordr);
              }
            else{
              StatePaymentclass.instancStateordr.errorName=null;
              _sinkOrder.add( StatePaymentclass.instancStateordr);
            }
          }
        else if(event is addNumbercard)
        {
          MethodNumbercard(event.text!);
        }
        else if (event is addexpiryDate)
        {


        // _sinkOrder.add( StatePaymentclass.instancStateordr);

            String? temp= validateDate(event.text);

            getExpiryDate(event.text!);
            print("Stateorderclass.instancStateordr.regularDate.toString()"+StatePaymentclass.instancStateordr.regularDate.toString());





        }
        else if(event is addCCV)
        {
          if(event.text!.length<3)
          {
            StatePaymentclass.instancStateordr.errorCCvString="It must more than 3";
            _sinkOrder.add( StatePaymentclass.instancStateordr);
          }
          else{
            StatePaymentclass.instancStateordr.errorCCvString=null;
           // StatePaymentclass.instancStateordr.acount!.cvc!=event.text;
            _sinkOrder.add( StatePaymentclass.instancStateordr);
          }
        }
        else if(event is addcard)
          {
            if(event.acount!.cardHolder!.isEmpty)
              {
                StatePaymentclass.instancStateordr.errorName="Please enter your Name";
                _sinkOrder.add( StatePaymentclass.instancStateordr);
              }
           else  if(event.acount!.validDate!.isEmpty)
              {
                StatePaymentclass.instancStateordr.expiryDaterror="Please enter the expiry date";
                _sinkOrder.add( StatePaymentclass.instancStateordr);
              }
            else if(event.acount!.cvc!.isEmpty)
              {
                StatePaymentclass.instancStateordr.errorCCvString="Please enter the cvc code";
                _sinkOrder.add( StatePaymentclass.instancStateordr);
              }
            else if(event.acount!.cardNumber!.isEmpty)
            {
              StatePaymentclass.instancStateordr.Numbercardreeor="Please enter the card number";
              _sinkOrder.add( StatePaymentclass.instancStateordr);
            }
           else{
              MethodAddcard(event.acount!);
            }


          }
        else if(event is getAdreess)
          {
            getAdrees();
          }
        else if(event is addPayment )
          {

            StatePaymentclass.instancStateordr.otderview=new AddorderViewModel();
            StatePaymentclass.instancStateordr.otderview!.cuid=SplashScreen.user.customer.cuid;
            StatePaymentclass.instancStateordr.ordermod=[];
           // _orderBloc.eventSink.add(finalOrder());
            StatePaymentclass.instancStateordr.ordermod!.addAll(finalOrders.Orders);

          // print("payment click"+ StatePaymentclass.instancStateordr.ordermod!.length.toString());
          //   print("payment click2"+ StatePaymentclass.instancStateordr.orderAcount!.type.toString());
          //   print("payment click3"+ StatePaymentclass.instancStateordr.otderview!.cuid.toString());
            if( StatePaymentclass.instancStateordr.otderview!.cuid==0|| StatePaymentclass.instancStateordr.orderAcount!.type==null|| StatePaymentclass.instancStateordr.ordermod!.length==0)
              {
                Fluttertoast.showToast(
                    msg: "Please enter the requested",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xff7f92a7),
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            else
              {

                _sinkOrder.add( StatePaymentclass.instancStateordr);
                Oder_payment_product oder_payment_product=new Oder_payment_product(addPaymentViewModel:StatePaymentclass.instancStateordr.orderAcount,addOrderProductViewModel:StatePaymentclass.instancStateordr.ordermod,addorderViewModel:StatePaymentclass.instancStateordr.otderview);
                addPaymentApi ("http://yamamstore.fingerprint.ml/api/OrderProduct/Completed",body: json.encode(oder_payment_product.toJson()),);
             await   orderBloc.removeData("all_order");
                product_blocc.allorders=[];
             if(product_blocc.allorders.isEmpty) {
               Navigator.of(event.context!).push(MaterialPageRoute(
                   builder: (context) => BottomBar(index: 1)));
             }
              }

          }
        else if(event is addcardcash)
          {
            MethodAddcard(event.acount!);
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
        // else if(event is Delete)
        //   {
        //     var orderss = await gitOrders();
        //     orderss.removeAt(event.id);
        //     _sinkOrder.add(orderss);
        //     print(event.id);
        //      print(orderss.length);
        //
        //   }
      }
    });
  }
  MethodAddcard(Acount acount)
  {

    addcarddApi ("http://yamamstore.fingerprint.ml/api/Account/AddAccount",body: json.encode(acount.toJson()),);
  }
  MethodNumbercard(String text)
  {
    getCardTypeFrmNumber(text);

  }
  methodAddAcount(Acount acount)
  {

  }


  getAdrees()
  async {

    print("lattttttttttt"+SplashScreen.user.customer.lat.toString());

      final coordinates = await new Coordinates(SplashScreen.user.customer.lat,SplashScreen.user.customer.lang);
      var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
      print("addresses" + addresses.toString());
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}" +
          "nivo" +
          addresses.toString());
      StatePaymentclass.instancStateordr.textLoccation = "${first.featureName} : ${first.addressLine}";


  _sinkOrder.add(StatePaymentclass.instancStateordr);
  }


  Future <List<Acount>> fetchacountt(int cid) async {
    print("inside cid"+cid.toString());
    final response =
    await http.get(Uri.parse(
        "http://yamamstore.fingerprint.ml/api/Account/getAccountByIdCustomer?cuid=$cid"));
    if (response.statusCode == 200) {
      print("respose pody acount "+response.body);
      print("alll acount" + Acounts
          .fromJson(json.decode(response.body)['dataList'])
          .aconts
          .toString());
          
      payment_screen.acts  = Acounts
          .fromJson(json.decode(response.body)['dataList'])
          .aconts;
      for(int i=0;i<payment_screen.acts.length;i++)
        {
        for(int k=1;k<payment_screen.acts.length;k++)
          {
            if(payment_screen.acts[i].type==payment_screen.acts[k].type)
              {
                payment_screen.acts[i].type=payment_screen.acts[i].type!+'('+payment_screen.acts[i].cardNumber!+')';
              }
          }
        }
      bool isfindd=false;
      for(int i=0;i<payment_screen.acts.length;i++) {
        if (payment_screen.acts[i].type == "Cash") {
          isfindd = true;
        }
      }
      if(!isfindd) {
        Acount actt= new Acount(type:"Cash",cuid: SplashScreen.user.cuid);
        actt.cuid=SplashScreen.user.customer.cuid;
        _PayBloc.eventSink.add(addcardcash(acount:actt ));
      }



      StatePaymentclass.instancStateordr.acounts= payment_screen.acts;
      _sinkOrder.add( StatePaymentclass.instancStateordr);
      payment_screen.acts.add(new Acount(type: "add new card"));

      return Acounts
          .fromJson(json.decode(response.body)['dataList'])
          .aconts;


    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  void dispose() {
    _eventStreamController.close();
   stateStremPayController.close();
  }


  String validateDate(String? value) {
    String temp="";

    if (value == null || value.isEmpty) {
      StatePaymentclass.instancStateordr.expiryDaterror="";
      _sinkOrder.add( StatePaymentclass.instancStateordr);
      StatePaymentclass.instancStateordr.expiryDaterror;
      return "";

    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(/)'))) {
      var split = value.split(new RegExp(r'(/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      print("month"+month.toString());
      year = int.parse(split[1]);
      print("your"+year.toString());
    } else  {
      // Only the month was entered


      //  value="01";
      month = int.parse(value.substring(0, (value.length)));
      year = 20;

      // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      StatePaymentclass.instancStateordr.expiryDaterror='Expiry month is invalid';
      _sinkOrder.add( StatePaymentclass.instancStateordr);
      return   "";

    }
    int convertYearTo4Digits(int year) {
      if (year < 100 && year >= 0) {
        var now = DateTime.now();
        String currentYear = now.year.toString();
        String prefix = currentYear.substring(0, currentYear.length - 2);
        year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
        print("convert year"+year.toString());
      }

      return year;
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      StatePaymentclass.instancStateordr.expiryDaterror='Expiry year is invalid';
      _sinkOrder.add( StatePaymentclass.instancStateordr);
      return "" ;
    }

    bool hasYearPassed(int year) {
      int fourDigitsYear = convertYearTo4Digits(year);
      var now = DateTime.now();
      // The year has passed if the year we are currently is more than card's
      // year

      return fourDigitsYear < now.year;
    }

    bool hasMonthPassed(int year, int month) {
      var now = DateTime.now();
      // The month has passed if:
      // 1. The year is in the past. In that case, we just assume that the month
      // has passed
      // 2. Card's month (plus another month) is more than current month.
      return hasYearPassed(year) ||
          convertYearTo4Digits(year) == now.year && (month < now.month + 1);
    }

    bool isNotExpired(int year, int month) {
      // It has not expired if both the year and date has not passed
      return !hasYearPassed(year) && !hasMonthPassed(year, month);
    }

    bool hasDateExpired(int month, int year) {
      StatePaymentclass.instancStateordr.expiryDaterror="Card has expired";
      _sinkOrder.add( StatePaymentclass.instancStateordr);
      return isNotExpired(year, month);
    }

    if (!hasDateExpired(month, year)) {
      StatePaymentclass.instancStateordr.expiryDaterror="";

      _sinkOrder.add( StatePaymentclass.instancStateordr);
      return "";
      ;
    }

    return "";
  }

  List<int>? getExpiryDate(String value) {
    List<int> result = [];
    List<String> split = [];

    split = value.split(new RegExp(r'(/)'));
    print("split" + split.length.toString());

          if(split.length<2)
            {
              split.add("0");
              split.add("0");
            }

      result = [int.parse(split[0]), int.parse(split[1])];
      StatePaymentclass.instancStateordr.regularDate=  result;
      _sinkOrder.add( StatePaymentclass.instancStateordr);
      print("result"+result.toString());
      return result;
  }



  String getCardTypeFrmNumber(String input) {
    String cardType;
    if (input.startsWith(new RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = "Master";
    } else if (input.startsWith(new RegExp(r'[4]'))) {
      cardType = "Visa";
    } else if (input
        .startsWith(new RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = "Verve";
    } else if (input.startsWith(new RegExp(r'((34)|(37))'))) {
      cardType = "AmericanExpress";
    } else if (input.startsWith(new RegExp(r'((6[45])|(6011))'))) {
      cardType = "Discover";
    } else if (input
        .startsWith(new RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = "DinersClub";
    } else if (input.startsWith(new RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = "Jcb";
    } else if (input.length <= 8) {
      cardType = "Others";
    } else {
      cardType = "Invalid";
    }
    StatePaymentclass.instancStateordr.Numbercardreeor=cardType;
    _sinkOrder.add( StatePaymentclass.instancStateordr);
    return cardType;
  }





  Future<Acount> addcarddApi(String url, {required String body}) async {
    print("uri******"+Uri.parse(url).toString()+body.toString());
    return http.post(Uri.parse(url), body: body,headers: {
      "Accept": "application/json",
      "content-type": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("acount"+response.statusCode.toString());

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      if(statusCode==200) {
        print("body" + response.body);
        _PayBloc.eventSink.add(fetchAcount());

      }
      print("Acount"+Acount.fromJson(json.decode(response.body)["data"]).toString());
      return Acount.fromJson(json.decode(response.body)["data"]);

    });
  }

  Future<List<Order_model>> addPaymentApi(String url, {required String body}) async {
    print("uri******"+Uri.parse(url).toString()+body.toString());
    return http.post(Uri.parse(url), body: body,headers: {
      "Accept": "application/json",
      "content-type": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("Order_model all"+response.statusCode.toString());

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      if(statusCode==200) {
        print("body" + response.body);
        StatePaymentclass.instancStateordr.ordermod=allOrders_model.fromJson(json.decode(response.body)["dataList"]).orders;
        _sinkOrder.add(StatePaymentclass.instancStateordr);

      }
     // print("Order_model"+Order_model.fromJson(json.decode(response.body)["dataList"]).toString());
      return allOrders_model.fromJson(json.decode(response.body)["dataList"]).orders;

    });
  }
}
