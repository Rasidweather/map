import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

// weather_data.dart
class WeatherData {
  final String city;
  final String description;
  final double temperature;
  final int humidity;
  final String iconCode;

  WeatherData({
    required this.city,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.iconCode,
  });
}

// location_data.dart
class LocationData {
  final double latitude;
  final double longitude;

  LocationData({
    required this.latitude,
    required this.longitude,
  });
}

class WeatherApi {
  final String apiKey;
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherApi({required this.apiKey});

  Future<Map<String, dynamic>> fetchWeatherData(double latitude, double longitude) async {
    final response = await http.get('$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric' as Uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}


class WeatherProvider with ChangeNotifier {
  WeatherData? _weatherData;
  LocationData? _locationData;

  WeatherProvider() {
    _locationData = LocationData(latitude: 0.0, longitude: 0.0); // Initialize with default location
    fetchWeatherData();
  }

  WeatherData? get weatherData => _weatherData;
  LocationData? get locationData => _locationData;

  void setLocation(double latitude, double longitude) {
    _locationData = LocationData(latitude: latitude, longitude: longitude);
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      final api = WeatherApi(apiKey: '9de243494c0b295cca9337e1e96b00e2');
      final data = await api.fetchWeatherData(_locationData!.latitude, _locationData!.longitude);
      _weatherData = WeatherData(
        city: data['name'],
        description: data['weather'][0]['description'],
        temperature: data['main']['temp'],
        humidity: data['main']['humidity'],
        iconCode: data['weather'][0]['icon'],
      );
      notifyListeners();
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }
}

final Map<String, WidgetBuilder> routes = {
  '/': (context) => HomeScreen(),
  '/location_picker': (context) => LocationPickerScreen(),
};

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}
class _LocationPickerScreenState extends State<LocationPickerScreen> {
  double _latitude = 0.0;
  double _longitude = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Latitude: $_latitude'),
            Text('Longitude: $_longitude'),
            ElevatedButton(
              onPressed: () {
                // Implement location picker logic here
                // Update _latitude and _longitude accordingly
                final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
                weatherProvider.setLocation(_latitude, _longitude);
                Navigator.pop(context);
              },
              child: Text('Set Location'),
            ),
          ],
        ),
      ),
    );
  }
}








class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: weatherData != null
            ? WeatherInfoWidget(weatherData: weatherData)
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a location picker screen or use device location services
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
class WeatherInfoWidget extends StatelessWidget {
  final WeatherData weatherData;
  WeatherInfoWidget({required this.weatherData});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/weather_icons/${weatherData.iconCode}.svg', width: 100),
        SizedBox(height: 16),
        Text(weatherData.city, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(weatherData.description, style: TextStyle(fontSize: 16)),
        SizedBox(height: 16),
        Text('${weatherData.temperature.toStringAsFixed(1)}°C', style: TextStyle(fontSize: 32)),
        Text('Humidity: ${weatherData.humidity}%', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}