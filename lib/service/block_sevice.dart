import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/homePage/allCategories_model.dart';
import 'package:yamams_market/homePage/category_model.dart';
import 'package:yamams_market/service/data/data_service.dart';

import 'package:yamams_market/service/model/product.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:yamams_market/service/model/products.dart';
import 'package:yamams_market/service/screen/add_service.dart';
import 'package:yamams_market/sitting/sitting_screen.dart';

class eventService
{
  String text="";
  int textee=0;
  eventService({ this.text="",this.textee=0});
}
class addServiceName extends eventService
{
  String text="";

  addServiceName({ this.text=""});
}
class addServiceNameEn extends eventService
{
  String text="";

  addServiceNameEn({ this.text=""});
}
class addServicedescription extends eventService
{
  String text="";
  addServicedescription({ this.text=""});
}
class addServicedescriptionEn extends eventService
{
  String text="";
  addServicedescriptionEn({ this.text=""});
}

class adddropValu extends eventService
{
  int textt=0;
  adddropValu({ this.textt=0});
}
class adddropValuFitchcats extends eventService
{
  List<Category_model> cats;
  adddropValuFitchcats({required this.cats});


}

class addPrice extends eventService
{
  double pr=0;
  addPrice({ this.pr=0});
}
class addImgPath extends eventService
{
  String text="";
  addImgPath({ this.text=""});
}
class addOneService extends eventService
{
   Product ser;
   BuildContext context;
    addOneService({required this.ser,required this.context});

}
class addAllService extends eventService
{

}
class EdetService extends eventService
{
  Product ser;
  BuildContext context;
  EdetService({required this.ser,required this.context});

}
class deletService extends eventService
{
  Product ser;
  deletService({required this.ser});

}

class StateService
{


  static final StateService _singleton = new StateService._internal();


  factory StateService() {
    return _singleton;
  }

  StateService._internal({ this.Name="",this.NameEn="",this.description="",this.descriptionEn="",this.errorDescriptionEn="",this.errorNameService="",this.errorNameServiceEn="",this.errorDescription="",this.dropValue=0,this.price=0,this.errorPrice="",this.imgpath="",this.errorImgPath="", this.ser,this.errordropValu="",   this.catgs});


  Product? ser;
  String Name="";
  String NameEn="";
String description="";
  String descriptionEn="";
  String errorNameService="";
  String errorNameServiceEn="";
  String errorDescription="";
  String errorDescriptionEn="";
  int dropValue=0;
  String errordropValu="";
 double price=0;
  String errorPrice="";
  String imgpath="";
  String errorImgPath="";
  List<Category_model>? catgs= [];
}





class ServiceBloc {

  var eventController = StreamController<eventService>();


  BehaviorSubject stateserviceController = BehaviorSubject<StateService>();
  BehaviorSubject stateAllService = BehaviorSubject<List<Product>>();


  static final ServiceBloc _singletonn = new ServiceBloc._internal();


  factory ServiceBloc() {
    return _singletonn;
  }

  ServiceBloc._internal(){
    eventController.stream.listen(_mapEventToState);
  }


  _mapEventToState(eventService event) async {
    print("event+" + event.toString());
    if (event is addServiceName) {
      methodNameService(event.text);
    }
    else if (event is addServiceNameEn) {
      methodNameServiceEn(event.text);
    }
    else if (event is addServicedescription) {
      methodDescrepService(event.text);
    }
    else if (event is addServicedescriptionEn) {
      methodDescrepServiceEn(event.text);
    }
    else if (event is adddropValu) {
      methodDropdown(event.textt);
    }
    else if (event is adddropValuFitchcats) {
      fetchCategory_model();
    }
    else if (event is addPrice) {
      stateserviceController.sink.add(
          new StateService._internal(price: event.pr));
    }
    else if (event is addImgPath) {
      stateserviceController.sink.add(
          new StateService._internal(imgpath: event.text));
    }
    else if (event is addOneService) {
      methodOneService(event.ser, event.context);
    }
    else if (event is addAllService) {
      methodAllService();
    }
    else if (event is EdetService) {
      methodEdetService(event.ser, event.context);
    }
    else if (event is deletService)
      {
        deleteProduct(event.ser.prid,event.ser);
      }
  }

  methodNameService(String text) {
    if (text == null) {
      stateserviceController.sink.add(
          new StateService._internal(
              errorNameService: "Please Enter Name Service"));
    }
    else if (text.length < 4) {
      stateserviceController.sink.add(new StateService._internal(
          errorNameService: "The Length of Name Minimum 4 churctuers"));
    }
    else {
      stateserviceController.sink.add(new StateService._internal(Name: text));
    }
  }

  methodNameServiceEn(String text) {
    if (text == null) {
      stateserviceController.sink.add(
          new StateService._internal(
              errorNameServiceEn: "Please Enter English Name Service"));
    }
    else if (text.length < 4) {
      stateserviceController.sink.add(new StateService._internal(
          errorNameServiceEn: "The Length of Name English  Minimum 4 churctuers"));
    }
    else {
      stateserviceController.sink.add(new StateService._internal(NameEn: text));
    }
  }

  methodDescrepService(String text) {
    if (text == null)
      stateserviceController.sink.add(new StateService._internal(
          errorDescription: "Please Enter Description the  Service"));
    else if (text.length < 6) {
      stateserviceController.sink.add(new StateService._internal(
          errorDescription: "The Length of Name Minimum 6 churctuers"));
    }

    else {
      stateserviceController.sink.add(
          new StateService._internal(description: text));
    }
  }

  methodDescrepServiceEn(String text) {
    if (text == null)
      stateserviceController.sink.add(new StateService._internal(
          errorDescriptionEn: "Please Enter English Description the  Service"));
    else if (text.length < 6) {
      stateserviceController.sink.add(new StateService._internal(
          errorDescriptionEn: "The Length of English  Name Minimum 6 churctuers"));
    }

    else {
      stateserviceController.sink.add(
          new StateService._internal(descriptionEn: text));
    }
  }

  methodDropdown(int text) {
    stateserviceController.sink.add(
        new StateService._internal(dropValue: text));
  }

  methodOneService(Product servicce, BuildContext context) {
    // print("stateserviceController.value.Name"+stateserviceController.value.Name);
    if (servicce.nameAr == "") {
      stateserviceController.sink.add(
          new StateService._internal(
              errorNameService: "Please Enter Name Service"));
    }
    else if (servicce.nameEn == "") {
      stateserviceController.sink.add(
          new StateService._internal(
              errorNameServiceEn: "Please Enter Name Service"));
    }
    else if (servicce.descriptionAr == "") {
      stateserviceController.sink.add(new StateService._internal(
          errorDescription: "Please Enter Description the  Service"));
      print("errorDescription");
    }
    else if (servicce.descriptionEn == "") {
      stateserviceController.sink.add(new StateService._internal(
          errorDescriptionEn: "Please Enter Description the  Service"));
      print("errorDescriptionEn");
    }
    else if (servicce.price == 0) {
      stateserviceController.sink.add(new StateService._internal(
          errorPrice: "Please Enter the Price service"));
      print("errorPrice");
    }
    else if (servicce.caid == 0) {
      stateserviceController.sink.add(new StateService._internal(
          errordropValu: "Please Enter the Type of service"));
      print("errordropValu");
    }
    else if (servicce.photo == "") {
      stateserviceController.sink.add(new StateService._internal(
          errorImgPath: "Please Enter the image for  service"));
      print("errorImgPath");
    }
    else {
      //service.caid=1011;
      servicce.sid = SplashScreen.user.store.sid;
      //addproductModel(service);
      addpos(servicce);
      stateserviceController.sink.add(
          new StateService._internal(ser: servicce));
      print("okkkkkkkk");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SittingScreen()));
    }
  }

  methodAllService() {
    //stateAllService.sink.add(sevicesdata);
    fetchAllProduct(SplashScreen.user.store.sid);
  }

  methodEdetService(Product ser, BuildContext context) async {
    if (ser.nameAr == "") {
      print("fffffffffffff" + ser.nameAr);
      stateserviceController.sink.add(
          new StateService._internal(
              errorNameService: "Please Enter Name Service"));
    }
    else if (ser.nameEn == "") {
      stateserviceController.sink.add(
          new StateService._internal(
              errorNameServiceEn: "Please Enter Name Service"));
    }
    else if (ser.descriptionAr == "") {
      stateserviceController.sink.add(new StateService._internal(
          errorDescription: "Please Enter Description the  Service"));
      print("errorDescription");
    }
    else if (ser.descriptionEn == "") {
      stateserviceController.sink.add(new StateService._internal(
          errorDescriptionEn: "Please Enter Description the  Service"));
      print("errorDescriptionEn");
    }
    else if (ser.price == 0) {
      stateserviceController.sink.add(new StateService._internal(
          errorPrice: "Please Enter the Price service"));
      print("errorPrice");
    }
    else if (ser.caid == 0) {
      stateserviceController.sink.add(new StateService._internal(
          errordropValu: "Please Enter the Type of service"));
      print("errordropValu");
    }
    else if (ser.photo == ""||ser.photo==null) {
      stateserviceController.sink.add(new StateService._internal(
          errorImgPath: "Please Enter the image for  service"));
      print("errorImgPath");
    }
    else {
      stateserviceController.sink.add(StateService._internal(ser: ser));
      ser.sid = SplashScreen.user.store.sid;
      await EdetProductt(ser);
      Fluttertoast.showToast(
          msg: "complete Edetting",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SittingScreen()));
    }
  }


  void addpos(Product product) async
  {
    var req = http.MultipartRequest('POST',
        Uri.parse("http://yamamstore.fingerprint.ml/api/Product/AddProduct"));

    req.fields['NameAr'] = product.nameAr;
    req.fields['NameEn'] = product.nameEn;
    req.fields["DescriptionAr"] = product.descriptionAr;
    req.fields['DescriptionEn'] = product.descriptionEn;
    req.fields["SID"] = product.sid.toString();
    req.fields["CAID"] = product.caid.toString();
    req.fields["Price"] = product.price.toString();
    req.fields["Status"] = "1";
    req.files.add(
        http.MultipartFile.fromBytes(
            'Image',
            File(product.photo).readAsBytesSync(),
            filename: product.photo
                .split("/")
                .last
        )
    );

    http.Response response2 = await http.Response.fromStream(await req.send());
    print("Result: ${response2.statusCode}");
    print("body" + response2.body);
  }


  Future <List<Category_model>> fetchCategory_model() async {
    final response =
    await http.get(Uri.parse(
        "http://yamamstore.fingerprint.ml/api/Category/getAllCategory"));
    if (response.statusCode == 200) {
      print("alll cats" + allCategories
          .fromJson(json.decode(response.body)['dataList'])
          .Categories
          .toString());
      stateserviceController.sink.add(
          new StateService._internal(catgs: allCategories
              .fromJson(json.decode(response.body)['dataList'])
              .Categories));
      AddService.tempList = allCategories
          .fromJson(json.decode(response.body)['dataList'])
          .Categories;
      return allCategories
          .fromJson(json.decode(response.body)['dataList'])
          .Categories;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future <List<Product>> fetchAllProduct(int Sid) async {
    final response =
    await http.get(Uri.parse(
        "http://yamamstore.fingerprint.ml/api/Product/GetStoreProducts?Sid=$Sid"));
    if (response.statusCode == 200) {
      print("alll Prods" + Products
          .fromJson(json.decode(response.body)['dataList'])
          .prods
          .toString());
      stateAllService.sink.add(Products
          .fromJson(json.decode(response.body)['dataList'])
          .prods);
      return Products
          .fromJson(json.decode(response.body)['dataList'])
          .prods;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future EdetProductt(Product product) async {
    print("product" + product.prid.toString());
    var req = http.MultipartRequest('POST', Uri.parse(
        "http://yamamstore.fingerprint.ml/api/Product/updateProduct"));

    req.fields['NameAr'] = product.nameAr;
    req.fields['NameEn'] = product.nameEn;
    req.fields["DescriptionAr"] = product.descriptionAr;
    req.fields['DescriptionEn'] = product.descriptionEn;
    req.fields["SID"] = product.sid.toString();
    req.fields["CAID"] = product.caid.toString();
    req.fields["Price"] = product.price.toString();
    req.fields["PRID"] = product.prid.toString();
    req.fields["Status"] = "1";
    // print("niv"+product.photo.contains("yamamstore.fingerprint.ml").toString());
    if (product.photo.contains("yamamstore.fingerprint.ml")) {

    }
    else {
      req.files.add(
          http.MultipartFile.fromBytes(
              'Image',
              File(product.photo).readAsBytesSync(),
              filename: product.photo
                  .split("/")
                  .last
          )
      );
    }

    http.Response response2 = await http.Response.fromStream(await req.send());
    print("Result: ${response2.statusCode}");
    print("body" + response2.body);
  }


  Future deleteProduct(int proid,Product product) async {
    final http.Response response = await http.delete(
      Uri.parse(
          "http://yamamstore.fingerprint.ml/api/Product/deleteProduct?id=$proid"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("response.statusCode"+response.statusCode.toString());
    if (response.statusCode == 200) {

     List prds=stateAllService.value;
     if(prds.contains(product))
       {
         prds.remove(product);
       }
     stateAllService.sink.add(prds);

    } else {
      throw Exception('Failed to delete product.');
    }
  }
}