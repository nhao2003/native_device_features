import 'dart:convert';

import 'package:http/http.dart';
const APIKEY = 'pk.eyJ1Ijoibm5oYW8yMDAzIiwiYSI6ImNsYW5wMWFuYjA4azYzdm52bHE2ZTJpcWIifQ.AeFt6dL_vbcZgROieATpfg';
class LocationHelper {
  static String generateLocationPreviewImage({required double latitude, required double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$APIKEY';
  }
  static Future<String> getPlaceAddress(double latitude, double longitude) async {
    final url = Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$APIKEY');
    final placeAddress = await get(url);
    final extracted = jsonDecode(placeAddress.body);
    final types =extracted['features'][0];
    return types['place_name'];
  }
}