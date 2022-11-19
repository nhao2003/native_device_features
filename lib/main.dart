import 'package:flutter/material.dart';
import 'package:native_device_features/providers/great_places.dart';
import 'package:native_device_features/screens/add_place_screen.dart';
import 'package:native_device_features/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';
import 'screens/places_list_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName:(context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}

