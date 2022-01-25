import 'package:carousel_slider/carousel_slider.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:yamams_market/Widges/appBar.dart';
import 'package:yamams_market/app_locale.dart';
import 'package:yamams_market/favouritePage/favourite_screen.dart';
import 'package:yamams_market/homePage/events_types.dart';
import 'package:yamams_market/homePage/fitch_output.dart';
import 'package:yamams_market/homePage/home_bloc.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamams_market/homePage/item_design.dart';
import 'package:yamams_market/orderPage/order_screen.dart';
import 'package:yamams_market/productPage/product_bloc.dart';
import 'package:yamams_market/productPage/products_screen.dart';

class HomePage extends StatefulWidget {
  static int store_id = 0;
// HomePage({required this.store_id});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  home_bloc _home_bloc =  home_bloc() ;

  double _width = 0;
  double _heigh = 200;
  bool Changecolor = false;
  @override
  void initState() {
    _home_bloc.eventSink.add(fitch());

    //here we have to git data so we need to put event fitch in sink of event
    super.initState();
  }

  @override
  void dispose() {
    //  _home_bloc.dispose();


    super.dispose();
  }

  int _currentIndex = 0;
  bool isExpand = true;
  product_bloc productBlocc = product_bloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
                                  productBlocc.allorders.length.toString().tr(),
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
                      hintText: "Search".tr(),
                      hintStyle: TextStyle(),
                      contentPadding: EdgeInsets.all(7),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (content) {
                     // productBlocc.eventSink.add(searchh(content: content));
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
      //MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Container(
            child: StreamBuilder<fitch_output>(
              stream: _home_bloc.productStrem,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/7,
                          child: ListView.builder(

                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.categoryList.categories.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          int id = snapshot.data!.categoryList.categories[index].caid;
                                          _home_bloc.eventSink.add(fitchCategoryStoress(id: id));
                                          Changecolor = true;
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height/10,
                                          width: MediaQuery.of(context).size.width/6,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],

                                            shape: BoxShape.circle,
                                            image: DecorationImage(

                                                image: NetworkImage(

                                                    "http://" +
                                                        snapshot.data!.categoryList.categories[index].photo
                                                            .replaceAll(
                                                            "\\", "/")

                                                ),

                                                fit: BoxFit.none
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                          AppLocale().locale!=Locale('ar')? snapshot.data!.categoryList.categories[index].nameAr
                                              :snapshot.data!.categoryList.categories[index].nameEn
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        FutureBuilder(builder: (context, index) {
                          return Column(children: [
                            CarouselSlider(

                              options: CarouselOptions(

                                  onPageChanged: (index, _) {
                                    setState(() {
                                      _currentIndex =
                                          snapshot.data!.offerList.advertisments[index].adid;
                                    });
                                  },
                                  // height: MediaQuery.of(context).size.height / 3.7,
                                  initialPage: 0,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1,
                                  height: MediaQuery.of(context).size.height / 3
                              ),
                              items: snapshot.data!.offerList.advertisments
                                  .map((item) => Container(
                                width: MediaQuery.of(context).size.width /
                                    1.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  color: Color(0xff7f92a7),
                                ),
                                child: Stack(
                                  children: [
                                    Container(

                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(28),
                                          image: DecorationImage(
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.5),
                                              BlendMode.darken,
                                            ),
                                            image:
                                            NetworkImage(

                                                "http://" +
                                                    item.Photo
                                                        .replaceAll(
                                                        "\\", "/")

                                            ),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Center(
                                      child: Container(
                                        width: 300,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale().locale!=Locale('ar')?  item.descriptionAr==null?"":item.nameAr  :item.descriptionEn==null?"":item.nameEn,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xfffefefe),
                                                  fontSize: 19,
                                                  fontFamily:
                                                  "DIN Next LT W23",
                                                  fontWeight:
                                                  FontWeight.w700,
                                                ),
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    AppLocale().locale!=Locale('ar')?   item.descriptionAr == null ? "" : item.descriptionAr
                                                    : item.descriptionEn == null ? "" : item.descriptionEn,
                                                    textAlign:
                                                    TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 40,
                                                      fontFamily: "Gotham",
                                                      fontWeight:
                                                      FontWeight.w700,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  Text(
                                                    'Up to'.tr(),
                                                    textAlign:
                                                    TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily:
                                                      "DIN Next LT W23",
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ]);
                        }),
                        Container(
                          width: 90,
                          height: 10,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.offerList.advertisments.length,
                              itemBuilder: (context, index) {
                                //  var article = snapshot.data![index];
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex ==
                                          snapshot.data!.offerList.advertisments[index].adid
                                          ? Color(0xff3c4051)
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 1.09),
                            height:MediaQuery.of(context).size.height/3,
                            child: ListView.separated(
                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,

                              // shrinkWrap: true,
                              separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                              itemCount: snapshot.data!.storeList.stores.length,
                              itemBuilder: (context, index) {
                                _width = MediaQuery.of(context).size.width / 2;
                                return GestureDetector(
                                  onTap: (){
                                    HomePage.store_id = snapshot.data!.storeList.stores[index].sid;
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>product_screen(storeId:snapshot.data!.storeList.stores[index].sid)))
                                    ;},
                                  child: item_design(
                                    name: AppLocale().locale!=Locale('ar')?
                                    snapshot.data!.storeList.stores[index].nameAr != null ? snapshot.data!.storeList.stores[index].nameAr : ""
                                        :snapshot.data!.storeList.stores[index].nameEn != null ? snapshot.data!.storeList.stores[index].nameEn : "" ,
                                    price: '',
                                    dis: AppLocale().locale!=Locale('ar')? snapshot.data!.storeList.stores[index].cityAr !=null ? snapshot.data!.storeList.stores[index].cityAr:""
                                    :snapshot.data!.storeList.stores[index].cityEn !=null ? snapshot.data!.storeList.stores[index].cityEn:"",
                                    url:snapshot.data!.storeList.stores[index].photo,
                                    rating: snapshot.data!.storeList.stores[index].rate,
                                    checkImage:snapshot.data!.storeList.stores[index].photo != null ?true :false ,

                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                      ]);

                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
