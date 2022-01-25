import 'package:carousel_slider/carousel_slider.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/Widges/appBar.dart';
import 'package:yamams_market/app_locale.dart';
import 'package:yamams_market/favouritePage/favouriteItem_design.dart';
import 'package:yamams_market/favouritePage/favouriteOutput.dart';
import 'package:yamams_market/favouritePage/favourite_bloc.dart';
import 'package:yamams_market/homePage/events_types.dart';
import 'package:yamams_market/homePage/fitch_output.dart';
import 'package:yamams_market/homePage/home_bloc.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamams_market/homePage/item_design.dart';
import 'package:yamams_market/productPage/product_bloc.dart';
import 'package:yamams_market/productPage/products_screen.dart';
import 'favouriteEvents_type.dart';

class favourite_screen extends StatefulWidget {
  static int store_id = 0;
// HomePage({required this.store_id});
  @override
  _favourite_screen createState() => _favourite_screen();
}

class _favourite_screen extends State<favourite_screen> {

  favourite_bloc favourite_blocc =  favourite_bloc() ;

  double _width = 0;
  double _heigh = 200;

  @override
  void initState() {
    favourite_blocc.eventSink.add(fitchFavourite(customerId: SplashScreen.user.customer.cuid));
    //here we have to git data so we need to put event fitch in sink of event
    super.initState();
  }

  @override
  void dispose() {
    // _home_bloc.dispose();


    super.dispose();
  }

  int _currentIndex = 0;
  bool isExpand = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Center(

          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<favouriteoutput>(
                stream: favourite_blocc.favouriteStrem,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: [




                          SingleChildScrollView(
                            child: Container(
                              width: (MediaQuery.of(context).size.width / 1.09),
                              height:(MediaQuery.of(context).size.height)  +(-100),
                              child: ListView.separated(
                                // physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,

                                // shrinkWrap: true,
                                separatorBuilder: (BuildContext context, int index) =>
                                const Divider(),
                                itemCount: snapshot.data!.favouriteResult.favourites.length,
                                itemBuilder: (context, index) {
                                  _width = MediaQuery.of(context).size.width / 2;
                                  return GestureDetector(
                                    // onTap: (){
                                    //   favourite_screen.store_id = snapshot.data!.storeList.stores[index].sid;
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>product_screen(storeId:snapshot.data!.storeList.stores[index].sid)))
                                    //   ;},
                                    child: favouriteItem_design(
                                      name: AppLocale().locale!=Locale('ar')?
                                      snapshot.data!.favouriteResult.favourites[index].nameAr != null ? snapshot.data!.favouriteResult.favourites[index].nameAr : ""
                                      :                                      snapshot.data!.favouriteResult.favourites[index].nameEn != null ? snapshot.data!.favouriteResult.favourites[index].nameEn : ""
                                      ,
                                      price: snapshot.data!.favouriteResult.favourites[index].price !=null ? snapshot.data!.favouriteResult.favourites[index].price  : 0  ,
                                      dis: snapshot.data!.favouriteResult.favourites[index].nameAr!=null ? snapshot.data!.favouriteResult.favourites[index].nameAr:"",
                                      url:snapshot.data!.favouriteResult.favourites[index].photo,
                                      rating: 3,
                                      addedProductFromFavourite: snapshot.data!.favouriteResult.favourites[index],
                                      id: snapshot.data!.favouriteResult.favourites[index].prid,

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
      ),
    );
  }
}
