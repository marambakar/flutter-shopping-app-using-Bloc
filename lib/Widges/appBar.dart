import 'package:flutter/material.dart';
import 'package:yamams_market/favouritePage/favourite_screen.dart';
import 'package:yamams_market/homePage/events_types.dart';
import 'package:yamams_market/homePage/home_bloc.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/order_bloc.dart';
import 'package:yamams_market/orderPage/order_bloc.dart';
import 'package:yamams_market/orderPage/event_types.dart';
import 'package:yamams_market/orderPage/order_screen.dart';
import 'package:yamams_market/paymentPage/payment_screen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  // orderBloc _orderBloc = orderBloc();
//  home_bloc _homebloc = home_bloc();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            IconButton(
                icon: Image.asset('images/12.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => order_screen()),
                  );
                  // showSearch(context: context, delegate: DataSearch(listWords));
                }),
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
                    // _homebloc.eventSink.add(search(content: content));
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
