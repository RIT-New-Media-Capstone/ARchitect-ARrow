import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'; //arcore plugin
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var geoSpatialAPIKey = "AIzaSyC5r1F1Ua0XzKxP7ckoFDL6lezYote52E8";

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
        primarySwatch: Colors.grey,
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
  Location? _selectedLocation;
  String? _dropdownHintText;
  Location? _currentPosition = Location("My Position", 0, 0);
  String? _navigationMode = "driving";
  String? _duration = "0 Seconds";

  List<Location> locations = [
    Location("Crossroads", -77.680056, 43.082633),
    Location("Magic Spell Studios", -77.676657, 43.085648),
    Location("Niagara Falls", -79.0377, 43.0962),
  ];

  @override
  void initState() {
    super.initState();
    _selectedLocation = locations[0];

    if (_selectedLocation == null) {
      _dropdownHintText = 'Select Location';
    } else {
      _dropdownHintText = _selectedLocation!.place;
    }

    updateMyPosition();
  }

  updateMyPosition() async {
    log('attempting to get position');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    log('position: $position');
    log('lat: ${position.latitude}');

    setState(() {
      _currentPosition =
          Location("My Position", position.longitude, position.latitude);
    });

    callMapBox(_selectedLocation!, _currentPosition!);
  }

  // This method should make a call the mapbox api using the current devices location as well as the desired location
  void callMapBox(Location destination, Location position) async {
    log('attempting to call MapBox');

    String url =
        'https://api.mapbox.com/directions/v5/mapbox/${_navigationMode}/${position.long}%2C${position.lat}%3B${destination!.long}%2C${destination!.lat}?alternatives=false&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=pk.eyJ1IjoidHJ5Z29uMTE3IiwiYSI6ImNsb251eHZsMDE2bWoyaW5ybmxkMXN6b2wifQ.MFqc4EcWND4gkyK7XIZ0CQ';

    print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Do something with the response data
      Map<String, dynamic> data = json.decode(response.body);
      log('response:');
      print(data);
      print(data["routes"][0]["duration"]);
      setState(() {
        _duration = '${data["routes"][0]["duration"]} Seconds';
      });
    } else {
      // ignore_for_file: avoid_print
      print("Sorry, try again.");
      log('$response');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
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
              height: 240,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      //display user's current location
                      height: 50,
                      width: 350,
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 2),
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'You are at: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_currentPosition!.lat}, ${_currentPosition!.long}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 144, 190, 109)),
                          ),
                        ],
                      )),
                  Container(
                      //user choose where to go
                      height: 50,
                      width: 350,
                      padding: const EdgeInsets.fromLTRB(5, 0, 10, 2),
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Go To: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textWidthBasis: TextWidthBasis.parent,
                          ),
                          DropdownButton<Location>(
                            value: _selectedLocation,
                            hint: Text(_dropdownHintText!),
                            style: const TextStyle(color: Colors.black),
                            items: locations.map((location) {
                              return DropdownMenuItem<Location>(
                                value: location,
                                child: Text(
                                  location.place.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 144, 190, 109)),
                                ),
                              );
                            }).toList(),
                            onChanged: (Location? value) {
                              setState(() {
                                _selectedLocation = Location(
                                    value?.place, value?.long, value?.lat);
                                debugPrint(
                                    'Value Changed: ${value?.place}, ${value?.long}, ${value?.lat}');
                                debugPrint('$_selectedLocation');
                                callMapBox(
                                    _selectedLocation!, _currentPosition!);
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
                      const Text('Choose one option:'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.directions_car_filled_sharp,
                                color: Color.fromARGB(255, 201, 227, 172),
                                size: 32.0,
                                semanticLabel: 'Travel by car',
                              ),
                              Text("Car")
                            ],
                          ),
                          Radio<String>(
                            value: 'driving',
                            fillColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color.fromARGB(255, 234, 144, 16)),
                            groupValue: _navigationMode,
                            onChanged: (String? value) {
                              setState(() {
                                _navigationMode = value;
                                debugPrint(
                                    'Method of travel: $_navigationMode');
                                callMapBox(
                                    _selectedLocation!, _currentPosition!);
                              });
                            },
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.directions_bike_outlined,
                                color: Color.fromARGB(255, 201, 227, 172),
                                size: 32.0,
                                semanticLabel: 'Travel by Bike',
                              ),
                              Text("Cycling")
                            ],
                          ),
                          Radio<String>(
                            value: 'cycling',
                            fillColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color.fromARGB(255, 234, 144, 16)),
                            groupValue: _navigationMode,
                            onChanged: (String? value) {
                              setState(() {
                                _navigationMode = value;
                                debugPrint(
                                    'Method of travel: $_navigationMode');
                                callMapBox(
                                    _selectedLocation!, _currentPosition!);
                              });
                            },
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.directions_walk_outlined,
                                color: Color.fromARGB(255, 201, 227, 172),
                                size: 32.0,
                                semanticLabel: 'Travel by foot',
                              ),
                              Text("Walking")
                            ],
                          ),
                          Radio<String>(
                            value: 'walking',
                            fillColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color.fromARGB(255, 234, 144, 16)),
                            groupValue: _navigationMode,
                            onChanged: (String? value) {
                              setState(() {
                                _navigationMode = value;
                                debugPrint(
                                    'Method of travel: $_navigationMode');
                                callMapBox(
                                    _selectedLocation!, _currentPosition!);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    //display the button to open the ar camera
                    height: 48,
                    width: 350,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      //display travel time
                      'It will take about $_duration',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 144, 190, 109)),
                    ),
                  ),
                ],
              ),
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
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                        width: 200,
                        margin: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                        child: Text(
                          'It will take $_duration to get from your current location to ${_selectedLocation!.place} by $_navigationMode',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 144, 190, 109)),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        callMapBox(_selectedLocation!, _currentPosition!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 234, 144, 16),
                      ),
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

class Location {
  String? place;
  double? lat;
  double? long;

  Location(this.place, this.long, this.lat);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          place == other.place;

  @override
  int get hashCode => place.hashCode;

  void initState() {}
}
