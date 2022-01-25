import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/homePage/home_screen.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/order_bloc.dart';
import 'package:yamams_market/productPage/events_type.dart';
import 'package:yamams_market/productPage/product_bloc.dart';
import 'package:yamams_market/service/model/product.dart';
import 'package:share/share.dart';
import 'package:easy_localization/src/public_ext.dart';

class item_designn extends StatefulWidget {
  String image_url;
  String name;
  String price;
  String dis;
  int id;
  Product addedProductt;
  bool isFavourite;
  Function(int) callbackk;
  item_designn(
      {required this.name,
        required this.price,
        required this.dis,
        required this.image_url,
        required this.id,
        required this.addedProductt,
        required this.isFavourite,
        required this.callbackk  });

  @override
  _item_design createState() => _item_design();
}

class _item_design extends State<item_designn> {
  double _heigh = 250;
  bool isExpand = true;
  int wordscount = 0;
  double _width = 600;
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    product_bloc Product_Blocc = product_bloc();
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
              _heigh = MediaQuery.of(context).size.height / 2.8 + 70;
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

          width: _width,
          height: isExpand == true
              ? MediaQuery.of(context).size.height / 2.8
              : _heigh,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                fit: BoxFit.cover,
                image: NetworkImage(
                    "http://" + widget.image_url.replaceAll("\\", "/")),
              )),
          duration: const Duration(seconds: 1),
          child: Padding(
            padding:  EdgeInsets.only(left: 0,top: (MediaQuery.of(context).size.height / 2.8) - 120,right: 0,bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.price,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(widget.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),

                      ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Divider(
                    thickness: 2.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      IconButton(
                          icon: Image.asset('images/buy.png'),padding: EdgeInsets.all(0),

                          iconSize: 38,
                          onPressed: () {
                            Product_Blocc.eventSink.add(addTocard(addedProduct: widget.addedProductt));
                            widget.callbackk(Product_Blocc.allorders.length);

                            // showSearch(context: context, delegate: DataSearch(listWords));
                          }),
                      IconButton(
                          icon: Image.asset('images/share.png'),
                          padding: EdgeInsets.all(0),
                          iconSize: 38,
                          onPressed: () {

                            Share.share('check this product https://example.com', subject: 'Look what I made!');

                            // showSearch(context: context, delegate: DataSearch(listWords));
                          }),
                      GestureDetector(
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white),
                            child: Icon(
                              widget.isFavourite == false ?   Icons.favorite_border :  Icons.favorite,
                              size: 27,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              widget.isFavourite = ! widget.isFavourite;

                            });
                            if(widget.isFavourite == true){
                              print("iiiiiiiiiiiiiiiiiiiid" + widget.id.toString());
                              Product_Blocc.eventSink.add(addTofavourite(Cid: SplashScreen.user.cuid, Pid: widget.id));
                            }
                            else{
                              Product_Blocc.eventSink.add(deleteProductFromFavourite(productDeleted: widget.id));
                            }
                            // showSearch(context: context, delegate: DataSearch(listWords));
                          }
                      ),
                      // Container(
                      //   width: 35,
                      //   height: 35,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(100),
                      //       color: Colors.white),
                      //   child: Center(
                      //     child: IconButton(
                      //       onPressed: () {Product_Blocc.eventSink.add(addTofavourite(Cid: SplashScreen.user.customer.cuid, Pid: widget.id));},
                      //       icon: Image.asset('images/fav.png'),
                      //       iconSize: 14,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                isExpand == false
                    ? new Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.zero,
                          topLeft: Radius.zero,
                          bottomRight: Radius.circular(28),
                          bottomLeft: Radius.circular(28)), //.circular(28),
                    ),
                    child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical, //.horizontal
                        child: Container(
                          // color:Colors.grey ,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 10, right: 0, bottom: 0),
                              child: Column(
                                children: [
                                  Text("Details".tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    widget.dis,
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,

                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                )
                    : Text("")
              ],
            ),
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
