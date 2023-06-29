import 'package:flutter/material.dart';
import 'package:mycity/constants.dart';

class CarousalData {
  CarousalData({this.imgList});

  List<String>? imgList;

  List<Widget> getCarousalWidgets() {
    return imgList!
        .map(
          (item) => Container(
            child: Container(
              //margin: EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child:
                          Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffA084DC),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: boxShadows,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
