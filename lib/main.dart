import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflitexample/369_agent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TFLite Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TFLite Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _log = "Hello";
  int _logchange = 1;
  MachineLearningAgent1 _machineLearningAgent1 = MachineLearningAgent1();

  void _risingText() {
    for (int j = 0; j < 10000; j++) {
      setState(() {
        String answer = TsnDecode(
            _counter, _machineLearningAgent1.predict(BinaryEncode(_counter)));
        CheckAnswer(answer);
      });
    }
  }

  List<List<int>> BinaryEncode(int num) {
    List<List<int>> i = '$num'
        .padLeft(5, '0')
        .codeUnits
        .map((int j) => j.toRadixString(2))
        .map((String bin) => bin.padLeft(7, '0').split('').reversed.toList())
        .map((List<String> binList) => binList
            .map((String binElement) => int.parse(binElement))
            .toList())
        .toList();
    return i;
  }

  List TsnEncode(int num) {
    String n = '$num';
    int y = 0;
    '$num'.split('').forEach((ch) {
      if ('369'.contains(ch)) {
        y += 1;
      }
    });
    List result = [];
    for (int j = 0; j < 5; j++) {
      if (j == y) {
        result.add(1);
      } else {
        result.add(0);
      }
    }
    return result;
  }

  String TsnDecode(int num, int prediction) {
    var list = ['$num'];
    for (var i = 1; i < 5; i++) {
      list += ['x' * i];
    }
    return list[prediction];
  }

  String Tsn(int num) {
    var list = ['$num'];
    for (var i = 1; i < 5; i++) {
      list += ['x' * i];
    }
    List n = TsnEncode(num);
    int max = n[0];
    int maxIdx = 0;
    int i = 0;
    for (final e in n) {
      if (max < e) {
        max = e;
        maxIdx = i;
      }
      i++;
    }
    return list[maxIdx];
  }

  void CheckAnswer(String answer) {
    setState(() {
      if (answer == Tsn(_counter)) {
        _counter++;
        print(_counter);
      } else {
        _log = 'stop at $_counter';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 6,
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  _log,
                  maxLines: 10,
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(child: SizedBox(), flex: 1,),
                Flexible(child: SizedBox(
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('Hi'),
                  ),
                ), flex: 1,),
                Flexible(child: SizedBox(), flex: 1,),
              ],
            ),
            flex: 4,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _risingText,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
