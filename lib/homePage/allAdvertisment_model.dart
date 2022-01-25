import 'advertisment_model.dart';
class allAdvertisment
{
  List<Advertisment_model> Advertisments = [];
  allAdvertisment({
    required List<Advertisment_model> advertisments
  })
  {
    this.Advertisments = advertisments;
  }
  List<Advertisment_model> get advertisments => Advertisments;
  set advertisments(List<Advertisment_model> storess) => Advertisments = advertisments;
  factory allAdvertisment.fromJson(List<dynamic> json) => allAdvertisment(
      advertisments: List<Advertisment_model>.from(json.map((x) => Advertisment_model.fromJson(x))));
}