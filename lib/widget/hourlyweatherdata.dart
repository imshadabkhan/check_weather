import 'dart:math';

import 'package:check_weather/services/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../controller/global_controller.dart';
import '../model/weather_model.dart';

class HourlyWeatherData extends StatelessWidget {

  Weather_Info weather_info = Get.put(Weather_Info());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Today",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
          SizedBox(
            height: 20,
          ),
          hourlyData(),
          SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }
}

class hourlyData extends StatelessWidget {
  RxInt _cardindex=GlobalController().getCurrentIndex();
  GlobalController global = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return


      Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: global.weather_info.hourly!.length > 12
              ? 12
              : global.weather_info.hourly!.length,
          itemBuilder: (context, index) {
            return  Obx(() => GestureDetector(
              onTap: (){
                _cardindex.value=index;

                // debugPrint(global.weather_info.hourly?[index].isChecked.toString());

              },
              child: Padding(
                padding:  EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),


                    gradient: _cardindex==index?LinearGradient(colors: [
                      CustomColors.firstGradientColor.withOpacity(0.5),
                      CustomColors.secondGradientColor.withOpacity(0.9),
                    ]):null,


                  ),
                  child: hourlyDataDetail(
                    temp: global.weather_info.hourly![index].temp,
                    timeStamp: global.weather_info.hourly![index].dt,
                    pressure: global.weather_info.hourly![index].pressure!,
                  ),
                ),
              ),
            )) ;


          }),
    );
  }
}

class hourlyDataDetail extends StatelessWidget {
  Weather_Info weather_info = Get.find<GlobalController>().weather_info;

  hourlyDataDetail(
      {required this.temp, required this.timeStamp, required this.pressure});
  num? temp;
  int? timeStamp;
  num? pressure;

  String getTime(final timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 500);
    String x = DateFormat('jm').format(dateTime);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(
        children: [
          Container(
            child: Text(
              getTime(timeStamp),style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            child: Image(
              image: AssetImage('assets/icons/clouds.png',),color: Colors.white,
              height: 40,
              width: 40,
            ),
          ),
          Container(
            child: Text(temp!.toStringAsFixed(0) + " °C",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          ),

        ],
      )
    ]);
  }
}



