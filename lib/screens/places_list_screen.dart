import 'package:flutter/material.dart';
import 'package:native_device_features/providers/great_places.dart';
import 'package:native_device_features/screens/add_place_screen.dart';
import 'package:native_device_features/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapShot) => snapShot == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (context, greatPlaces, cld) =>
                    greatPlaces.Items.isNotEmpty
                        ? ListView.builder(
                            itemCount: greatPlaces.Items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.Items[index].image),
                                ),
                                title: Text(greatPlaces.Items[index].title),
                                subtitle: Text(greatPlaces.Items[index].location.address),
                                onTap: () {
                                  Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.Items[index].id);
                                },
                              );
                            },
                          )
                        : cld as Widget,
                child: const Center(
                  child: Text('Got no places yet, start adding some places.'),
                ),
              ),
      ),
    );
  }
}
