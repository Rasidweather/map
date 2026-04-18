import 'package:flutter/material.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:open_weather_widget/weather_model.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ModelMap {
  const ModelMap(this.state, this.color, this.stateCode);
  /// Represents the Australia state name.
  final String state;
  /// Represents the Australia state color.
  final Color color;
  /// Represents the Australia state code.
  final String stateCode;
}

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  late List<ModelMap> _data;
  late MapShapeSource _mapSource;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {

    OpenMeteo(
      longitude: 52.12,
      latitude: 13.15,
      current_weather: true,
      temperature_unit: TemperatureUnit.celsius,
      windspeed_unit: WindspeedUnit.kmh,
      precipitation_unit: PrecipitationUnit.mm,
    );



    // _data = const <ModelMap>[
    //   ModelMap('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
    //       '       New\nSouth Wales'),
    //   ModelMap('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
    //   ModelMap('Northern Territory', Color.fromRGBO(255, 78, 66, 1.0),
    //       'Northern\nTerritory'),
    //   ModelMap('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
    //   ModelMap('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
    //       'South Australia'),
    //   ModelMap('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
    //       'Western Australia'),
    //   ModelMap('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
    //   ModelMap('Australian Capital Territory', Colors.teal, 'ACT')
    // ];
    //
    // _mapSource = MapShapeSource.asset(
    //   'assets/world_map.json',
    //   shapeDataField: 'STATE_NAME',
    //   dataCount: _data.length,
    //   primaryValueMapper: (int index) => _data[index].state,
    //   dataLabelMapper: (int index) => _data[index].stateCode,
    //   shapeColorValueMapper: (int index) => _data[index].color,
    //
    // );
    super.initState();
    // _zoomPanBehavior = MapZoomPanBehavior();
    // _sublayers = [];
  }
  @override
  void dispose() {
    // _sublayers.clear();
    super.dispose();
  }
  // late List<MapSublayer> _sublayers;
  //
  // bool _handleOnWillZoom(MapZoomDetails details) {
  //   setState(() {
  //     if (_sublayers.isEmpty && details.newZoomLevel! >= 2) {
  //       _sublayers.add(MapShapeSublayer(
  //         source: _mapSource,
  //         color: Colors.blue[100],
  //         strokeWidth: 1,
  //         strokeColor: Colors.blue[800],
  //       ));
  //     } else if (details.newZoomLevel! < 2) {
  //       _sublayers.clear();
  //     }
  //   });
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(





        // child: SfMaps(
        //     layers: <MapShapeLayer>[
        //       MapShapeLayer(
        //         zoomPanBehavior: _zoomPanBehavior,
        //         sublayers: _sublayers,
        //         source: _mapSource,
        //         showDataLabels: true,
        //         color: Colors.blue[800],
        //
        //         legend: const MapLegend(MapElement.shape),
        //         tooltipSettings: MapTooltipSettings(
        //             color: Colors.grey[700],
        //             strokeColor: Colors.black,
        //             strokeWidth: 2),
        //         strokeColor: Colors.grey,
        //         strokeWidth: 0.4,
        //         shapeTooltipBuilder: (BuildContext context, int index) {
        //           return Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text(
        //               _data[index].stateCode,
        //               style: const TextStyle(color: Colors.black),
        //             ),
        //           );
        //         },
        //         dataLabelSettings: MapDataLabelSettings(
        //           textStyle: TextStyle(
        //               color: Colors.black,
        //               fontWeight: FontWeight.bold,
        //               fontSize:
        //               Theme.of(context).textTheme.bodySmall!.fontSize),
        //         ),
        //       ),
        //     ]
        // ),
      ),
    );
  }
}
