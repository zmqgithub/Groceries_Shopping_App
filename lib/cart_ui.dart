import 'package:flutter/material.dart';
import 'model.dart';
import 'dialog.dart';
import 'orderplaced.dart';

 class FruitCart extends StatefulWidget {

   final Fruit fruit;

  const FruitCart({Key key, @required this.fruit}) : super(key: key);
   @override
   _FruitCartState createState() => _FruitCartState();
 }

 class _FruitCartState extends State<FruitCart> with SingleTickerProviderStateMixin {
   AnimationController _controller;
    int count = 1;
    int page = 0;
   @override
   void initState() {
     _controller = AnimationController(vsync: this);
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
     return Scaffold(appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.black),),
       backgroundColor: Colors.transparent,
       elevation: 0.0,
       iconTheme: IconThemeData(
         color: Colors.black, //change your color here
       ),
     ),
       body: Stack(
         children: <Widget>[
         Padding(padding: EdgeInsets.only(top: 30, left: 20, right: 20),
           child: Column(
             children: <Widget>[
               buildRow(Text('1 Item', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                   Text('\$5.7', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
               Padding(padding: EdgeInsets.only(top: 30),
                 child: Container(child: Row(children: <Widget>[
                   Container(
                     child: Center(child: Image.network(widget.fruit.image, ),),
                     height: 120,
                     margin: EdgeInsets.only(),
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(color: HexColor(widget.fruit.color),
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),),
                   Expanded(child: Container(
                     padding: EdgeInsets.all(8.0),
                     height: 120,
                     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Text(widget.fruit.name, style: TextStyle(fontWeight: FontWeight.bold),),
                         Padding(padding: EdgeInsets.only(top: 12, bottom: 20),
                           child: Text(widget.fruit.rate, style: TextStyle(fontWeight: FontWeight.w100),),),
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
                         ),

                       ],),

                     decoration: BoxDecoration(color: Colors.white,
                         borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))),)),

                 ],),decoration: BoxDecoration(
                     boxShadow: [new BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: Offset(2, 5))]
                 ),),),
               Align(alignment: Alignment.centerLeft,
                 child: Padding(padding: EdgeInsets.only(top: 30, bottom: 20),
                   child:  Text('Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),),
               buildRow(Text('Cart value'), Text('\$10.5')),
               buildRow(Text('Discount'), InkWell(child: Text('Apply coupon',  style: TextStyle(color: Colors.deepPurple[400]),),onTap: (){

               },)),
               buildRow(Text('Taxes'), Text('\$0.5')),
               buildRow(Text('Delivery charges'), Text('\$1.5')),

             ],),
         ),

         Align(alignment: Alignment.bottomCenter,
         child: InkWell(child: Container(
           height: 40,
           margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
           child: Center(child: Text('Pay', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),),
           decoration: BoxDecoration(color: Colors.deepPurple[400],
               borderRadius: BorderRadius.all(Radius.circular(30)),
               boxShadow: [new BoxShadow(color: Colors.deepPurple[400].withOpacity(0.5), offset: Offset(5, 5),
                 blurRadius: 5,
               )]),),onTap: (){

                showDialog(context: context, builder: (context) => SHDialog(
                  title: Text('Pay with card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  height: 400,
                  child: Column(
                    children: <Widget>[
                      Container(height: 220,
                      child: Stack(children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent[100],
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [new BoxShadow(color: Colors.deepPurple[400].withOpacity(0.5), offset: Offset(5, 5),
                                blurRadius: 5,
                              )]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 30, left: 0),
                                child: Text('Mr. Zulfiqar Ali', style: TextStyle(color: Colors.white, fontSize: 18),),),

                              Padding(padding: EdgeInsets.only(top: 50,),
                                child: Column(children: <Widget>[
                                  buildRow(Text('Card number', style: TextStyle(fontSize: 14, color: Colors.deepPurple),),
                                      Text('Exp date', style: TextStyle(fontSize: 14, color: Colors.deepPurple),)),

                                  buildRow(Text('4444 1254 1330 1234', style: TextStyle(fontSize: 14, color: Colors.white),),
                                      Text('12/2020', style: TextStyle(fontSize: 14, color: Colors.white),)),
                                ],),
                              )

                            ],),
                        ),
                        Align(alignment: Alignment.bottomRight,
                          child: InkWell(child: Container(
                            height: 50,
                            width: 150,

                            margin: EdgeInsets.only(right: 25),
                            decoration: BoxDecoration(color: Colors.green[300],
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                boxShadow: [new BoxShadow(color: Colors.green[300].withOpacity(0.2), offset: Offset(2, 2), blurRadius: 5)]
                            ),
                            child: Center(child: Text('Pay \$110', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),),)
                            ,onTap: (){
                              print('OnPay selected');
                              Navigator.of(context).pop();

                              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPlaced()));

                            },),),
                      ],),),
                      Padding(padding: EdgeInsets.only(top: 30),
                      child: Text('OR'),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Text('Select different payment method'),
                        IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){

                        })
                      ],)
                  ],),
                  onOkButtonPressed: (){

                  },
                ));
                
         },),)
       ],),
     );
   }

   Widget buildRow(itemA, itemB) => Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
   child: Row(children: <Widget>[
     Expanded(child: itemA),
     itemB
   ],),);
 }
