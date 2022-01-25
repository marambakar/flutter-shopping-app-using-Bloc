import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/myProfile/bloc_profile.dart';
import 'package:yamams_market/regeister/model/otp.dart';
import 'package:yamams_market/sitting/wiedget/buttum_wedget.dart';
import 'package:easy_localization/src/public_ext.dart';


class StoreRequest extends StatefulWidget {



  @override
  StoreRequestBody createState() => StoreRequestBody();
  ProfileBloc ser = new ProfileBloc();
}

class StoreRequestBody extends State<StoreRequest> {

  @override
  initState()  {
    super.initState();

        StateProfie.singleton.customer=SplashScreen.user.customer;


    StateProfie.singleton.store=SplashScreen.user.store;
    widget.ser.stateProfileController.sink.add(  StateProfie.singleton);
  }

  double widthscreen = 0, heightscreen = 0;
  bool findText = false;
  bool fintselect = false;

  int DopValubool = 0;
  int ImagPathbool = 0;
  String? dropdounvalu;

  int? chosenVal;
  int SocialVal=0;
  int tempvalue=0;
  TextEditingController Namee = new TextEditingController();
  TextEditingController NameEnglish = new TextEditingController();
  TextEditingController descript = new TextEditingController();
  TextEditingController descriptEn = new TextEditingController();
  TextEditingController SocialContFace = new TextEditingController();
  TextEditingController SocialContInsta = new TextEditingController();
  TextEditingController SocialAmazon = new TextEditingController();
  TextEditingController SocialShopee = new TextEditingController();
 final formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
            elevation: 0,
            leading: Container(),
            actions: [],
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "Request a seller's license",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            )),
        body: StreamBuilder(
            stream: widget.ser.stateProfileController.stream,
            //output stream (Counetr)
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //  print("snapshot.data.store.sstatus"+snapshot.data.store.sstatus.toString());
            if(snapshot.hasData)
                {

                  print("snapshot.data.errorSocialMedia"+snapshot.data.errorNameProj.toString());
                  if(snapshot.data.store.sstatus=="")
                    { return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: widthscreen / 22,
                                right: widthscreen / 22,
                                top: heightscreen / 22),
                            child: Text(
                              "Name Arabic Project".tr(),
                              style: TextStyle(
                                color: Color(0xff3c4051),
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: widthscreen / 1.2,
                            height: heightscreen / 15,
                            margin: EdgeInsets.only(
                                left: widthscreen / 22, right: widthscreen / 22),
                            padding:
                            EdgeInsets.only(left: widthscreen / 22,right:widthscreen / 22),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 4,
                                  offset: Offset(3, 4),
                                ),
                              ],
                              color: Color(0xffe5e5e5),
                            ),


                            child:
                            TextFormField(
                              //textAlign: TextAlign.start,
                              // textAlignVertical: TextAlignVertical.center,
                                controller: Namee,
                                onChanged: (value) {
                                  widget.ser.eventProfileController.sink.add(new EnterNameArabic(text: value));
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(

                                    hintText: "",


                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: heightscreen/8),
                                    errorText:snapshot.data.errorNameProj==""?null:snapshot.data.errorNameProj)),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: widthscreen / 22,
                                right: widthscreen / 22,
                                top: heightscreen / 22),
                            child: Text(
                              "Name English Project".tr(),
                              style: TextStyle(
                                color: Color(0xff3c4051),
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: widthscreen / 1.2,
                            height: heightscreen / 15,
                            margin: EdgeInsets.only(
                                left: widthscreen / 22, right: widthscreen / 22),
                            padding:
                            EdgeInsets.only(left: widthscreen / 22,right:widthscreen / 22),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 4,
                                  offset: Offset(3, 4),
                                ),
                              ],
                              color: Color(0xffe5e5e5),
                            ),


                            child:
                            TextFormField(
                              //textAlign: TextAlign.start,
                              // textAlignVertical: TextAlignVertical.center,
                                controller: NameEnglish,
                                onChanged: (value) {
                                  widget.ser.eventProfileController.sink.add(new EnterNameEnglish(text: value));
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(

                                    hintText: "",


                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: heightscreen/8),
                                    errorText:snapshot.data.errorNameEnglishProj==""?null:snapshot.data.errorNameEnglishProj)),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: widthscreen / 22,
                                right: widthscreen / 22,
                                top: heightscreen / 22),
                            child: Text(
                              "Description Project".tr(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff3c4051),
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: widthscreen / 1.2,
                            height: heightscreen / 3,
                            margin:
                            EdgeInsets.symmetric(horizontal: widthscreen / 22),
                            padding:
                            EdgeInsets.symmetric(horizontal: widthscreen / 22),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 4,
                                  offset: Offset(3, 4),
                                ),
                              ],
                              color: Color(0xffe5e5e5),
                            ),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: descript,
                                    onChanged: (value) {
                                      widget.ser.eventProfileController.sink.add(new EnterDesc(text: value));
                                    },
                                    keyboardType: TextInputType.name,

                                    minLines: 1,
                                    maxLines: 14,
                                    decoration: InputDecoration(
                                        hintText: "",

                                        border: InputBorder.none,
                                        hintStyle: TextStyle(fontSize: heightscreen/44),
                                        errorText:snapshot.data.ErrorDesc==""?null:snapshot.data.ErrorDesc))),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: widthscreen / 22,
                                right: widthscreen / 22,
                                top: heightscreen / 22),
                            child: Text(
                              "English Description Project".tr(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff3c4051),
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: widthscreen / 1.2,
                            height: heightscreen / 3,
                            margin:
                            EdgeInsets.symmetric(horizontal: widthscreen / 22),
                            padding:
                            EdgeInsets.symmetric(horizontal: widthscreen / 22),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 4,
                                  offset: Offset(3, 4),
                                ),
                              ],
                              color: Color(0xffe5e5e5),
                            ),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: descriptEn,
                                    onChanged: (value) {
                                      widget.ser.eventProfileController.sink.add(new EnterDescEn(text: value));
                                    },
                                    keyboardType: TextInputType.name,

                                    minLines: 1,
                                    maxLines: 14,
                                    decoration: InputDecoration(
                                        hintText: "",

                                        border: InputBorder.none,
                                        hintStyle: TextStyle(fontSize: heightscreen/44),
                                        errorText:snapshot.data.ErrorDescEn==""?null:snapshot.data.ErrorDescEn))),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: widthscreen / 22,
                                right: widthscreen / 22,
                                top: heightscreen / 22),
                            child: Text(
                              "Acount SocialMedia".tr(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff3c4051),
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(  width: widthscreen / 1.2,
                            height: heightscreen / 15,
                            margin: EdgeInsets.only(
                                left: widthscreen / 22, right: widthscreen / 22),
                            // padding:
                            // EdgeInsets.only(left: widthscreen / 22,right:widthscreen / 22),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 4,
                                  offset: Offset(3, 4),
                                ),
                              ],
                              color: Color(0xffe5e5e5),
                            ),
                            child: RaisedButton(
                                color: Color(0xff7f92a7),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child:Text("Enter your Acounts",style: TextStyle(fontSize: 12),),
                                onPressed:() {
                                  print("Enter your Acounts");
                                  methodSocialMedia();

                                }
                            ),
                          ),




                          snapshot.data.errorSocialMedia!=""?
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthscreen / 33,
                                vertical: heightscreen / 88),
                            child: Text(
                              "Please Enter Your Account",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                              : Container(),

                          Container(
                            margin: EdgeInsets.only(
                                left: widthscreen / 22,
                                right: widthscreen / 22,
                                top: heightscreen / 22),
                            child: Text(
                              "Store Acount".tr(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff3c4051),
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(  width: widthscreen / 1.2,
                            height: heightscreen / 15,
                            margin: EdgeInsets.only(
                                left: widthscreen / 22, right: widthscreen / 22),
                            // padding:
                            // EdgeInsets.only(left: widthscreen / 22,right:widthscreen / 22),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 4,
                                  offset: Offset(3, 4),
                                ),
                              ],
                              color: Color(0xffe5e5e5),
                            ),
                            child: RaisedButton(
                                color: Color(0xff7f92a7),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child:Text("Enter your Stors",style: TextStyle(fontSize: 12),),
                                onPressed:() {
                                  print("ok");
                                  methodStorAcount();

                                }
                            ),
                          ),


                          SizedBox(
                            height: heightscreen / 33,
                          ),
                          Center(
                              child: Container(
                                child: RaisedButton(
                                  child: Text(
                                    "Add",
                                    //textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "DIN Next LT W23",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  color: Color(0xff3c4051),
                                  onPressed: () {
                                    widget.ser.eventProfileController.sink.add(new RequestStore());
                                  },
                                ),
                              )),
                          Container(
                            height: heightscreen / 22,
                          )
                        ],
                      ),
                    );}
                  else if(snapshot.data.store.sstatus=="Pending")
                    {
                      print("snapshot.data.store.sstatus"+snapshot.data.store.sstatus);
                      return    Container(
                          height: heightscreen,
                          width: widthscreen,
                          decoration: BoxDecoration(
                            //  color: nextCo

                            image: DecorationImage(

                              image:AssetImage("images/notiBack.png"),
                              fit: BoxFit.fill,

                            ),),
                          child:Image.asset("images/reqStor.png",width: widthscreen/22,)
                          // child: Container(
                          //   height: heightscreen/4,
                          //   width: widthscreen/4,
                          //   // decoration: BoxDecoration(
                          //   //   //  color: nextCo
                          //   //
                          //   //   image: DecorationImage(
                          //   //
                          //   //     image:AssetImage("images/reqStor.png"),
                          //   //
                          //   //
                          //   //   ),),
                          //   child:Image.asset("images/reqStor.png",width: widthscreen/22,)
                          // )

                      );
                    }
                 else{
                   print("snapshot.data.store.sstatus"+snapshot.data.store.sstatus+"dont Pandding");
                    return Container();
                  }
                 }
              else{
                print("erroeeeeeeeeee");
                return Container(

                );
              }

            }));
  }
  methodSocialMedia()
  {

    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return  Container(
              margin: EdgeInsets.only(top: heightscreen/44),
              height:heightscreen/4,

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                  [
                    BottumaddCount("FaceBook",true,FontAwesomeIcons.facebook,methodtoFacebookEdet),
                    BottumaddCount("Instagram",true,FontAwesomeIcons.instagram,methodtoInstagramEdet),
                  ]
              )




          );}),

      clipBehavior: Clip.antiAlias,
    );
   showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  methodStorAcount()
  {

    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: StatefulBuilder(
          builder: (context, setState) {
            return  Container(
                margin: EdgeInsets.only(top: heightscreen/44),
                height:heightscreen/4,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                [
                  BottumaddCount("Amazon",false,Icons.camera_front,methodtodAmazonEdet),
                  BottumaddCount("Shopee",false,Icons.camera_front,methodtodShopeeEdet),
                 ]
                )




                  );




           }),

      clipBehavior: Clip.antiAlias,
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  methodEnterSocial( TextEditingController controller,String NameUri)
  {

      Dialog simpleDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: heightscreen / 5,
          child: StreamBuilder(
              stream: widget.ser.stateProfileController.stream,
              //output stream (Counetr)
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

               return
                   Container(
                       height: heightscreen / 5,
                       padding: EdgeInsets.symmetric(
                           horizontal: widthscreen / 22),
                       child: Form(
                           key:formkey,

                   child:    Column(children: [
                         TextFormField(
                             textAlign: TextAlign.start,
                             controller: controller,
                             onChanged: (value) {


                             },
                             validator: (value)
                             {

                             },


                             keyboardType: TextInputType.name,
                             decoration: InputDecoration(
                                 hintText: "...@gmail.com",
                                 errorText:snapshot.data!=null? snapshot.data.errorUri ==
                                     "" ? StateProfie.singleton.errorSocialMedia="" : snapshot.data.errorUri:null

                             )),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             RaisedButton(
                                 color: Color(0xff7f92a7),
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(
                                         10)),
                                 child: Text("confirm",
                                   style: TextStyle(fontSize: 12),),
                                 onPressed: () {
                                   print("ok");
                                   widget.ser.eventProfileController.sink.add(
                                       new EnterSocialMed(
                                           textUri: controller.text, NameUri: NameUri,controller: controller,context: context));




                                 }
                             ),
                             RaisedButton(
                                 color: Color(0xff7f92a7),
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(
                                         10)),
                                 child: Text("cancel",
                                   style: TextStyle(fontSize: 12),),
                                 onPressed: () {
                                   print("cancel");
                                   controller.clear();
                                   StateProfie.singleton.errorUri = "";
                                   Navigator.pop(context);
                                 }
                             )
                           ],)

                       ],)

                   ));




              }),
        ),


        clipBehavior: Clip.antiAlias,
      );
      showDialog(
          context: context, builder: (BuildContext context) => simpleDialog);
    }


  Widget  BottumaddCount(String text,bool isIcon,IconData iconData,Function meth)
    {
      return     Container(  width: widthscreen / 1.2,
          height: heightscreen / 15,
          margin: EdgeInsets.only(
              left: widthscreen / 22, right: widthscreen / 22),
          // padding:
          // EdgeInsets.only(left: widthscreen / 22,right:widthscreen / 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0x3f000000),
                blurRadius: 4,
                offset: Offset(3, 4),
              ),
            ],
            color:  Color(0xff7f92a7),
          ),
          child:
          FlatButton(
            child:
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: (widthscreen / 1.2)/3.4,

                      alignment: Alignment.centerRight,
                      child: isIcon==true?
                      Icon(iconData):Container()),


                  Text(text,style: TextStyle(fontSize: 18),


                  ),
                ]


            ),
            onPressed:() {
              print("ok");
             meth();

            },
          ));
    }



methodtoFacebookEdet()
{

  methodEnterSocial( SocialContFace,"FaceBook");
 // Navigator.pop(context);
}
  methodtoInstagramEdet()
  {
   // Navigator.pop(context);
    methodEnterSocial( SocialContInsta,"Instagram");
  }

  methodtodAmazonEdet()
  {
    //Navigator.pop(context);
    methodEnterSocial(SocialAmazon,"Amazon");
  }

  methodtodShopeeEdet()
  {
  //  Navigator.pop(context);
    methodEnterSocial( SocialShopee,"Shopee");
  }
}
