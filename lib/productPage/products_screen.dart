import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/Widges/appBar.dart';
import 'package:yamams_market/app_locale.dart';
import 'package:yamams_market/favouritePage/favourite_screen.dart';
import 'package:yamams_market/homePage/events_types.dart';
import 'package:yamams_market/homePage/home_screen.dart';
import 'package:yamams_market/orderPage/item_design.dart';
import 'package:yamams_market/orderPage/order_model.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamams_market/orderPage/order_screen.dart';
import 'package:yamams_market/productPage/events_type.dart';
import 'package:yamams_market/productPage/item_design.dart';
import 'package:yamams_market/productPage/output.dart';
import 'package:yamams_market/productPage/product_bloc.dart';

class product_screen extends StatefulWidget {
  int storeId = 0;
  product_screen({required this.storeId});
  @override
  _product_screen createState() => _product_screen();
}

class _product_screen extends State<product_screen> {
  product_bloc productBlocc = product_bloc();
  @override
  void initState() {
    // TODO: implement initState
    productBlocc.eventSink.add(fitch_products(storeId: HomePage.store_id));
    super.initState();
  }
  callbackk(int length)
  {
    setState(() {
      productBlocc.allorders.length = length;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              new Stack(
                children: [
                  new IconButton(
                    icon: new Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                  productBlocc.allorders.length == 0
                      ?
                  IconButton(
                      icon: Image.asset('images/12.png'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => order_screen()),
                        );
                        // showSearch(context: context, delegate: DataSearch(listWords));
                      })
                      : new Positioned(
                      child: new Stack(
                        children: <Widget>[
                          IconButton(
                              icon: Image.asset('images/12.png'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => order_screen()),
                                );
                                // showSearch(context: context, delegate: DataSearch(listWords));
                              }),
                          new Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.red[800]),
                          new Positioned(
                              top: 3.0,
                              right: 34.0,
                              child: new Center(
                                child: new Text(
                                  productBlocc.allorders.length.toString(),
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      )),
                ],
              ),
              // IconButton(
              //     icon: Image.asset('images/12.png'),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => order_screen()),
              //       );
              //       // showSearch(context: context, delegate: DataSearch(listWords));
              //     }),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "البحث",
                      hintStyle: TextStyle(),
                      contentPadding: EdgeInsets.all(7),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (content) {
                      productBlocc.eventSink.add(searchh(content: content));
                    }),
              ),
              IconButton(
                icon: Image.asset('images/favourite.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => favourite_screen()),
                  );
                },
                // showSearch(context: context, delegate: DataSearch(listWords));
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Container(
          child: StreamBuilder<output>(
            stream: productBlocc.productStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Center(
                    child: Container(
                      height: (MediaQuery.of(context).size.height) + (-100),
                      width: (MediaQuery.of(context).size.width / 1.09),
                      child: ListView.separated(
                        itemCount: snapshot.data!.productss.length,
                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                        itemBuilder: (context, index) {
                          return item_designn(
                            addedProductt:
                            snapshot.data!.productss[index].Viewproduct,
                            name: AppLocale().locale!=Locale('en')?
                            snapshot.data!.productss[index].Viewproduct
                                .nameEn !=
                                null
                                ? snapshot
                                .data!.productss[index].Viewproduct.nameEn
                                : ""
                                :
                            snapshot.data!.productss[index].Viewproduct
                                .nameAr !=
                                null
                                ? snapshot
                                .data!.productss[index].Viewproduct.nameAr
                                : ""
                            ,
                            price: (snapshot.data!.productss[index].Viewproduct
                                .price)
                                .toString() !=
                                null
                                ? (snapshot.data!.productss[index].Viewproduct
                                .price)
                                .toString()
                                : "",
                            dis: AppLocale().locale!=Locale('ar')?
                            snapshot.data!.productss[index].Viewproduct
                                .descriptionAr !=
                                null
                                ? snapshot.data!.productss[index].Viewproduct
                                .descriptionAr
                                : ""
                            :    snapshot.data!.productss[index].Viewproduct
                                .descriptionEn !=
                                null
                                ? snapshot.data!.productss[index].Viewproduct
                                .descriptionEn
                                : "" ,
                            image_url: snapshot.data!.productss[index]
                                .Viewproduct.photo !=
                                null
                                ? snapshot
                                .data!.productss[index].Viewproduct.photo
                                : "",
                            id: snapshot.data!.productss[index].Viewproduct
                                .prid !=
                                null
                                ? snapshot
                                .data!.productss[index].Viewproduct.prid
                                : 0,
                            isFavourite:
                            snapshot.data!.productss[index].isFavourite,
                            callbackk: callbackk,
                          );
                        },
                      ),
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
