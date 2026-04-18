import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'core/constant/api_key.dart';


class ForecastTileProvider implements TileProvider {
  final String mapType;
  final DateTime dateTime;
  int tileSize = 256;
  final double opacity;
  final String palette ;
  final bool fill  ;

  ForecastTileProvider({
    required this.mapType,
    required this.dateTime,
    required this.opacity,
    required this.palette,
    required this.fill,
  });

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);
    try {
      final url =
      // "https://api.windy.com/api/point-forecast/v2?lat=49.809&lon=16.787&model=gfs&parameters=[wind,dewpoint,rh,pressure]&levels=[surface,800h,300h]&key=vOKuQTaX5WCKwYzjPE7tD0MCmfU2eQU9";
      //     "https://api.tomorrow.io/v4/map/tile/$zoom/$x/$y/$mapType/now.png?apikey=hsi30x2nmxbQMRw5CKCVJ8i8fFL8fZ5D";
              "https://maps.openweathermap.org/maps/2.0/weather/$mapType/$zoom/$x/$y?appid=$API_KEY&fill_bound=$fill&opacity=$opacity&palette=$palette";
              // "http://maps.openweathermap.org/maps/2.0/weather/PAR0/$zoom/$x/$y?appid=$API_KEY&fill_bound=true&opacity=0.6&palette=-65:821692;-55:821692;-45:821692;-40:821692;-30:8257db;-20:208cec;-10:20c4e8;0:23dddd;10:c2ff28;20:fff028;25:ffc228;30:fc8014";


      final uri = Uri.parse(url);
      // final response = await http.get(uri);
      // print(response.body);
      // final json = jsonDecode(response.body);
        final ByteData imageData = await NetworkAssetBundle(uri).load("");
        tileBytes = imageData.buffer.asUint8List();
        print(tileBytes);
    } catch (e) {
      print(e.toString());
    }
    return Tile(tileSize, tileSize, tileBytes);
  }
}

class TilesCache {
  static Map<String, Uint8List> tiles = {};
}


class post2 implements TileProvider{
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);
    var url =
        "https://api.windy.com/api/point-forecast/v2";
    Map data ={
      "lat": 49.809,
      "lon": 16.787,
      "model": "gfs",
      "parameters": ["wind", "dewpoint", "rh", "pressure"],
      "levels": ["surface", "800h", "300h"],
      "key": "vOKuQTaX5WCKwYzjPE7tD0MCmfU2eQU9"
    };
    //encode Map to JSON
    var body = json.encode(data);
    final uri = Uri.parse(url);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("fefefefe ${response.statusCode}");
    print("fefefefe ${response.bodyBytes}");
    return Tile(256, 256, response.bodyBytes);
  }

}



Future<http.Response> postRequest () async {
  var url =
      "https://api.windy.com/api/point-forecast/v2";
  Map data ={
    "lat": 49.809,
    "lon": 16.787,
    "model": "gfs",
    "parameters": ["wind", "dewpoint", "rh", "pressure"],
    "levels": ["surface", "800h", "300h"],
    "key": "vOKuQTaX5WCKwYzjPE7tD0MCmfU2eQU9"
  };
  //encode Map to JSON
  var body = json.encode(data);
  final uri = Uri.parse(url);
  var response = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}