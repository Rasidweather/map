// import 'package:flutter/material.dart';
// import 'package:rased/HomePage.dart';

// class WeatherNews extends StatelessWidget {
//   const WeatherNews({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const WeatherNewsScreen(),
//     );
//   }
// }

// class WeatherNewsScreen extends StatelessWidget {
//   const WeatherNewsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1C1E2A), // خلفية داكنة
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1C1E2A),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => HomePage()));
//           },
//         ),
//         title: const Text(
//           "Weather News",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ListView(
//           children: [
//             // Daily News
//             const Text(
//               "Daily News",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),

//             // Big Card
//             Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFF2A2C3D),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0), // تباعد خارجي عن الكارد
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12), // حواف دائرية
//                       child: Image.asset(
//                         "images/png1.jpg",
//                         height: 180,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   "Saudi Arabia | Areas covered by rain forecast",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold)),
//                               SizedBox(height: 5),
//                               Text("Fri, 1 Feb 2024",
//                                   style: TextStyle(
//                                       color: Colors.grey, fontSize: 12)),
//                             ],
//                           ),
//                         ),
//                         const Icon(Icons.favorite_border, color: Colors.white),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Small Cards
//             buildNewsItem(
//               image:
//                   "images/png2.jpg",
//               title: "Saudi Arabia | A cold wave affects most regions...",
//               date: "Tue, 27 Feb 2024",
//             ),
//             const SizedBox(height: 30),

//             // Latest News
//             const Text(
//               "Latest News",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),

//             buildNewsItem(
//               image:
//                   "images/png3.jpg",
//               title: "Saudi Arabia | A cold wave affects most regions...",
//               date: "Tue, 27 Feb 2024",
//             ),
//             buildNewsItem(
//               image:
//                   "images/png4.jpg",
//               title: "Saudi Arabia | The Siberian high air pressure...",
//               date: "Tue, 27 Feb 2024",
//             ),
//             buildNewsItem(
//               image:
//                   "images/png5.jpg",
//               title: "Algeria | Heavy rain and snow over the mountains...",
//               date: "Tue, 27 Feb 2024",
//             ),
//             buildNewsItem(
//               image:
//                   "images/png6.jpg",
//               title: "Riyadh | The first sand wave of the year may...",
//               date: "Tue, 27 Feb 2024",
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildNewsItem(
//       {required String image, required String title, required String date}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2A2C3D),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(6.0), // تباعد خارجي عن الكارد
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12), // حواف دائرية
//               child: Image.network(image, height: 80, width: 80, fit: BoxFit.cover),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 5),
//                   Text(date,
//                       style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                 ],
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.favorite_border, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:rased/HomePage.dart';
import 'package:rased/Weather_Tracker.dart';
import 'package:rased/features/weather/presentation/pages/weather_page.dart';

class WeatherNews extends StatelessWidget {
  const WeatherNews({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherNewsScreen(),
    );
  }
}

class WeatherNewsScreen extends StatelessWidget {
  const WeatherNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1E2A),
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
          "Weather News",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const Text(
              "Daily News",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            buildBigNewsCard(
              context: context,
              image: "images/png1.jpg",
              title: "Saudi Arabia | Areas covered by rain forecast",
              date: "Fri, 1 Feb 2024",
              description:
                  "",
            ),
            const SizedBox(height: 10),
  buildNewsItem(
              context: context,
              image: "images/png2.jpg",
              title: "Saudi Arabia | A cold wave affects most regions...",
              date: "Tue, 27 Feb 2024",
              description:
                  "A cold wave is sweeping across most regions, leading to a noticeable drop in temperatures.",
            ),
             const SizedBox(height: 30),
            const Text(
              "Latest News",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

          
            buildNewsItem(
              context: context,
              image: "images/png3.jpg",
              title: "Saudi Arabia | The Siberian high air pressure...",
              date: "Tue, 27 Feb 2024",
              description:
                  """The results of computer simulations of the movement of air masses indicate expectations that the Kingdom of Saudi Arabia will be affected in the coming days by a cold wave that will cause a significant drop in temperatures in most regions except the western region, as a result of a cold upper trough approaching the region, which will lead to an extension of the influence of the high air pressure. Siberian over the kingdom.

In conjunction with the Old Day: a significant drop in temperature levels below their average in the coming days

It is expected, God willing, that the Kingdom will be increasingly affarted on Warinaerday hu the cold air mace on that",
            """),
            buildNewsItem(
              context: context,
              image: "images/png4.jpg",
              title: "Algeria | Heavy rain and snow over the mountains...",
              date: "Tue, 27 Feb 2024",
              description:
                  "Heavy rainfall and snowfall are expected in Algeria, especially over mountainous areas.",
            ),
            buildNewsItem(
              context: context,
              image: "images/png5.jpg",
              title: "Riyadh | The first sand wave of the year may...",
              date: "Tue, 27 Feb 2024",
              description:
                  "The first sandstorm of the year may affect Riyadh and nearby areas, reducing visibility.",
            ),
            buildNewsItem(
              context: context,
              image: "images/png6.jpg",
              title: "Jordan | Rising chances of heavy thunderstorms...",
              date: "Tue, 27 Feb 2024",
              description:
                  "Thunderstorms are expected across many regions in Jordan with heavy rain.",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBigNewsCard({
    required BuildContext context,
    required String image,
    required String title,
    required String date,
    required String description,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherTracker(
              title: title,
              date: date,
              image: image,
              description: description,
            ),
          ),
        );
      },
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2C3D),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
             Padding(
  padding: const EdgeInsets.all(12.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        date,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      const SizedBox(height: 10),

      // SizedBox(
      //   child: SingleChildScrollView(
      //     child: Text(
      //       description,
      //       style: const TextStyle(color: Colors.white70, fontSize: 14),
      //     ),
      //   ),
      // ),
    ],
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  // 🔹 الكارد الصغيرة (Latest News)
  Widget buildNewsItem({
    required BuildContext context,
    required String image,
    required String title,
    required String date,
    required String description,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherTracker(
              title: title,
              date: date,
              image: image,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2C3D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(image,
                    height: 80, width: 80, fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(date,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const   Padding(
      padding:  EdgeInsets.only(right: 6.0), 
      child:  Icon(Icons.favorite_border, color: Colors.white),
    ),
          ],
        ),
      ),
    );
  }
}
