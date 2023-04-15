import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/AllScreens/registrationScreen.dart';
import 'package:uber_clone/AllScreens/searchScreen.dart';
import 'package:uber_clone/AllWidgets/Divider.dart';
import 'package:uber_clone/Assistants/assistantMethods.dart';
import 'package:uber_clone/DataHandler/appData.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();

  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      displayToastMessage("Location services are disabled", context,
          duration: Toast.LENGTH_LONG);
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentPosition = position;

        String address =
            await AssistantMethods.searchCoordinateAddress(position, context);

        LatLng latLangPosition = LatLng(position.latitude, position.longitude);

        CameraPosition cameraPosition =
            new CameraPosition(target: latLangPosition, zoom: 14);

        newGoogleMapController!.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
      } else {
        displayToastMessage('Location permissions are denied', context,
            duration: Toast.LENGTH_LONG);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      displayToastMessage(
          'Location permissions are permanently denied, we cannot request permissions.',
          context,
          duration: Toast.LENGTH_LONG);
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  GoogleMapController? newGoogleMapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Main Screen',
          style: TextStyle(
            fontSize: 35.0,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/user_icon.png',
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 43.0,
                          ),
                          Text(
                            "Profile Name",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Brand Bold",
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text("Visit Profile")
                        ],
                      )
                    ],
                  ),
                ),
              ),
              dividerWidget(),
              SizedBox(
                height: 12.0,
              ),
              //Drawer Body Controls
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Visit Profile",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 300.0;
              });
              locatePosition();
            },
          ),

          //Hamburger button for drawer

          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7)),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  radius: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7))
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 18.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Hi there, ",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      "Where to?, ",
                      style:
                          TextStyle(fontSize: 22.0, fontFamily: "Brand Bold"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7))
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("Search Drop Off"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.blue[400],
                          size: 44,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Provider.of<AppData>(context).pickupLocation !=
                                      null
                                  ? Provider.of<AppData>(context)
                                      .pickupLocation!
                                      .placeName
                                      .toString()
                                  : "Add Address",
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Your Living home address",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    dividerWidget(),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.blue[400],
                          size: 44,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Work'),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Your office address",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
