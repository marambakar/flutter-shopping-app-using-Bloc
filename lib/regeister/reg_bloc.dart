import 'dart:async';
import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';




import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/homePage/store_model.dart';
import 'package:yamams_market/main.dart';
import 'package:yamams_market/regeister/model/customer.dart';
import 'package:yamams_market/regeister/model/otp.dart';

import 'package:yamams_market/regeister/screen/password_screen.dart';
import 'package:yamams_market/regeister/screen/verification_screen.dart';



class registerEvent {
  String? text;

  registerEvent({ this.text}) ;

}

class addFullNam extends registerEvent {String? text="";
addFullNam({ this.text}) : super(text: text);
}
class addphone extends registerEvent {
  String? text="";

  addphone({ this.text}) :super(text: text);
}
class addverfi extends registerEvent {
  String? text="";

  addverfi({ this.text}) :super(text: text);
}
class addPassword extends registerEvent {
  String? text="";

  addPassword({ this.text}) :super(text: text);
}
class addconfirmPass extends registerEvent {
  String? text="";

  addconfirmPass({ this.text}) :super(text: text);
}

class continu extends registerEvent{
  BuildContext context;
  continu({required this.context});

}

class continuVerfi extends registerEvent
{
  BuildContext context;
  continuVerfi({required this.context});
}

class passSend extends registerEvent
{
  BuildContext context;
  passSend({required this.context});
}







class registerBloc
{

  var eventController = StreamController<registerEvent>();
  // Stream get eventStream =>_eventController.stream;
  Sink <registerEvent> get eventControllerSink =>eventController.sink;

  BehaviorSubject stateFullNameController=BehaviorSubject<String>();
  BehaviorSubject statephoneController=BehaviorSubject<String>();
  BehaviorSubject statevaficationController=BehaviorSubject<String>();
  BehaviorSubject statePasswordController=BehaviorSubject<String>();
  BehaviorSubject statesurePassController=BehaviorSubject<String>();
  BehaviorSubject statesurecontinuController=BehaviorSubject<bool>();



  late Customer customer;
  late Store_model stor;
  late Otp otp;
  registerBloc() {
// Whenever there is a new event, we want to map it to a new state

    customer=new Customer();
    stor =new Store_model();
    otp=new Otp(customer: customer, store: stor);
    eventController.stream.listen(_mapEventToState);


  }

  _mapEventToState(registerEvent event)
  {
    print("event+"+event.toString());

    if(event is addFullNam)
      checkFullNameText(event.text!);
    else if(event is addphone)
      checkPhone(event.text!);
    else if(event is continu)
      sendContinu(event.context);
    else if(event is addverfi)
      checkverfication(event.text!);
    else if(event is continuVerfi)
      verficationsend(event.context);
    else if(event is addPassword)
      checkPassordText(event.text!);
    else if(event is addconfirmPass)
      checkConfirmPassordText(event.text!);
    else if (event is passSend)
      Passwordsend(event.context);
  }

  void checkFullNameText(String text)
  {
    (text .length<4)
        ? stateFullNameController.sink.addError("Please Enter your Name!")
        : stateFullNameController.sink.add(text);

    // print("stateController"+stateController.stream.last.toString());
  }


  void checkPhone(String text)
  {
    RegExp regex = new RegExp(  r'^(?:[+0]9)?[0-9]{10}$');
    if (!regex.hasMatch(text))
      statephoneController.sink.addError( 'Enter Valid Phone Number');
    else
      (text == null || text == "")
          ?  statephoneController.sink.addError( "Please Enter your phone!")
          :statephoneController.sink.add(text);
  }



  void checkverfication(String text)
  {
    (text == null || text == "")
        ?  statevaficationController.sink.addError("Please Enter the verfication code!")
        : text.length<4 ?
    statevaficationController.sink.addError("the verfication is wrong")
        : statevaficationController.sink.add(text);
  }


  void checkPassordText(String text)
  {
    (text == null || text == "")
        ?  statePasswordController.sink.addError("Please Enter your Password!")
        : (text.length<8)?
    statePasswordController.sink.addError("Enter 8 Churctuer")
        : statePasswordController.sink.add(text);
  }

  void checkConfirmPassordText(String text)
  {
    (text == null || text == "")
        ?  statesurePassController.sink.addError("Please Enter your confirm Password!")
        : statePasswordController.value!=text?
    statesurePassController.sink.addError("the password is wrong")
        : statesurePassController.sink.add(text);
  }


  Future<void> sendContinu (BuildContext context)
  async {
    if(stateFullNameController.hasValue&&statephoneController.hasValue) {
      customer.userName = stateFullNameController.value;
      customer.phoneNumber = statephoneController.value;
      customer.status=1;
      // print("User" + user.name.toString() + user.phoneNumber.toString());
      statesurecontinuController.sink.add(true);
      if( statesurecontinuController.value==true) {
        otp= await createotp("http://yamamstore.fingerprint.ml/api/OTP/LogIn",
            body: json.encode(customer.toJson()),);
        print("otp0000000"+otp.phoneNumber.toString());

        if(otp!=null) {

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerificationScreen()));
        }
      }

    }
    else{
      if(!stateFullNameController.hasValue) {
        stateFullNameController.sink.addError("please Enter your Name");
      }
      if(!statephoneController.hasValue)
      {
        statephoneController.sink.addError("please Enter your Phone");}
      // statesurecontinuController.addError("No");
      statesurecontinuController.add(false);
    }

  }

  Future<void> verficationsend(BuildContext context)
  async {
    if(statevaficationController.hasValue)
    {
      otp.code=statevaficationController.value;
      otp.status=1;
      // print("UserVerfica" + user.varificationCode+user.name);
      statesurecontinuController.sink.add(true);
      if( statesurecontinuController.value==true) {

        String result= await cheakDb("http://yamamstore.fingerprint.ml/api/OTP/Check?PhoneNumber=${otp.phoneNumber}&Code=${otp.code}",
          body: "",);
        print("res"+result);
        if(result=="OK") {
          await  SaveData(otp);
          SplashScreen.user=otp;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => passwordScreen()));
          print("okkkkkkkkkkk");
        }
        else{
          statevaficationController.sink.addError("please Enter your verfication");
          statesurecontinuController.sink.add(false);
        }
      }
    }
    else
    {
      print("&&&&&&&&&&&&&&&&&");
      statevaficationController.sink.addError("please Enter your verfication");
      // statesurecontinuController.addError("No");
      statesurecontinuController.sink.add(false);
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
    print("Password ok" + otp.customer.password);
    otp.customer.lat= _locationData!.latitude!;
    otp.customer.lang=_locationData!.longitude!;


  }

  Future<void> Passwordsend(BuildContext context)
  async {
    if(statePasswordController.hasValue&&statesurePassController.hasValue)
    {

      statesurecontinuController.sink.add(true);
      if(statesurecontinuController.value==true)
      {
        otp.customer.password=statePasswordController.value;

        otp.customer.Token=MyApp.token;
     await   _getUserLocation();
       otp.customer= await updateCustomer("http://yamamstore.fingerprint.ml/api/Customer/updateCustomer",
          body: json.encode(otp.customer.toJson()),);
        SaveData(otp);
        SplashScreen.user=otp;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var  userStringg =  prefs.getString('User_data');
        otp=  Otp.fromJson(jsonDecode(userStringg.toString()));
        print("jjjjj"+otp.toJson().toString());
        if(otp.customer!=null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BottomBar(index: 1,)));
        }
      }
    }
       else if(!statePasswordController.hasValue)
         {
           statePasswordController.sink.addError("please Enter Your Passord");
           statesurecontinuController.sink.add(false);
         }
       else if(!statesurePassController.hasValue)
         {
           statesurePassController.sink.addError("Please Enter Your Confirm Password");
           statesurecontinuController.sink.add(false);
         }
    else
    {
      statePasswordController.sink.addError("please Enter Your Passord");
      statesurePassController.sink.addError("Please Enter Your Confirm Password");
      statesurecontinuController.sink.add(false);
    }
  }

  Future<void> SaveData(Otp userr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(userr.toJson());
    print("mmmmmmm"+json.encode(userr.toJson()));
    await prefs.setString('User_data', encodedData);



  }



  dispose() {
    eventController.close();
    stateFullNameController.close();
    statephoneController.close();
    statephoneController.close();
    statePasswordController.close();
    statesurecontinuController.close();

  }


  Future<Otp> createotp(String url, {required String body}) async {
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
      }
      print("nivo"+Otp.fromJson(json.decode(response.body)["data"]).phoneNumber.toString());
      return Otp.fromJson(json.decode(response.body)["data"]);

    });
  }


  Future<String> cheakDb(String url, {required String body}) async {
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
        print("body" + jsonDecode(response.body)['data']  );
      }
      return jsonDecode(response.body)['data'];

    });
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
      }
      print("nivo"+Customer.fromJson(json.decode(response.body)["data"]).phoneNumber.toString());
      return Customer.fromJson(json.decode(response.body)["data"]);

    });
  }


}

