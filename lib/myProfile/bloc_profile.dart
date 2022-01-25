
import 'dart:async';
import 'dart:convert';


import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/homePage/store_model.dart';
import 'package:yamams_market/myProfile/model/link.dart';
import 'package:yamams_market/regeister/model/customer.dart';
import 'package:http/http.dart' as http;
import 'package:yamams_market/regeister/model/otp.dart';
class EventProfile
{

}
class addAdress extends EventProfile
{
  String LocTex="";
  addAdress({required this.LocTex});

}
class EdetCustomer extends EventProfile
{
  Customer? customer;
  EdetCustomer({this.customer});

}
class EnterNameArabic extends EventProfile
{
  String text="";
  EnterNameArabic({required this.text});
}
class EnterNameEnglish extends EventProfile
{
  String text="";
  EnterNameEnglish({required this.text});
}
class EnterDesc extends EventProfile
{
  String text="";
  EnterDesc({required this.text});
}
class EnterDescEn extends EventProfile
{
  String text="";
  EnterDescEn({required this.text});
}
class EnterSocialMed extends EventProfile
{
  String? textUri="";
  String? NameUri="";
  BuildContext? context;
  TextEditingController? controller;

  EnterSocialMed({this.textUri,this.NameUri,this.context,this.controller});
}
class getbalanceClass extends EventProfile
{

}


class RequestStore extends EventProfile
{
  Customer? customer;
  RequestStore({this.customer});
}
class StateProfie
{
  static  StateProfie singleton = new StateProfie();



  StateProfie();


  String? TextLoc="";
  LocationData? locDat;
   LatLng? latLng;
   Customer? customer;
  String? errorNameProj="";
  String? NameProj="";
  String? errorNameEnglishProj="";
  String? NameEnglishProj="";
  String? desc="";
  String? descEn="";
  String? ErrorDesc="";
  String? ErrorDescEn="";
 String? uriString="";
 String? NameUri="";
 String? errorUri="";
  String? errorSocialMedia="";
  Link? link;
  String? balance;
  Store_model store=new Store_model();



}
class ProfileBloc {
  static final ProfileBloc blocProfile = ProfileBloc._internal();

  factory ProfileBloc() {
    return blocProfile;
  }

  var eventProfileController = StreamController<EventProfile>();



  BehaviorSubject stateProfileController = BehaviorSubject<StateProfie>();

  ProfileBloc._internal() {

// Whenever there is a new event, we want to map it to a new state


    eventProfileController.stream.listen(_mapEventToState);
  }

  _mapEventToState(EventProfile event) {
    print("eventProfile+" + event.toString());
    if(event is addAdress)
      {
        methodaddAdress(event.LocTex);
      }
    else   if(event is EdetCustomer)
        {
          methodEdetCustomer(event.customer!);
        }
     else if(event is RequestStore)
        {
          methodStoreRequest();
        }
     else if (event is EnterNameArabic)
       {
         methodNameArabicProject(event.text);
       }
    else if (event is EnterNameEnglish)
    {
            methodNameEnglishProject(event.text);
    }
    else if(event is EnterDesc)
      {
        methodDesc(event.text);
      }
    else if(event is EnterDescEn)
    {
      methodDescEn(event.text);
    }
    else if (event is EnterSocialMed) {
      methodEnterSocialMe(event.textUri!,event.NameUri!,event.controller!,event.context!);
    }
    else if (event is getbalanceClass) {
      methodBalance(StateProfie.singleton.customer!.cuid);
    }
  }


  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  Location location = new Location();

  Future _getUserLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return "";
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return "";
      }
    }

    _locationData = await location.getLocation();
    print("vvvv" + _locationData.toString());


    //----------------------


    await _getaddress();
  }

  String locationTex = "";

  Future<String> _getaddress() async {
    // print("_locationData.latitudeNivoooooo" + loc.axis.toString());
    // final coordinates = await new Coordinates(loc.axis, loc.yais);
    final coordinates = await new Coordinates(_locationData!.latitude, _locationData!.longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print("addresses" + addresses.toString());
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}" +
        "nivo" +
        addresses.toString());
    locationTex = "${first.featureName} : ${first.addressLine}";
    print("nivoooooooooooo"+locationTex.split(',').last.toString());
    StateProfie.singleton.TextLoc= locationTex;
    StateProfie.singleton.locDat=_locationData;
    stateProfileController.sink.add(StateProfie.singleton);
    return "${first.featureName} : ${first.addressLine}";
  }


  methodaddAdress(String TextLoc)
  async {
  await _getUserLocation();


  }

  methodEdetCustomer(Customer customer)
  async {
    final coordinates = await new Coordinates(customer.lat, customer.lang);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print("addresses" + addresses.toString());
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}" +
        "nivo" +
        addresses.toString());
    locationTex = "${first.featureName} : ${first.addressLine}";
    print("nivoooooooooooo"+locationTex.split(',').last.toString());
    customer.city=locationTex.split(',').last.toString();
    SplashScreen.user.customer= await updateCustomer("http://yamamstore.fingerprint.ml/api/Customer/updateCustomer",
      body: json.encode(customer.toJson()),);
    SaveData(SplashScreen.user);
    StateProfie.singleton.customer=SplashScreen.user.customer;
    stateProfileController.sink.add(  StateProfie.singleton);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var  userStringg =  prefs.getString('User_data');
  // Otp  otp=  Otp.fromJson(jsonDecode(userStringg.toString()));
  //   print("jjjjj"+otp.toJson().toString());
  }


  methodStoreRequest()
  async {
    if(StateProfie.singleton.NameProj=="")
      {
        StateProfie.singleton.errorNameProj="Please Enter the Arabic Name";
        stateProfileController.sink.add( StateProfie.singleton);
      }
    else if (StateProfie.singleton.NameEnglishProj=="")
      {
        StateProfie.singleton.errorNameEnglishProj="Please Enter the English Name";
        stateProfileController.sink.add( StateProfie.singleton);
      }
    else if (StateProfie.singleton.desc=="")
    {
      StateProfie.singleton.ErrorDesc="Please Enter the Arabic Description";
      stateProfileController.sink.add( StateProfie.singleton);
    }
    else if (StateProfie.singleton.descEn=="")
    {
      StateProfie.singleton.ErrorDescEn="Please Enter the Arabic Description";
      stateProfileController.sink.add( StateProfie.singleton);
    }
    else if(StateProfie.singleton.uriString=="")
      {
        StateProfie.singleton.errorSocialMedia="Please Enter Your Account";
        stateProfileController.sink.add( StateProfie.singleton);
      }
    else
      {
        StateProfie.singleton.errorNameProj="";
        StateProfie.singleton.errorNameEnglishProj="";
        StateProfie.singleton.errorSocialMedia="";
        StateProfie.singleton.customer!.nameAr=StateProfie.singleton.NameProj!;
        StateProfie.singleton.customer!.nameEn=StateProfie.singleton.NameEnglishProj!;
        StateProfie.singleton.customer!.desAr=StateProfie.singleton.desc!;
        StateProfie.singleton.customer!.desEn=StateProfie.singleton.descEn!;

       await requestSeller("http://yamamstore.fingerprint.ml/api/Customer/TransFormToStore",body: json.encode( StateProfie.singleton.customer!.toJson()),);

        stateProfileController.sink.add(StateProfie.singleton);
      }


  }


  methodNameArabicProject(String text)
  {
    if(text.isEmpty)
      {
        StateProfie.singleton.errorNameProj="Please Enter Your Arabic Name";
        stateProfileController.sink.add(StateProfie.singleton);
      }
    else if(text.length<4)
      {
        StateProfie.singleton.errorNameProj="must be more than 4 letters";
        stateProfileController.sink.add(StateProfie.singleton);
      }
    else
      {
        StateProfie.singleton.errorNameProj="";
        StateProfie.singleton.NameProj=text;
        stateProfileController.sink.add(StateProfie.singleton);
      }
  }

  methodNameEnglishProject(String text)
  {
    if(text.isEmpty)
    {
      StateProfie.singleton.errorNameEnglishProj="Please Enter Your English Name";
      stateProfileController.sink.add(StateProfie.singleton);
    }
    else if(text.length<4)
    {
      StateProfie.singleton.errorNameEnglishProj="must be more than 4 letters";
      stateProfileController.sink.add(StateProfie.singleton);
    }
    else
    {
      StateProfie.singleton.errorNameEnglishProj="";
      StateProfie.singleton.NameEnglishProj=text;
      stateProfileController.sink.add(StateProfie.singleton);
    }
  }

  methodDesc(String text)
  {
    if(text.isEmpty)
      {
        StateProfie.singleton.ErrorDesc="Please Enter the Description";
        stateProfileController.sink.add(StateProfie.singleton);
      }
    else{
      StateProfie.singleton.ErrorDesc="";
      StateProfie.singleton.desc=text;
      stateProfileController.sink.add(StateProfie.singleton);
    }
  }
  methodDescEn(String text)
  {
    if(text.isEmpty)
    {
      StateProfie.singleton.ErrorDescEn="Please Enter the English Description";
      stateProfileController.sink.add(StateProfie.singleton);
    }
    else{
      StateProfie.singleton.ErrorDescEn="";
      StateProfie.singleton.descEn=text;
      stateProfileController.sink.add(StateProfie.singleton);
    }
  }

  methodEnterSocialMe(String TextUri,String NameUri,TextEditingController controller,BuildContext context)
  {
    if(TextUri=="")
      {
        StateProfie.singleton.errorSocialMedia="Please Enter Your Account";
        stateProfileController.sink.add(StateProfie.singleton);
      }
    else{

      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com+").hasMatch(TextUri);
      print("emailValid"+emailValid.toString());
          if(emailValid)
            {
              StateProfie.singleton.uriString=TextUri;
              StateProfie.singleton.NameUri=NameUri;
              StateProfie.singleton.errorUri="";
              StateProfie.singleton.link=new Link();
              StateProfie.singleton.link!.storeUrl!=StateProfie.singleton.uriString;
              StateProfie.singleton.link!.name!=StateProfie.singleton.NameUri;
              StateProfie.singleton.link!.cuid!=StateProfie.singleton.customer!.cuid;

              stateProfileController.sink.add(StateProfie.singleton);
              requestSellerLink("http://yamamstore.fingerprint.ml/api/Links/AddLinks", body:  json.encode( StateProfie.singleton.link!.toJson()));

                StateProfie.singleton.errorUri = "";
                controller.clear();
                Navigator.pop(context);


            }
          else{
            StateProfie.singleton.errorUri="the link is error";
        stateProfileController.sink.add(StateProfie.singleton);
          }

    }
  }

  methodBalance(int cId)
  {
    fetchbalance(cId);
  }
  Future<Customer> updateCustomer(String url, {required String body}) async {
    print("uri******"+Uri.parse(url).toString()+body.toString());
    return http.post(Uri.parse(url), body: body,headers: {
      "Accept": "application/json",
      "content-type": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("cod"+response.statusCode.toString());

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      if(statusCode==200) {
        print("body" + response.body);
        // Fluttertoast.showToast(
        //     msg: jsonDecode(response.body)["ErrorMessage"].toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Color(0xff7f92a7),
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      }
      print("nivo"+Customer.fromJson(json.decode(response.body)["data"]).phoneNumber.toString());
      return Customer.fromJson(json.decode(response.body)["data"]);

    });
  }
  Future<void> SaveData(Otp userr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(userr.toJson());
    print("mmmmmmm"+json.encode(userr.toJson()));
    await prefs.setString('User_data', encodedData);



  }

  Future<Store_model> requestSeller(String url, {required String body}) async {
    print("uri******"+Uri.parse(url).toString()+body.toString());
    return http.post(Uri.parse(url), body: body,headers: {
      "Accept": "application/json",
      "content-type": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("cod"+response.statusCode.toString());

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      if(statusCode==200) {
        print("body Seller" + response.body);
        StateProfie.singleton.store=Store_model.fromJson(json.decode(response.body)["data"]);
            stateProfileController.sink.add(StateProfie.singleton);
        SplashScreen.user.store= StateProfie.singleton.store;
       // SplashScreen.user.customer=new Customer();
        SaveData(SplashScreen.user);

      }
      print("Store_Model"+Store_model.fromJson(json.decode(response.body)["data"]).sid.toString());
      return Store_model.fromJson(json.decode(response.body)["data"]);

    });
  }

  Future<Link> requestSellerLink(String url, {required String body}) async {
    print("uri******"+Uri.parse(url).toString()+body.toString());
    return http.post(Uri.parse(url), body: body,headers: {
      "Accept": "application/json",
      "content-type": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("cod"+response.statusCode.toString());

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      if(statusCode==200) {
        print("body Link" + response.body);

      }
      print("Link"+Store_model.fromJson(json.decode(response.body)["data"]).sid.toString());
      return Link.fromJson(json.decode(response.body)["data"]);

    });
  }

  Future <double> fetchbalance(int cId) async {
    final response =
    await http.get(Uri.parse(
       " http://yamamstore.fingerprint.ml/api/Account/getCustomerbalance?cuid=$cId"));
    if (response.statusCode == 200) {
      print("balance" +json.decode(response.body)['data'].toString());

          StateProfie.singleton.balance=json.decode(response.body)['data'];

      return json.decode(response.body)['data'];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
