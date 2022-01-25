import 'package:yamams_market/service/model/product.dart';

class eventt {}

class Search extends eventt {
  final String content;
  Search({required this.content});
}

class Fitch extends eventt {}

class Delete extends eventt {
  int id ;
  Delete({required this.id});
}
class deleteFromPayments extends eventt{
  int deletedOrder ;
  deleteFromPayments({required this.deletedOrder});
}
class addedToPayments extends eventt{
  int addedOrder ;
  addedToPayments({required this.addedOrder});
}
class checkAll extends eventt{

}
class updateQuantity extends eventt{
  int orderQuantity ;
  updateQuantity({required this.orderQuantity});
}
class updateQuantity2 extends eventt{
  int orderQuantity2 ;
  updateQuantity2({required this.orderQuantity2});
}
class updateTotalPrice extends eventt{
  int orderPrice ;
  updateTotalPrice({required this.orderPrice});
}
class updateTotalPrice2 extends eventt{
  int orderPrice ;
  updateTotalPrice2({required this.orderPrice});
}
class finalOrder extends eventt{

}
class deleteAll extends eventt{

}