import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weatherModel = WeatherModel();
  void getlocationdata()
  async {
          var wd = await weatherModel.getweatherinfo();
         Navigator.push(context, MaterialPageRoute(builder: (context) {
         return LocationScreen(weatherdata: wd,);
    })) ;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocationdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SpinKitPouringHourglass(color: Colors.white,size: 100.0,)),
    );
  }
}
