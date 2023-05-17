import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var hello = "WORLD";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var latitude;
  var longitude;
  var data;
  var temp2;
  var tes = 100.0000000000;
  var test;
  var dat;
  var timeline;
  var feelsLike;
  late Color fontcolor;
  var imageUrl = "assets/night.png";
  setimage() {
    if (DateTime.now().hour > 18 && DateTime.now().hour > 6) {
      setState(() {
        timeline = 0;
        imageUrl = "assets/night.png";
        fontcolor = Colors.white;
      });
    } else {
      timeline = 1;
      imageUrl = "assets/sunny.png";
      fontcolor = Colors.black;
    }
  }

  var results;
  Future getWeather() async {
    Uri apiUrl = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=karachi&units=imperial&appid=acbd2f858e9b066dd9f0732aeb60618a");
    http.Response response = await http.get(apiUrl);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = ((results['main']['temp'] - 32) * 5 / 9).toString();
      temp = double.parse(temp).toStringAsFixed(1);
      this.data = results;
      this.description = results['weather'][0]['description'];
      this.humidity = results['main']['humidity'];
      this.currently = results['weather'][0]['main'];
      this.windspeed = results['wind']['speed'];
       this.feelsLike= ((results['main']['feels_like'] - 32) * 5 / 9).toString();
       feelsLike = double.parse(feelsLike).toStringAsFixed(1);
    });
  }

  var styling = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  @override
  void initState() {
    super.initState();
    this.getWeather();
    this.setimage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.fill)),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:20, bottom: 5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Currently in Karachi',
                          style: TextStyle(
                              color: fontcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        temp != null ? temp.toString() + '\u00b0' : "Loading",
                        style: TextStyle(
                            color: fontcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                          currently != null ? currently : "Loading",
                          style: TextStyle(
                            color: fontcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children: [
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.thermometerHalf,
                              color: Colors.red,
                            ),
                            title: Text(
                              "Temperature",
                              style: styling,
                            ),
                            trailing: Text(
                                temp != null
                                    ? temp.toString() + '\u00b0'
                                    : "Loading...",
                                style: styling),
                          ),

                           ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.tint,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Feels Like",
                              style: styling,
                            ),
                            trailing: Text(
                                temp != null
                                    ? feelsLike.toString() + '\u00b0'
                                    : "Loading...",
                                style: styling),
                          ),

                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.cloud,
                              color: Colors.blue,
                            ),
                            title: Text("Weather", style: styling),
                            trailing: Text(
                              currently != null ? currently : "Loading...",
                              style: styling,
                            ),
                          ),

                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.water,
                              color: Colors.blue[100],
                            ),
                            title: Text("Humidity", style: styling),
                            trailing: Text(
                                humidity != null
                                    ? humidity.toString()
                                    : "Loading...",
                                style: styling),
                          ),

                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.wind,
                              color: Colors.deepPurple,
                            ),
                            title: Text("Wind Speed", style: styling),
                            trailing: Text(
                                windspeed != null
                                    ? windspeed.toString()
                                    : "Loading...",
                                style: styling),
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
