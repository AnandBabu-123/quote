import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quote_controller.dart';

class FavoritesView extends StatelessWidget {
  final QuoteController controller = Get.find();

  FavoritesView({super.key});

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
            "Favorites",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
      ),

      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(
            child: Text(
              "No favorites yet",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final quote = controller.favorites[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${quote.content}"',
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "- ${quote.author}",
                        style: const TextStyle(
                          color: Color(0xFF6A11CB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: const Color(0xFFE91E63),
                        onPressed: () =>
                            controller.removeFavorite(quote),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
