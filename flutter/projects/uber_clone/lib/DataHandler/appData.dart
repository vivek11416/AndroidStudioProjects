import 'package:flutter/material.dart';
import 'package:uber_clone/Models/address.dart';

class AppData extends ChangeNotifier {
  Address? pickupLocation;

  void updatePickupLocationAddress(Address pickupAddress) {
    pickupLocation = pickupAddress;
    notifyListeners();
  }
}
