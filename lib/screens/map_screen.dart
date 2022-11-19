import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import '../models/place.dart';

const MAPBOX_API_KEY =
    'https://api.mapbox.com/styles/v1/nnhao2003/clanpke26003d15nsdtjrsb38/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibm5oYW8yMDAzIiwiYSI6ImNsYW5wMWFuYjA4azYzdm52bHE2ZTJpcWIifQ.AeFt6dL_vbcZgROieATpfg';

const MAPBOX_USER =
    'pk.eyJ1Ijoibm5oYW8yMDAzIiwiYSI6ImNsYW5wMWFuYjA4azYzdm52bHE2ZTJpcWIifQ.AeFt6dL_vbcZgROieATpfg';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.421, longitude: -122.084, address: ''),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_pickedLocation);
                },
                icon: const Icon(Icons.check))
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16.0,
          onTap: widget.isSelecting
              ? (tapPosition, point) {
                  setState(() {
                    _pickedLocation = point;
                  });
                }
              : null,
        ),
        mapController: MapController(),
        children: [
          TileLayer(
            urlTemplate: MAPBOX_API_KEY,
            additionalOptions: const {
              'accessToken': MAPBOX_USER,
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayer(
            markers: [
              if (_pickedLocation != null)
                Marker(
                  point: _pickedLocation as LatLng,
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    size: 50,
                    color: Colors.red,
                  ),
                )
              else if (!widget.isSelecting)
                Marker(
                  point: LatLng(widget.initialLocation.latitude,
                      widget.initialLocation.longitude),
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
