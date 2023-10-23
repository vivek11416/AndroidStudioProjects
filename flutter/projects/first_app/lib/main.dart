import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

String FILENAME = 'timg.jpeg';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: PainterPage(), // PosterPage(),
    );
  }
}

class PainterPage extends StatefulWidget {
  @override
  _PainterPageState createState() {
    return _PainterPageState();
  }
}

class _PainterPageState extends State<PainterPage> {
  late ImageInfo _imageInfo;
  GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    // load Image
    var imgUrl =
        'https://img.tuguaishou.com/ips_templ_preview/0b/66/10/lg_2034979_1566193207_5d5a363796f4e.jpg!w384?auth_key=2199888000-0-0-80d642dfdc7b206f09b718c79547acc8&v=1554825701';
    var img = NetworkImage(imgUrl);
    img.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          setState(() {
            _imageInfo = info;
          });
        },
      ),
    );
  }

  _handleSavePressed() async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    var painter = _PosterPainter(_imageInfo);
    var size = _containerKey.currentContext!.size;

    painter.paint(canvas, size!);
    ui.Image renderedImage = await recorder
        .endRecording()
        .toImage(size!.width.floor(), size.height.floor());

    var pngBytes =
        await renderedImage.toByteData(format: ui.ImageByteFormat.png);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('制作'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('save'),
        onPressed: _handleSavePressed,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                key: _containerKey,
                child: InteractiveViewer(
                  child: CustomPaint(
                    painter: _PosterPainter(_imageInfo),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PosterPainter extends CustomPainter {
  ImageInfo imageInfo;

  _PosterPainter(this.imageInfo);

  paint(Canvas canvas, Size size) {
    if (imageInfo != null) {
      canvas.save();
      canvas.drawImageRect(
        imageInfo.image,
        Rect.fromLTWH(
          0,
          0,
          imageInfo.image.width.toDouble(),
          imageInfo.image.height.toDouble(),
        ),
        Rect.fromLTWH(
          0,
          0,
          size.width,
          imageInfo.image.height.toDouble() /
              (imageInfo.image.width.toDouble() / size.width),
        ),
        Paint(),
      );
      canvas.restore();
    }

    canvas.drawRect(
        Rect.fromLTWH(10, 40, size.width, size.height),
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke);

    canvas.drawRect(
        Rect.fromLTWH(20, 50, size.width, size.height),
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
