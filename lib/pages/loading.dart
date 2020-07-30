import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:weatherApp/services/City.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void waitForIt() async {
    var parsed = await json.decode(
        await DefaultAssetBundle.of(context).loadString('assets/city.json'));
    List<City> citylist = parseJosn(parsed);
    Navigator.pushReplacementNamed(context, '/home',
        arguments: {'citylist': citylist});
  }

  @override
  void initState() {
    super.initState();
    waitForIt();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Hexcolor('#BFD9D7'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/SenseWeather.png'),
              SpinKitDoubleBounce(
                color: Colors.white,
                size: 35.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<City> parseJosn(response) {
    if (response == null) {
      return [];
    }
    List<City> cities;
    cities = (response as List).map((i) => City.fromJson(i)).toList();
    return cities;
  }
}
