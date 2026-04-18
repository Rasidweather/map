// import 'package:flutter/material.dart';

// class WelcomePage extends StatelessWidget {
//   const WelcomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("images/bg_welcome.jpg"), 
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Container(
//           color: Colors.black.withOpacity(0.4), // طبقة شفافة فوق الخلفية
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [

//                 const Spacer(),

//                 // Logo Text
//                 const Text(
//                   "Logo\nHere",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Welcome Text
//                 const Text(
//                   "welcome",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // Subtitle
//                 const Text(
//                   "To Fire Frame Weather & Rain Radar",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),

//                 const Spacer(),

//                 // Description
//                 const Text(
//                   "This app doesn’t require creating an account, "
//                   "just choose to show your location or free.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 12,
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // Start Now button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // انتقل للشاشة التالية
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: const Text(
//                       "Start Now",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 // Show Your Location button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // فعل الموقع هنا
//                     },
//                     icon: const Icon(Icons.my_location,
//                         color: Colors.white, size: 20),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromRGBO(53, 85, 208, 1),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     label: const Text(
//                       "Show Your Location",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const Spacer(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:rased/HomePage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg_welcome.jpg"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Text(
                  "Logo\nHere",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "To Fire Frame Weather & Rain Radar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const Spacer(),
                const Text(
                  "This app doesn’t require creating an account, "
                  "just choose to show your location or free.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Start Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // زر Show Your Location
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // فعل الموقع هنا
                    },
                    icon: const Icon(Icons.my_location,
                        color: Colors.white, size: 20),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(53, 85, 208, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    label: const Text(
                      "Show Your Location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
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

