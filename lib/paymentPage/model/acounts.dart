import 'package:yamams_market/paymentPage/model/acount.dart';

class Acounts {
  List<Acount>? _aconts;

  Acounts({
    List<Acount>?aconts
  })
  {
    this._aconts = aconts;
    if(aconts==null){
      this._aconts=<Acount>[];
    }
  }
  List<Acount> get aconts => _aconts!;
  set aconts(List<Acount> acontt) => _aconts = acontt;

  factory Acounts.fromJson(List<dynamic> json) => Acounts(
      aconts: List<Acount>.from(json.map((x) => Acount.fromJson(x))));
}