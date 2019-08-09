import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class SHSlider extends StatefulWidget {

  final String path;
  final int divisions;
  final double min, max;
  final String unit;
  final double fontSize;
  final double padding;
  final double lineWidth;
  final Color backgroundColor;
  final Color color;
  final void Function(double value) callback;

  SHSlider({this.path,
    this.divisions = 10,
    this.min = 0,
    this.max = 100,
    this.unit = '',
    this.fontSize = 20,
    this.padding,
    this.lineWidth = 2,
    this.backgroundColor = Colors.blue,
    this.color = Colors.black,
    this.callback
  });

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
    initImage(widget.path);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future <Null> initImage(path) async {
    final ByteData data = await rootBundle.load(path,);
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
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 100, child: Stack(children: <Widget>[
      Align(alignment: Alignment.bottomCenter,
        child: CustomPaint(painter: Pointer(offset: offset,
            image: image,
            divisions: widget.divisions,
            min: widget.min,
            max: widget.max,
            unit: widget.unit,
            fontSize: widget.fontSize,
            lineWidth: widget.lineWidth,
            backgroundColor: widget.backgroundColor,
            color: widget.color, callback: (value){
//              print(value);
              if(widget.callback != null)
                widget.callback(value);
            }),
          size: Size(size.width, size.height)
          ,),),
      Container(
//        color: Colors.lightGreen.withOpacity(0.2),
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
    ]),);
  }
}


class Pointer extends CustomPainter{

  Offset offset;
  ui.Image image;
  int divisions;
  double min, max;
  String unit;
  double fontSize;
  double padding;
  double lineWidth;
  Color backgroundColor;
  Color color;
  final void Function(double value) callback;
  Pointer({
    this.offset,
    this.image,
    this.divisions,
    this.min,
    this.max,
    this.unit,
    this.padding,
    this.fontSize,
    this.color,
    this.backgroundColor,
    this.lineWidth,
    this.callback
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    padding = this.padding == null?size.width/6: this.padding;
    double segment = (size.width - 2*padding)/divisions;

    divisions = divisions !=null? divisions:((max - min) < 0?(max - min)*10:(max - min));
    double dx = (((offset.dx.floor() - padding/2)~/segment).toInt())*segment;
    dx = (dx > size.width - 2*padding)?(size.width - 2*padding):dx;
    dx  = dx < padding/divisions? 0: dx;
    Offset reOffset = Offset(dx + padding, size.height/2);

    double pox = min + (((reOffset.dx-padding)/segment)*((max - min)/divisions));

    callback(pox);

    paint..strokeWidth = lineWidth;
    paint..color = backgroundColor;
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
      canvas.drawCircle(Offset(padding + i*segment, size.height/2), 2, paint..color = color);
    }

    canvas.drawCircle(reOffset, 30, paint..color = backgroundColor);

    Path path = Path();
    path.moveTo(reOffset.dx, reOffset.dy - 35);
    path.lineTo(reOffset.dx - 5, reOffset.dy - 40);
    path.lineTo(reOffset.dx + 5, reOffset.dy - 40);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.grey, 2.0, true);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(reOffset.dx - 35, reOffset.dy - 80, 70, 40),Radius.circular(10.0)),paint..color = backgroundColor);

    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.white, fontSize: fontSize), text: '${pox.toStringAsFixed(1)} $unit');
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