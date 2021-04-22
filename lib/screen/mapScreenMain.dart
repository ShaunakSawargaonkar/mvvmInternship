import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dropdownfield/dropdownfield.dart';

class MapScreenMain extends StatefulWidget {
  static const routeName = '/MapScreenMain';

  @override
  _MapScreenMainState createState() => _MapScreenMainState();
}

class _MapScreenMainState extends State<MapScreenMain> {
  Position origin;

  MapScreenMain(origin) {
    this.origin = origin;
  }

  @override
  String hospital_input = '';
  List<String> hospitals = ['Parking 1', 'Parking 2'];
  Widget build(BuildContext context) {
    Position a = ModalRoute.of(context).settings.arguments;
    var _initialCameraPostion = CameraPosition(
      target: LatLng(a.latitude, a.longitude),
      zoom: 14.5,
    );
    Marker origin, signal1, signal2;
    setState(() => {
          origin = Marker(
              markerId: MarkerId('Your Location'),
              infoWindow: InfoWindow(title: "Your Location"),
              position: LatLng(a.latitude, a.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueCyan)),
        });
    setState(() => {
          signal1 = Marker(
              markerId: MarkerId('Your Location'),
              infoWindow: InfoWindow(title: "Your Location"),
              position: LatLng(19.876838649268407, 75.34805409866875),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen)),
        });
    // setState(() => {
    //       signal2 = Marker(
    //           markerId: MarkerId('Your Location'),
    //           infoWindow: InfoWindow(title: "Your Location"),
    //           position: LatLng(30.88873400275054, 75.7903493245303),
    //           icon: BitmapDescriptor.defaultMarkerWithHue(
    //               BitmapDescriptor.hueOrange)),
    //     });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Where do you want to park?',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          DropDownField(
            onValueChanged: (value) {
              setState(() {
                hospital_input = value;
              });
            },
            value: hospital_input,
            required: false,
            hintText: 'Aurangabad,Maharastra',
            items: hospitals,
          ),
          Expanded(
            child: Stack(
              children: [
                Expanded(
                  child: Container(
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      initialCameraPosition: _initialCameraPostion,
                      markers: {
                        origin,
                        // signal2,s
                        signal1,
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  left: 1,
                  child: Card(
                    child: Container(
                      height: 70.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/download.jpg'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
