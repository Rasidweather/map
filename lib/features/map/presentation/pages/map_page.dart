// import 'package:google_place/google_place.dart' ;
// import 'package:geocoding/geocoding.dart' as geo;

// import 'package:animated_widgets/animated_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart'as intl;
// import 'package:rased/AboutUsPage.dart';
// import 'package:rased/ForecastTileProvider.dart';
// import 'package:rased/SearchLocation/constants.dart';
// import 'package:rased/SearchLocation/location_search_screen.dart';
// import 'package:rased/SearchPage.dart';
// import 'package:rased/SettingPage.dart';
// import 'package:rased/features/map/data/datasources/map_remote_data_source.dart';
// import 'package:rased/features/map/domain/usecases/get_map.dart';
// import 'package:rased/features/map/presentation/bloc/map_bloc.dart';
// import 'package:http/http.dart'as http;
// import 'package:syncfusion_flutter_maps/maps.dart';



// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController mapController;

//   final LatLng latLng = const LatLng(0.0, 0.0);

//   String _isTempMap = 'temp';
//   // bool _isTempMap = false;
// bool _pressed = false; 

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }
//   late BitmapDescriptor markerIcon ;

//   Set<Marker>   _markers = Set<Marker>();
//   String? _currentAddress;
//   Position? _currentPosition;

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       mapController.moveCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
//       BitmapDescriptor.fromAssetImage(
//           const ImageConfiguration(), "images/marker.png")
//           .then(
//             (icon) {
//           setState(() {
//             markerIcon = icon;
//           });
//         },
//       );
//       _markers.add(
//         Marker(
//           markerId: MarkerId('marker'),
//           position: LatLng(position.latitude, position.longitude),
//           icon: markerIcon ,
//       )
//       );
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }


//   GooglePlace? googlePlace;
// AutocompletePrediction? destinationPrediction;
// TextEditingController? controller;


//   final startAddressController = TextEditingController();

//   TileOverlay? _tileOverlay;

//   DateTime _forecastDate = DateTime.now();

//   // _initTiles(DateTime date) async {
//   //   final String overlayId = date.millisecondsSinceEpoch.toString();
//   //
//   //   final TileOverlay tileOverlay = TileOverlay(
//   //     tileOverlayId: TileOverlayId(overlayId),
//   //     tileProvider: ForecastTileProvider(
//   //       dateTime: date,
//   //       // mapType: 'PAR0',
//   //       mapType: 'PR0',
//   //       opacity: 0.4,
//   //     ),
//   //   );
//   //   setState(() {
//   //     _tileOverlay = tileOverlay;
//   //   });
//   // }


//   bool displayMyWidget = false ;
//   bool displayMyWidget2 = false ;
//   bool displayMyWidget3 = false ;


//   @override
//   void initState() {
//     super.initState();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<MapBloc>(
//       create: (context) => MapBloc(),
//       child: BlocBuilder<MapBloc, MapState>(
//         builder: (context, state) {
//           // if (state is Temperature) {
//           //   _isTempMap = 'PR0';
//           // } else if (state is Precipitation){
//           //   _isTempMap = 'prec';
//           // } else if (state is Windnew){
//           //   _isTempMap = 'wind';
//           // }else if (state is Cloudsnew){
//           //   _isTempMap = 'cloud';
//           // }else if (state is Pressurenew){
//           //   _isTempMap = 'press';
//           // }
//           return Scaffold(
//             // floatingActionButtonLocation:
//             // FloatingActionButtonLocation.startFloat,
//             body: Stack(
//               children: [
//                 // GoogleMap(
//                 //   tileOverlays: {
//                 //     TileOverlay(
//                 //       tileOverlayId:
//                 //       const TileOverlayId('PR0_id'),
//                 //       tileProvider: tileProvider("PR0"),
//                 //     ),
//                 //   },
//                 //   // {
//                 //   //   _isTempMap == 'PR0'
//                 //   //       ? TileOverlay(
//                 //   //     tileOverlayId:
//                 //   //     const TileOverlayId('precipitation_new_id'),
//                 //   //     tileProvider: tileProvider("PR0"),
//                 //   //   ) :
//                 //   //   _isTempMap == 'temp' ?
//                 //   //   TileOverlay(
//                 //   //     tileOverlayId: const TileOverlayId('temp_new_id'),
//                 //   //     tileProvider: tileProvider("temp_new"),
//                 //   //   ) : _isTempMap == 'wind' ?
//                 //   //   TileOverlay(
//                 //   //     tileOverlayId: const TileOverlayId('wind_new_id'),
//                 //   //     tileProvider: tileProvider("wind_new"),
//                 //   //   ) :
//                 //   //   _isTempMap == 'cloud' ?
//                 //   //   TileOverlay(
//                 //   //     tileOverlayId:
//                 //   //     const TileOverlayId('clouds_new_id'),
//                 //   //     tileProvider: tileProvider("clouds_new"),
//                 //   //   ):
//                 //   //   TileOverlay(
//                 //   //     tileOverlayId:
//                 //   //     const TileOverlayId('pressure_new_id'),
//                 //   //     tileProvider: tileProvider("pressure_new"),
//                 //   //   ),
//                 //   // },
//                 //   onMapCreated: setControler,
//                 //   zoomControlsEnabled: false,
//                 //   mapType: MapType.normal,
//                 //   markers: _markers,
//                 //   initialCameraPosition: CameraPosition(
//                 //     target: latLng,
//                 //     zoom: 4,
//                 //   ),
//                 // ),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 33 , horizontal: 14),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width / 3.1,
//                         child: Column(
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width / 3.1,
//                               decoration: BoxDecoration(
//                                 color: Color.fromRGBO(40, 43, 58, 10),
//                                 borderRadius:displayMyWidget3 == true ?
//                                 BorderRadius.only(
//                                     topRight: Radius.circular(20),
//                                     topLeft: Radius.circular(20),
//                                 ) :
//                                 BorderRadius.circular(50),
//                               ),
//                               child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Container(
//                                             child: Image.asset('images/rased.png',
//                                                 width:MediaQuery.of(context).size.width / 3.1/1.5),
//                                           ),
//                                           InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   displayMyWidget3 =! displayMyWidget3 ;
//                                                   displayMyWidget = false ;
//                                                   displayMyWidget2 = false ;
//                                                 });
//                                               },
//                                               child: Icon(Icons.keyboard_arrow_down , color: Colors.white)),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                               ),
//                             ),

//                             displayMyWidget3 == false ? Container(width: 0,height: 0,) :
//                             TranslationAnimatedWidget(
//                               curve: Curves.easeIn,
//                               duration: Duration(seconds: 1),
//                               enabled: this.displayMyWidget3, //update this boolean to forward/reverse the animation
//                               values: [
//                                 Offset(0, -20), // disabled value value
//                                 Offset(0, 0), //intermediate value
//                               ], child: Container(
//                               decoration: BoxDecoration(
//                                 color: Color.fromRGBO(40, 43, 58, 10),
//                                 borderRadius:displayMyWidget3 == true ?
//                                 BorderRadius.only(
//                                   bottomRight: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                 ) :
//                                 BorderRadius.circular(50),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [

//                                     InkWell(
//                                         onTap: (){
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage(),));
//                                         },
//                                         child: Text('Settings' , style: TextStyle(color: Colors.white, fontSize: 13),)),
//                                     Divider(color: Colors.white, thickness: 0.4,),

//                                     InkWell(
//                                         onTap: (){
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage(),));
//                                         },
//                                         child: Text('About Us' , style: TextStyle(color: Colors.white, fontSize: 13),)),
//                                     Divider(color: Colors.white, thickness: 0.4,),

//                                     Text('Share' , style: TextStyle(color: Colors.white, fontSize: 13),),
//                                     Divider(color: Colors.white, thickness: 0.4,),

//                                     Text('News' , style: TextStyle(color: Colors.white, fontSize: 13),),

//                                     SizedBox(height: 8,)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),


//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Align(
//                             alignment: Alignment.bottomRight,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 displayMyWidget2 == true ? Container(width: 0,) : Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child:InkWell(
//   onTap: () async {
//     setState(() => _pressed = true); // تظهر الأيقونة الكبيرة فور الضغط
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const SearchLocationScreen()),
//     );

//     if(result == 'currentlocation') {
//       _getCurrentPosition();
//     } else if(result != null) {
//       List<geo.Location> placemarks = await geo.locationFromAddress(result);
//       var lat = placemarks.first.latitude;
//       var lon = placemarks.first.longitude;
//       setState(() {
//         mapController.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lon)));
//         _markers.add(
//           Marker(
//             markerId: const MarkerId('marker'),
//             position: LatLng(lat, lon),
//             icon: BitmapDescriptor.defaultMarker,
//           )
//         );
//       });
//     }

//     setState(() => _pressed = false); 
//   },
//   child: Container(
//     width: _pressed ? 70 : 50,
//     height: _pressed ? 70 : 50,
//     decoration: BoxDecoration(
//       color: _pressed ? Colors.transparent : const Color.fromRGBO(40, 43, 58, 1),
//       borderRadius: BorderRadius.circular(_pressed ? 0 : 50),
//     ),
//     child: Center(
//       child: Icon(
//         Icons.search,
//         color: _pressed ? Colors.black : Colors.white,
//         size: _pressed ? 40 : 24,
//       ),
//     ),
//   ),
// ),
//                                 ),

//                                 displayMyWidget2 == false ? Container(width: 0,):
//                                 TranslationAnimatedWidget(
//                                   curve: Curves.ease,
//                                   duration: Duration(seconds: 1),
//                                   enabled: this.displayMyWidget2, //update this boolean to forward/reverse the animation
//                                   values: [
//                                     Offset(0, 50), // disabled value value
//                                     Offset(0, -7), //intermediate value
//                                   ],
//                                   child:  Padding(
//                                     padding: const EdgeInsets.all(0.0),
//                                     child: Container(
//                                       width: 160,
//                                       decoration: BoxDecoration(
//                                         color: Color.fromRGBO(40, 43, 58, 10),
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 12),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.end,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         displayMyWidget2 =! displayMyWidget2 ;
//                                                         print('433');
//                                                       });
//                                                     },
//                                                     child: Icon(Icons.close , color: Colors.white,size: 20,)),

//                                                 Text('Map Overlay' , style: TextStyle(color: Colors.white, fontSize: 13),),
//                                               ],
//                                             ),
//                                             SizedBox(height: 12,),
//                                             // Icon(Icons.ac_unit , color: Colors.white,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.end,
//                                               children: [

//                                                 Text('Clouds' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                 SizedBox(width: 12,),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isTempMap == 'prec' ;
//                                                       print('prec');
//                                                       context.read<MapBloc>().add(GetTempAndPrepForMap("precipitation_new"));
//                                                     });
//                                                   },
//                                                   child: Image.asset('images/rain.png' , width: 24 , height: 24,
//                                                     color:
//                                                     _isTempMap == 'prec' ? Colors.blue[600] : Colors.white,),
//                                                 ),

//                                               ],
//                                             ),
//                                             Divider(color: Colors.white,thickness: 0.2,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.end,
//                                               children: [
//                                                 Text('Wind Motion' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                 SizedBox(width: 12,),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isTempMap == 'wind' ;
//                                                       print('wind');
//                                                       context.read<MapBloc>().add(GetTempAndPrepForMap("wind_new"));
//                                                     });
//                                                   },
//                                                   child: Image.asset('images/reah.png' , width: 24 , height: 24,
//                                                     color: _isTempMap == 'wind' ? Colors.green : Colors.white,),
//                                                 ),
//                                               ],
//                                             ),
//                                             Divider(color: Colors.white,thickness: 0.2,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.end,
//                                               children: [
//                                                 Text('Active Fires' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                 SizedBox(width: 12,),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isTempMap == 'temp' ;
//                                                       print('temp');
//                                                       context
//                                                           .read<MapBloc>()
//                                                           .add(GetTempAndPrepForMap("temp_new"));
//                                                     });
//                                                   },
//                                                   child: Image.asset('images/temper.png' ,width: 24 , height: 24,
//                                                     color:
//                                                     _isTempMap == 'temp' ? Colors.red[900] : Colors.white,),
//                                                 ),
//                                               ],
//                                             ),
//                                             Divider(color: Colors.white,thickness: 0.2,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.end,
//                                               children: [
//                                                 Text('Tropical System' , style: TextStyle(color: Colors.white, fontSize: 13),),
//                                                 SizedBox(width: 12,),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isTempMap == 'cloud' ;
//                                                       print('cloud');
//                                                       context
//                                                           .read<MapBloc>()
//                                                           .add(GetTempAndPrepForMap("clouds_new"));
//                                                     });
//                                                   },
//                                                   child: Image.asset('images/pressure.png' , width: 24 , height: 24,
//                                                     color:
//                                                     _isTempMap == 'cloud' ? Colors.red[900] : Colors.white,),
//                                                 ),
//                                               ],
//                                             ),
//                                             Divider(color: Colors.white,thickness: 0.2,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.end,
//                                               children: [
//                                                 Text('Labels' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                 SizedBox(width: 12,),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isTempMap == 'press' ;
//                                                       print('press');
//                                                       context
//                                                           .read<MapBloc>()
//                                                           .add(GetTempAndPrepForMap("pressure_new"));
//                                                     });
//                                                   },
//                                                   child: Image.asset('images/humi.png' , width: 22 , height: 24,
//                                                     color:
//                                                     _isTempMap == 'press' ? Colors.red[900] : Colors.white,),
//                                                 ),
//                                               ],
//                                             ),
//                                             Divider(color: Colors.white,thickness: 0.2,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.end,
//                                               children: [
//                                                 Text('Night Border' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                 SizedBox(width: 12,),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isTempMap == 'press' ;
//                                                       print('press');
//                                                       context
//                                                           .read<MapBloc>()
//                                                           .add(GetTempAndPrepForMap("pressure_new"));
//                                                     });
//                                                   },
//                                                   child: Image.asset('images/humi.png' , width: 22 , height: 24,
//                                                     color:
//                                                     _isTempMap == 'press' ? Colors.red[900] : Colors.white,),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),

//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         displayMyWidget2 =! displayMyWidget2 ;
//                                         displayMyWidget = false ;
//                                         displayMyWidget3 = false ;
//                                       });
//                                       // Navigator.push(context,
//                                       //     MaterialPageRoute(builder: (context) => SettingPage(),));
//                                     },
//                                     child: Container(
//                                       width: 50,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         color: Color.fromRGBO(40, 43, 58, 10),
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       child: Icon( displayMyWidget2 == true ? Icons.close :
//                                         Icons.layers , color: Colors.white,),
//                                     ),
//                                   ),
//                                 ),


//                                 displayMyWidget == false ?
//                                 TranslationAnimatedWidget(
//                                   curve: Curves.bounceInOut,
//                                   duration: Duration(seconds: 2),
//                                   enabled: this.displayMyWidget, //update this boolean to forward/reverse the animation
//                                   values: [
//                                     Offset(0, -3), // disabled value value
//                                     Offset(0, 10), //intermediate value
//                                   ],
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       width: 50,
//                                       decoration: BoxDecoration(
//                                         color: Color.fromRGBO(40, 43, 58, 10),
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(vertical: 12),
//                                         child: Column(
//                                           children: [
//                                             InkWell(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     displayMyWidget =!displayMyWidget  ;
//                                                     displayMyWidget2 = false ;
//                                                     displayMyWidget3 = false ;
//                                                   });
//                                                 },
//                                                 child: Icon(Icons.sunny, color: Colors.white,)),
//                                             SizedBox(height: 12,),
//                                             // Icon(Icons.ac_unit , color: Colors.white,),
//                                             InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _isTempMap == 'PR0' ;
//                                                   print('PR0');
//                                                   context.read<MapBloc>().add(GetTempAndPrepForMap("PR0"));
//                                                 });
//                                               },
//                                               child: Image.asset('images/rain.png' , width: 30 , height: 30,
//                                                 color:
//                                                 _isTempMap == 'prec' ? Colors.blue[600] : Colors.white,),
//                                             ),
//                                             SizedBox(height: 12,),
//                                             InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _isTempMap == 'wind' ;
//                                                   print('wind');
//                                                   context.read<MapBloc>().add(GetTempAndPrepForMap("wind_new"));
//                                                 });
//                                               },
//                                               child: Image.asset('images/reah.png' , width: 30 , height: 30,
//                                                 color: _isTempMap == 'wind' ? Colors.green : Colors.white,),
//                                             ),
//                                             SizedBox(height: 12,),
//                                             InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _isTempMap == 'temp' ;
//                                                   print('temp');
//                                                   context
//                                                       .read<MapBloc>()
//                                                       .add(GetTempAndPrepForMap("temp_new"));
//                                                 });
//                                               },
//                                               child: Image.asset('images/temper.png' , width: 30 , height: 30,
//                                                 color:
//                                                 _isTempMap == 'temp' ? Colors.red[900] : Colors.white,),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                     )
//                                  :   Container(width: 0,),

//                                 displayMyWidget == true ?
//                                 TranslationAnimatedWidget(
//                                   curve: Curves.fastEaseInToSlowEaseOut,
//                                     duration: Duration(seconds: 2),
//                                     enabled: this.displayMyWidget, //update this boolean to forward/reverse the animation
//                                     values: [
//                                       Offset(0, 30), // disabled value value
//                                       Offset(0, -10), //intermediate value
//                                     ],
//                                     child:  Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         width: 150,
//                                         decoration: BoxDecoration(
//                                           color: Color.fromRGBO(40, 43, 58, 10),
//                                           borderRadius: BorderRadius.circular(10),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 12),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           displayMyWidget =! displayMyWidget ;
//                                                           print('433');
//                                                         });
//                                                       },
//                                                       child: Icon(Icons.close , color: Colors.white,size: 20,)),

//                                                   Text('Weather Map' , style: TextStyle(color: Colors.white, fontSize: 13),),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 12,),
//                                               // Icon(Icons.ac_unit , color: Colors.white,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [

//                                                   Text('Map Satting' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                   SizedBox(width: 12,),
//                                                   InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         _isTempMap == 'prec' ;
//                                                         print('prec');
//                                                         context.read<MapBloc>().add(GetTempAndPrepForMap("precipitation_new"));
//                                                       });
//                                                     },
//                                                     child: Icon(Icons.settings)
//                                                     // child: Icon(Icons.setting) , width: 24 , height: 24,
//                                                     //   color:
//                                                     //   _isTempMap == 'prec' ? Colors.blue[600] : Colors.white,),
//                                                   ),

//                                                 ],
//                                               ),
//                                               Divider(color: Colors.white,thickness: 0.2,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [
//                                                   Text('Wind' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                   SizedBox(width: 12,),
//                                                   InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         _isTempMap == 'wind' ;
//                                                         print('wind');
//                                                         context.read<MapBloc>().add(GetTempAndPrepForMap("wind_new"));
//                                                       });
//                                                     },
//                                                     child: Image.asset('images/reah.png' , width: 24 , height: 24,
//                                                       color: _isTempMap == 'wind' ? Colors.green : Colors.white,),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Divider(color: Colors.white,thickness: 0.2,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [
//                                                   Text('Temp' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                   SizedBox(width: 12,),
//                                                   InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         _isTempMap == 'temp' ;
//                                                         print('temp');
//                                                         context
//                                                             .read<MapBloc>()
//                                                             .add(GetTempAndPrepForMap("temp_new"));
//                                                       });
//                                                     },
//                                                     child: Image.asset('images/temper.png' ,width: 24 , height: 24,
//                                                       color:
//                                                       _isTempMap == 'temp' ? Colors.red[900] : Colors.white,),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Divider(color: Colors.white,thickness: 0.2,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [
//                                                   Text('Humidity' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                   SizedBox(width: 12,),
//                                                   InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         _isTempMap == 'cloud' ;
//                                                         print('cloud');
//                                                         context
//                                                             .read<MapBloc>()
//                                                             .add(GetTempAndPrepForMap("humidity_new"));
//                                                       });
//                                                     },
//                                                     child: Image.asset('images/pressure.png' , width: 24 , height: 24,
//                                                       color:
//                                                       _isTempMap == 'cloud' ? Colors.red[900] : Colors.white,),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Divider(color: Colors.white,thickness: 0.2,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [
//                                                   Text('Pressure' , style: TextStyle(color: Colors.white, fontSize: 14),),
//                                                   SizedBox(width: 12,),
//                                                   InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         _isTempMap == 'press' ;
//                                                         print('press');
//                                                         context
//                                                             .read<MapBloc>()
//                                                             .add(GetTempAndPrepForMap("pressure_new"));
//                                                       });
//                                                     },
//                                                     child: Image.asset('images/humi.png' , width: 22 , height: 24,
//                                                       color:
//                                                       _isTempMap == 'press' ? Colors.red[900] : Colors.white,),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                 ) : Container(width: 0,) ,

//                               ],
//                             ),
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             width: 100,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(40, 43, 58, 1),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text('ICON' , style: TextStyle(
//                                       color: Colors.white , fontWeight: FontWeight.bold,
//                                       fontSize: 18
//                                   ),) ,
//                                   Text('GFS' , style: TextStyle(
//                                       color: Colors.white54 , fontWeight: FontWeight.bold,
//                                       fontSize: 18
//                                   ),) ,
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: InkWell(
//                             onTap: () {
//                               _getCurrentPosition();
//                             },
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: Color.fromRGBO(40, 43, 58, 10),
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               child: Icon(Icons.my_location_outlined , color: Colors.white,),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: 8,),



//                   ],
//                 ),
// //===============================================
//                 Positioned(
//       left: 0,
//       right: 0,
//       bottom: 10,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         child: Directionality(
//           textDirection: TextDirection.ltr,
//           child: Container(
//             height: 60,
//             decoration: BoxDecoration(
//               color: const Color.fromRGBO(40, 43, 58, 1),
//               borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           const SizedBox(width: 6),
//           const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40),

//           // السهم لليسار
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _forecastDate =
//                     _forecastDate.subtract(const Duration(hours: 1));
//               });
//             },
//             child: const Icon(Icons.arrow_left, color: Colors.white),
//           ),

//           // التاريخ (اليوم + الشهر + يوم)
//           Text(
//             intl.DateFormat('EEE dd').format(_forecastDate),
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
//           ),

//           // السهم لليمين
//           InkWell(
//             onTap: _forecastDate.difference(DateTime.now()).inDays >= 10
//                 ? null
//                 : () {
//                     setState(() {
//                       _forecastDate =
//                           _forecastDate.add(const Duration(hours: 1));
//                     });
//                   },
//             child: const Icon(Icons.arrow_right, color: Colors.white),
//           ),

//           // الوقت الحالي
//           Text(
//             intl.DateFormat('ha').format(_forecastDate),
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 13,
//                 fontWeight: FontWeight.normal),
//           ),

//           // السلايدر (Gradient bar)
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Container(
//                 height: 14,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xff0000ff), // أزرق (0°)
//                       Color(0xff00ffff), // سماوي (10°)
//                       Color(0xff00ff00), // أخضر (20°)
//                       Color(0xffffff00), // أصفر (30°)
//                       Color(0xffff0000), // أحمر (40°)
//                     ],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           Row(
//             children: [
//               _buildDayBox("Sat", 19),
//               _buildDayBox("Sun", 20),
//               _buildDayBox("Mon", 21),
//             ],
//           ),
//           const SizedBox(width: 6),
//         ],
//       ),
//     ),
//   ),
// ),
//                 ),

//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   TileProvider tileProvider(String mapType) {
//     return GetMap(
//       mapType: mapType,
//       mapRemoteDataSource: MapRemoteDataSourceImpl(),
//     );
//   }

//   void setControler(GoogleMapController controller) {
//     mapController = controller;
//     // mapController.setMapStyle('''
//     // $stops
//     // ''');
//   }

// Widget _buildDayBox(String day, int date) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 4),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(day,
//             style: const TextStyle(color: Colors.white, fontSize: 11)),
//         Text(
//           "$date",
//           style: const TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
//         ),
//       ],
//     ),
//   );
// }
// }

// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:rased/AboutUsPage.dart';
// // import 'package:rased/SettingPage.dart';
// // import 'package:rased/SearchLocation/location_search_screen.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:animated_widgets/animated_widgets.dart';
// // import 'package:rased/features/map/presentation/bloc/map_bloc.dart';

// // class MapPage extends StatefulWidget {
// //   const MapPage({Key? key}) : super(key: key);

// //   @override
// //   State<MapPage> createState() => _MapPageState();
// // }

// // // ---------- AnimatedIconButton Widget ----------
// // class AnimatedIconButton extends StatefulWidget {
// //   final Widget icon;
// //   final VoidCallback onTap;
// //   const AnimatedIconButton({required this.icon, required this.onTap, super.key});

// //   @override
// //   State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
// // }

// // class _AnimatedIconButtonState extends State<AnimatedIconButton> {
// //   double _scale = 1.0;

// //   void _onTap() async {
// //     setState(() => _scale = 0.8);
// //     await Future.delayed(const Duration(milliseconds: 100));
// //     setState(() => _scale = 1.0);
// //     await Future.delayed(const Duration(milliseconds: 100));
// //     widget.onTap();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: _onTap,
// //       child: AnimatedScale(
// //         scale: _scale,
// //         duration: const Duration(milliseconds: 100),
// //         curve: Curves.easeOut,
// //         child: widget.icon,
// //       ),
// //     );
// //   }
// // }

// // // ---------- MapPage State ----------
// // class _MapPageState extends State<MapPage> {
// //   late GoogleMapController mapController;
// //   Set<Marker> _markers = Set<Marker>();
// //   Position? _currentPosition;

// //   bool displayMyWidget = false;
// //   bool displayMyWidget2 = false;
// //   bool displayMyWidget3 = false;

// //   Future<bool> _handleLocationPermission() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;
// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Location services are disabled. Please enable the services'))
// //       );
// //       return false;
// //     }
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Location permissions are denied'))
// //         );
// //         return false;
// //       }
// //     }
// //     if (permission == LocationPermission.deniedForever) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Location permissions are permanently denied.'))
// //       );
// //       return false;
// //     }
// //     return true;
// //   }

// //   Future<void> _getCurrentPosition() async {
// //     final hasPermission = await _handleLocationPermission();
// //     if (!hasPermission) return;
// //     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
// //         .then((Position position) {
// //       setState(() => _currentPosition = position);
// //       mapController.moveCamera(CameraUpdate.newLatLng(
// //           LatLng(position.latitude, position.longitude)));
// //       _markers.add(
// //         Marker(
// //           markerId: const MarkerId('marker'),
// //           position: LatLng(position.latitude, position.longitude),
// //           icon: BitmapDescriptor.defaultMarker,
// //         ),
// //       );
// //     }).catchError((e) => debugPrint(e.toString()));
// //   }

// //   void setController(GoogleMapController controller) {
// //     mapController = controller;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider<MapBloc>(
// //       create: (context) => MapBloc(),
// //       child: BlocBuilder<MapBloc, MapState>(
// //         builder: (context, state) {
// //           return Scaffold(
// //             body: Stack(
// //               children: [
// //                 // --- Google Map (يمكن تفعيلها لاحقاً) ---
// //                 // GoogleMap(...),

// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(vertical: 33, horizontal: 14),
// //                       child: Container(
// //                         width: MediaQuery.of(context).size.width / 3.1,
// //                         child: Column(
// //                           children: [
// //                             // Header
// //                             Container(
// //                               width: MediaQuery.of(context).size.width / 3.1,
// //                               decoration: BoxDecoration(
// //                                 color: const Color.fromRGBO(40, 43, 58, 1),
// //                                 borderRadius: displayMyWidget3
// //                                     ? const BorderRadius.only(
// //                                         topRight: Radius.circular(20),
// //                                         topLeft: Radius.circular(20))
// //                                     : BorderRadius.circular(50),
// //                               ),
// //                               child: Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: Row(
// //                                   children: [
// //                                     Image.asset(
// //                                       'images/rased.png',
// //                                       width: MediaQuery.of(context).size.width / 3.1 / 1.5,
// //                                     ),
// //                                     AnimatedIconButton(
// //                                       icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
// //                                       onTap: () {
// //                                         setState(() {
// //                                           displayMyWidget3 = !displayMyWidget3;
// //                                           displayMyWidget = false;
// //                                           displayMyWidget2 = false;
// //                                         });
// //                                       },
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),

// //                             // Dropdown Menu
// //                             if (displayMyWidget3)
// //                               TranslationAnimatedWidget(
// //                                 curve: Curves.easeIn,
// //                                 duration: const Duration(seconds: 1),
// //                                 enabled: displayMyWidget3,
// //                                 values: const [Offset(0, -20), Offset(0, 0)],
// //                                 child: Container(
// //                                   decoration: const BoxDecoration(
// //                                     color: Color.fromRGBO(40, 43, 58, 1),
// //                                     borderRadius: BorderRadius.only(
// //                                       bottomRight: Radius.circular(20),
// //                                       bottomLeft: Radius.circular(20),
// //                                     ),
// //                                   ),
// //                                   child: Padding(
// //                                     padding: const EdgeInsets.all(5.0),
// //                                     child: Column(
// //                                       crossAxisAlignment: CrossAxisAlignment.end,
// //                                       children: [
// //                                         AnimatedIconButton(
// //                                           icon: const Text('Settings',
// //                                               style: TextStyle(color: Colors.white, fontSize: 13)),
// //                                           onTap: () {
// //                                             Navigator.push(
// //                                               context,
// //                                               MaterialPageRoute(builder: (context) => SettingPage()),
// //                                             );
// //                                           },
// //                                         ),
// //                                         const Divider(color: Colors.white, thickness: 0.4),
// //                                         AnimatedIconButton(
// //                                           icon: const Text('About Us',
// //                                               style: TextStyle(color: Colors.white, fontSize: 13)),
// //                                           onTap: () {
// //                                             Navigator.push(
// //                                               context,
// //                                               MaterialPageRoute(builder: (context) => AboutUsPage()),
// //                                             );
// //                                           },
// //                                         ),
// //                                         const Divider(color: Colors.white, thickness: 0.4),
// //                                         const Text('Share', style: TextStyle(color: Colors.white, fontSize: 13)),
// //                                         const Divider(color: Colors.white, thickness: 0.4),
// //                                         const Text('News', style: TextStyle(color: Colors.white, fontSize: 13)),
// //                                         const SizedBox(height: 8),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),

// //                     const Spacer(),

// //                     // --- Bottom Row Icons ---
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           AnimatedIconButton(
// //                             icon: Container(
// //                               width: 50,
// //                               height: 50,
// //                               decoration: BoxDecoration(
// //                                 color: const Color.fromRGBO(40, 43, 58, 1),
// //                                 borderRadius: BorderRadius.circular(50),
// //                               ),
// //                               child: const Icon(Icons.search, color: Colors.white),
// //                             ),
// //                             onTap: () async {
// //                               final result = await Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(builder: (context) => const SearchLocationScreen()),
// //                               );
// //                               if (result == 'currentlocation') {
// //                                 _getCurrentPosition();
// //                               }
// //                             },
// //                           ),

// //                           AnimatedIconButton(
// //                             icon: Container(
// //                               width: 50,
// //                               height: 50,
// //                               decoration: BoxDecoration(
// //                                 color: const Color.fromRGBO(40, 43, 58, 1),
// //                                 borderRadius: BorderRadius.circular(50),
// //                               ),
// //                               child: Icon(
// //                                 displayMyWidget2 ? Icons.close : Icons.layers,
// //                                 color: Colors.white,
// //                               ),
// //                             ),
// //                             onTap: () {
// //                               setState(() {
// //                                 displayMyWidget2 = !displayMyWidget2;
// //                                 displayMyWidget = false;
// //                                 displayMyWidget3 = false;
// //                               });
// //                             },
// //                           ),

// //                           AnimatedIconButton(
// //                             icon: Container(
// //                               width: 50,
// //                               height: 50,
// //                               decoration: BoxDecoration(
// //                                 color: const Color.fromRGBO(40, 43, 58, 1),
// //                                 borderRadius: BorderRadius.circular(50),
// //                               ),
// //                               child: const Icon(Icons.my_location_outlined, color: Colors.white),
// //                             ),
// //                             onTap: _getCurrentPosition,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
