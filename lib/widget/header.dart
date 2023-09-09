import 'package:check_weather/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  GlobalController globalController=Get.put(GlobalController());
  var apikey = "6932b333e35a7dd07355ec50731f2bad";
  var cityName;
  var subLocality;

  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress(globalController.lat.value, globalController.lon.value);
  }

  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    print(placemarks);

    if (placemarks.isNotEmpty) {
      Placemark firstPlacemark = placemarks.first;
      setState(() {
        cityName = firstPlacemark.locality ??
            "Unknown"; // Use the locality as the city name
        subLocality = firstPlacemark.subLocality ?? "";
      });
    }
    debugPrint(cityName.toString());
  }

  String date = DateFormat("yMMMMd").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(

                subLocality.toString(),
                style: TextStyle(fontSize: 20, height: 2,color: Colors.white,fontWeight: FontWeight.bold),
              ),


              Text(

                cityName.toString(),
                style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ],
          ),

        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            date.toString(),
            style: TextStyle(fontSize: 10, height: 1.5,color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
