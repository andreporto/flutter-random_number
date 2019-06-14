import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple random number generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Random Number Generator'),
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
  String _counter = '';
  Random random = new Random();
  Map<int, int> pickedNumbers = {};
  int maxNumber = 10;

  int randomize() {
    return this.random.nextInt(maxNumber) + 1;
  }

  void _randomNumer() {
    setState(() {
      int sizePickedNumberList = pickedNumbers.length;
      if (sizePickedNumberList < maxNumber) {
        int pickedNumber = randomize();
        while (pickedNumbers.containsKey(pickedNumber)) {
          pickedNumber = randomize();
        }
        pickedNumbers[pickedNumber] = sizePickedNumberList + 1;
        _counter = pickedNumber.toString();
        print(pickedNumbers);
      }
    });
  }

  void _reset() {
    setState(() {
      pickedNumbers = {};
      _counter = '';
    });
  }

  void _onMaxNumberChange(value) {
    setState(() {
      maxNumber = int.parse(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue, fontSize: 40),
                key: Key('maxNumberField'),
                onChanged: _onMaxNumberChange,
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
              ),
            ),
            if (pickedNumbers.length < maxNumber)
              Text(
                'Pushe the blue button to pick a number',
                style: TextStyle(fontSize: 20, color: Colors.blue),
                textAlign: TextAlign.center,
              )
            else
              Text(
                'No numbers left!',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            if (pickedNumbers.length > 0)
              Text(
                'Last picked number:',
                style: TextStyle(fontSize: 30),
              ),
            if (pickedNumbers.length <= maxNumber)
              Text(
                '$_counter',
                style: TextStyle(
                    fontSize: 100,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: (pickedNumbers.length < maxNumber)
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (pickedNumbers.length < maxNumber)
          ? FloatingActionButton(
              onPressed: _randomNumer,
              tooltip: 'Random',
              child: Icon(Icons.redo),
            )
          : FloatingActionButton(
              tooltip: 'Reset',
              child: Icon(
                Icons.refresh,
              ),
              backgroundColor: Colors.red,
              onPressed: _reset,
            ),
    );
  }
}
