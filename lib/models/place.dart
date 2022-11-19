import 'dart:io';

class PlaceLocation {
  ///[latitude] vĩ độ
  final double latitude;

  ///[longitude] kinh độ
  final double longitude;

  ///[address] địa chỉ
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
