import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:native_device_features/helpers/location_helper.dart';
import 'package:native_device_features/screens/map_screen.dart';
import 'package:latlong2/latlong.dart';

class LocationInput extends StatefulWidget {
  late Function selectPlace;

  LocationInput(this.selectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    late LocationData locData;
    try{
      locData = await Location().getLocation();
    } catch (error){
      return;
    }
    _showPreview(locData.latitude as double, locData.longitude as double);
    widget.selectPlace(locData.latitude, locData.longitude);
  }

  void _showPreview(double latitude, double longitude) {
    final staticMapImage = LocationHelper.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImage;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.add_location_alt),
              label: const Text('Select on map'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        )
      ],
    );
  }
}
