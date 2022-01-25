import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamams_market/favouritePage/favouriteEvents_type.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/order_bloc.dart';
import 'package:yamams_market/orderPage/ordersView_model.dart';
import 'package:yamams_market/paymentPage/event_payment.dart';
import 'package:yamams_market/paymentPage/payment_bloc.dart';
import 'package:yamams_market/service/model/product.dart';

class item_design_pay extends StatefulWidget {
  odersView_model order;

  item_design_pay(
      {required this.order});

  @override
  _item_designbody createState() => _item_designbody();
}

class _item_designbody extends State<item_design_pay> {
  double _heigh = 250;
  bool isExpand = true;
  int wordscount = 0;

  double _width = 600;

  @override
  Widget build(BuildContext context) {
    orderBloc orderBlocc = orderBloc();
    PaymntBloc _PayBloc = PaymntBloc();
    return

           SingleChildScrollView(
              child:
              AnimatedContainer(
                // Use the properties stored in the State class.
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 4.5,
                // width: _width,
                // height: isExpand == true ? MediaQuery.of(context).size.height/2.8 : _heigh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff7f92a7), Color(0xff3c4051)],
                  ),
                  // borderRadius: BorderRadius.circular(28),
                  // color: const Color(0xff7c94b6),

                  // image: new DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: AssetImage('assets/photo_2021-08-22_11-55-47.jpg'),
                  // )
                ),
                duration: const Duration(seconds: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height / 18,
                          right: 0,
                          bottom: 0),
                      child: Padding(
                        padding: EdgeInsets.only(left: 0, top: MediaQuery
                            .of(context)
                            .size
                            .height / 30, right: 10, bottom: 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (widget.order.quantity > 1) {
                                      orderBlocc.eventSink.add(updateQuantity2(
                                          orderQuantity2: widget.order.pId));
                                      orderBlocc.eventSink.add(
                                          updateTotalPrice2(
                                              orderPrice: widget.order.pId));
                                      _PayBloc.eventSink.add(addsum());
                                      orderBlocc.eventSink.add(finalOrder());
                                    }
                                  },
                                  child: Container(
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Color(0xfffefefe),
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.minus,
                                        color: Colors.white,
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10,
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 50,
                                      right: 10,
                                      bottom: 0),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          widget.order.quantity.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: _width/44,
                                              color: Color(0xfffefefe)),
                                        ),
                                      ),
                                      Container(
                                          width: 20,
                                          child: Divider(
                                            color: Colors.white,
                                            thickness: 0.5,
                                            indent: 0,
                                          )),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    // widget.order.quantity = widget.order.quantity+1;
                                    // widget.order.totalPrice = widget.order.totalPrice + widget.order.price;

                               orderBlocc.eventSink.add(updateTotalPrice(
                                        orderPrice: widget.order.pId));
                                    orderBlocc.eventSink.add(updateQuantity(
                                        orderQuantity: widget.order.pId));
                               orderBlocc.eventSink.add(finalOrder());

                                  },
                                  child: Container(
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            child: FaIcon(
                                              FontAwesomeIcons.plus,
                                              color: Color(0xfffefefe),
                                              size: 13,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.order.totalPrice.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xfffefefe),
                                fontSize: _width/44,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 0,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height / 26,
                          right: 10,
                          bottom: 0),
                      child:

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 4,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 4,
                        child: Column(

                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [ Text(
                                widget.order.name,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xfffefefe),
                                  fontSize: _width/44,
                                  fontFamily: "DIN Next LT W23",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              ],

                            ),


                            Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [ Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 5,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 20,
                                  child: Text(
                                    "0",
                                    maxLines: 3,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xfffefefe),
                                      fontSize: 10,
                                      fontFamily: "DIN Next LT W23",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ],

                              ),

                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 12,
                                  top: 20,
                                  right: 0,
                                  bottom: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [ Text(
                                  widget.order.price.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xfffefefe),
                                    fontSize: _width/44,
                                    fontFamily: "DIN Next LT W23",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                ],

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 0),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 0, right: 10, bottom: 0),
                      child: Container(
                        width: 104, // MediaQuery.of(context).size.width / 3.7,
                        height: 104, // MediaQuery.of(context).size.height / 6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color(0xfffefefe),
                              width: 2,
                            ),
                            image: DecorationImage(
                                image: NetworkImage("http://" +
                                    widget.order.imageurl.replaceAll(
                                        "\\", "/")),
                                fit: BoxFit.cover)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 0, right: 10, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 28.0,
                            width: 28.0,
                            child: new IconButton(
                                padding: new EdgeInsets.all(0.0),
                                icon: Image.asset('images/delet.png'),
                                iconSize: 0,
                                onPressed: () {
                                  orderBlocc.eventSink.add(Delete(
                                      id: widget.order.pId));
                                _PayBloc.eventSink.add(fetchelement());
                                  _PayBloc.eventSink.add(addsum());
                                }),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );



  }
}
