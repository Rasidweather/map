import 'package:flutter/material.dart';

class WeatherTracker extends StatelessWidget {
  final String title;
  final String date;
  final String image;
  final String description;

  const WeatherTracker({
    super.key,
    required this.title,
    required this.date,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Stack(
        children: [
          // الخلفية = صورة الطقس
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),

          // Layer غامق فوق الصورة
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          // زر الرجوع
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // البطاقة قابلة للسحب والتمدد
          DraggableScrollableSheet(
            initialChildSize: 0.35, // حجم البطاقة عند البداية
            minChildSize: 0.25,     // أقل حجم ممكن
            maxChildSize: 1.0,      // البطاقة تمتد لتغطي كامل الشاشة
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2A2C3D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // المحتوى داخل ScrollView مربوط مع controller
                    SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // مؤشر السحب
                          Center(
                            child: Container(
                              width: 40,
                              height: 5,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          // درجة الحرارة
                          Text(
                            "18°C",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // العنوان
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // الوصف
                         
                
                
                 SingleChildScrollView(
                    child: Text(
                      description,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
               
              
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),

                    // أيقونة المفضلة طالعة من فوق الكونتينر
                    Positioned(
                      top: -25,
                      right: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.green[600],
                        radius: 25,
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

