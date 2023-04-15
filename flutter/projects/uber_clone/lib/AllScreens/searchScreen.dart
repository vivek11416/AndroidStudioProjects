import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:uber_clone/DataHandler/appData.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickupTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String placeAddress = Provider.of<AppData>(context).pickupLocation != null
        ? Provider.of<AppData>(context).pickupLocation!.placeName.toString()
        : "";

    pickupTextEditingController.text = placeAddress;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                top: 20.0,
                right: 25.0,
                bottom: 20.0,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Set Drop Off",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Brand Bold",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Image.asset(
                          "assets/images/pick-up.gif",
                          height: 60.0,
                          width: 60.0,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            //borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              3.0,
                            ),
                            child: TextField(
                              controller: pickupTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Pickup Location",
                                fillColor: Color(0xFFFFE438),
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.0,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Image.asset(
                          "assets/images/drop-off.gif",
                          height: 60.0,
                          width: 60.0,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            //borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              3.0,
                            ),
                            child: TextField(
                              controller: dropOffTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                fillColor: Color(0xFFFFE438),
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
