import 'package:flutter/cupertino.dart';
import 'package:yamams_market/paymentPage/model/acount.dart';

class eventPaym
{

}
class fetchelement extends eventPaym
{

}

class fetchAcount extends eventPaym
{

}
class addAcount extends eventPaym
{
  Acount? acount;
  addAcount({this.acount});

}
class addNumbercard extends eventPaym
{
  String? text;
  addNumbercard({this.text});
}
class addexpiryDate extends eventPaym
{
  String? text;
  // String? textReg;
  addexpiryDate({this.text});
}
class addCCV extends eventPaym
{
  String? text;
  addCCV({this.text});
}
class addcard extends eventPaym
{
  Acount? acount;
  addcard({this.acount});
}
class addcardcash extends eventPaym
{
  Acount? acount;
  addcardcash({this.acount});
}
class addname extends eventPaym
{
  String? text;
  addname({this.text});
}
class getAdreess extends eventPaym
{

}
class addPayment extends eventPaym
{
BuildContext? context;
addPayment({this.context});
}
class addsum extends eventPaym
{

}
