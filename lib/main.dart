import 'package:flutter/material.dart';
import 'package:weatherApp/pages/displayStuff.dart';
import 'pages/home.dart';
import 'pages/loading.dart';
import 'pages/error.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/display': (context) => Display(),
      '/error': (context) => Error(),
    },
  ));
}
