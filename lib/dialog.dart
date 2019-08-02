import 'dart:async';

import 'package:flutter/material.dart';

class SHDialog extends StatefulWidget {
  final Widget title;
  final double height;
  final Icon icon;
  final Widget child;
  final backgroundColor;
  final VoidCallback onOkButtonPressed;
  SHDialog({
    this.title = const Text('😃 I\'m title' ),
    this.icon = const Icon(Icons.cancel, color: Colors.grey,),
    this.child = const Text('Hello 😀\n Replace me with your widgets\n Thank You'),
    this.height = 0,
    this.backgroundColor = Colors.white,
    this.onOkButtonPressed,
  });
  @override
  _SHDialogState createState() => _SHDialogState();
}

class _SHDialogState extends State<SHDialog> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _height = 0;
  double _opacity = 0;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    Timer(Duration(milliseconds: 100), () {
     setState(() {
       Size size = MediaQuery.of(context).size;
       _height = widget.height == 0? size.height/3:widget.height;
       _opacity = 1;
     });
    });
    super.initState();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      Scaffold(
        backgroundColor: Colors.transparent,
        body:
        Container(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(alignment: Alignment.bottomCenter,
              child: AnimatedOpacity(opacity: _opacity,duration: Duration(milliseconds: 800),
                child: AnimatedContainer(duration: Duration(milliseconds: 700),
                  curve: ElasticOutCurve(),
                  margin: EdgeInsets.only(left: 0.0, right: 0.0),
                  height: _height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(size.width/16), topLeft: Radius.circular(size.width/16)),
                      boxShadow: [new BoxShadow(color: Colors.grey, offset: Offset(4, 4), blurRadius: 40)]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(children: <Widget>[
                        SizedBox(width: size.width/20,),
                        Expanded(child: widget.title),
                        IconButton(icon: widget.icon, onPressed: (){
                          setState(() {
                            _height = _height/2.5;
                            _opacity = 0;
                          });
                          widget.onOkButtonPressed();
                          Timer(Duration(milliseconds: 400), () {
                            Navigator.of(context).pop();
                            widget.onOkButtonPressed();
                          });

                        })],),
                      Expanded(child: SingleChildScrollView(child: widget.child,))
                    ],),
                ),),
            ),
          ],
        ),),
      )
    ],);
  }
}
