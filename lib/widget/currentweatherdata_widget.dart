import 'package:check_weather/controller/global_controller.dart';
import 'package:check_weather/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Current_Weather_Data_Widget extends StatefulWidget {
  Current_Weather_Data_Widget();

  @override
  State<Current_Weather_Data_Widget> createState() => _Current_Weather_Data_WidgetState();
}

class _Current_Weather_Data_WidgetState extends State<Current_Weather_Data_Widget> {
  late final Weather_Info weather_info;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
     weather_info=Get.find<GlobalController>().weather_info;
    }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [

        temperatureAreaWidget(weather_info: weather_info),
        currentWeatherMoreDetail(),

        ],
      ),
    );
  }
}

class temperatureAreaWidget extends StatelessWidget {
  const temperatureAreaWidget({
    super.key,
    required this.weather_info,
  });

  final Weather_Info weather_info;

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.sizeOf(context).height;
    var width =MediaQuery.sizeOf(context).width;
    return Column(
      children: [
SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: height*0.1,
                width: width*0.2,
                child: Image.asset('assets/weather/01d.png')),
            SizedBox(width: 5,),
            Row(children: [ Text(weather_info.current!.temp!.toStringAsFixed(0) + "°C",style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),),
              Container(width: 10,),
              Padding(
                padding:  EdgeInsets.only(top: 19.0),
                child: Text(weather_info.current!.weather![0].description!.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.white),),
              ),],)



          ],
        ),

        Container(height: height*0.03,width:width*0.3,decoration: BoxDecoration(color: Colors.lightBlue.withOpacity(0.5),borderRadius: BorderRadius.circular(10)),child: Center(child: Text("Feels like   " + weather_info.current!.feelsLike!.toStringAsFixed(0),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),),

        SizedBox(height: 20),
      ],
    );
  }
}


class currentWeatherMoreDetail extends StatelessWidget {

 Weather_Info weather_info=Get.find<GlobalController>().weather_info;



  @override
  Widget build(BuildContext context) {


    return  Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
          children: [
            Image(image: AssetImage("assets/icons/clouds.png"),height: 50,width: 80,),
           Text( weather_info.current!.clouds!.toString() + " percent" ,style: TextStyle(color: Colors.white), ),


          ],
        ),
        Column(
          children: [
            Image(image: AssetImage("assets/icons/humidity.png"),height: 50,width: 80,),
            Text( weather_info.current!.humidity!.toString() + ' percent',style: TextStyle(color: Colors.white), ),
          ],
        ),
        Column(
          children: [
            Image(image: AssetImage("assets/icons/windspeed.png"),height: 50,width: 80,),
            Text( weather_info.current!.windSpeed!.toString() + " Km/hr" ,style: TextStyle(color: Colors.white), ),

          ],
        ),



      ],),




    ],);
  }
}

