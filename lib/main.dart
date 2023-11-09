import 'package:flutter/material.dart';
import 'dart:developer';
//import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

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
  Locations? _selectedLocation;
  String? _selectedPlaceString;
  String? _dropdownHintText;
  String currentLocation = 'placeA';
  String? _selectedOption = "None";

  @override
  Widget build(BuildContext context) {
    List<Locations> locations = [
      Locations("Niagara Falls", 43.092461, 79.047150),
      Locations("District of Columbia", 38.895, -77.03667),
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'You are at:  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'user location',
                            style: TextStyle(
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
                          DropdownButton<Locations>(
                            value: _selectedLocation,
                            hint: Text(_dropdownHintText!),
                            style: const TextStyle(color: Colors.black),
                            items: locations.map((location) {
                              return DropdownMenuItem<Locations>(
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
                            onChanged: (Locations? value) {
                              setState(() {
                                _selectedLocation = Locations(
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
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                                debugPrint(
                                    'Method of travel: $_selectedOption');
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
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                                debugPrint(
                                    'Method of travel: $_selectedOption');
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
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value;
                                debugPrint(
                                    'Method of travel: $_selectedOption');
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    //display the button to open the ar camera
                    height: 50,
                    width: 350,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: const Text(
                      //display travel time
                      'It will take about [travel time]',
                      style: TextStyle(
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
                          'It will take [amount of time] to get from your current location to $_selectedPlaceString by $_selectedOption',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 144, 190, 109)),
                        )),
                    ElevatedButton(
                      onPressed: () {},
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

  void initState() {
    updateMyPosition();
  }

  updateMyPosition() async {
    log('attempting to get position');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    log('position: $position');
    log('lat: ${position.latitude}');

    // setState(() {
    //   _position = position;
    // });
    return position;
  }

  // This method should make a call the mapbox api using the current devices location as well as the desired location
  void callMapBox(dynamic destination, Position position) async {
    log('attempting to call MapBox');

    final response = await http.get(Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/walking/${position.latitude.toString()}%2C${position.longitude.toString()}%3B${destination!.latitude.toString()}%2C${destination!.longitude.toString()}?alternatives=false&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=pk.eyJ1IjoidHJ5Z29uMTE3IiwiYSI6ImNsb251eHZsMDE2bWoyaW5ybmxkMXN6b2wifQ.MFqc4EcWND4gkyK7XIZ0CQ'));
    if (response.statusCode == 200) {
      // Do something with the response data
      log('response $response');
    } else {
      print("Sorry, try again.");
      // Handle error
    }
  }

  // calling this method will get the device's location and update the _position varible
}
