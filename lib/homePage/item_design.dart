import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class item_design extends StatefulWidget {
  String name;
  String dis;
  String url;
  String price;
  double rating;
  bool checkImage;
  item_design(
      {required this.name,
        required this.dis,
        required this.url,
        required this.price,
        required this.rating,
        required this.checkImage});

  @override
  _item_designState createState() => _item_designState();
}

class _item_designState extends State<item_design> {
  //note : i have to make the width with mediaquery
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
              image:widget.checkImage == true ? NetworkImage("http://" + widget.url.replaceAll("\\", "/")) : NetworkImage("https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.generationsforpeace.org%2Fwp-content%2Fuploads%2F2018%2F03%2Fempty.jpg&imgrefurl=https%3A%2F%2Fwww.generationsforpeace.org%2Fen%2Fhow-we-work%2Fpublications%2Fempty%2F&tbnid=4SpTlJP1Z3JHOM&vet=12ahUKEwiC1J732qTzAhUCxeAKHaVtC7AQMygAegUIARDNAQ..i&docid=dhcWL-5kuQU2WM&w=500&h=400&q=image%20for%20empty%20image&ved=2ahUKEwiC1J732qTzAhUCxeAKHaVtC7AQMygAegUIARDNAQ"),
            )),
        duration: const Duration(seconds: 1),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        unratedColor: Colors.grey,
                        initialRating: widget.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.8),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
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
                padding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.dis,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
    ;
    // TODO: implement build
    throw UnimplementedError();
  }
}
