import 'package:flutter/material.dart';


class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
//    _controller = AnimationController(vsync: this);
    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));//..repeat();
    CurvedAnimation curve = CurvedAnimation(parent: _controller, curve: ElasticOutCurve());
    _animation = Tween(begin: 0.0, end: 1.0).animate(curve);
    _controller.addListener((){
      setState(() {
      });
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green[400],
      body: Align(alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle, color: Colors.white, size: 100*_animation.value,),
            Padding(padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Text('Order Placed', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),),
            InkWell(child: Container(
              height: 50,
              margin: EdgeInsets.all(30),
              child: Center(
              child: Text('Continue shopping.....', style: TextStyle(color: Colors.white),),),
            decoration: BoxDecoration(color: Colors.black38,
            borderRadius: BorderRadius.all(Radius.circular(25))),
            ), onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },),

          ],),),
    );
  }
}
