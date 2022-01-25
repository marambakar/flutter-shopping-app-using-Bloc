import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamams_market/Splash/logo_drop.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/homePage/store_model.dart';
import 'package:yamams_market/main.dart';
import 'package:yamams_market/regeister/model/customer.dart';

import 'package:yamams_market/regeister/model/otp.dart';

import 'package:yamams_market/regeister/screen/reg_screen.dart';
import 'package:yamams_market/service/screen/add_service.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {

  static Otp user=new Otp(customer:new Customer(), store: new Store_model());

  @override
  SplashPageState createState() =>SplashPageState();
}
class SplashPageState extends State<SplashScreen> with  SingleTickerProviderStateMixin {

  double widthScreen = 0,
      highScreen = 0;

  AnimationController? controllerr;
  LogodropAnimation? animation;
bool isFinish=false;

  @override
  void initState() {

    _getUserLocation();
    controllerr = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    animation =   LogodropAnimation(controllerr!);
    controllerr!.forward();

    controllerr!.addListener(() {
      print("ccccccccccccccccc" + controllerr!.isCompleted.toString());
      if(controllerr!.isCompleted)
        {

          isFinish=true;
          Timer(Duration(seconds: 2), () async {

      fetchData();
        // removeData();

          });
        }
          setState(() {

          });
    });



  }
  Future<dynamic> updateCustomer(String url,int num,{required String body}) async {
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
        if(num==1)
          {
           return  Customer.fromJson(json.decode(response.body)["data"]);

          }
        else{
          return Store_model.fromJson(json.decode(response.body)["data"]);
        }

      }
     // print("nivo"+Customer.fromJson(json.decode(response.body)["data"]).phoneNumber.toString());


    });
  }


  fetchData()
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Fetch and decode data
   var  userString = await prefs.getString('User_data');
   print("eeeeeeeee"+userString.toString());
    if(userString!=null) {
      print("hhhhhhhhhhhhhh");
      SplashScreen.user = Otp.fromJson(jsonDecode(userString.toString()));

      if (SplashScreen.user.customer.cuid ==0&&SplashScreen.user.store.sid==0) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => reg_screen()));
      }
      else {
        print("user is found");

    if(SplashScreen.user.customer.cuid!=0) {
      SplashScreen.user.customer.lat=_locationData!.latitude!;
      SplashScreen.user.customer.lang=_locationData!.longitude!;
      updateCustomer("http://yamamstore.fingerprint.ml/api/Customer/updateCustomer",1,
        body: json.encode(SplashScreen.user.customer.toJson()),);

    }
    else{
      EdetStore( SplashScreen.user.store);
    }
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BottomBar(index: 1,)));

      }
    }
    else
      {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => reg_screen()));
      }
  }
 Future<void>  removeData()
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('User_data');
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



  }


  void EdetStore(Store_model store) async
  {
    var req = http.MultipartRequest('POST',
        Uri.parse("http://yamamstore.fingerprint.ml/api/Store/updateStore"));

    req.fields['SID'] = store.sid.toString();
    req.fields["Token"]=MyApp.token;
    req.fields["Status"] = "1";
    req.fields["Lat"]= _locationData!.latitude.toString();
    req.fields["Lng"]=_locationData!.longitude.toString();


    http.Response response2 = await http.Response.fromStream(await req.send());
    print("Result:Store ${response2.statusCode}");
    print("body" + response2.body);
  }


  Widget build(BuildContext context) {
    widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    highScreen = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(children: [
    Scaffold(
    body: Container(
    width: widthScreen,
        height: highScreen,
        decoration: BoxDecoration(
          //  color: nextCo

          image: DecorationImage(

            image: AssetImage("images/Logwith.png"),
            fit: BoxFit.fill,

          ),
        ),
        child: SingleChildScrollView(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isFinish?
                  Column(children: [
                      Container(
                        height: highScreen/2,
                        alignment: Alignment.bottomCenter,
                        child:    Text(
                          "Welcom",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "DIN Next LT W23",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                          height: highScreen /19,
                          child: Align(alignment: Alignment.bottomCenter,
                            child: Image.asset("images/Loading.gif"),)),
                  ],):Container()

            ]),))
    ),
      Positioned(
         top: animation!.dropPosition.value * highScreen,
          left: widthScreen / 2 - animation!.dropSize.value / 2,
          child: SizedBox(
              width: animation!.dropSize.value,
              height: animation!.dropSize.value,
              child:Image.asset("images/Logo.png"),
          )
      )
    ],);


    }


}
