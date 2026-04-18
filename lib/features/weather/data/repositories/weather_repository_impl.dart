import 'package:rased/core/error/failures.dart';
import 'package:rased/core/error/exceptions.dart';
import 'package:rased/core/network/network_info.dart';
import 'package:rased/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:rased/features/weather/domain/entities/weather.dart';
import 'package:rased/core/utils/lat_long.dart';
import 'package:rased/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:rased/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getWeather(LatLong latLong) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherRemoteData =
            await weatherRemoteDataSource.getWeather(latLong);
        return Right(weatherRemoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
