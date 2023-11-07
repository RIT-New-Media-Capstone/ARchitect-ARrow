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
  Locations? _selectedLocation = Locations("Select aLocation", 0, 0);
  String? _selectedPlaceString;
  String? _dropdownHintText;
  String currentLocation = 'placeA';
  String? _selectedOption = "None";

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
              //location and destination section
              height: 200,
              width: 350,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      //display user's current location
                      height: 50,
                      width: 350,
                      padding: const EdgeInsets.fromLTRB(5, 10, 10, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                  Container(
                      //user choose where to go
                      height: 50,
                      width: 350,
                      padding: const EdgeInsets.fromLTRB(5, 10, 10, 2),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                      color: Colors.orange,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Go To: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textWidthBasis: TextWidthBasis.parent,
                          ),
                          DropdownButton<Locations>(
                            value: _selectedLocation,
                            hint: Text(_dropdownHintText!),
                            style: const TextStyle(color: Colors.black),
                            items: _locations.map((location) {
                              return DropdownMenuItem<Locations>(
                                value: location,
                                child: Text(location.place.toString()),
                              );
                            }).toList(),
                            onChanged: (Locations? value) {
                              setState(() {
                                _selectedLocation = new Locations(
                                    value?.place, value?.lat, value?.long);
                                _selectedPlaceString = value?.place;
                                debugPrint(
                                    'Value Changed: ${value?.place}, ${value?.lat}, ${value?.long}');
                                debugPrint('$_selectedLocation');
                              });
                            },
                          ),
                        ],
                      )),
                  Column(
                    //user choose how to go
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Choose one option:'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.directions_car_filled_sharp,
                                color: Colors.yellow,
                                size: 32.0,
                                semanticLabel: 'Travel by car',
                              ),
                              Text("Car")
                            ],
                          ),
                          Radio<String>(
                            value: 'driving',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                                debugPrint(
                                    'Method of travel: ${_selectedOption}');
                              });
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.directions_bike_outlined,
                                color: Colors.yellow,
                                size: 32.0,
                                semanticLabel: 'Travel by Bike',
                              ),
                              Text("Cycling")
                            ],
                          ),
                          Radio<String>(
                            value: 'cycling',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                                debugPrint(
                                    'Method of travel: ${_selectedOption}');
                              });
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.directions_walk_outlined,
                                color: Colors.yellow,
                                size: 32.0,
                                semanticLabel: 'Travel by foot',
                              ),
                              Text("Walking")
                            ],
                          ),
                          Radio<String>(
                            value: 'walking',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                                debugPrint(
                                    'Method of travel: ${_selectedOption}');
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
              //display travel time
              'travel time',
            ),
            Container(
              //display mapbox map(with route?)
              height: 300,
              width: 350,
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              color: Colors.red,
              child: const Text(
                'Map',
              ),
            ),
            Container(
                //display the complete inforfamtion for the users location/destination, an give the button prompt to open the ar camera

                height: 120,
                width: 350,
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                color: Colors.green,
                child: Row(
                  children: [
                    Container(
                        width: 200,
                        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Text(
                          'It will take [amount of time] to get from your current location to ${_selectedPlaceString} by $_selectedOption',
                        )),
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
  String? place;
  double? lat;
  double? long;

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
