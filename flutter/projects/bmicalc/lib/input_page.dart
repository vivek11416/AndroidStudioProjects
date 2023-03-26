import 'package:flutter/material.dart';

const bottomContainerHeight = 60.0;
const activeCardColor = 0xFF1D1E33;
const bottomContainerColor = 0xFFEB1555;

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: containersCard(
                    color: Color(activeCardColor),
                  ),
                ),
                Expanded(
                  child: containersCard(
                    color: Color(activeCardColor),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: containersCard(
              color: Color(activeCardColor),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: containersCard(
                    color: Color(activeCardColor),
                  ),
                ),
                Expanded(
                  child: containersCard(
                    color: Color(activeCardColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(bottomContainerColor),
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: bottomContainerHeight,
          )
        ],
      ),
    );
  }
}

class containersCard extends StatelessWidget {
  containersCard({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
