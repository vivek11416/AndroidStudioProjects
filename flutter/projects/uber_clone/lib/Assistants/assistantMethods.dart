import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/AllScreens/registrationScreen.dart';
import 'package:uber_clone/Assistants/requestAssistant.dart';
import 'package:uber_clone/DataHandler/appData.dart';
import 'package:uber_clone/Models/address.dart';
import 'package:uber_clone/Models/directionDetails.dart';
import 'package:uber_clone/configMaps.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String url =
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&zoom=18&addressdetails=1";
    var response = await RequestAssistant.getRequest(Uri.parse(url));

    if (response != "Failed") {
      placeAddress =
          response['address']['city'] + ", " + response['address']['country'];
      Address userPickupAddress = new Address();
      userPickupAddress.placeName = placeAddress;
      userPickupAddress.latitude = position.latitude;
      userPickupAddress.longitude = position.longitude;

      Provider.of<AppData>(context, listen: false)
          .updatePickupLocationAddress(userPickupAddress);
    }

    return placeAddress;
  }

  static Future<DirectionDetails> obtainPlaceDirectionsDetails(
      LatLng initialPosition, LatLng finalPosition, context) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?destination=${finalPosition.latitude},${finalPosition.longitude}&origin=${initialPosition.latitude},${initialPosition.longitude}&key=$mapKey";
    var res = await RequestAssistant.getRequest(Uri.parse(directionUrl));

    if (res == "failed") {
      displayToastMessage("The Google direction API gave an error !", context,
          duration: Toast.LENGTH_LONG);
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints =
        res["routes"][0]['overview_polyline']['points'];

    directionDetails.distanceText =
        res["routes"][0]['legs'][0]['distance']['text'];

    directionDetails.diatanceValue =
        res["routes"][0]['legs'][0]['distance']['value'];

    directionDetails.durationText =
        res["routes"][0]['legs'][0]['duration']['text'];

    directionDetails.durationValue =
        res["routes"][0]['legs'][0]['duration']['value'];

    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    // in INR
    double timeTraveledFare = (directionDetails.durationValue! / 60) * 0.20;
    double distanceTraveledFare =
        (directionDetails.diatanceValue! / 1000) * 0.20;

    double totalFare = (timeTraveledFare + distanceTraveledFare) * 82;

    return totalFare.truncate();
  }
}
