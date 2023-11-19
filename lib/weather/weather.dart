// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  static const String apiBaseUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=dhaka&units=imperial&appid=$apiKey";

  static const String apiKey = "cfd6780d7aa7b8f5b0c19a4da1bf8755";

  var currently;
  var description;
  var humidity;
  var temp;
  var windSpeed;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> getWeather() async {
    try {
      http.Response response = await http.get(Uri.parse(apiBaseUrl));
      var results = jsonDecode(response.body);
      setState(() {
        temp = results['main']['temp'];
        description = results['weather'][0]['description'];
        currently = results['weather'][0]['main'];
        humidity = results['main']['humidity'];
        windSpeed = results['wind']['speed'];
      });
    } catch (e) {
      log("Error fetching weather data: $e");
    }
  }

  String getWeatherImagePath(String weatherDescription) {
    switch (weatherDescription.toLowerCase()) {
      case 'haze':
        return 'images/foggy.png';
      case 'clouds':
        return 'images/clouds.png';
      case 'rain':
        return 'images/rain.png';
      case 'clear':
        return 'images/sun.png';
      // Add more cases for other weather conditions as needed
      default:
        return 'images/loading.gif';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('images/bg.jpg'),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Current Weather In Dhaka',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Text(
                    temp != null ? "$temp\u00B0" : "Loading",
                    style: const TextStyle(
                        fontSize: 68,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          getWeatherImagePath(description),
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          currently != null ? currently.toString() : "Loading",
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
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
                    leading: const FaIcon(FontAwesomeIcons.temperatureHalf),
                    title: const Text("Temperature",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    trailing: Text(
                      temp != null ? "$temp\u00B0" : "Loading",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.cloud),
                    title: const Text("Weather",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    trailing: Text(
                      description != null ? description.toString() : "Loading",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.sun),
                    title: const Text("TemperatureHumidity",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                    trailing: Text(
                      humidity != null ? humidity.toString() : "Loading",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.wind,
                    ),
                    title: const Text("Wind",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                    trailing: Text(
                      windSpeed != null ? windSpeed.toString() : "Loading",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
