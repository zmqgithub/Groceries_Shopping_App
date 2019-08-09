import 'dart:convert';

import 'package:flutter/material.dart';
import 'dialog.dart';
import 'networkdialog.dart';
import 'slider.dart';
import 'fruit_cell.dart';
import 'detail_view.dart';
import 'model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//  List<String> widgetList = ['https://cdn.pixabay.com/photo/2016/02/23/17/42/orange-1218158_960_720.png',
//    'http://pngimg.com/uploads/kiwi/kiwi_PNG4028.png',
//    'http://pngimg.com/uploads/pineapple/pineapple_PNG2733.png',
//  'http://pngimg.com/uploads/apricot/apricot_PNG12656.png',
//  'https://storage.needpix.com/rsynced_images/guava-2836148_1280.png',
//  'https://cdn.pixabay.com/photo/2016/02/23/17/44/apple-1218166_960_720.png',
//  'https://upload.wikimedia.org/wikipedia/commons/d/dc/Orange-fruit.png',
//  'https://cdn.pixabay.com/photo/2018/10/11/00/15/fruit-3738720_960_720.png',
//  'https://storage.needpix.com/rsynced_images/papaya-708779_1280.png',
//  ];
  List<String>fruitsName = ['Fruits', 'Veggies', 'Staple'];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = size.height > 800?size.height/3.5: size.height/2.75;
    final double itemWidth = size.width / 2;

    return Scaffold(
        body: SafeArea(child: FutureBuilder(
            future: DefaultAssetBundle
                .of(context)
                .loadString('assets/fruits.json'),
            builder: (context, snapshot){
          if(snapshot.hasData){

            List parsedJson = json.decode(snapshot.data.toString());
            List<Fruit> dataList = parsedJson.map((i)=>Fruit.fromJson(i)).toList();

            return Stack(children: <Widget>[
              Column(children: <Widget>[
                profilePic(),
                itemList(),
                contentList(itemHeight,itemWidth, dataList)
              ],),
              bottomMenu()
            ],);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        })));
  }

  Widget profilePic() => Align(alignment: Alignment.topLeft,
    child: Padding(padding: EdgeInsets.only(top: 4, left: 8),
      child: CircleAvatar(
        radius: 20.0,
        backgroundImage:
        NetworkImage('https://scontent-sin6-2.xx.fbcdn.net/v/t1.0-1/c0.0.160.160a/p160x160/1898205_10203216793644653_1200563537_n.jpg?_nc_cat=109&_nc_oc=AQkUXcGN4BB1PcUn7tS93XWzRRGbGzfwck5UA8ChY4mwKz3XrMlUZo4eBAzGhp_uXSs&_nc_ht=scontent-sin6-2.xx&oh=02e3e948478b06ba3d19ab4dc2203e49&oe=5DA588C4'),
        backgroundColor: Colors.transparent,
      ),),);

  Widget itemList() => Container(
    height: 50,
    child: Center(child: ListView.builder(itemBuilder: (context, index){
      return FlatButton(onPressed: (){
        setState(() {
          selected = index;
        });
      }, child: Text(fruitsName[index],
        style: TextStyle(color: index == selected?Colors.black:Colors.grey, fontSize: 25),));
    }, itemCount: fruitsName.length, scrollDirection: Axis.horizontal,),),
  );
  
  Widget contentList(itemHeight,itemWidth, dataList) => Expanded(child: Container(
    margin: EdgeInsets.only(left: 16, right: 16),
    child: new GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: new ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: dataList.map<Widget>((value) {
        print(value);
        Fruit fruit = value;
        return GestureDetector(child: FruitCell(fruit: fruit,),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => FruitDetails(fruit: fruit,)));
        },);
      }).toList(),
    ),
  ));

  Widget bottomMenu() => Align(alignment: Alignment.bottomCenter,
  child: Container(
    margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.white,
      boxShadow: [new BoxShadow(color: Colors.black38, blurRadius: 15, offset: Offset(5, 5))]
    ),
    child: Row(children: <Widget>[
      menuButton(Icons.home, 0),
      menuButton(Icons.search, 1),
      menuButton(Icons.shopping_cart, 2),
    ],),
  ),);

  Widget menuButton(icon, index) => Expanded(child: Center(child: IconButton(icon: Icon(icon,
    color: index == 0?Colors.deepPurple[400]:Colors.black,), onPressed: (){
    print(icon.toString());
  }),));
}
