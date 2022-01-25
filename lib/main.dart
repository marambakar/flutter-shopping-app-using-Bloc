import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/homePage/home_screen.dart';

import 'package:yamams_market/notification/notification_block.dart';
import 'package:yamams_market/notification/screen/notification_list.dart';
import 'package:yamams_market/paymentPage/payment_screen.dart';
import 'package:yamams_market/regeister/screen/reg_screen.dart';
import 'package:yamams_market/service/screen/add_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yamams_market/app_locale.dart';

NotificationBlock? notibloc;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  notibloc = new NotificationBlock();

  // notibloc!.initialize();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'translations', // <-- change patch to your
      fallbackLocale: Locale('ar'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static String token = "";
  @override
  Widget build(BuildContext context) {
    AppLocale().context = context;
    AppLocale().locale=context.locale;
    FirebaseMessaging.instance.getToken().then((tokenn) {
      token = tokenn!;
    });

    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage()
        //   snapshot.hasData?
        //   NotificationList():SplashScreen(),
        // );
        // });
        );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StateNotificationclass.InstanceNoti.context = this.context;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: StreamBuilder(
            stream: notibloc!.StateController.stream,
            //output stream (Counetr)
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              print("Nivo stated");

              return //snapshot.hasData&&snapshot.data.onNotification.type=="hh"?
                  //reg_screen():
                  SplashScreen();
            }));
  }
}
