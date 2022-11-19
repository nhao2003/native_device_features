import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:native_device_features/helpers/db_helper.dart';
import 'dart:io';
import 'package:native_device_features/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get Items {
    return [..._items];
  }

  void AddPlace(String title, File image, PlaceLocation pickedLocation) {
    Place newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: pickedLocation,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': pickedLocation.latitude,
      'loc_lng': pickedLocation.longitude,
      'address': pickedLocation.address,
    });
  }
  Place findById(String id){
    return _items.firstWhere((element) => element.id == id);
  }
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'] as String,
            title: item['title'] as String,
            location: PlaceLocation(latitude: item['loc_lat'] as double, longitude: item['loc_lng'] as double, address: item['address'] as String),
            image: File(item['image'] as String),
          ),
        )
        .toList();
  }
}
