import 'package:flutter/material.dart';
import 'package:rased/HomePage.dart';


class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          "About Us",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('About Us' , style: TextStyle(
                   color: Colors.white , fontSize: 24 , fontWeight: FontWeight.bold
               ),),
               
               SizedBox(height: 12,),
               Text('Office ipsum you must be muted. View options closer when model price streamline scraps jumping productize. Cc pants hours hill opportunity im whistles. Job bed post know im not by closest based player-coach. Regroup pee working investigation skulls relaxation organic identify hit.',
               style: TextStyle(color: Colors.white , fontSize: 13),),


               SizedBox(height: 12,),
               Text('Indicators loss criticality ping flesh follow dog horse comms. Close uat unlock points effects hear. Turn game room bake and exploratory watches. Important money functional keywords base today cost. Place unlock lot third company across build hard investigation here. About mint have horse food mindfulness idea across fastworks. Comes hurting slipstream driving requirements effects status didnt right. Quarter shift supervisor conversation mint emails. Vec is recap beef investigation closest. Due whistles boil ladder dear.',
                 style: TextStyle(color: Colors.white , fontSize: 13),),

               SizedBox(height: 12,),
               Text('Office ipsum you must be muted. View options closer when model price streamline scraps jumping productize. Cc pants hours hill opportunity im whistles. Job bed post know im not by closest based player-coach. Regroup pee working investigation skulls relaxation organic identify hit.',
                 style: TextStyle(color: Colors.white , fontSize: 13),),


               SizedBox(height: 12,),
               Text('Indicators loss criticality ping flesh follow dog horse comms. Close uat unlock points effects hear. Turn game room bake and exploratory watches. Important money functional keywords base today cost. Place unlock lot third company across build hard investigation here. About mint have horse food mindfulness idea across fastworks. Comes hurting slipstream driving requirements effects status didnt right. Quarter shift supervisor conversation mint emails. Vec is recap beef investigation closest. Due whistles boil ladder dear.',
                 style: TextStyle(color: Colors.white , fontSize: 13),),

             ],
          ),
        ),
      ),
    );
  }
}
