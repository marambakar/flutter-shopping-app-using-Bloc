import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share/share.dart';
import 'package:yamams_market/favouritePage/favourite_bloc.dart';
import 'package:yamams_market/favouritePage/favourite_model.dart';
import 'package:yamams_market/service/model/product.dart';
import 'favouriteEvents_type.dart';
class favouriteItem_design extends StatefulWidget {
  String name;
  String dis;
  String url;
  double price;
  double rating;
  int id;
  Favourite_model addedProductFromFavourite;
  favouriteItem_design(
      {required this.name,
        required this.dis,
        required this.url,
        required this.price,
        required this.rating,
        required this.addedProductFromFavourite,
        required this.id});

  @override
  _favouriteItem_design createState() => _favouriteItem_design();
}

class _favouriteItem_design extends State<favouriteItem_design> {
  //note : i have to make the width with mediaquery
  favourite_bloc favourite_bloccc =  favourite_bloc() ;

  double _width = 600;
  double _heigh = 200;
  bool isExpand = true;
  int wordscount = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        // Use the properties stored in the State class.
        width: MediaQuery.of(context).size.width / 1.09,
        height: MediaQuery.of(context).size.height / 3.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
              fit: BoxFit.cover,
              image: NetworkImage("http://" + widget.url.replaceAll("\\", "/")),
            )),
        duration: const Duration(seconds: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.price.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text(widget.name,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
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
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {favourite_bloccc.eventSink.add(addToCardFromFavourite(addedProductFromFavourite: widget.addedProductFromFavourite ));},
                    icon: Image.asset('images/buy.png'),
                    iconSize: 35,
                  ),

                  IconButton(
                    onPressed: () {     Share.share('check this product https://example.com', subject: 'Look what I made!');
                    },
                    icon: Image.asset('images/share.png'),
                    iconSize: 35,
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          favourite_bloccc.eventSink.add(removeFromfavourite(removedId:widget.id));
                        },
                        icon: Image.asset('images/fav.png'),
                        iconSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            )
            // isExpand == false
            //     ? new Expanded(
            //         flex: 1,
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.only(
            //                 topRight: Radius.zero,
            //                 topLeft: Radius.zero,
            //                 bottomRight: Radius.circular(28),
            //                 bottomLeft:
            //                     Radius.circular(28)), //.circular(28),
            //             color: Colors.grey,
            //           ),
            //           child: new SingleChildScrollView(
            //               scrollDirection: Axis.vertical, //.horizontal
            //               child: Container(
            //                 // color:Colors.grey ,
            //                 child: Center(
            //                   child: Padding(
            //                     padding: const EdgeInsets.only(
            //                         left: 0, top: 0, right: 10, bottom: 0),
            //                     child: Column(
            //                       crossAxisAlignment:
            //                           CrossAxisAlignment.end,
            //                       //  mainAxisAlignment: MainAxisAlignment.start,
            //                       children: [
            //                         Text("التفاصيل",
            //                             style: TextStyle(
            //                                 color: Colors.white,
            //                                 fontWeight: FontWeight.w900,
            //                                 fontSize: 20),
            //                             textAlign: TextAlign.center),
            //                         Text(
            //                           widget.dis,
            //                           style: new TextStyle(
            //                             fontSize: 16.0,
            //                             color: Colors.white,
            //                           ),
            //                           textAlign: TextAlign.center,
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               )),
            //         ),
            //       )
            //     : Text("")
          ],
        ),
      ),
    );
    ;
    // TODO: implement build
    throw UnimplementedError();
  }
}
