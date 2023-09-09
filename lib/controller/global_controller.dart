//
// import 'package:check_weather/viewmodel/fetch_data.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// class GlobalController extends GetxController {
//   bool isLoading = true;
//   final double _lat = 0.0;
//   final double _long = 0.0;
//   bool ?isServiceEnabled;
//
//
// }
//
//
//
//
// void initState() {
//   // This method is called when the stateful widget is inserted into the widget tree.
//   // You can perform initialization tasks here.
//   if(isLoading==true){
//
//     getLocation();
//   }
// }
//
//
//
//
//
//
//
//
//
//   getLocation() async {
//     isServiceEnabled = await Geolocator.isLocationServiceEnabled();
//
//     if (!isServiceEnabled!) {
//       return Future.error("Service is not Enabled");
//     }
//
//     LocationPermission _permission = await Geolocator.checkPermission();
//     if (_permission == LocationPermission.denied) {
//       await Geolocator.requestPermission();
//     }
//     if (_permission == LocationPermission.deniedForever) {
//       return Future.error(
//           "Location service are permanently denied and we cannot request permission");
//     }
//
//     return await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high)
//         .then((value) {
//       _lat.value = value.latitude;
//       _long.value = value.longitude;
//
//       debugPrint(_lat.value.toString());
//       debugPrint(_long.value.toString());
//
//        );
//     });
//   }
// }

import 'package:check_weather/model/weather_model.dart';
import 'package:check_weather/services/fetch_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  RxInt _currentIndex=0.obs;
  RxBool isLoading = true.obs;
  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;
  late Weather_Info weather_info;
  bool? serviceEnabled;
  RxList statusHourlyList = [].obs;
  RxList statusDailyList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    weather_info = Weather_Info();
    if (isLoading.value == true) {
      getLocation();
    }
    else
    {
      getCurrentIndex();
    }
  }

  getLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint("Permission is Denied-Forever");
      return Future.error('Permission is Denied-Forever');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      lat.value = value.latitude;
      lon.value = value.longitude;

      weather_info = await FetchWeather.processData(lat.value, lon.value);

      weather_info.hourly?.forEach((element) {
        statusHourlyList.add(false);
      },
      );

      weather_info.daily?.forEach((element) {
        statusDailyList.add(false);
      },
      );

      debugPrint(statusHourlyList.length.toStringAsFixed(1));
      debugPrint(weather_info.hourly?.length.toStringAsFixed(1));
      debugPrint(lat.value.toString());
      debugPrint(lon.value.toString());
      debugPrint(weather_info.current!.temp.toString());
      isLoading.value = false;
    });
  }

  RxInt getCurrentIndex(){
    return _currentIndex;
  }

}
