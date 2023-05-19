import 'dart:async';
import 'package:AsianTea/model/TeaShop.dart';
import 'package:AsianTea/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom/custom_app_bar.dart';

class MapScreen extends StatefulWidget {
  static const String idScreen = "mapScreen";
  final List<TeaShop> shops;

  MapScreen(this.shops);

  @override
  _MapScreenState createState() => _MapScreenState(shops);
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final List<Marker> markers = <Marker>[];
  List<TeaShop> shops;

  _MapScreenState(this.shops);

  Map<PolylineId, Polyline> polylines = {};

  // on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(42.00478491557928, 21.40917442067392),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _createMarkersForShops(shops);
  }

  void _createMarkersForShops(shops) {
    for (var i = 0; i < shops.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position:
              LatLng(shops[i].location.latitude, shops[i].location.longitude),
          infoWindow: InfoWindow(
            title: shops[i].shopName,
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            getUserCurrentLocation().then((userLocation) async {
              LatLng destinationLocationCoordinates = LatLng(
                  shops[i].location.latitude, shops[i].location.longitude);
              LatLng userLocationCoordinates =
                  LatLng(userLocation.latitude, userLocation.longitude);
              _findTheShortestRoute(
                  userLocationCoordinates, destinationLocationCoordinates);
            });
          }));
    }
    print("Number of markers created: " + markers.length.toString());
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  void _findTheShortestRoute(
      LatLng userLocation, LatLng destinationLocation) async {
    print("Finding shortest route for Coffe shop ");
    PolylinePoints polylinePoints = PolylinePoints();
    String googleAPI = 'AIzaSyBiZLHiNQAaMde8Eb2hWoHKA3hj_T6RBMY';

    addPolyLine(List<LatLng> polylineCoordinates) {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 8,
      );
      polylines[id] = polyline;
      setState(() {});
    }

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPI,
      PointLatLng(userLocation.latitude, userLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        widgets: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 30.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 30.0,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
              ))
        ],
      ),
      body: Container(
        child: SafeArea(
          child: GoogleMap(
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            markers: Set<Marker>.of(markers),
            polylines: Set<Polyline>.of(polylines.values),
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: false,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());

            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Icon(
          Icons.my_location_sharp,
          color: Colors.black,
        ),
      ),
    );
  }
}
