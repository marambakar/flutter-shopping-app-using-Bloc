import 'package:yamams_market/orderPage/order_model.dart';

class allOrders_model{
  List<Order_model> Orders = [];
  allOrders_model ({
    required List<Order_model> orders
  })
  {
    this.Orders = orders;
  }
  List<Order_model> get orders => Orders;
  set orders(List<Order_model> orderss) => Orders = orderss;
  factory allOrders_model.fromJson(List<dynamic> json) => allOrders_model(
      orders: List<Order_model>.from(json.map((x) => Order_model.fromJson(x))));


  List toJson() {
    List jsonList = [];
    orders.map((item) =>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }
}