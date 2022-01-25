

import 'dart:async';
import 'dart:convert';


import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/homePage/home_bloc.dart';
import 'package:yamams_market/myProfile/store_request.dart';

import 'package:yamams_market/notification/model/notificationnn.dart';
import 'package:yamams_market/notification/model/notifications.dart';
import 'package:yamams_market/regeister/model/otp.dart';
import 'package:yamams_market/regeister/screen/reg_screen.dart';


import 'data/data_noti.dart';



// Or do other work.
bool isback=false;
RemoteMessage? Message;
Future<void> backgroundHandler(RemoteMessage message) async {
  //out of app and it is close
  print("here backgrond");
  print(message.notification.toString());
  isback=true;
  Message=message;

}
class allEvent{
  String? text="";

  allEvent({ this.text});
}
class NotificationEvent extends allEvent{

  //carries the payload sent for notification
 String payload="";


  NotificationEvent(this.payload);

}

class NotificationErrorEvent extends allEvent {
  final String error;

  NotificationErrorEvent(this.error) ;
}

class fetchNotification extends allEvent
{
  fetchNotification();
}
class eventallRead extends allEvent
{

}
class addeyeevent extends allEvent
{
  Notificationnn? notificationn;
  addeyeevent({this.notificationn});
}
class deletEvent extends allEvent
{
  Notificationnn? notificationn;
  deletEvent({this.notificationn});
}

class StateNotificationclass
{
  List<Notificationnn>? allnoti;
  Notificationnn? onNotification;
  BuildContext? context;
  static StateNotificationclass InstanceNoti =new StateNotificationclass();
  StateNotificationclass();
}

class NotificationBlock
{


  String _fcmToken="";

  int _notificationId = 1; //Id for every notification

  bool _hasLaunched = false;

  String _payLoad="";
 var notificationChannel = "Notification channel";
  var notificationChannelDescription =
      "Notification channel description";
var  notificationChannelId = "Channel_id_1";

 var eventController = StreamController<allEvent>();

  var StateController = BehaviorSubject<StateNotificationclass>();
//  var stateControllernoti=StreamController<Notificationn>();
var  localNotifications= new FlutterLocalNotificationsPlugin();
  var fcm= FirebaseMessaging.instance;



  static final NotificationBlock _singleton = new NotificationBlock._internal();




  factory NotificationBlock()  {

       return _singleton;
  }

  NotificationBlock._internal(){
    initialize();
    eventController.stream.listen(mapEventToState);

  }


  Future initialize() async {
    NotificationAppLaunchDetails? _appLaunchDetails = await localNotifications.getNotificationAppLaunchDetails();
    var initializationSettings = _getPlatformSettings();
    await localNotifications.initialize(initializationSettings,
   onSelectNotification:_handleNotificationTap );

    _createNotificationChannel();
   await _fcmInitialization2();

    _hasLaunched = _appLaunchDetails!.didNotificationLaunchApp;
    if (_hasLaunched) {
      if (_appLaunchDetails.payload != null) {
        _payLoad = _appLaunchDetails.payload!;
      }
    }
  }

  fetchNotifi()
  async {

    if(SplashScreen.user.customer.cuid!=0)
      {
        StateNotificationclass.InstanceNoti.allnoti=await  fetchallNoti(SplashScreen.user.customer.cuid,1);
      }
    else{
      StateNotificationclass.InstanceNoti.allnoti=await fetchallNoti(SplashScreen.user.store.sid,2);
    }

    StateController.sink.add(StateNotificationclass.InstanceNoti);
  }


  addAllread()
  {
    if(SplashScreen.user.customer.cuid!=0)
      {
        Notifications allList=new Notifications();
        allList.nots.addAll(StateNotificationclass.InstanceNoti.allnoti!);
        print("allList.nots"+allList.nots.length.toString());
        setallReadNoti("http://yamamstore.fingerprint.ml/api/AppNotification/SetNotificationReadedforCustomer?Cuid=${SplashScreen.user.customer.cuid}", body: json.encode(allList.toJson()));
      }
    else if(SplashScreen.user.store.sid!=0)
    {
      Notifications allList=new Notifications();
      allList.nots!=StateController.value.allnoti!;
      setallReadNoti("http://yamamstore.fingerprint.ml/api/AppNotification/getStoreByIdNotification?sid=${SplashScreen.user.store.sid}", body: json.encode(allList.toJson()));
    }

  }

  addeyeRead(Notificationnn notificationn)
  {
    print("Notification id"+notificationn.id.toString());

    setReadNoti("http://yamamstore.fingerprint.ml/api/AppNotification/SetNotificationReaded?Anid=${notificationn.id}",notificationn,body: json.encode(notificationn.toJson()));

  }


  deletNoti(Notificationnn notificationn)
  {
    deleteNotification(notificationn.id, notificationn);
  }


  Future _fcmInitialization2()
  async {

    FirebaseMessaging.instance.getInitialMessage().then((message) async {

      if(message!=null){
        print("inside get intance"+message.notification!.body.toString());
        Notificationnn notification =
        convertToNotification(_notificationId++, message);
        _hasLaunched = true;
        _payLoad = json.encode(notification.toJson());
        if(SplashScreen.user.cuid==0&&SplashScreen.user.store.sid==0)
          {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            // Fetch and decode data
            var  userString = await prefs.getString('User_data');
            if(userString!=null) {
              print("hhhhhhhhhhhhhh+notification"+SplashScreen.user.store.sid.toString());
              SplashScreen.user =
                  Otp.fromJson(jsonDecode(userString.toString()));

            }
          }
        eventController.add(NotificationEvent((json.encode(notification.toJson()))));
       ;
      }
      else
        {
          print("inside get intance"+"nooooooooooo");
        }
    }).whenComplete(() {
      //get the token
      FirebaseMessaging.instance.getToken().then((value) {
        print("**********"+value!);
      })  ;
    });
    FirebaseMessaging.onMessage.listen((message) async {  Notificationnn notification =
            convertToNotification(_notificationId++, message);
              await _showNotification(notification);
              print("on massege"+message.toString());});
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    if(isback==true)
      {
        print("isbackk"+isback.toString());
        Notificationnn notification =
        convertToNotification(_notificationId++, Message!);
        eventController.add(NotificationEvent((json.encode(notification.toJson()))));
        isback==false;
      }
  }
  var initializationSettingsAndroid ;
   _getPlatformSettings() {
    initializationSettingsAndroid=
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    return InitializationSettings(
     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }
Notificationnn? finalNoti;
  Future _handleNotificationTap(String? payload) async {
     print("payload"+payload.toString());
    if (payload != null) {
      print("Local Notification");
      // finalNoti= Notificationn.fromJson(payload);
      // //finalNoti=new Notificationn(title: "lala",type: "hh",pContent: "fdf");
      // print("finalNoti"+finalNoti.toString());

      eventController.sink.add(NotificationEvent(payload));

    }
  }

  void _createNotificationChannel() async {
    var androidNotificationChannel = AndroidNotificationChannel(
      notificationChannelId,
      notificationChannel,
      notificationChannelDescription,
    );
    await localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(androidNotificationChannel);
  }

  Future<void> _showNotification(Notificationnn payload) async {
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 200;
    vibrationPattern[2] = 200;
    vibrationPattern[3] = 200;

    var bigTextStyleInformation = BigTextStyleInformation(
        payload.contentEn.toString(),
        contentTitle: payload.headerEn);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _notificationId.toString(),
        notificationChannel,
        notificationChannelDescription,
        icon: '@mipmap/ic_launcher',
        color: Colors.blue,
        vibrationPattern: vibrationPattern,
        importance: Importance.max,
        priority: Priority.max,

        styleInformation: bigTextStyleInformation);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android:  androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);
    await localNotifications.show(
        payload.id,
        payload.headerEn,
        payload.contentEn,
        platformChannelSpecifics,
        payload: json.encode(payload.toJson()));
  }


 Notificationnn convertToNotification(
      int notificationId, RemoteMessage message) {
    Notificationnn notification;


      notification = new Notificationnn(
        id :notificationId,
          headerEn : message.notification!.title,
      contentEn: message.notification!.body,
        readed: 0,
        type: "hh",

        );

    return notification;
  }


  mapEventToState(allEvent event)  {

       if(event is NotificationEvent )
         {
           print("IndexedNotification"+event.payload);
           StateNotificationclass.InstanceNoti.onNotification=Notificationnn.fromJson(jsonDecode(event.payload));

           StateController.sink.add( StateNotificationclass.InstanceNoti);
           if(StateNotificationclass.InstanceNoti.onNotification!.type=="hh")
             {
               Navigator.of(StateNotificationclass.InstanceNoti.context!).push(MaterialPageRoute(
                   builder: (context) => StoreRequest()));
             }


         }
       else if(event is fetchNotification )
         {
           fetchNotifi();
           print("fetchNotification");
         }
       else if(event is eventallRead)
         addAllread();
       else if(event is addeyeevent)
         addeyeRead(event.notificationn!);
       else if(event is deletEvent)
         deletNoti(event.notificationn!);
  }


  Future <List<Notificationnn>> fetchallNoti(int cid,int num) async {
    final response ;
    if(num==1)
      {
       response =
        await http.get(Uri.parse(
            "http://yamamstore.fingerprint.ml/api/AppNotification/getCustomerByIdNotification?cuid=$cid"));

      }
    else{
      response =
      await http.get(Uri.parse(
          "http://yamamstore.fingerprint.ml/api/AppNotification/getStoreByIdNotification?sid=$cid"));

    }

    if (response.statusCode == 200) {
      print("notification" +Notifications.fromJson(json.decode(response.body)['dataList']).nots.length.toString());



      return Notifications.fromJson(json.decode(response.body)['dataList']).nots;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }




  Future<Notificationnn> setReadNoti(String url,Notificationnn  notificationn,{required String body}) async {
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
        List<Notificationnn> temp =StateNotificationclass.InstanceNoti.allnoti!;
        if(temp.contains(notificationn))
        {
          int index=temp.indexOf(notificationn);
          temp[index].readed=1;
          StateNotificationclass.InstanceNoti.allnoti=temp;
          StateController.sink.add(StateNotificationclass.InstanceNoti);
        }
      }
      print("notification"+Notificationnn.fromJson(json.decode(response.body)["data"]).toString());
      return Notificationnn.fromJson(json.decode(response.body)["data"]);

    });
  }


  Future deleteNotification(int id,Notificationnn notificationn) async {
    final http.Response response = await http.delete(
      Uri.parse(
          "http://yamamstore.fingerprint.ml/api/AppNotification/deleteAppNotification?id=$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("response.statusCode"+response.statusCode.toString());
    if (response.statusCode == 200) {

      List<Notificationnn> temp =StateNotificationclass.InstanceNoti.allnoti!;
      if(temp.contains(notificationn))
      {
        temp.remove(notificationn);
        StateNotificationclass.InstanceNoti.allnoti=temp;
        StateController.sink.add( StateNotificationclass.InstanceNoti);
      }

    } else {
      throw Exception('Failed to delete product.');
    }
  }


  Future<List<Notificationnn>> setallReadNoti(String url,{required String body}) async {
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
        List<Notificationnn> temp =StateNotificationclass.InstanceNoti.allnoti!;
        for(int i=0;i<temp.length;i++)
        {
          temp[i].readed!=1;
        }
        StateNotificationclass.InstanceNoti.allnoti=temp;
        StateController.sink.add(StateNotificationclass.InstanceNoti);
      }
      print("notification"+Notifications.fromJson(json.decode(response.body)["dataList"]).toString());
      return Notifications.fromJson(json.decode(response.body)["dataList"]).nots;

    });
  }
  }





