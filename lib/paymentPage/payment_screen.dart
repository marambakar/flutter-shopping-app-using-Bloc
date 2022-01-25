import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/myProfile/bloc_profile.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/item_design.dart';
import 'package:yamams_market/orderPage/order_bloc.dart';
import 'package:yamams_market/paymentPage/event_payment.dart';
import 'package:yamams_market/paymentPage/model/acount.dart';
import 'package:yamams_market/paymentPage/payment_bloc.dart';
import 'package:yamams_market/paymentPage/wedget/CardMonthInputFormatter.dart';
import 'package:yamams_market/paymentPage/wedget/custom_dropdown.dart';
import 'package:yamams_market/paymentPage/wedget/item_design_payment.dart';
import 'package:yamams_market/service/model/products.dart';

class payment_screen extends StatefulWidget {
  static List<Acount> acts = [];
  @override
  _payment_screen createState() => _payment_screen();
}

class _payment_screen extends State<payment_screen> {
  int _value = 1;
  int? chosenVal;
  PaymntBloc _PayBloc = PaymntBloc();
bool findf=false;
  void initState() {
    super.initState();
    StatePaymentclass.instancStateordr.orderAcount=new Acount()  ;
     _PayBloc.eventSink.add(fetchelement());
    _PayBloc.eventSink.add(fetchAcount());
//  _PayBloc.eventSink.add(getAdreess());
    _PayBloc.eventSink.add(addsum());



  }

  double widthScreen = 0, highScreen = 0;
  TextEditingController NameCard = new TextEditingController();
  TextEditingController NumberCard = new TextEditingController();
  TextEditingController dateCard = new TextEditingController();
  TextEditingController CVVCard = new TextEditingController();
  bool scale=false;
  @override
  Widget build(BuildContext context) {
    print("hi lol payment_screen" + payment_screen.acts.length.toString());
    widthScreen = MediaQuery.of(context).size.width;
    highScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
            "Payment",
            style: TextStyle(color: Colors.black),

        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [],
        leading: Container(),
      ),
      extendBodyBehindAppBar: false,
      body: Container(
          color: Colors.white,
          child: StreamBuilder<StatePaymentclass>(
              stream: _PayBloc.PaytStrem,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        height: highScreen/7.6,
                        width: widthScreen,
                          padding: EdgeInsets.symmetric(horizontal: widthScreen/35,vertical: highScreen/66),
                          margin: EdgeInsets.symmetric(horizontal: widthScreen/35,vertical: highScreen/66),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child:Text(snapshot.data!.textLoccation!=null?snapshot.data!.textLoccation!:"",style: TextStyle(fontSize: widthScreen/25),)
                      ),
                      Container(
                        width: widthScreen / 1.2,
                        height: highScreen / 16,
                        margin: EdgeInsets.only(
                            left: widthScreen / 22,
                            right: widthScreen / 22,
                            bottom: highScreen / 44),
                        // padding:
                        // EdgeInsets.symmetric(horizontal: widthScreen / 22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(3, 4),
                            ),
                          ],
                          color: Color(0xff7f92a7),
                        ),
                        child: CustomDropdown<int>(
                          child: Expanded(
                            child: Text(
                              "Pay through",
                            ),
                          ),
                          onChange: (int index) {
                            print("index" + index.toString());
                            print("item" +
                                payment_screen.acts[index].ACID.toString());

                            StatePaymentclass.instancStateordr.orderAcount=payment_screen.acts[index];
                            _PayBloc.stateStremPayController.sink.add( StatePaymentclass.instancStateordr);
                            if (index == payment_screen.acts.length - 1) {
                              showModalBottomSheet<void>(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return
                                            Container(
                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                                child: AddNewCard());

                                     //   });
                                  });
                            }
                          },
                          dropdownButtonStyle: DropdownButtonStyle(
                            // width: widthScreen / 1.2,
                            // height: highScreen / 16,
                            //  elevation: 5,
                            //backgroundColor: Colors.transparent,

                            primaryColor: Colors.white,
                          ),
                          dropdownStyle: DropdownStyle(
                            borderRadius: BorderRadius.circular(12),
                            elevation: 6,

                            // padding: EdgeInsets.all(5),
                          ),
                          items: payment_screen.acts
                              .map<DropdownMenuItem<int>>(
                                (item) => DropdownMenuItem<int>(
                                  value: item.cuid,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      item.type!,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: (MediaQuery.of(context).size.height) - (highScreen/2.1),
                          width: (MediaQuery.of(context).size.width / 1.05),
                          child: ListView.separated(
                            itemCount: snapshot.data!.orderproducts!.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (context, index) {
                              return
                                Container(
                                 // height: highScreen/3.3,

                                  child: item_design_pay(
                                order: snapshot.data!.orderproducts[index],
                              ),
                                );
                            },
                          ),
                        ),
                      ),
                     Container(
                    padding: EdgeInsets.symmetric(vertical: highScreen/55),
                       child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           margin: EdgeInsets.symmetric(horizontal: widthScreen/38),
                           height: highScreen/16,
                           width: widthScreen/4,
                           child: RaisedButton(
                             child: Text(
                               "Payment",

                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: widthScreen/29,
                                 fontFamily: "DIN Next LT W23",
                                 fontWeight: FontWeight.w700,
                               ),
                             ),
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(14)),
                             color: Color(0xff3c4051),
                             onPressed: () {
                               _PayBloc.eventSink.add(addPayment(context: context));



                             },
                           ),
                         ),
                         Expanded(
                           child: Container(
                               
                               margin: EdgeInsets.symmetric(horizontal: widthScreen/38),
                               padding: EdgeInsets.symmetric(horizontal: widthScreen/38),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(12),
                                 border: Border.all(
                                   color: Colors.black,
                                   width: 1,
                                 ),
                               ),
                               child:Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     mainAxisSize: MainAxisSize.min,
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children:[
                                       Text(
                                         "all",
                                         style: TextStyle(
                                           color: Color(0xff7f92a7),
                                           fontSize: widthScreen/26,
                                           fontFamily: "DIN Next LT W23",
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                       Text(
                                         snapshot.data!.all!=null? snapshot.data!.all.toString():"0" ,
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: widthScreen/33,
                                           fontFamily: "DIN Next LT W23",
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                     ],
                                   ),
                                   Text("=",style: TextStyle(fontSize: 14),),
                                   Column(
                                     mainAxisSize: MainAxisSize.min,
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children:[
                                       Text(
                                         "tax",
                                         style: TextStyle(
                                           color: Color(0xff7f92a7),
                                           fontSize: widthScreen/26,
                                           fontFamily: "DIN Next LT W23",
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                       Text(
                                         "0.4" ,
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: widthScreen/33,
                                           fontFamily: "DIN Next LT W23",
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                     ],
                                   ),
                                   Text("+",style: TextStyle(fontSize: 14),),
                                   Column(
                                     mainAxisSize: MainAxisSize.min,
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children:[
                                       Text(
                                         "sum",
                                         style: TextStyle(
                                           color: Color(0xff7f92a7),
                                           fontSize: widthScreen/26,
                                           fontFamily: "DIN Next LT W23",
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                       Text(
                                         snapshot.data!.sum!=null? snapshot.data!.sum.toString():"0" ,
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: widthScreen/33,
                                           fontFamily: "DIN Next LT W23",
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                     ],
                                   ),

                                 ],)
                           ),
                         ),

                       ],),)

                    ]),
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              })),
    );
  }

  Widget AddNewCard() {
    return StreamBuilder<StatePaymentclass>(
        stream: _PayBloc.PaytStrem,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context)
                  .size
                  .height *
                  0.50,
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: widthScreen / 22,
                          right: widthScreen / 22,
                          top: highScreen / 22),
                      child: Text(
                        "Name Card",
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 14,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: widthScreen / 1.1,
                      height: highScreen / 15,
                      margin: EdgeInsets.only(
                          left: widthScreen / 22, right: widthScreen / 22),
                      padding: EdgeInsets.only(
                          left: widthScreen / 22, right: widthScreen / 22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Color(0xffe5e5e5),
                      ),
                      child: TextFormField(
                          //textAlign: TextAlign.start,
                          // textAlignVertical: TextAlignVertical.center,
                          controller: NameCard,
                          onChanged: (value) {
                            scale=true;
                            _PayBloc.eventSink
                                .add(
                                new addname(text: value));
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: null,
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: highScreen / 8),
                              errorText: snapshot.data!.errorName!=null?snapshot.data!.errorName:null)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: widthScreen / 22,
                          right: widthScreen / 22,
                          top: highScreen / 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: widthScreen / 1.8,
                                child: Text(
                                  "expiry date",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xff3c4051),
                                    fontSize: 14,
                                    fontFamily: "DIN Next LT W23",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "CCV",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xff3c4051),
                                    fontSize: 14,
                                    fontFamily: "DIN Next LT W23",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: widthScreen / 2.3,
                                height: highScreen / 14,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Color(0xffe5e5e5),
                                ),
                                child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly,
                                      new LengthLimitingTextInputFormatter(
                                          4),
                                      new CardMonthInputFormatter()
                                    ],
                                    textAlign: TextAlign.center,
                                   textAlignVertical: TextAlignVertical.center,
                                    controller: dateCard,
                                    onChanged: (value) {
                                      scale=true;
                                      if(value!=null) {
                                        _PayBloc.eventSink
                                            .add(
                                            new addexpiryDate(text: value));
                                      }

                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: dateCard.text==null?"MM/yy":null,
                                        border: InputBorder.none,
                                       // hintStyle: TextStyle(fontSize: highScreen / 8),
                                        errorStyle: TextStyle(fontSize: highScreen / 55 ),
                                        errorText: snapshot.data!.expiryDaterror!=null?snapshot.data!.expiryDaterror==""?null:snapshot.data!.expiryDaterror:null)),
                              ),
                              Container(
                                width: widthScreen / 2.6,
                                height: highScreen / 14,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Color(0xffe5e5e5),
                                ),
                                child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: CVVCard,
                                    onChanged: (value) {
                                      scale=true;
                                      _PayBloc.eventSink
                                        .add(
                                      new addCCV(text: value));
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "",
                                      errorText: snapshot.data!.errorCCvString!=null&& snapshot.data!.errorCCvString!=""?snapshot.data!.errorCCvString:null
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: widthScreen / 22,
                          right: widthScreen / 22,
                          top: highScreen / 22),
                      child: Text(
                        "Number Card",
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 14,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Column(children: [
                      Container(
                        width: widthScreen / 1.1,
                        height: highScreen / 13,
                        margin: EdgeInsets.only(
                            left: widthScreen / 22, right: widthScreen / 22),
                        padding: EdgeInsets.only(
                            left: widthScreen / 22, right: widthScreen / 22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Color(0xffe5e5e5),
                        ),
                        child:
                        TextFormField(
                            textAlign: TextAlign.center,
                            controller: NumberCard,
                            onChanged: (value) {
                              scale=true;
                              _PayBloc.eventSink
                                  .add(new addNumbercard(text: value));
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: null,
                                prefixIcon: snapshot.data!.Numbercardreeor != null?
                                getCardIcon(snapshot.data!.Numbercardreeor!)
                                    : Container(),
                                errorText:null)
                          // snapshot.data!.Numbercardreeor != null
                          //     ? snapshot.data!.Numbercardreeor!
                          //     : null,
                          // errorStyle: TextStyle(fontSize: highScreen/55,inherit: false,)
                        )),
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
                               // print("Type card"+StatePaymentclass.instancStateordr.Numbercardreeor.toString());
                             //   print("experment date"+DateTime.parse("20"+StatePaymentclass.instancStateordr.regularDate![1].toString()+"-"+StatePaymentclass.instancStateordr.regularDate![0].toString()+"-"+"01 00:00:00").toString()) ;
                               Acount acoun=new Acount();
                               acoun.cvc=CVVCard.text;
                               acoun.status=1;
                               acoun.cardNumber=NumberCard.text;
                               acoun.cardHolder=NameCard.text;
                               acoun.type=StatePaymentclass.instancStateordr.Numbercardreeor;
                               acoun.cuid=SplashScreen.user.customer.cuid;
                               acoun.validDate=dateCard.text;
                               _PayBloc.eventSink.add(addcard(acount:acoun ));
                               Navigator.pop(context);


                              },
                            ),
                          )),
                    ],),




                  ]),
            );
          } else {
            return Container();
          }
        });
  }

  Widget getCardIcon(String cardType) {
    String img = "";
    late Icon icon;
    switch (cardType) {
      case "Master":
        img ='mastercard.png';
        break;
      case "Visa":
        img = 'visa.png';
        break;
      case "Verve":
        img = 'verve.png';
        break;
      case "AmericanExpress":
        img = 'american_express.png';
        break;
      case "Discover":
        img = 'discover.png';
        break;
      case "DinersClub":
        img = 'dinners_club.png';
        break;
      case "Jcb":
        img = 'jcb.png';
        break;
      case "Others":
        icon = new Icon(
          Icons.credit_card,
          color: Color(0xff599ab1),
          size: 40,
        );
        break;
      default:
        icon = new Icon(
          Icons.warning,
          size: 40.0,
          color: Colors.grey[600],
        );
        break;
    }
    Widget widget;
    if (img.isNotEmpty) {
      widget = new Image.asset(
        'images/$img',
        width: 20.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }
}
