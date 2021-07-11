import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherdata});
  final weatherdata;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  String cityname;
  String weathericon;
  int temperature;
  String message;
  var typedname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.weatherdata);
  }
  WeatherModel weather = WeatherModel();
  void updateUI(dynamic weatherData) {
     setState(() {
       if(weatherData==Null)
         {
           temperature = 0;
           weathericon = 'Error';
           cityname = 'you are on the Earth!!';
           message = 'turn on location';
           return;
         }
       double tem =  weatherData['main']['temp'];
       temperature = tem.toInt();
       var condition =   weatherData['weather'][0]['id'];
       weathericon = weather.getWeatherIcon(condition);
       cityname =   weatherData['name'];
       message = weather.getMessage(temperature);
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var wlink = await weather.getweatherinfo();
                      updateUI(wlink);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                       typedname = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }),);
                      if(typedname!=Null)
                      {
                          var gdata = await weather.getcityweather(typedname);
                          updateUI(gdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°C',
                      style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 90.0,
                      ),
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityname',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Spartan MB',
                    fontSize: 40.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
