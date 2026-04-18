import 'package:dartz/dartz.dart';
import 'package:rased/core/error/failures.dart';
import 'package:rased/core/utils/lat_long.dart';
import 'package:rased/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeather(LatLong latLong);
}
