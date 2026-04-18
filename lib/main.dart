import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rased/HomePage.dart';
import 'package:rased/WelcomePage.dart';

import 'HomePage2.dart';
import 'features/weather/presentation/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto'
      ),
      home:  WelcomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
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
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12 ,horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Spacer(),
                Text('Welcome' , style: TextStyle(color: Colors.white
                    ,fontWeight: FontWeight.bold, fontSize: 25),),
                Text('To Fire Frame Weather & Rain Radar' ,
                  style: TextStyle(color: Colors.white , fontSize: 16,fontWeight: FontWeight.w600,),),
                Spacer(),
                Text('This app doesn’t require creating an account, just choose to show your location or free.' ,
                  style: TextStyle(color: Colors.white , fontSize: 16,),textAlign: TextAlign.center,),

                SizedBox(height: 16,),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context)=>HomePage()),
                            (route) => false);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(82, 183, 136, 10),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('start now' , style: TextStyle(color: Colors.white , fontSize: 15),),
                        SizedBox(width: 25,),
                        Icon(Icons.arrow_forward , size: 22,color: Colors.white,),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(53, 85, 208, 10),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_location_rounded , size: 22,color: Colors.white,),
                      SizedBox(width: 22,),
                      Text('show your location' , style: TextStyle(color: Colors.white , fontSize: 15),),

                    ],
                  ),
                ),




              ],
            ),
          ),
          
        ),
      ),
    );
  }
}


