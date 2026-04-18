import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rased/core/constant/api_key.dart';
import 'package:rased/core/error/exceptions.dart';
import 'package:rased/core/utils/lat_long.dart';
import 'package:rased/features/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(LatLong latLong);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeather(LatLong latLong) async {
    final response = await client.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=${latLong.lat}&lon=${latLong.long}&units=metric&appid=$API_KEY"),
      headers: {'content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
