import 'package:flutter/material.dart';
import 'package:rased/HomePage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool val = true ;
  Color kSecondaryColor = Colors.blueGrey ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 43, 58, 1),
         appBar: AppBar(
        backgroundColor: const Color(0xFF1C1E2A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Settings' , style: TextStyle(
                    color: Colors.white , fontSize: 24 , fontWeight: FontWeight.bold
                ),),

                SizedBox(height: 16,),
                Text('GENERAL' , style: TextStyle(
                    color: Colors.white , fontSize: 12 , fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 12,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: 0.5
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('show temp degree' , style: TextStyle(
                              color: Colors.white , fontSize: 12 ,
                              fontWeight: FontWeight.bold
                            ),),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  val = !val;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 33,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white ,width: 0.5
                                    ),
                                    color: Color.fromRGBO(40, 43, 58, 1),),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            // color: val
                                            //     ? Colors.white
                                            //     : kSecondaryColor
                                              ),
                                        child: Center(
                                            child: Text(
                                              'ON',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: val
                                                      ? Colors.white
                                                      : Color.fromRGBO(40, 43, 58, 1)),
                                            )),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            // color: val
                                            //     ? Color.fromRGBO(40, 43, 58, 10)
                                            //     : Colors.white
                                        ),
                                        child: Center(
                                            child: Text(
                                              'OFF',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: val
                                                      ? Color.fromRGBO(40, 43, 58, 1)
                                                      : Colors.white),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),




                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Notifications' , style: TextStyle(
                                color: Colors.white , fontSize: 12 ,
                                fontWeight: FontWeight.bold
                            ),),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  val = !val;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white ,width: 0.5
                                  ),
                                  color: Color.fromRGBO(40, 43, 58, 1),),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          color: val
                                              ? Colors.white
                                              : Colors.transparent
                                        ),
                                        child: Center(
                                            child: Text(
                                              'ON',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: val
                                                      ? Colors.black
                                                      : Color.fromRGBO(40, 43, 58, 1)),
                                            )),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          color: val
                                              ? Colors.transparent
                                              : Colors.white
                                        ),
                                        child: Center(
                                            child: Text(
                                              'OFF',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: val
                                                      ? Color.fromRGBO(40, 43, 58, 1)
                                                      : Colors.black),
                                            )),
                                      ),
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
                ) ,


                SizedBox(height: 16,),
                Text('TIME' , style: TextStyle(
                    color: Colors.white , fontSize: 12 , fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 12,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.white,
                          width: 0.5
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.language , size: 15 , color: Colors.white,),
                                SizedBox(width: 8,),
                                Text('Time Zone' , style: TextStyle(
                                    color: Colors.white , fontSize: 12 ,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  val = !val;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white ,width: 0.5
                                  ),
                                  color: Color.fromRGBO(40, 43, 58, 1),),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /2.2,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            color: val
                                                ? Colors.white
                                                : Colors.transparent
                                          ),
                                          child: Center(
                                              child: Text(
                                                'Local',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.black
                                                        : Colors.white),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /2.2,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            color: val
                                                ? Color.fromRGBO(40, 43, 58, 1)
                                                : Colors.white
                                          ),
                                          child: Center(
                                              child: Text(
                                                'UTC',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.white
                                                        : Colors.black),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.timelapse_outlined , size: 15 , color: Colors.white,),
                                SizedBox(width: 8,),
                                Text('Clock format' , style: TextStyle(
                                    color: Colors.white , fontSize: 12 ,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  val = !val;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white ,width: 0.5
                                  ),
                                  color: Color.fromRGBO(40, 43, 58, 1),),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /2.2,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Colors.white
                                                  : Colors.transparent
                                          ),
                                          child: Center(
                                              child: Text(
                                                '12 hours',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.black
                                                        : Colors.white),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /2.2,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Color.fromRGBO(40, 43, 58, 1)
                                                  : Colors.white
                                          ),
                                          child: Center(
                                              child: Text(
                                                '24 hours',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.white
                                                        : Colors.black),
                                              )),
                                        ),
                                      ),
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
                ) ,


                SizedBox(height: 16,),
                Text('Animation' , style: TextStyle(
                    color: Colors.white , fontSize: 12 , fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 12,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.white,
                          width: 0.5
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.speed_outlined , size: 15 , color: Colors.white,),
                                SizedBox(width: 8,),
                                Text('Animation speed' , style: TextStyle(
                                    color: Colors.white , fontSize: 12 ,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  val = !val;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white ,width: 0.5
                                  ),
                                  color: Color.fromRGBO(40, 43, 58, 1),),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Colors.white
                                                  : Colors.transparent
                                          ),
                                          child: Center(
                                              child: Text(
                                                'slow',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.black
                                                        : Colors.white),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Color.fromRGBO(40, 43, 58, 1)
                                                  : Colors.white
                                          ),
                                          child: Center(
                                              child: Text(
                                                'medium',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.white
                                                        : Colors.black),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Color.fromRGBO(40, 43, 58, 1)
                                                  : Colors.white
                                          ),
                                          child: Center(
                                              child: Text(
                                                'fast',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.white
                                                        : Colors.black),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.satellite_alt_outlined , size: 15 , color: Colors.white,),
                                SizedBox(width: 8,),
                                Text('satellite animation during' , style: TextStyle(
                                    color: Colors.white , fontSize: 12 ,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  val = !val;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white ,width: 0.5
                                  ),
                                  color: Color.fromRGBO(40, 43, 58, 1),),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Colors.white
                                                  : Colors.transparent
                                          ),
                                          child: Center(
                                              child: Text(
                                                '3 hours',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.black
                                                        : Colors.white),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Color.fromRGBO(40, 43, 58, 1)
                                                  : Colors.white
                                          ),
                                          child: Center(
                                              child: Text(
                                                '6 hours',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.white
                                                        : Colors.black),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Color.fromRGBO(40, 43, 58, 1)
                                                  : Colors.white
                                          ),
                                          child: Center(
                                              child: Text(
                                                '12 hours',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.white
                                                        : Colors.black),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Color.fromRGBO(40, 43, 58, 1)
                                                  : Colors.white
                                          ),
                                          child: Center(
                                              child: Text(
                                                '24 hours',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.white
                                                        : Colors.black),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.speed_outlined , size: 15 , color: Colors.white,),
                                SizedBox(width: 8,),
                                Text('satellite animation style' , style: TextStyle(
                                    color: Colors.white , fontSize: 12 ,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  val = !val;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white ,width: 0.5
                                  ),
                                  color: Color.fromRGBO(40, 43, 58, 1),),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Colors.white
                                                  : Colors.transparent
                                          ),
                                          child: Center(
                                              child: Text(
                                                'fast',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.black
                                                        : Colors.white),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width /3,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: val
                                                  ? Color.fromRGBO(40, 43, 58, 1)
                                                  : Colors.white
                                          ),
                                          child: Center(
                                              child: Text(
                                                'smooth',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: val
                                                        ? Colors.white
                                                        : Colors.black),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16,),
                            Text('fast style plays animations immediately. smooth style preloads imagery for a better appearance.' , style: TextStyle(
                                color: Colors.white , fontSize: 12 , fontWeight: FontWeight.w400
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ) ,






              ],
            ),
          ),
        ),

      ),
    );
  }
}
