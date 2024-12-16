import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latlng;

  PlaceModel({required this.id, required this.name, required this.latlng});
}

List<PlaceModel> places = [
  PlaceModel(
      id: 1,
      name: 'باريس بلازا',
      latlng: const LatLng(30.573585090973413, 31.001112902809833)),
  PlaceModel(
      id: 2,
      name: 'جوهرة اللحوم حواوشي علاء',
      latlng: const LatLng(30.560627090542727, 31.00742314420848)),
  PlaceModel(
      id: 3,
      name: 'مطعم الدمشقي شبين الكوم',
      latlng: const LatLng(30.566121630267457, 31.006252875324144)),
];
