import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamams_market/Login/log_bloc.dart';
import 'package:yamams_market/Login/login_screen.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/myProfile/customer_profile.dart';
import 'package:yamams_market/service/screen/add_service.dart';
import 'package:yamams_market/service/screen/service_list.dart';
import 'package:yamams_market/sitting/wiedget/buttum_wedget.dart';

import '../app_locale.dart';


class SittingScreen extends StatefulWidget {

  @override
  SittingScreenBody createState() => SittingScreenBody();

}
enum Languages { Arabic, English }
class SittingScreenBody extends State<SittingScreen> {
  late Languages selectedLanguage;

  @override
  initState() {

    super.initState();
    if (AppLocale().locale == Locale('ar'))
      selectedLanguage = Languages.Arabic;
    else
      selectedLanguage = Languages.English;
  }


  double widthscreen = 0,
      heightscreen = 0;
  bool findText = false;
  bool fintselect = false;


  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery
        .of(context)
        .size
        .width;
    heightscreen = MediaQuery
        .of(context)
        .size
        .height;
    return  Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        actions: [],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:   Text("Settings".tr(),style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),) ,
      ),
     body:   SingleChildScrollView(child:   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Column(children: [
          SplashScreen.user.store.sid!=0?
          WedgetButtom(text: " Add a new service".tr(),iconData: Icons.adjust_outlined,isLine: true,Textalarm: "",method:addServic ,):Container(),
          SplashScreen.user.store.sid!=0?
          WedgetButtom(text: " Service Management".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine:false,Textalarm: "",method: manageServic,):Container(),
          Container(
            margin: EdgeInsets.symmetric(vertical: heightscreen/44,horizontal: widthscreen/33),
            child:Text(
              "General Settings".tr(),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ) ,
          ),

          WedgetButtom(text: "Alarm tone".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "defult".tr(),),
          WedgetButtom(text: "List of complaints submitted".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "",),

          WedgetButtom(text: "Edit profile".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "",method: profilMethod,),
          WedgetButtom(text: "Language settings".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "",method:(){

            AwesomeDialog(
              context: context,
              animType: AnimType.SCALE,
              btnOkColor:  Color(0xff3c4051),
              dialogType: DialogType.NO_HEADER,
              padding: EdgeInsets.all(10),
              body: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      RadioListTile<Languages>(
                        title: const Text('العربية'),
                        activeColor:Color(0xff3c4051),
                        value: Languages.Arabic,
                        groupValue: selectedLanguage,
                        onChanged: (Languages? value) {
                          setState(() {
                            selectedLanguage = value!;
                          });
                        },
                      ),
                      RadioListTile<Languages>(
                        title: const Text('English'),
                        value: Languages.English,
                        activeColor:Color(0xff3c4051),
                        groupValue: selectedLanguage,
                        onChanged: (Languages? value) {
                          setState(() {
                            selectedLanguage = value!;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              title: 'This is Ignored',
              desc: 'This is also Ignored',
              btnOkOnPress: () {

                if (selectedLanguage == Languages.Arabic) {
                  if (context.locale != Locale('ar'))
                    setState(() {
                      context.locale = Locale('ar');
                    });
                } else {
                  if (context.locale != Locale('en'))
                    setState(() {
                      context.locale = Locale('en');
                    });
                }
              },
            )
              ..show();
         }),
          WedgetButtom(text: "Terms of use".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "",),
          WedgetButtom(text: "Privacy policy".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "",),
          WedgetButtom(text: "Rate the app".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "",),
          WedgetButtom(text: "Log out ".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "",method:logout ,),
          Container(
            margin: EdgeInsets.symmetric(vertical: heightscreen/44,horizontal: widthscreen/33),
            child:Text(
              "aid".tr(),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ) ,
          ),
          WedgetButtom(text: "About the application".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: true,Textalarm: "",),
          WedgetButtom(text: "Join our team".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine: false,Textalarm: "",),
          Container(
            height: heightscreen/5,
            width: widthscreen,
          )
        ],)

      ],),));





  }


  addServic()
  {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddService()));
  }
  manageServic()
  {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ServiceList()));
  }
  Future<void>  removeData()
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('User_data');
  }
  logout()
  async {
    await removeData();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  BlocProvider(
        create: (BuildContext context)=> LogBloc(),
        child: LoginScreen(),
      ),));
  }

  profilMethod()
  async {

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CustomerProfile()));
  }


}
