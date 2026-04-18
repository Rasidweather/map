import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:rased/core/constant/api_key.dart';
import 'package:rased/core/error/exceptions.dart';
import 'package:rased/features/map/data/models/map_model.dart';

abstract class MapRemoteDataSource {
  Future<MapModel> getMaps(String mapType, int x, int y, int zoom);
}

class MapRemoteDataSourceImpl extends MapRemoteDataSource {
  @override
  Future<MapModel> getMaps(String mapType, int x, int y, int zoom) async {
    try {
      mapType = 'WNDUV';
      final uri = Uri.parse(
          // "https://tile.openweathermap.org/map/$mapType/$zoom/$x/$y.png?appid=$API_KEY"
          //     "https://maps.openweathermap.org/maps/2.0/weather/1h/$mapType/$zoom/$x/$y?appid=$API_KEY"
              // "https://maps.openweathermap.org/maps/2.0/weather/1h/$mapType/$zoom/$x/$y?date=1618898990&appid=$API_KEY"
        "https://maps.openweathermap.org/maps/2.0/weather/1h/$mapType/$zoom/$x/$y?date=16188989909&appid=$API_KEY"
      );


      final ByteData imageData = await NetworkAssetBundle(uri).load("");
      return MapModel.fromByteData(imageData);
    } catch (e) {
      throw ServerException();
    }
  }
}

