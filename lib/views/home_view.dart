import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/quote_controller.dart';
import 'favourites_view.dart';



class HomeView extends StatelessWidget {
  final QuoteController controller = Get.put(QuoteController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA), // light background

      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Center(
          child: const Text(
            "Daily Quote",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite,color: Colors.white,),
            onPressed: () => Get.to(() => FavoritesView()),
          )
        ],
      ),

      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.currentQuote.value == null) {
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2575FC),
              ),
              onPressed: controller.getNewQuote,
              child: const Text("Load Quote"),
            ),
          );
        }

        final q = controller.currentQuote.value!;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// 🔹 QUOTE CARD
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '"${q.content}"',
                      style: const TextStyle(
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "- ${q.author}",
                      style: const TextStyle(
                        color: Color(0xFF6A11CB),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              /// 🔹 ACTION BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _circleButton(
                    icon: Icons.refresh,
                    color: const Color(0xFF2575FC),
                    onTap: controller.getNewQuote,
                  ),
                  const SizedBox(width: 20),
                  _circleButton(
                    icon: Icons.favorite_border,
                    color: const Color(0xFFE91E63),
                    onTap: controller.addToFavorites,
                  ),
                  const SizedBox(width: 20),
                  _circleButton(
                    icon: Icons.share,
                    color: const Color(0xFF4CAF50),
                    onTap: () {
                      Share.share('"${q.content}" - ${q.author}');
                    },
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  /// 🔹 Reusable colored button
  Widget _circleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}


