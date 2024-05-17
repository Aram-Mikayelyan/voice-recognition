import 'package:flutter/material.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late PorcupineManager _porcupineManager;
  final String key = 'vSd3/zNpT+oilC8L0J5kuJ+O6s/VEcNcXDfTxAwYcAYx0TMCsuQnow==';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> createPorcupineManager() async {
    try {
      _porcupineManager = await PorcupineManager.fromKeywordPaths(
        key,
        [
          "assets/gunshot.ppn",
          "assets/eartquake.ppn",
          "assets/fire.ppn",
        ],
        _wakeWordCallback,
      );
    } on PorcupineException catch (err) {
      // handle porcupine init error
    }
  }

  Future<void> _wakeWordCallback(int keywordIndex) async {
    if (keywordIndex == 0) {
      print('0');
    } else if (keywordIndex == 1) {
      print('2');
    } else if (keywordIndex == 2) {
      print('3');
    }
  }

  Future<void> init() async {
    try {
      await createPorcupineManager();
      await _porcupineManager.start();
      // ignore: nullable_type_in_catch_clause
    } catch (ex) {
      print(ex.toString());
      // deal with audio exception
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('widget.title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
