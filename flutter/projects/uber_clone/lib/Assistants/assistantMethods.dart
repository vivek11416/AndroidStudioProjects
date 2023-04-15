import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/Assistants/requestAssistant.dart';
import 'package:uber_clone/DataHandler/appData.dart';
import 'package:uber_clone/Models/address.dart';

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
}
