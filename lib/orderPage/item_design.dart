import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:yamams_market/favouritePage/favouriteEvents_type.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/order_bloc.dart';
import 'package:yamams_market/service/model/product.dart';
import 'order_screen.dart';

class item_design extends StatefulWidget {
  String image_url;
  String name;
  double price;
  String dis;
  int id;
  Function(double) callback;
  // Product checkedOrder;
  bool value;
  double count;
  double total;
  item_design(
      {required this.name,
      required this.price,
      required this.dis,
      required this.image_url,
      required this.id,
      // required this.checkedOrder,
      required this.value,
      required this.count,
      required this.total,
      required this.callback});

  @override
  _item_design createState() => _item_design();
}

class _item_design extends State<item_design> {
  double _heigh = 250;
  bool isExpand = true;
  int wordscount = 0;

  double _width = 600;

  @override
  Widget build(BuildContext context) {
    orderBloc orderBlocc = orderBloc();
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpand = !isExpand;
          if (isExpand == false) {
            wordscount = widget.dis.split(' ').length;
            if (wordscount == 0) {
              print("11111111");
              _heigh = MediaQuery.of(context).size.height / 2.8 + 100;
            } else if (wordscount <= 50) {
              print("222222222");
              _heigh = MediaQuery.of(context).size.height / 2.8 + 200;
            } else if (wordscount > 50 && wordscount <= 100) {
              print("33333");
              _heigh = MediaQuery.of(context).size.height / 2.8 + 250;
            } else {
              print("444444444");
              _heigh = MediaQuery.of(context).size.height / 2.8 + 400;
            }
          } else {
            _heigh = MediaQuery.of(context).size.height / 2.8;
          }
        });
      },
      child: SingleChildScrollView(
        child: AnimatedContainer(
          // Use the properties stored in the State class.
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 4.5,
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
                    top: MediaQuery.of(context).size.height / 18,
                    right: 0,
                    bottom: 0),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 0,
                      top: MediaQuery.of(context).size.height / 30,
                      right: 10,
                      bottom: 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.count > 0) {
                                  widget.count = widget.count - 1;
                                  widget.total = widget.total - widget.price;
                                  product_blocc.allTotal =
                                      product_blocc.allTotal - widget.price;
                                  widget.callback(product_blocc.allTotal);
                                  orderBlocc.eventSink.add(updateQuantity2(
                                      orderQuantity2: widget.id));
                                  orderBlocc.eventSink.add(
                                      updateTotalPrice2(orderPrice: widget.id));
                                }
                              });
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
                                top: MediaQuery.of(context).size.height / 50,
                                right: 10,
                                bottom: 0),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    widget.count.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
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
                            onTap: () {
                              setState(() {
                                widget.count = widget.count + 1;
                                widget.total = widget.total + widget.price;
                                product_blocc.allTotal =
                                    product_blocc.allTotal + widget.price;
                                widget.callback(product_blocc.allTotal);
                                orderBlocc.eventSink.add(
                                    updateTotalPrice(orderPrice: widget.id));
                                orderBlocc.eventSink.add(
                                    updateQuantity(orderQuantity: widget.id));
                              });
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                        widget.total.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xfffefefe),
                          fontSize: 19,
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
                    top: MediaQuery.of(context).size.height / 26,
                    right: 10,
                    bottom: 0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.name,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xfffefefe),
                              fontSize: 14,
                              fontFamily: "DIN Next LT W23",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height / 20,
                              child: Text(
                                widget.dis,
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
                            left: 0,
                            top: 20,
                            right: 0,
                            bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.price.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xfffefefe),
                                fontSize: 19,
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
                              widget.image_url.replaceAll("\\", "/")),
                          fit: BoxFit.cover)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
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
                            product_blocc.allTotal =
                                product_blocc.allTotal - widget.total;
                            widget.callback(product_blocc.allTotal);
                            orderBlocc.eventSink.add(Delete(id: widget.id));
                          }),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    SizedBox(
                      height: 28.0,
                      width: 28.0,
                      child: new IconButton(
                          padding: new EdgeInsets.all(0.0),
                          icon: Image.asset('images/share.png'),
                          iconSize: 0,
                          onPressed: () {
                            Share.share(
                                'check this product https://example.com',
                                subject: 'Look what I made!');
                          }),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.value = !widget.value;

                        setState(() {
                          if (!widget.value) {
                            orderBlocc.eventSink.add(
                                deleteFromPayments(deletedOrder: widget.id));
                            product_blocc.allTotal =
                                product_blocc.allTotal - widget.total;
                            widget.callback(product_blocc.allTotal);
                          } else {
                            orderBlocc.eventSink
                                .add(addedToPayments(addedOrder: widget.id));
                            product_blocc.allTotal =
                                product_blocc.allTotal + widget.total;
                            widget.callback(product_blocc.allTotal);
                          }
                        });
                      },
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: widget.value == false
                              ? Colors.transparent
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: widget.value == false
                            ? Icon(
                                Icons.check_box_outline_blank,
                                size: 20.0,
                                color: Colors.transparent,
                              )
                            : Icon(
                                Icons.check,
                                size: 20.0,
                                color: Colors.grey[700],
                              ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
