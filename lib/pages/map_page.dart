import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key, this.iniLatitude, this.iniLongitude}) : super(key: key);
  var iniLatitude;
  var iniLongitude;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static double? iniLatitude;
  static double? iniLongitude;

  @override
  void initState() {
    iniLatitude = double.parse(widget.iniLatitude);
    iniLongitude = double.parse(widget.iniLongitude);
    super.initState();
  }

  Marker marker = Marker(
      markerId: MarkerId('placeId'),
      position: LatLng(iniLatitude ?? 0, iniLongitude ?? 0));
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(iniLatitude ?? 1, iniLongitude ?? 1),
    zoom: 5.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
            height: 85,
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                    ),
                    Text("PICKUP MAP",
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: {marker},
          ))
        ],
      )),
    );
  }
}
