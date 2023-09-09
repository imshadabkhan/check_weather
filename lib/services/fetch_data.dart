import 'dart:convert';
import 'dart:developer';
import 'package:check_weather/model/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const String apiKey = "6932b333e35a7dd07355ec50731f2bad";

class FetchWeather {
  static Future processData(var lat, var long) async {
    var response = await http.get(Uri.parse(apiUrl(lat, long)!));
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body.toString());
      Weather_Info weather_info = Weather_Info.fromJson(jsonString);
      log(weather_info.current!.clouds!.toString());
      log(weather_info.daily!.toString());

      return weather_info;
    } else
    {
      debugPrint("Not getting Apis error data");
    }
  }
}
String? apiUrl(var lat, var long) {
  String url =
      'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=$apiKey&units=metric&exclude=minutely';
  return url;
}
