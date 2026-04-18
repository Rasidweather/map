import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: InkWell(
         onTap: press,
         child: Container(
           width: MediaQuery.of(context).size.width,
           height: 45,
           decoration: BoxDecoration(
               color: Color.fromRGBO(21, 23, 31, 10),
               borderRadius: BorderRadius.circular(10)
           ),
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Row(
               children: [
                 Container(
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(30)
                     ),
                     child: Icon(Icons.circle , color: Colors.deepPurple, size: 15,)),
                 SizedBox(width: 10,) ,
                 Expanded(
                   child: Text(location ,
                     maxLines: 2 ,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                       color: Colors.white , fontSize: 12
                   ),),
                 ),


               ],
             ),
           ),
         ),
       ),
     );
    // return Column(
    //   children: [
    //     ListTile(
    //       onTap: press,
    //       horizontalTitleGap: 0,
    //       title: Text(
    //         location,
    //         style: TextStyle(color: Colors.black),
    //         maxLines: 2,
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //     ),
    //     const Divider(
    //       height: 2,
    //       thickness: 2,
    //       color: secondaryColor5LightTheme,
    //     ),
    //   ],
    // );
  }
}
