import 'package:flutter/material.dart';
import 'dialog.dart';
import 'networkdialog.dart';
import 'slider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

  double _values = 10;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
//            Builder(
//                builder: (context) => Container(
//                      child: Center(
//                        child: FlatButton.icon(
//                            onPressed: () {
//                              showDialog(
//                                context: context,
//                                builder: (_) => SHDialog(
//                                  onOkButtonPressed: (){
//                                    print('Dialog Canceled');
//                                  },
//                                  title: Text('How much you want?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
//                                  child: Column(children: <Widget>[
//                                  Container(
//                                    margin: EdgeInsets.only(left: 8.0, right: 8.0),
//                                    width: double.infinity, height: 100, color: Colors.deepOrange,)
//                                ],), ),
//                              );
//                            },
//                            icon: Icon(Icons.bubble_chart),
//                            label: Text('Popup dialog')),
//                      ),
//                    )),
//            Slider(value: _values,
//                min: 0,
//                max: 20,
//                divisions: 10,
//                label: '$_values',
//
//                onChanged: (value){
//              print(value);
//              setState(() {
//                _values = value;
//              });
//            }),
            SHSlider()
          ],
        ));
  }
}
