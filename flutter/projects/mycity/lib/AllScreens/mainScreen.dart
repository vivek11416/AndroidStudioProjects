import 'package:flutter/material.dart';
import 'package:mycity/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mycity/modals/carousalData.dart';
import 'package:mycity/widgets/shadowContainers.dart';

final List<Widget> imageSliders =
    CarousalData(imgList: imgList).getCarousalWidgets();

class MainScreen extends StatefulWidget {
  MainScreen({super.key});
  static const String idScreen = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).secondaryHeaderColor,
      backgroundColor: Color(0xfff5f7fb),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hi Vivek,',
                          style: TextStyle(
                            fontFamily: "Teko",
                            fontSize: 35,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        Icon(
                          Icons.menu_open,
                          color: Theme.of(context).primaryColorDark,
                          size: 45,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.4,
                        aspectRatio: 18 / 9,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 5.0,
                          height: 5.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Theme.of(context).primaryColorDark
                                      : Theme.of(context).unselectedWidgetColor)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShadowContainers(),
                ShadowContainers(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShadowContainers(),
                ShadowContainers(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.insights,
                    size: 35,
                  ),
                  Icon(
                    Icons.roofing_rounded,
                    size: 35,
                  ),
                  Icon(
                    Icons.person_2_outlined,
                    size: 35,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
