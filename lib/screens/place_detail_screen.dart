import 'package:flutter/material.dart';
import 'package:native_device_features/providers/great_places.dart';
import 'package:native_device_features/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const String routeName = '/place-detail-screen';
  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context).findById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    isSelecting: false,
                    initialLocation: selectedPlace.location,
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
                textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            )),
            child: const Text('View on map'),
          ),
        ],
      ),
    );
  }
}
