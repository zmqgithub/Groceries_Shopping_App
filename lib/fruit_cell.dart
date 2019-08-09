import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'model.dart';

class FruitCell extends StatefulWidget {
  final Color backgroundColor;
  final double borderRadius;
  final double width;
  final double height;
  final String url;
  final Fruit fruit;
  FruitCell(
      {
        @required this.fruit,
        this.backgroundColor = Colors.white,
      this.borderRadius = 8,
      this.width,
      this.height = 250,
      this.url});

  @override
  _FruitCellState createState() => _FruitCellState();
}

class _FruitCellState extends State<FruitCell> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: Container(
            child: Center(
              child: Image.network(widget.fruit.image,
                width: size.width/4,height: size.height/4, fit: BoxFit.scaleDown,),
            ),
            decoration: BoxDecoration(
                color:
                HexColor(widget.fruit.color).withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius),
                    topRight: Radius.circular(widget.borderRadius))),
          )),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              widget.fruit.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  widget.fruit.rate,
                  style: TextStyle(fontSize: 10),
                )),
                Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      child: InkWell(
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            count += 1;
                          });
                        },
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Colors.black),
                    ),
                    Container(height: 20, width: 15, color: Colors.black,
                    child: Center(child: Text('$count', style: TextStyle(fontSize: 10, color: Colors.white),),),),
                    Container(
                      width: 20,
                      height: 20,
                      child: InkWell(
                        child: Center(
                          child: Text(
                            '-',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            count -= 1;
                          });
                        },
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.black),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
      height: widget.height,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          boxShadow: [
            new BoxShadow(
                color: Colors.black.withOpacity(0.1), offset: Offset(2, 5), blurRadius: 2)
          ]),
    );
  }
}
