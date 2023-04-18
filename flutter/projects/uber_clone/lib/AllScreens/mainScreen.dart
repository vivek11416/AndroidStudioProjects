import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/AllScreens/loginScreen.dart';
import 'package:uber_clone/AllScreens/registrationScreen.dart';
import 'package:uber_clone/AllScreens/searchScreen.dart';
import 'package:uber_clone/AllWidgets/Divider.dart';
import 'package:uber_clone/AllWidgets/progressDialog.dart';
import 'package:uber_clone/Assistants/assistantMethods.dart';
import 'package:uber_clone/DataHandler/appData.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uber_clone/Models/directionDetails.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:uber_clone/configMaps.dart';

// animated text constants

const colorizeColors = [
  Colors.green,
  Colors.purple,
  Colors.pink,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 55,
  fontFamily: 'Signatra',
);
// =======================

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();

  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  DirectionDetails? tripDirectionDetails;
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polyLineSet = {};

  double rideDetailsContainerHeight = 0;
  double searchContainerHeight = 300.0;
  double requestWaitContainerHeight = 0;

  bookingWaitForCab() {
    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 0;
      requestWaitContainerHeight = 300;
    });
  }

  DatabaseReference? rideRequestRef;

  @override
  void initState() {
    super.initState();
    AssistantMethods.getCurrentOnlineUSerInfo();
  }

  void saveRideRequest() {
    rideRequestRef =
        FirebaseDatabase.instance.ref().child("Ride_Requests").push();
    var pickUp = Provider.of<AppData>(context, listen: false).pickupLocation;
    var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;

    Map pickupLocMap = {
      "latitide": pickUp!.latitude.toString(),
      "longitude": pickUp.longitude.toString(),
      "pickup_address": pickUp.placeName,
    };

    Map dropOffLocMap = {
      "latitide": dropOff!.latitude.toString(),
      "longitude": dropOff.longitude.toString(),
      "dropOff_address": dropOff.placeName,
    };

    Map rideInfoMap = {
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickup": pickupLocMap,
      "dropoff": dropOffLocMap,
      "created_at": DateTime.now().toString(),
      "rider_name": userCurrentInfo!.name,
      "rider_phone": userCurrentInfo!.phone,
    };

    rideRequestRef!.set(rideInfoMap);
  }

  resetApp() {
    setState(() {
      searchContainerHeight = 300;
      rideDetailsContainerHeight = 0;
      requestWaitContainerHeight = 0;
      polyLineSet.clear();
      markerSet.clear();
      circleSet.clear();
      pLineCoordinates.clear();
    });
    locatePosition();
  }

  void cancelRideRequest() {
    rideRequestRef!.remove();
  }

  void displayrideDetailsContainer() async {
    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 300;
    });
    saveRideRequest();
  }

  void resetHomeAddress() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
  }

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
      primary: true,
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: null,
      // AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     'Main Screen',
      //     style: TextStyle(
      //       fontSize: 35.0,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
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
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 100.0),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polyLineSet,
            markers: markerSet,
            circles: circleSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 300.0;
              });
              locatePosition();
            },
            onCameraIdle: () {
              resetHomeAddress();
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
            child: AnimatedSize(
              //vsync: this,
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 160),
              child: Container(
                height: searchContainerHeight,
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
                        onTap: () async {
                          var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()));

                          if (res == "obtainedDirection") {
                            //await getPlaceDirection();
                            displayrideDetailsContainer();
                          }
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
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.tealAccent[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/taxi.png',
                                height: 70.0,
                                width: 80.0,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "car",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Brand Bold',
                                    ),
                                  ),
                                  Text(
                                    ((tripDirectionDetails != null)
                                        ? "${tripDirectionDetails!.distanceText.toString()}"
                                        : ""),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  ((tripDirectionDetails != null)
                                      ? "₹ ${AssistantMethods.calculateFares(tripDirectionDetails!)}"
                                      : ""),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      fontFamily: 'Brand Bold'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.moneyCheck,
                              size: 18,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Text("Cash"),
                            SizedBox(
                              width: 6.0,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black54,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 5,
                        ),
                        child: SwipeTo(
                          onRightSwipe: () {
                            //print('Swiped Right');
                            bookingWaitForCab();
                          },
                          iconOnRightSwipe: Icons.check,
                          iconOnLeftSwipe: Icons.cancel,
                          onLeftSwipe: () {
                            //print('Swiped Left');
                            cancelRideRequest();
                            resetApp();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blueAccent, Colors.red],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                null;
                              },
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Book",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Swipe Right",
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.lightBlueAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.arrowRight,
                                          color: Colors.white,
                                          size: 26.0,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.ban,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Cancel",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Swipe Left",
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.lightBlueAccent,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.5,
                    blurRadius: 16.0,
                    color: Colors.black54,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              height: requestWaitContainerHeight,
              child: Column(
                children: [
                  SizedBox(
                    height: 114.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'Requesting a Ride.....',
                          textStyle: colorizeTextStyle,
                          textAlign: TextAlign.center,
                          colors: colorizeColors,
                        ),
                        ColorizeAnimatedText(
                          'Please wait.....',
                          textStyle: colorizeTextStyle,
                          textAlign: TextAlign.center,
                          colors: colorizeColors,
                        ),
                        ColorizeAnimatedText(
                          'Finding a driver.....',
                          textStyle: colorizeTextStyle,
                          textAlign: TextAlign.center,
                          colors: colorizeColors,
                        ),
                      ],
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 22.0,
                  ),
                  TextButton(
                    onPressed: () {
                      cancelRideRequest();
                      resetApp();
                    },
                    child: Text(
                      "Cancel Request",
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickupLocation;

    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLong = LatLng(
        initialPos!.latitude!.toDouble(), initialPos.longitude!.toDouble());

    var dropOffLatLong =
        LatLng(finalPos!.latitude!.toDouble(), finalPos.longitude!.toDouble());

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(message: "Please wait...."),
    );
    var details = await AssistantMethods.obtainPlaceDirectionsDetails(
        pickUpLatLong, dropOffLatLong, context);

    setState(() {
      tripDirectionDetails = details;
    });

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResults =
        polylinePoints.decodePolyline(details.encodedPoints.toString());
    pLineCoordinates.clear();
    if (decodedPolyLinePointsResults.isNotEmpty) {
      decodedPolyLinePointsResults.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polyLineSet.clear();
    setState(() {
      Polyline polyLine = Polyline(
        polylineId: PolylineId("PolyLineID"),
        color: Colors.pink,
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 2,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      polyLineSet.add(polyLine);
    });
    LatLngBounds latLngBounds;
    if (pickUpLatLong.latitude > dropOffLatLong.latitude &&
        pickUpLatLong.longitude > dropOffLatLong.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLong, northeast: pickUpLatLong);
    } else if (pickUpLatLong.latitude > dropOffLatLong.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLong.latitude, pickUpLatLong.longitude),
          northeast: LatLng(pickUpLatLong.latitude, dropOffLatLong.longitude));
    } else if (pickUpLatLong.longitude > dropOffLatLong.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLong.latitude, dropOffLatLong.longitude),
          northeast: LatLng(dropOffLatLong.latitude, pickUpLatLong.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLong, northeast: dropOffLatLong);
    }

    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickupLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(
          title: initialPos.placeName,
          snippet: "my Loaction",
        ),
        position: pickUpLatLong,
        markerId: MarkerId("pickupId"));

    Marker dropOffLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: initialPos.placeName,
        snippet: "Drop Off Location",
      ),
      position: dropOffLatLong,
      markerId: MarkerId("dropOffId"),
    );

    setState(() {
      markerSet.add(pickupLocationMarker);
      markerSet.add(dropOffLocationMarker);
    });

    Circle pickupCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLong,
      radius: 12,
      strokeWidth: 2,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickupId"),
    );

    Circle dropOffCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLong,
      radius: 12,
      strokeWidth: 2,
      strokeColor: Colors.deepPurple,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      circleSet.add(pickupCircle);
      circleSet.add(dropOffCircle);
    });
  }
}
