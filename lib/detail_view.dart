import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'model.dart';
import 'dialog.dart';
import 'slider.dart';
import 'cart_ui.dart';

class FruitDetails extends StatefulWidget {
  final String imageUrl;
  final Fruit fruit;
  FruitDetails({@required this.fruit,this.imageUrl});

  @override
  _FruitDetailsState createState() => _FruitDetailsState();
}

class _FruitDetailsState extends State<FruitDetails> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  Color appBarColor;
  @override
  void initState() {
    appBarColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(0.5);
    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));//..repeat();
    CurvedAnimation curve = CurvedAnimation(parent: _controller, curve: ElasticOutCurve());
    animation = Tween(begin: 0.0, end: 360.0).animate(curve);
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
    Size size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
    Container(color: Colors.white,),
      ClipPath(clipper: ArcClipper(), child:
      Container(color: HexColor(widget.fruit.color),)),
      Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[IconButton(icon: Icon(Icons.shopping_cart, color: Colors.blueGrey[800],), onPressed: (){

          })],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(child: Stack(children: <Widget>[
          Align(alignment: Alignment.topCenter,
            child: Padding(padding: EdgeInsets.only(top: size.height/30),
              child: Image.network(widget.fruit.image, width: 150*animation.value/360, height: 150*animation.value/360,),),),
          Align(alignment: Alignment.topCenter,
            child: Padding(padding: EdgeInsets.only(top: size.height/20, left: 4, right: 4),
              child: Container(
                height: 100,

                child: Row(children: <Widget>[
                  Expanded(child: Align(alignment: Alignment.centerLeft,
                    child: FloatingActionButton(onPressed: (){

                    }, heroTag: 'left', child: Icon(Icons.arrow_back), backgroundColor: Colors.black54, elevation: 0.1),)),
                  Expanded(child: Align(alignment: Alignment.centerRight,
                    child: FloatingActionButton(onPressed: (){

                    }, heroTag: 'right', child: Icon(Icons.arrow_forward), backgroundColor: Colors.black54, elevation: 0.1,),))
                ],),),),),

          Align(alignment: Alignment.topCenter,
            child: Padding(padding: EdgeInsets.only(top: size.height/4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(widget.fruit.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  Padding(padding: EdgeInsets.only(top: 18),
                    child: Text(widget.fruit.rate, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),),

                  Padding(padding: EdgeInsets.only(top: 14, left: 20, right: 20),
                    child: Text(widget.fruit.desc, textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87),),),

                  Padding(padding: EdgeInsets.only(top: 20),
                    child: Text('Nutritional Value', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),

                  Container(margin: EdgeInsets.only(top: 20, bottom: 20),
                    width: 100,
                    height: 100,

                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.fruit.nutritions.value.value, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.fruit.nutritions.value.desc, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200),),
                      ],)),
                    decoration: BoxDecoration(color: Colors.deepPurple[400], borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),

                  Row(children: <Widget>[
                    description(widget.fruit.nutritions.fat.value, widget.fruit.nutritions.fat.desc, Colors.black),
                    description(widget.fruit.nutritions.carbhyd.value, widget.fruit.nutritions.carbhyd.desc, Colors.black),
                    description(widget.fruit.nutritions.protein.value, widget.fruit.nutritions.protein.desc, Colors.black),
                  ],),

                  InkWell(child: Container(margin: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30.0),
                    height: 50,
                    decoration: BoxDecoration(color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [new BoxShadow(color: Colors.deepPurple[400].withOpacity(0.5), offset: Offset(5, 5),
                          blurRadius: 5,
                        )]),

                    child: Center(child: Text('Add to Cart', style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold,
                        fontSize: 20),),),
                  ),onTap: (){
                    print('Add to Cart Selected');
                    showDialog(context: context, builder: (context){
                      return SHDialog(height: 300,//size.height/3,
                        title: Text('How much you want', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        child: Column(children: <Widget>[
                          SHSlider(path: 'assets/strwberry.png', backgroundColor: HexColor(widget.fruit.color),
                          min: 1, max: 5, divisions: 8, lineWidth: 10,),

                          InkWell(child: Container(child: Center(child: Text('Confirm', style: TextStyle(fontSize: 20, color: Colors.white),),),
                          height: 50,
                          margin: EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
                          decoration:  BoxDecoration(color: HexColor(widget.fruit.color),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: [new BoxShadow(color: HexColor(widget.fruit.color).withOpacity(0.5), offset: Offset(5, 5),
                                blurRadius: 5,
                              )]),),onTap: (){

                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FruitCart(fruit: widget.fruit,)));
                          },)

                        ],),
                        onOkButtonPressed: (){

                      },);
                    });
                  },)

                ],),),)

        ],),),)
    ],);
  }

  Widget description(value, desc, color) => Expanded(child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('$value', style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold),),
      Text('$desc', style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w200),),
  ],));
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0.0, size.height/6);
    path.quadraticBezierTo(size.width/2, size.height/3, size.width, size.height/6);
    path.lineTo(size.width, size.height/6);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
