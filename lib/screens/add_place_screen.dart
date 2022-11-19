import 'package:flutter/material.dart';
import 'package:native_device_features/models/place.dart';
import 'package:native_device_features/providers/great_places.dart';
import 'dart:io';
import 'package:native_device_features/widgets/image_input.dart';
import 'package:native_device_features/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../helpers/location_helper.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleControler = TextEditingController();
    File? _pickedImage;
    PlaceLocation? _pickedLocation;
    void _selectImage(File pickedImage) {
      _pickedImage = pickedImage;
    }

    void _savePlace() {
      if (_titleControler.text.isEmpty || _pickedImage == null) {
        return;
      }
      Provider.of<GreatPlaces>(context, listen: false)
          .AddPlace(_titleControler.text, _pickedImage!, _pickedLocation as PlaceLocation);
      Navigator.of(context).pop();
    }
    Future<void> _selectPlace(double latitude, double longitude) async{
      final address = await LocationHelper.getPlaceAddress(latitude, longitude);
      _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude, address: address);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new place"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO: Remember add user input.
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleControler,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ImageInput(_selectImage),
                      const SizedBox(height: 10),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            )
          ],
        ),
      ),
    );
  }
}
