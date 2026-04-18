import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 43, 58, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 43, 58, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Search Bar
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(21, 23, 31, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 20),
                      Text(
                        'Find a place, storm, fire...',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Location Button
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(53, 85, 208, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_location,
                          color: Colors.white, size: 17),
                      SizedBox(width: 10),
                      Text(
                        'Show Your Location',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Active tropical system
              const Text(
                'Active tropical system',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              const SizedBox(height: 12),

              buildTropicalItem(
                  Colors.deepPurple, 'Invest 99S, South Indian Ocean'),

              const SizedBox(height: 30),

              // Recent tropical system
              const Text(
                'Recent tropical system',
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

              // Active fires
              const Text(
                'Active fires',
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
          ),
        ),
      ),
    );
  }

  // Widget for tropical systems
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

  // Widget for active fires
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
