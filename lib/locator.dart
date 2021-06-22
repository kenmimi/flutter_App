import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_drawer.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Locator extends StatefulWidget {
  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  GoogleMapController googleMapController;
  Map<MarkerId,Marker> markers = <MarkerId,Marker>{};
  Position position= Position(latitude: 4.061536, longitude: 9.786072);
  String addressLocation;
  String country;
  String postalCode;

  void getMarkers(double lat, double long){
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
      markerId: markerId,
      position: LatLng(lat,long),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueCyan
      ),
      infoWindow: InfoWindow(snippet: addressLocation)
    );
    setState(() {
      markers[markerId] = _marker;
    });
  }

  void getCurrentLocation() async{
    Position currentPosition =
     await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  @override
  void initState(){
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Drawer'),
          backgroundColor: Colors.blue,
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 600.0,
                  child: GoogleMap(
                    onTap: (tapped) async{
                      final coordinated = new geoCo.Coordinates(
                          tapped.latitude, tapped.longitude);
                      var address = await geoCo.Geocoder.local
                          .findAddressesFromCoordinates(coordinated);
                      var firstAddress = address.first;
                      getMarkers(tapped.latitude, tapped.longitude);
                      await FirebaseFirestore.instance.collection('location').add({
                        'latitude': tapped.latitude,
                        'longitude': tapped.longitude,
                        'Address': firstAddress.addressLine,
                        'Country': firstAddress.countryName,
                        'postalCode': firstAddress.postalCode
                      });
                      country = firstAddress.countryName;
                      postalCode = firstAddress.postalCode;
                      addressLocation = firstAddress.addressLine;
                    },
                    mapType: MapType.hybrid,
                    compassEnabled: true,
                    trafficEnabled: true,
                    onMapCreated: (GoogleMapController controller){
                      setState(() {
                        googleMapController = controller;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(position.latitude.toDouble(),position.longitude.toDouble()),
                        zoom: 15.0),
                    markers: Set<Marker>.of(markers.values)),
                ),
                Text("Address: $addressLocation"),
                Text("PostalCode : $postalCode"),
                Text("country : $country")
              ],
            ),
        ),
    );
  }
  @override
  void dispose(){
    super.dispose();
  }
}
