import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/Widges/appBar.dart';
import 'package:yamams_market/app_locale.dart';
import 'package:yamams_market/orderPage/item_design.dart';
import 'package:yamams_market/orderPage/order_model.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/order_outbut.dart';
import 'package:yamams_market/paymentPage/event_payment.dart';
import 'package:yamams_market/paymentPage/payment_bloc.dart';
import 'package:yamams_market/paymentPage/payment_screen.dart';
import 'package:yamams_market/productPage/product_bloc.dart';
import 'package:yamams_market/service/model/products.dart';
import 'order_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class order_screen extends StatefulWidget {
  static bool changeAllTotal = false;
  @override
  _order_screen createState() => _order_screen();
}

class _order_screen extends State<order_screen> {
  orderBloc _orderBloc = orderBloc();

  @override
  void initState() {
    // TODO: implement initState
    _orderBloc.eventSink.add(Fitch());
    super.initState();
  }

  bool checkall = false;
  callback(newTotal) {
    setState(() {
      product_blocc.allTotal = newTotal;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Container(
          child: StreamBuilder<order_outbut>(
            stream: _orderBloc.productStrem,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: (MediaQuery.of(context).size.height) + (-150),
                          width: (MediaQuery.of(context).size.width / 1.05),
                          child:
                          ListView.separated(
                            itemCount: snapshot.data!.allorders.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                            const Divider(),
                            itemBuilder: (context, index) {
                              return item_design(
                                name: AppLocale().locale!=Locale('ar')?
                                snapshot.data!.allorders[index].name != null
                                    ? snapshot.data!.allorders[index].name
                                    : ""
                                : snapshot.data!.allorders[index].name_en != null
                                    ? snapshot.data!.allorders[index].name_en
                                    : "",
                                price:
                                snapshot.data!.allorders[index].price  != null
                                    ? snapshot.data!.allorders[index].price
                                    : 0,
                                dis: AppLocale().locale!=Locale('ar')?
                                snapshot.data!.allorders[index].dis !=
                                    null
                                    ?snapshot.data!.allorders[index].dis
                                    : ""
                                :    snapshot.data!.allorders[index].dis_en !=
                                    null
                                    ?snapshot.data!.allorders[index].dis_en
                                    : "",
                                image_url:
                                snapshot.data!.allorders[index].imageurl != null
                                    ?snapshot.data!.allorders[index].imageurl
                                    : "",
                                id: snapshot.data!.allorders[index].pId != null
                                    ?snapshot.data!.allorders[index].pId
                                    : 0,
                                //  checkedOrder:snapshot.data!.allorders[index].check ,
                                value: snapshot.data!.allorders[index].check,
                                count :snapshot.data!.allorders[index].quantity ,
                                total: (snapshot.data!.allorders[index].quantity) * snapshot.data!.allorders[index].price,
                                callback: callback,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0,top: 5,right: 0,bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff3c4051),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xff7f92a7),
                                    width: 2,
                                  ),
                                ),
                                child:    new IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    icon: Image.asset('images/delet.png'),
                                    iconSize: 0,
                                    onPressed: () {
                                      _orderBloc.eventSink.add(deleteAll());
                                      setState(() {
                                        product_blocc.allTotal = 0;
                                      });
                                    }),
                              ),

                              Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff3c4051),
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      'payment'.tr(),
                                      style: TextStyle(
                                        color: Color(0xffebebeb),
                                        fontSize: 19,
                                        fontFamily: "DIN Next LT W23",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    onPressed: () {
                                      print('Pressed');
                                      _orderBloc.eventSink.add(finalOrder());
                                      PaymntBloc _PayBloc = PaymntBloc();
                                     _PayBloc.eventSink.add(getAdreess());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => payment_screen()),
                                      );

                                    },
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Column(
                                  children: [
                                    Text(
                                      "Total".tr(),
                                      style: TextStyle(
                                        color: Color(0xff7f92a7),
                                        fontSize: 15,
                                        fontFamily: "DIN Next LT W23",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      product_blocc.allTotal.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "DIN Next LT W23",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0,top: 0,right: 16,bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Everyone".tr(),
                                        style: TextStyle(
                                          color: Color(0xff7f92a7),
                                          fontSize: 17,
                                          fontFamily: "DIN Next LT W23",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            checkall = !checkall;
                                            if(checkall == true){
                                              _orderBloc.eventSink.add(checkAll());
                                              //  _orderBloc.eventSink.add(updateQuantity(orderQuantity: 1026));
                                            }
                                          });

                                        },
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                            color: checkall
                                                ? Colors.grey[700]
                                                : Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xff7f92a7),
                                              width: 2,
                                            ),
                                          ),
                                          child: checkall
                                              ? Icon(
                                            Icons.check,
                                            size: 20.0,
                                            color: Colors.white,
                                          )
                                              : Icon(
                                            Icons.check_box_outline_blank,
                                            size: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )  ],
                    ),
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
