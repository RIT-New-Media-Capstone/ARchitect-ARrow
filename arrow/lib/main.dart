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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ARchitect-ARrow'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Locations? _selectedLocation;
  String? _dropdownHintText;
  String currentLocation = 'placeA';
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    List<Locations> _locations = [
      Locations("placeA", 300, 400),
      Locations("placeB", 100, 400),
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
                  Container(
                      height: 50,
                      width: 350,
                      color: Colors.yellow,
                      child: Row(
                        children: [
                          const Text(
                            'You are at:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'user location',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  DropdownButton<Locations>(
                    value: _selectedLocation,
                    hint: Text(_dropdownHintText!),
                    items: _locations.map((location) {
                      return DropdownMenuItem<Locations>(
                        value: location,
                        child: Text(location.place),
                      );
                    }).toList(),
                    onChanged: (Locations? value) {
                      setState(() {
                        _selectedLocation = value;
                        debugPrint(
                            'Value Changed: ${value?.place}, ${value?.lat}, ${value?.long}');
                      });
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Choose one option:'),
                      Row(
                        children: <Widget>[
                          Text('Car'),
                          Radio<String>(
                            value: 'Option 1',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                          ),
                          Text('Bike'),
                          Radio<String>(
                            value: 'Option 2',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                          ),
                          Text('walk'),
                          Radio<String>(
                            value: 'Option 3',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Locations &&
          runtimeType == other.runtimeType &&
          place == other.place;

  @override
  int get hashCode => place.hashCode;
}
