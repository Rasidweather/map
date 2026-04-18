// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:rased/SearchLocation/components/NetworkUtiliti.dart';
// import 'package:rased/SearchLocation/models/autocomplate_prediction.dart';
// import 'package:rased/SearchLocation/models/place_auto_complate_response.dart';
// import 'components/location_list_tile.dart';
// import 'constants.dart';

// class SearchLocationScreen extends StatefulWidget {
//   const SearchLocationScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchLocationScreen> createState() => _SearchLocationScreenState();
// }

// class _SearchLocationScreenState extends State<SearchLocationScreen> {

//   List<AutocompletePrediction> placePredictions = [];
//   void placeAutocomplete(String query) async{
//     Uri uri = Uri.https("maps.googleapis.com",
//                         "maps/api/place/autocomplete/json",
//       {
//         "input" :query,
//         "key" : apiKey,
//       });
//     String ? response = await NetworkUtiliti.fetchUrl(uri);
//     if(response != null){
//       print(response);
//       PlaceAutocompleteResponse result =
//       PlaceAutocompleteResponse.parseAutocompleteResult(response);
//       if(result.predictions != null){
//           setState(() {
//             placePredictions = result.predictions! ;
//             print(result.predictions);
//           });
//       }
//     }
//   }

//   String? _currentAddress;
//   Position? _currentPosition;

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

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       Navigator.pop(context ,'currentlocation');
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(40, 43, 58, 10),
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(40, 43, 58, 10),
//         elevation: 0,
//         iconTheme: IconThemeData(
//           color: Colors.white
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Form(
//             child: Padding(
//               padding: const EdgeInsets.all(defaultPadding),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Color.fromRGBO(21, 23, 31, 10),
//                     borderRadius: BorderRadius.circular(30)
//                 ),
//                 child: TextFormField(
//                   style: TextStyle(color: Colors.white),
//                   onChanged: (value) {
//                     setState(() {
//                       placeAutocomplete(value);
//                     });
//                   },
//                   textInputAction: TextInputAction.search,
//                   decoration: InputDecoration(
//                     hintText: "Find a place, storm, fire...",
//                     hintStyle: TextStyle(color: Colors.white),
//                     enabledBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       child: SvgPicture.asset(
//                         "assets/icons/location_pin.svg",
//                         color: secondaryColor40LightTheme,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // const Divider(
//           //   height: 4,
//           //   thickness: 4,
//           //   color: secondaryColor5LightTheme,
//           // ),
//           Padding(
//             padding: const EdgeInsets.all(defaultPadding),
//             child: Center(
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   // placeAutocomplete("Dubai");
//                   _getCurrentPosition();
//                 },
//                 icon: SvgPicture.asset(
//                   "assets/icons/location.svg",
//                   height: 16,color: Colors.white,
//                 ),
//                 label: const Text("show your location" , style: TextStyle(color: Colors.white),),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromRGBO(53, 85, 208, 10),
//                   foregroundColor: textColorLightTheme,
//                   elevation: 0,
//                   fixedSize: const Size(double.infinity, 40),
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // const Divider(
//           //   height: 4,
//           //   thickness: 4,
//           //   color: secondaryColor5LightTheme,
//           // ),

//           SizedBox(height: 0,),

//           Padding(
//             padding: const EdgeInsets.all(defaultPadding),
//             child: Text('Active tropical system' , style: TextStyle(
//                 color: Colors.white , fontSize: 13
//             ),),
//           ),


//           Expanded(
//             child: ListView.builder(
//               itemCount: placePredictions.length,
//               itemBuilder: (context, index) => LocationListTile(
//               press: () async {
//                 FocusScope.of(context).unfocus();
//                 print(placePredictions[index].description!);
//                 Navigator.pop(context, placePredictions[index].description!);
//               },
//               location: placePredictions[index].description!,
//             ),),
//           ),

//         ],
//       ),
//     );
//   }

// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rased/SearchLocation/components/NetworkUtiliti.dart';
import 'package:rased/SearchLocation/models/autocomplate_prediction.dart';
import 'package:rased/SearchLocation/models/place_auto_complate_response.dart';
import 'components/location_list_tile.dart';
import 'constants.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  // ⬇️ متغيّرات البحث
  List<AutocompletePrediction> placePredictions = [];

  void placeAutocomplete(String query) async {
    if (query.isEmpty) {
      setState(() {
        placePredictions.clear();
      });
      return;
    }

    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": query,
        "key": apiKey, // تأكد من وضع مفتاح Google Maps API الصحيح
      },
    );

    String? response = await NetworkUtiliti.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);

      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  // ⬇️ متغيّرات الموقع
  Position? _currentPosition;

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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Location permissions are denied')));
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

    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "تم تحديد موقعك: ${position.latitude}, ${position.longitude}"),
        ),
      );
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // -------------- واجهة المستخدم --------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 43, 58, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 43, 58, 1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 شريط البحث
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(21, 23, 31, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  onChanged: (value) {
                    placeAutocomplete(value);
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: "Find a place, storm, fire...",
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 13),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SvgPicture.asset(
                        "assets/icons/location_pin.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
               Row(
  children: [
    // زر Show Your Location
    Expanded(
      flex: 4,
      child: SizedBox(
        height: 45,
        child: ElevatedButton.icon(
          onPressed: _getCurrentPosition,
          icon: const Icon(Icons.my_location, color: Colors.white, size: 17),
          label: const Text(
            "Show Your Location",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(53, 85, 208, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
        ),
      ),
    ),

    const SizedBox(width: 10), // مسافة بين الزرين

    // زر X لإغلاق أو مسح الموقع
    SizedBox(
      height: 45,
      width: 45,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _currentPosition = null;
            placePredictions.clear();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(53, 85, 208, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: const Icon(Icons.close, color: Colors.white, size: 20),
      ),
    ),
  ],
),
              // SizedBox(
              //   width: double.infinity,
              //   height: 45,
              //   child: ElevatedButton.icon(
              //     onPressed: _getCurrentPosition,
              //     icon: const Icon(Icons.my_location,
              //         color: Colors.white, size: 17),
              //     label: const Text(
              //       "Show Your Location",
              //       style: TextStyle(color: Colors.white, fontSize: 14),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color.fromRGBO(53, 85, 208, 1),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //       elevation: 0,
              //     ),
              //   ),
              // ),

              const SizedBox(height: 30),

              // 🔽 نتائج البحث
              if (placePredictions.isNotEmpty)
                Column(
                  children: List.generate(
                    placePredictions.length,
                    (index) => LocationListTile(
                      press: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(
                            context, placePredictions[index].description!);
                      },
                      location: placePredictions[index].description!,
                    ),
                  ),
                )
              else ...[
                // 🌀 Active tropical system
                const Text(
                  "Active tropical system",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(height: 12),

                buildTropicalItem(
                    Colors.deepPurple, 'Invest 99S, South Indian Ocean'),

                const SizedBox(height: 30),

                // 🌀 Recent tropical systems
                const Text(
                  "Recent tropical system",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(height: 12),

                buildTropicalItem(
                    Colors.deepPurple, 'Invest 98R, Near Vanuatu, South Pacific Ocean'),
                const SizedBox(height: 12),

                buildTropicalItem(
                    Colors.green, 'Tropical Cyclone Lincoln, Near Port Hedland, Australia'),
                const SizedBox(height: 12),

                buildTropicalItem(
                    Colors.yellow, 'Tropical Storm Eleanor, Near Mauritius, South Indian Ocean'),
                const SizedBox(height: 12),

                buildTropicalItem(
                    Colors.red, 'Tropical Cyclone Djongou, South Indian Ocean'),
                const SizedBox(height: 12),

                buildTropicalItem(
                    Colors.green, 'Tropical Cyclone 19F, South Pacific Ocean'),

                const SizedBox(height: 30),

                // 🔥 Active fires
                const Text(
                  "Active fires",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(height: 12),

                buildFireItem(
                  'Smokehouse Creek Fire,\nHutchinson Country, Texas, United States',
                  '40,000 ac',
                ),
                const SizedBox(height: 12),

                buildFireItem(
                  'Grap Vine Creek Fire,\nTexas, United States',
                  '30,000 ac',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // 🌀 عنصر الأنظمة الاستوائية
  Widget buildTropicalItem(Color color, String title) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(21, 23, 31, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(Icons.circle, color: color, size: 15),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 عنصر الحرائق
  Widget buildFireItem(String title, String size) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(21, 23, 31, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Icon(Icons.local_fire_department,
                color: Colors.red, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              size,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

