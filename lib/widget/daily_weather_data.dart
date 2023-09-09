import 'package:check_weather/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/weather_model.dart';

class Daily_Weather_Data extends StatelessWidget {

  String getDay(final day){
    DateTime time=DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x=DateFormat('EEE').format(time);
    return x;

  }
  Weather_Info weather_info = Get.put(Weather_Info());

  GlobalController global = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(

        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
            child: Row(
              children: [
                Text(
                  "Next Days",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
                itemCount: global.weather_info.daily!.length > 7
                    ? 7
                    : global.weather_info.daily!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getDay(global.weather_info.daily![index].dt,),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),

                            Text(
                              "${ global.weather_info.daily![index].temp!.max!.toStringAsFixed(0)} °C / ${ global.weather_info.daily![index].temp!.min!.toStringAsFixed(0)} °C",

                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
