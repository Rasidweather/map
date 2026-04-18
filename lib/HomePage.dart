import 'dart:async';

import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:linear_timer/linear_timer.dart';
import 'package:open_weather_widget/open_weather_widget.dart';
import 'package:rased/LegendItem.dart';
import 'package:rased/RotatingIcon.dart';
import 'package:rased/weatherNews.dart';
import 'package:rased/weather_ayer_panel.dart';

import 'AboutUsPage.dart';
import 'ForecastTileProvider.dart';
import 'SearchLocation/location_search_screen.dart';
import 'SearchPage.dart';
import 'SettingPage.dart';
import 'features/map/presentation/pages/map_page.dart';
import 'map_setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GoogleMapController? _controller;
  TileOverlay? _tileOverlay;
  DateTime _forecastDate = DateTime.now();
  bool displayMyWidget = false;
  bool displayMyWidget2 = false;
  bool displayMyWidget3 = false;
  late BitmapDescriptor markerIcon;
  Set<Marker> _markers = Set<Marker>();
  String? _currentAddress;
  Position? _currentPosition;
  String _isTempMap = "TA2";
  String palette =
      '-65:821692;-55:821692;-45:821692;-40:821692;-30:8257db;-20:208cec;-10:20c4e8;0:23dddd;10:c2ff28;20:fff028;25:ffc228;30:fc8014';
  String _gfs = "gfs";
  bool puase = false;
  bool val = true;
  late LinearTimerController timerController;
  bool timerRunning = false;
  var addedtimer = DateTime.now().add(Duration(hours: 3));
  bool displayWeatherSidebar = false;
  bool displayMapSettings = false;
  String selectedMapOption = "Forecast Value";
  String animationSpeed = "Medium";
  String animationDuration = "6 hours";
  String animationStyle = "Fast";
  double levelValue = 50;
  bool particleOn = true;
  bool isobarsOn = false;
  bool showTracking = false;

  @override
  void initState() {
    super.initState();
    timerController = LinearTimerController(this);
    setState(() {
      _isTempMap = "TA2";
      palette =
          '-65:821692;-55:821692;-45:821692;-40:821692;-30:8257db;-20:208cec;-10:20c4e8;0:23dddd;10:c2ff28;20:fff028;25:ffc228;30:fc8014';
    });
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }

  _initTiles(DateTime date) async {
    final String overlayId = date.millisecondsSinceEpoch.toString();
    final TileOverlay tileOverlay = TileOverlay(
      tileOverlayId: TileOverlayId(overlayId),
      tileProvider: ForecastTileProvider(
        mapType: _isTempMap,
        dateTime: date,
        fill: true,
        opacity: 0.6,
        palette: palette,
      ),
    );
    setState(() {
      _tileOverlay = tileOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'images/map_image.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05,
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3.2,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(40, 43, 58, 1),
                              borderRadius: displayMyWidget3
                                  ? const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    )
                                  : BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'images/rased.png',
                                    width: MediaQuery.of(context).size.width /
                                        3.5 /
                                        1.5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        displayMyWidget3 = !displayMyWidget3;
                                        displayMyWidget = false;
                                        displayMyWidget2 = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          displayMyWidget3
                              ? TranslationAnimatedWidget(
                                  curve: Curves.easeIn,
                                  duration: Duration(seconds: 1),
                                  enabled: displayMyWidget3,
                                  values: [
                                    Offset(0, -20),
                                    Offset(0, 0),
                                  ],
                                  child: Container(
                                    width: 125,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(40, 43, 58, 1),
                                      borderRadius: displayMyWidget3
                                          ? BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            )
                                          : BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SettingPage(),
                                                    ));
                                              },
                                              child: Text(
                                                'Settings',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              )),
                                          Divider(
                                            color: Colors.white,
                                            thickness: 0.4,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AboutUsPage(),
                                                    ));
                                              },
                                              child: Text(
                                                'About Us',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              )),
                                          Divider(
                                            color: Colors.white,
                                            thickness: 0.4,
                                          ),
                                          Text(
                                            'Share',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                          Divider(
                                            color: Colors.white,
                                            thickness: 0.4,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WeatherNews()));
                                            },
                                            child: Text('News',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13)),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(width: 0, height: 0),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              displayMyWidget2
                                  ? Container(width: 0)
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchLocationScreen()),
                                          );

                                          if (result == null) return;

                                          if (result == 'currentlocation') {
                                            _getCurrentPosition();
                                            return;
                                          }

                                          if (result is String &&
                                              result.isNotEmpty) {
                                            try {
                                              List<Location> placemarks =
                                                  await locationFromAddress(
                                                      result);
                                              if (placemarks.isNotEmpty) {
                                                var lat =
                                                    placemarks.first.latitude;
                                                var lon =
                                                    placemarks.first.longitude;
                                                setState(() {
                                                  _controller!.moveCamera(
                                                      CameraUpdate.newLatLng(
                                                          LatLng(lat, lon)));
                                                  _markers.add(Marker(
                                                    markerId:
                                                        MarkerId('marker'),
                                                    position: LatLng(lat, lon),
                                                    icon: BitmapDescriptor
                                                        .defaultMarker,
                                                  ));
                                                });
                                              }
                                            } catch (e) {
                                              print("خطأ في تحديد الموقع: $e");
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(40, 43, 58, 1),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                              displayMyWidget2
                                  ? SideSheetOpener(
                                      open: true,
                                      onClosedOrReset: () {
                                        setState(
                                            () => displayMyWidget2 = false);
                                      },
                                    )
                                  : Container(width: 0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      displayMyWidget2 = true;
                                      displayMyWidget = false;
                                      displayMyWidget3 = false;
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(40, 43, 58, 1),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.layers,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (!displayWeatherSidebar)
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              displayWeatherSidebar = true;
                                              displayMapSettings = false;
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(40, 43, 58, 1),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Icon(Icons.wb_sunny,
                                                color: Colors.white),
                                          ),
                                        ),
                                      if (displayWeatherSidebar)
                                        SideSheetOpeners(
                                          open: displayWeatherSidebar,
                                          panelWidth: 360, // غيّر العرض إذا تحب
                                          onClosedOrReset: () => setState(() => displayWeatherSidebar = false),
                                          sheetBuilder: (ctx) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 12),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(ctx).size.width * 0.9,
                                                  maxHeight: MediaQuery.of(ctx).size.height * 0.7,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(40, 43, 58, 0.8),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: SingleChildScrollView(
                                                  padding: const EdgeInsets.all(12),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                "Map Setting",
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(ctx).maybePop();
                                                            },
                                                            child: const Icon(Icons.close, color: Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 12),
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "SHOW ON MAP",
                                                            style: TextStyle(
                                                              color: Colors.white70,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Container(
                                                        padding: const EdgeInsets.all(12),
                                                        decoration: BoxDecoration(
                                                          color: const Color.fromRGBO(50, 53, 68, 1),
                                                          borderRadius: BorderRadius.circular(12),
                                                          border: Border.all(color: Colors.white),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            ...[
                                                              "Forecast Value",
                                                              "Weather Symbols",
                                                              "Reported Wind",
                                                              "Air Quality Index",
                                                              "Nothing"
                                                            ].map((option) {
                                                              return ListTile(
                                                                dense: true,
                                                                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                                                                contentPadding: EdgeInsets.zero,
                                                                title: Text(
                                                                  option,
                                                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                                                ),
                                                                trailing: selectedMapOption == option
                                                                    ? const Icon(Icons.check, color: Colors.blueAccent, size: 18)
                                                                    : null,
                                                                onTap: () {
                                                                  setState(() {
                                                                    selectedMapOption = option;
                                                                  });
                                                                },
                                                              );
                                                            }),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 12),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text("ANIMATION",
                                                              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                                                          const SizedBox(height: 8),
                                                          const Text("Animation Speed", style: TextStyle(color: Colors.white)),
                                                          const SizedBox(height: 6),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: const Color.fromRGBO(40, 43, 58, 1),
                                                              borderRadius: BorderRadius.circular(50),
                                                              border: Border.all(color: Colors.white),
                                                            ),
                                                            child: Row(
                                                              children: ["Slow", "Medium", "Fast"].map((speed) {
                                                                bool isSelected = animationSpeed == speed;
                                                                return Expanded(
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        animationSpeed = speed;
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      height: 30,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(50),
                                                                        color: isSelected ? Colors.white : Colors.transparent,
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          speed,
                                                                          style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            color: isSelected ? Colors.black : Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          const Text("Satellite Animation During", style: TextStyle(color: Colors.white)),
                                                          const SizedBox(height: 6),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: const Color.fromRGBO(40, 43, 58, 1),
                                                              borderRadius: BorderRadius.circular(50),
                                                              border: Border.all(color: Colors.white),
                                                            ),
                                                            child: Wrap(
                                                              spacing: 8,
                                                              runSpacing: 4,
                                                              children: ["3 hours", "6 hours", "12 hours", "24 hours"].map((duration) {
                                                                bool isSelected = animationDuration == duration;
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      animationDuration = duration;
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      color: isSelected ? Colors.white : Colors.transparent,
                                                                    ),
                                                                    child: Text(
                                                                      duration,
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        color: isSelected ? Colors.black : Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          const Text("Satellite Animation Style", style: TextStyle(color: Colors.white)),
                                                          const SizedBox(height: 6),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: const Color.fromRGBO(40, 43, 58, 1),
                                                              borderRadius: BorderRadius.circular(50),
                                                              border: Border.all(color: Colors.white),
                                                            ),
                                                            child: Row(
                                                              children: ["Fast", "Smooth"].map((style) {
                                                                bool isSelected = animationStyle == style;
                                                                return Expanded(
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        animationStyle = style;
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      height: 30,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(30),
                                                                        color: isSelected ? Colors.white : Colors.transparent,
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          style,
                                                                          style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            color: isSelected ? Colors.black : Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          const Text(
                                                            "AWARENESS LEVEL",
                                                            style: TextStyle(
                                                              color: Colors.white70,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              ...[
                                                                {"color": Colors.yellow, "text": "Slight Risk"},
                                                                {"color": Colors.orange, "text": "Moderate Risk"},
                                                                {"color": Colors.red, "text": "High Risk"},
                                                                {"color": Colors.purple, "text": "Extreme Risk"},
                                                              ].map((level) {
                                                                return Container(
                                                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                                                  decoration: BoxDecoration(
                                                                    color: const Color.fromRGBO(40, 43, 58, 1),
                                                                    borderRadius: BorderRadius.circular(50),
                                                                    border: Border.all(color: Colors.white),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.warning, color: level["color"] as Color),
                                                                      const SizedBox(width: 8),
                                                                      Expanded(
                                                                        child: Text(
                                                                          level["text"] as String,
                                                                          style: const TextStyle(
                                                                            color: Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height: 40,
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.blueAccent,
                                                                          borderRadius: BorderRadius.circular(50),
                                                                        ),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            "ON",
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 10),
                                                          const Text(
                                                            "Levels",
                                                            style: TextStyle(
                                                              color: Colors.white70,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Slider(
                                                            value: levelValue,
                                                            min: 0,
                                                            max: 100,
                                                            divisions: 100,
                                                            activeColor: Colors.blueAccent,
                                                            inactiveColor: Colors.white30,
                                                            label: levelValue.round().toString(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                levelValue = value;
                                                              });
                                                            },
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Container(
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.white),
                                                              borderRadius: BorderRadius.circular(50),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Particle Animation",
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      particleOn = !particleOn;
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    height: 35,
                                                                    width: 100,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.blueAccent,
                                                                      borderRadius: BorderRadius.circular(50),
                                                                    ),
                                                                    child: const Center(
                                                                      child: Text(
                                                                        "ON",
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Container(
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.white),
                                                              borderRadius: BorderRadius.circular(50),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Isobars",
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      isobarsOn = !isobarsOn;
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    height: 35,
                                                                    width: 100,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.red,
                                                                      borderRadius: BorderRadius.circular(50),
                                                                    ),
                                                                    child: const Center(
                                                                      child: Text(
                                                                        "OFF",
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          const Divider(color: Colors.white30, thickness: 1),
                                                          const SizedBox(height: 12),
                                                          const Center(
                                                            child: Text(
                                                              "Hurricane",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 12),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.white),
                                                              borderRadius: BorderRadius.circular(60),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Expanded(
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor: showTracking
                                                                          ? Colors.white
                                                                          : const Color.fromRGBO(40, 43, 58, 1),
                                                                      shape: const StadiumBorder(),
                                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                                    ),
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        showTracking = true;
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      "Tracking",
                                                                      style: TextStyle(
                                                                        color: showTracking ? Colors.black : Colors.white,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor: !showTracking
                                                                          ? Colors.white
                                                                          : const Color.fromRGBO(40, 43, 58, 1),
                                                                      shape: const StadiumBorder(),
                                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                                    ),
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        showTracking = false;
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      "Legend",
                                                                      style: TextStyle(
                                                                        color: !showTracking ? Colors.black : Colors.white,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          if (showTracking)
                                                            Container(
                                                              margin: const EdgeInsets.only(top: 20),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(70),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(color: Colors.white),
                                                                      borderRadius: BorderRadius.circular(50),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.white,
                                                                            ),
                                                                            onPressed: () {},
                                                                            child: const Text(
                                                                              "Historical",
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(width: 8),
                                                                        Expanded(
                                                                          child: ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(
                                                                              backgroundColor:
                                                                              const Color.fromRGBO(40, 43, 58, 1),
                                                                            ),
                                                                            onPressed: () {},
                                                                            child: const Text(
                                                                              "Forecast",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  const Divider(color: Colors.white),
                                                                  const Text(
                                                                    "Active Storm",
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets.all(16),
                                                                    padding: const EdgeInsets.all(12),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      border: Border.all(
                                                                        color: Colors.white,
                                                                      ),
                                                                      boxShadow: const [
                                                                        BoxShadow(
                                                                          color: Colors.black26,
                                                                          blurRadius: 8,
                                                                          offset: Offset(0, 4),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: Column(
                                                                      children: [
                                                                        const ListTile(
                                                                          leading: RotatingIcon(
                                                                            icon: Icons.cyclone,
                                                                            color: Colors.red,
                                                                          ),
                                                                          title: Text(
                                                                            "Iona",
                                                                            style: TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        Divider(color: Colors.grey[300]),
                                                                        const ListTile(
                                                                          leading: RotatingIcon(
                                                                            icon: Icons.cyclone,
                                                                            color: Colors.red,
                                                                          ),
                                                                          title: Text(
                                                                            "Krosa",
                                                                            style: TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        Divider(color: Colors.grey[300]),
                                                                        const ListTile(
                                                                          leading: RotatingIcon(
                                                                            icon: Icons.cyclone,
                                                                            color: Colors.red,
                                                                          ),
                                                                          title: Text(
                                                                            "Co-May",
                                                                            style: TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    "Active Disturbances",
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 16,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 8),
                                                                  Container(
                                                                    padding: const EdgeInsets.all(12),
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(color: Colors.white30),
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                    child: const Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Icon(Icons.close, color: Colors.red),
                                                                            SizedBox(width: 10),
                                                                            Text(
                                                                              "Pacific Disturbance 1",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 10),
                                                                        Divider(color: Colors.white30),
                                                                        SizedBox(height: 10),
                                                                        Row(
                                                                          children: [
                                                                            Icon(Icons.close, color: Colors.orange),
                                                                            SizedBox(width: 10),
                                                                            Text(
                                                                              "Pacific Disturbance 2",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          else
                                                            Container(
                                                              margin: const EdgeInsets.only(top: 20),
                                                              padding: const EdgeInsets.all(16),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              child: const Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  LegendItem(
                                                                    title: "Hurricane Category 5",
                                                                    speed: "> 43 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "5",
                                                                    lineColor: Colors.white,
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Hurricane Category 4",
                                                                    speed: "36 - 43 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "4",
                                                                    lineGradient:
                                                                    LinearGradient(colors: [Colors.white, Colors.blue]),
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Hurricane Category 3",
                                                                    speed: "31 - 36 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "3",
                                                                    lineGradient:
                                                                    LinearGradient(colors: [Colors.white, Colors.blue]),
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Hurricane Category 2",
                                                                    speed: "27 - 31 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "2",
                                                                    lineColor: Colors.white,
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Hurricane Category 1",
                                                                    speed: "21 - 26 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "1",
                                                                    lineGradient:
                                                                    LinearGradient(colors: [Colors.white, Colors.blue]),
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Tropical Storm",
                                                                    speed: "11 - 20 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "TS",
                                                                    lineGradient:
                                                                    LinearGradient(colors: [Colors.white, Colors.blue]),
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Post-Tropical Cyclone",
                                                                    speed: "05 - 11 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "L",
                                                                    lineGradient:
                                                                    LinearGradient(colors: [Colors.white, Colors.blue]),
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Tropical Depression",
                                                                    speed: "03 - 05 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "O",
                                                                    lineGradient:
                                                                    LinearGradient(colors: [Colors.white, Colors.blue]),
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Remnants",
                                                                    speed: "< 03 mph",
                                                                    iconColor: Colors.red,
                                                                    label: "R",
                                                                    lineGradient:
                                                                    LinearGradient(colors: [Colors.white, Colors.blue]),
                                                                  ),
                                                                  LegendItem(
                                                                    title: "Disturbances",
                                                                    speed: "",
                                                                    iconColor: Colors.red,
                                                                    label: "X",
                                                                    lineGradient:
                                                                    LinearGradient(colors: [Colors.white, Colors.blue]),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )



                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(40, 43, 58, 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _gfs = 'icon';
                                      _forecastDate = _forecastDate.subtract(
                                          const Duration(seconds: 100));
                                      _initTiles(_forecastDate);
                                    });
                                  },
                                  child: Text(
                                    'ICON',
                                    style: TextStyle(
                                        color: _gfs == 'icon'
                                            ? Colors.white
                                            : Colors.white54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: _gfs == 'icon' ? 19 : 15),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _gfs = 'gfs';
                                      _forecastDate = _forecastDate
                                          .subtract(const Duration(seconds: 1));
                                      _initTiles(_forecastDate);
                                    });
                                  },
                                  child: Text(
                                    'GFS',
                                    style: TextStyle(
                                        color: _gfs == 'gfs'
                                            ? Colors.white
                                            : Colors.white54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: _gfs == 'gfs' ? 19 : 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            _getCurrentPosition();
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(40, 43, 58, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.my_location_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(40, 43, 58, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 6),
                                  const Icon(Icons.play_arrow_rounded,
                                      color: Colors.white, size: 40),
                                  const SizedBox(width: 6),
                                  const Text("|",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 18)),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildDayWithDivider("Sat", 19),
                                          _buildDayWithDivider("Sun", 20),
                                          _buildDayWithDivider("Mon", 21),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  height: 20,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(6),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: const Center(
                                              child: Text(
                                                "Temperature",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                  left: Radius.circular(6),
                                                ),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xff0000ff),
                                                    Color(0xff00ffff),
                                                    Color(0xff00ff00),
                                                    Color(0xffffff00),
                                                    Color(0xffff0000),
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text("0",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)),
                                                    Text("10",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)),
                                                    Text("20",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)),
                                                    Text("30",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)),
                                                    Text("40",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ));
  }

  CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    // target: LatLng(44.8, 10.33),
    zoom: 4,
  );

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _controller!.moveCamera(CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude)));
      _initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        // target: LatLng(44.8, 10.33),
        zoom: 4,
      );
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "images/marker.png",
              mipmaps: true)
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
      _markers.add(Marker(
        markerId: MarkerId('marker'),
        position: LatLng(position.latitude, position.longitude),
        icon: markerIcon,
      ));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Widget _buildDayBox(String day, int date) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        Text(
          date.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDayWithDivider(String day, int date, {bool showDivider = true}) {
    return Row(
      children: [
        Row(
          children: [
            Text(
              day,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(width: 4),
            Text(
              date.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(width: 3),
          const Text(
            "|",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ],
      ],
    );
  }

  Widget _buildRadarImage(String imagePath, String name,
      {String? overlayImage}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            if (overlayImage != null)
              Image.asset(
                overlayImage,
                width: 24,
                height: 24,
                color: Colors.white,
              ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
  Widget _switchRow({
    required String title,
    required bool on,
    required VoidCallback onTap,
    required String onLabel,
    required Color onColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: onColor,
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              child: Text(
                onLabel,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _segmentedTwo({
    required String left,
    required String right,
    required bool isLeftSelected,
    required VoidCallback onLeft,
    required VoidCallback onRight,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60), bottomLeft: Radius.circular(60)),
              onTap: onLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isLeftSelected ? Colors.white : const Color.fromRGBO(40, 43, 58, 1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60), bottomLeft: Radius.circular(60)),
                ),
                alignment: Alignment.center,
                child: Text(left,
                  style: TextStyle(
                    color: isLeftSelected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
              onTap: onRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isLeftSelected ? Colors.white : const Color.fromRGBO(40, 43, 58, 1),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
                ),
                alignment: Alignment.center,
                child: Text(right,
                  style: TextStyle(
                    color: !isLeftSelected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

/// استعمل هذا بدلاً من استدعاء الدالة مباشرة داخل build
class SideSheetOpener extends StatefulWidget {
  const SideSheetOpener({
    super.key,
    required this.open, // true لفتح الشيت
    required this.onClosedOrReset, // مثل: إرجاع displayMyWidget2 = false
  });

  final bool open;
  final VoidCallback onClosedOrReset;

  @override
  State<SideSheetOpener> createState() => _SideSheetOpenerState();
}

class _SideSheetOpenerState extends State<SideSheetOpener> {
  bool _openingNow = false; // يمنع التكرار أثناء نفس الإطار

  @override
  void initState() {
    super.initState();
    if (widget.open) _scheduleOpen();
  }

  @override
  void didUpdateWidget(covariant SideSheetOpener oldWidget) {
    super.didUpdateWidget(oldWidget);
    // فتح جديد فقط عندما تتغير من false -> true
    if (!oldWidget.open && widget.open) _scheduleOpen();
  }

  void _scheduleOpen() {
    if (_openingNow) return;
    _openingNow = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      // افتح الشيت الجانبي ثم عند الإغلاق نفّذ onClosedOrReset
      await showWeatherSideSheet(context);
      if (!mounted) return;
      widget
          .onClosedOrReset(); // مثل: setState(() => displayMyWidget2 = false);
      _openingNow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ويدجت صامتة فقط لبدء الفتح عند الحاجة
    return const SizedBox.shrink();
  }
}
