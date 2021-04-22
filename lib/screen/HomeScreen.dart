import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm/screen/mapScreenMain.dart';
import 'package:dropdownfield/dropdownfield.dart';
import '../widget/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController _googleMapController;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Key key = new GlobalKey();
    final _formKey = GlobalKey<FormState>();

    void _submitForm(
      String longitude,
      String latitude,
    ) {
      // final isValid = _formKey.currentState.validate();
      FocusScope.of(context).unfocus();
      // if (isValid) {
      // _formKey.currentState.save();
      Firestore.instance.collection('signal')
          // .document('Cs5e4iFn1MUVl8EjNJeo')
          .add({
        'longitude': longitude,
        'latitude': latitude,
      });
      // }
    }

    var longitude = "";
    var latitude = "";
    String hospital_input = '';
    List<String> hospitals = ['Parking 1', 'Parking 2'];
    Future _getCurrentLocation() async {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'longitude',
                  style: kLabelStyle,
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: SizedBox(
                        width: 50,
                      ),
                      hintText: 'Enter your Signal longitude Coordinate',
                      hintStyle: kHintTextStyle,
                    ),
                    onChanged: (value) {
                      longitude = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Latitude',
                  style: kLabelStyle,
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: TextField(
                    key: key,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: SizedBox(
                        width: 50,
                      ),
                      hintText: 'Enter your Signal latitude Coordinate',
                      hintStyle: kHintTextStyle,
                    ),
                    onChanged: (value) {
                      latitude = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: RaisedButton(
                onPressed: () async {
                  print('hifniundfuinduifnsuidncfsdiundijcndnwi');
                  print(latitude);
                  _submitForm(longitude, latitude);
                  var a = await _getCurrentLocation();
                  Navigator.of(context)
                      .pushNamed(MapScreenMain.routeName, arguments: a);
                },
                child: Text('Map')),
          ),
        ],
      ),
    );
  }
}
