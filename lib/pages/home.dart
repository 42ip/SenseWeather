import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weatherApp/services/City.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myController = TextEditingController();
  Map data = {};
  Map datanew;
  http.Response response;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  String value;
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    List<City> citylist = data['citylist'];
    print(citylist.length);
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'SenseWeather',
          style: TextStyle(
            fontFamily: 'KronaOne',
            fontWeight: FontWeight.w400,
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 200, 10, 15),
              child: TextFormField(
                controller: myController,
                textCapitalization: TextCapitalization.sentences,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  fillColor: Colors.grey[400],
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0),
                  ),
                  hintText: "<Your location>",
                  hoverColor: Colors.white,
                  labelText: 'Enter an area name',
                  labelStyle: TextStyle(color: Colors.grey[900], fontSize: 25),
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
              ),
            ),
            FlatButton.icon(
              onPressed: () async {
                value = myController.text;
                print(value);
                try {
                  response = await http.get(
                      'http://api.openweathermap.org/data/2.5/weather?q=$value&units=metric&appid=ba6dad68c2e39e80508bf452a46b1bff');
                } catch (e) {
                  print(e.toString());
                  Navigator.pushReplacementNamed(
                    context,
                    '/error',
                  );
                }
                datanew = jsonDecode(response.body);
                print(datanew['cod']);

                // I guess the guy who wrote the api is satan
                //I literally sat for 15 minutes trying to figure out why datanew['cod'] == 404 is returning false
                //turns out 404 is string and 401 is integer
                if ((datanew['cod'] == 401) || (datanew['cod'] == "404")) {
                  Navigator.pushReplacementNamed(
                    context,
                    '/error',
                  );
                } else
                  Navigator.pushNamed(
                    context,
                    '/display',
                    arguments: {
                      'datanew': datanew,
                    },
                  );
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: Text(
                'Get results',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//TypeAheadFormField(
//textFieldConfiguration: TextFieldConfiguration(
//controller: this._typeAheadController,
//decoration: InputDecoration(labelText: 'City')),
//suggestionsCallback: (pattern) {
//return CitiesService.getSuggestions(pattern);
//},
//itemBuilder: (context, suggestion) {
//return ListTile(
//title: Text(suggestion),
//);
//},
//transitionBuilder: (context, suggestionsBox, controller) {
//return suggestionsBox;
//},
//onSuggestionSelected: (suggestion) {
//this._typeAheadController.text = suggestion;
//},
//validator: (value) {
//if (value.isEmpty) {
//return 'Please select a city';
//}
//},
//onSaved: (value) => this._selectedCity = value,
//),
