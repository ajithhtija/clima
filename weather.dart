import 'networking.dart';
import 'location.dart';
const apiKey = '8c382b3ea4ba5049021941ccf32d8a5f';
class WeatherModel {

  Future<dynamic> getcityweather(var cityname) async
  {
     var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apiKey&units=metric';
     Networkhelper networkhelper = Networkhelper(url);
     var wdata = await networkhelper.getdata();
     return wdata;
  }
  Future<dynamic> getweatherinfo() async
  {
    Location loc = Location();
    await loc.getcurrentlocation();
    Networkhelper networkhelper = Networkhelper('https://api.openweathermap.org/data/2.5/weather?lat=${loc.lat}&lon=${loc.long}&appid=$apiKey&units=metric');
    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return  '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
