import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'ARchitect-ARrow'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  Locations? _selectedLocation;
  String? _dropdownHintText;

  @override
  Widget build(BuildContext context) {
    List<Locations> _locations = [
      new Locations("placeA", 300, 400),
      new Locations("placeB", 100, 400)
    ];

    if (_selectedLocation == null) {
      _dropdownHintText = 'Select Location';
    } else {
      _dropdownHintText = _selectedLocation!.place;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 260,
              width: 350,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'where you are information',
                  ),
                  DropdownButton<Locations>(
                    value: _selectedLocation,
                    hint: Text(_dropdownHintText!), // Dynamic hint text
                    items: _locations.map((location) {
                      return DropdownMenuItem<Locations>(
                        value: location,
                        child: Text(location.place),
                      );
                    }).toList(),
                    onChanged: (Locations? value) {
                      setState(() {
                        _selectedLocation = value;
                        debugPrint('Value Changed: ${value?.place}');
                      });
                    },
                  ),
                  const Text(
                    'travel type to destination checkbox',
                  ),
                ],
              ),
            ),
            const Text(
              'travel time',
            ),
            Container(
              height: 300,
              width: 350,
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              color: Colors.red,
              child: const Text(
                'Map',
              ),
            ),
            Container(
                height: 70,
                width: 350,
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                color: Colors.green,
                child: Row(
                  children: [
                    const Text(
                      'Final destination confirmation',
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Open route'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class Locations {
  final String place;
  final double lat;
  final double long;

  Locations(this.place, this.lat, this.long);
}
// enum Locations {
//   placeA('Place A', 250, 100);


//   const Locations(this.place, this.lat, this.long);
//   final String place;
//   final double lat;
//   final double long;
// }
