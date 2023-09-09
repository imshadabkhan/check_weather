import 'package:check_weather/controller/global_controller.dart';
import 'package:check_weather/widget/header.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../widget/currentweatherdata_widget.dart';
import '../widget/daily_weather_data.dart';
import '../widget/hourlyweatherdata.dart';

class Home_View extends StatefulWidget {
  Home_View({super.key});

  @override
  State<Home_View> createState() => _Home_ViewState();
}

class _Home_ViewState extends State<Home_View> {
  late final GlobalController _globalController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalController = Get.put(GlobalController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

          decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background_image/allweathers.png"),fit: BoxFit.cover),
          ),
          child: Obx(
            () => _globalController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        HeaderWidget(),
                                               Current_Weather_Data_Widget(),
                        SizedBox(
                          height: 20,
                        ),
                        HourlyWeatherData(),
                        Daily_Weather_Data(),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
