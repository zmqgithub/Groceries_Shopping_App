import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class SHSlider extends StatefulWidget {
  @override
  _SHSliderState createState() => _SHSliderState();
}

class _SHSliderState extends State<SHSlider> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Offset offset = new Offset(100, 100);
  ui.Image image;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    initImage();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Future <Null> initImage() async {

    final ByteData data = await rootBundle.load('assets/strwberry.png',);

    image = await loadImage(new Uint8List.view(data.buffer));

    print(image.toString());
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        print('Image Loaded');
      });
      return completer.complete(img);
    });
    return completer.future;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
    Center(child: CustomPaint(painter: Pointer(offset, image), size: Size(size.width, size.height/2),),),
      Container(
        child: GestureDetector( onPanUpdate: (dragUpdate){
          print(dragUpdate.globalPosition);
          setState(() {
            offset = Offset(dragUpdate.localPosition.dx, offset.dy);
          });
        }, onPanDown: (onPanDown){
          print(onPanDown.localPosition);
          setState(() {
            offset = Offset(onPanDown.localPosition.dx, offset.dy);
          });
        },),)
    ],);
  }
}


class Pointer extends CustomPainter{

  Offset offset;
  ui.Image image;
  Pointer(this.offset, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.fill;

    double padding = size.width/6;
    int divisions = 6;
    double segment = (size.width - 2*padding)/divisions;

    double min = 0;
    double max = 10;
    String unit = 'Kg';

    double fontSize = 20;
    
    double dx = (((offset.dx.floor() - padding/2)~/segment).toInt())*segment;
    dx = (dx > size.width - 2*padding)?(size.width - 2*padding):dx;
    Offset reOffset = Offset(dx + padding, size.height/2);


    paint..strokeWidth = 8;
    paint..color = Colors.green.withOpacity(0.5);
    paint..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(9.9*padding/10, size.height/2), Offset(size.width - 9.9*padding/10, size.height/2), paint);

    TextSpan spanMinLimit = new TextSpan(style: new TextStyle(color: Colors.black, fontSize: 3*fontSize/4), text: '$min');
    TextPainter minTp = new TextPainter(text: spanMinLimit, textAlign: TextAlign.left, textDirection: TextDirection.ltr,);
    minTp.layout();

    minTp.paint(canvas, Offset(padding - (spanMinLimit.text.length)*fontSize/2, size.height/2 - fontSize/2));
    
    TextSpan spanMaxLimit = new TextSpan(style: new TextStyle(color: Colors.black, fontSize: 3*fontSize/4), text: '$max');
    TextPainter maxTp = new TextPainter(text: spanMaxLimit, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    maxTp.layout();

    maxTp.paint(canvas, Offset(size.width - padding + 6, size.height/2 - fontSize/2));

    for(int i = 0; i <= divisions; i ++){
      canvas.drawCircle(Offset(padding + i*segment, size.height/2), 2, paint..color = Colors.deepPurpleAccent);
    }

    canvas.drawCircle(reOffset, 30, paint..color = Colors.deepPurpleAccent);

    Path path = Path();
    path.moveTo(reOffset.dx, reOffset.dy - 35);
    path.lineTo(reOffset.dx - 5, reOffset.dy - 40);
    path.lineTo(reOffset.dx + 5, reOffset.dy - 40);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.grey, 2.0, true);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(reOffset.dx - 35, reOffset.dy - 80, 70, 40),Radius.circular(10.0)),paint..color = Colors.deepPurpleAccent);

    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.white, fontSize: fontSize), text: '2.0 $unit');
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(reOffset.dx - (span.text.length/2)*fontSize/2, reOffset.dy - 60 - (0.5*fontSize)));
    if(image != null) {
      paintImage(image, Rect.fromLTRB(reOffset.dx-15, reOffset.dy - 15, reOffset.dx + 15, reOffset.dy + 15), canvas, paint, BoxFit.cover);
    }
  }

  void paintImage(ui.Image image, Rect outputRect, Canvas canvas, Paint paint, BoxFit fit) {
    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
    final Rect inputSubRect = Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubRect = Alignment.center.inscribe(sizes.destination, outputRect);
    canvas.drawImageRect(image, inputSubRect, outputSubRect, paint);
  }

  @override
  bool shouldRepaint(Pointer oldDelegate) {
    return oldDelegate.offset != offset;
  }

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

}