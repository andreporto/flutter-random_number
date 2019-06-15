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

  void _randomNumber() {
    setState(() {
      int sizePickedNumberList = pickedNumbers.length;
      if (sizePickedNumberList < maxNumber) {
        int pickedNumber = randomize();
        while (pickedNumbers.containsKey(pickedNumber)) {
          pickedNumber = randomize();
        }
        pickedNumbers[pickedNumber] = sizePickedNumberList + 1;
        _counter = pickedNumber.toString();
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Center(
                  child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter max number:',
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                textAlign: TextAlign.center,
                maxLength: 4,
                style: TextStyle(color: Colors.lightBlue, fontSize: 40),
                key: Key('maxNumberField'),
                onChanged: _onMaxNumberChange,
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
              )),
            ),
            if (pickedNumbers.length == 0)
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    'Push the blue button to pick random numbers',
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ))
            else
              if (pickedNumbers.length == maxNumber)
                Text(
                  'No numbers left!',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
            if (pickedNumbers.length > 0)
              Text(
                'Last picked number:',
                style: TextStyle(fontSize: 30),
              ),
            if (pickedNumbers.length <= maxNumber && pickedNumbers.length > 0)
              Container(
                height: 180,
                width: (maxNumber.toString().length * 90.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 5,
                      spreadRadius: 5,
                    )
                  ],
                  color: Color(0x330000FF),
                  borderRadius: BorderRadius.circular(
                      (maxNumber.toString().length * 90.0) / 2),
                ),
                child: Center(
                  child: Text(
                    '$_counter',
                    style: TextStyle(
                      fontSize: 100,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: (pickedNumbers.length < maxNumber)
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (pickedNumbers.length < maxNumber)
          ? FloatingActionButton(
              onPressed: _randomNumber,
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
