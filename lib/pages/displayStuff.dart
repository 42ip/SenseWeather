import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  var temp;
  var humidity;
  var description;
  var currently;
  var pressure;
  var feelslike;
  var visibility;
  var tempmin;
  var tempmax;
  String value;
  String name;
  Map data = {};
  Map datanew;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    datanew = data['datanew'];
    setState(() {
      try {
        this.name = datanew['name'];
        this.temp = datanew['main']['temp'];
        this.description = datanew['weather'][0]['description'];
        this.humidity = datanew['main']['humidity'];
        this.currently = datanew['weather'][0]['main'];
        this.pressure = datanew['main']['pressure'];
        this.pressure /= 1000;
        this.feelslike = datanew['main']['feels_like'];
        this.visibility = datanew['visibility'];
        this.visibility /= 1000;
        this.tempmin = datanew['main']['temp_min'];
        this.tempmax = datanew['main']['temp_max'];
      } catch (e) {
        print(e.toString());
      }
    });
    print(datanew);
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            color: Colors.grey[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    name != null ? name.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + '\u00B0' + 'C' : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 36,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      FontAwesome.thermometer_three_quarters,
                      color: Colors.white,
                    ),
                    trailing: Text(
                      temp != null
                          ? temp.toString() +
                              '\u00B0' +
                              "/" +
                              feelslike.toString() +
                              '\u00B0' +
                              ' C'
                          : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Temp/Feels like",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesome.thermometer_three_quarters,
                      color: Colors.white,
                    ),
                    trailing: Text(
                      tempmin != null
                          ? tempmin.toString() +
                              '\u00B0' +
                              "/" +
                              tempmax.toString() +
                              '\u00B0' +
                              '  C'
                          : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Lo/Hi",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesome.sun_o,
                      color: Colors.white,
                    ),
                    trailing: Text(
                      humidity != null ? humidity.toString() + "%" : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Humidity',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesome.cloud,
                      color: Colors.white,
                    ),
                    trailing: Text(
                      description != null ? description.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Weather",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesome.compress,
                      color: Colors.white,
                    ),
                    trailing: Text(
                      pressure != null
                          ? pressure.toString() + " bar"
                          : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Pressure",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesome.low_vision,
                      color: Colors.white,
                    ),
                    trailing: Text(
                      visibility != null
                          ? visibility.toString() + " km"
                          : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Visibility",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
