import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/quote.dart';
import '../services/api_services.dart';
import '../services/dummy_quote_service.dart';


class QuoteController extends GetxController {
  final ApiService api = ApiService();
  final box = GetStorage();

  final DummyQuoteService service = DummyQuoteService();

  Rx<Quote?> currentQuote = Rx<Quote?>(null);

  RxList<Quote> favorites = <Quote>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
    getNewQuote();
  }

  Future<void> getNewQuote() async {
    currentQuote.value = service.getRandomQuote();
    try {
      loading.value = true;
      final quote = await api.fetchRandomQuote();
      currentQuote.value = quote;
    } catch (e) {
      Get.snackbar("Error", "Unable to fetch quote");
    } finally {
      loading.value = false;
    }
  }

  void addToFavorites() {
    if (currentQuote.value == null) return;

    final exists = favorites.any(
            (q) => q.content == currentQuote.value!.content);

    if (!exists) {
      favorites.add(currentQuote.value!);
      saveFavorites();
    }
  }

  void saveFavorites() {
    final data = favorites.map((e) => e.toJson()).toList();
    box.write("favorites", data);
  }

  void loadFavorites() {
    final data = box.read<List>("favorites") ?? [];
    favorites.value = data
        .map((e) => Quote.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  void removeFavorite(Quote q) {
    favorites.removeWhere((e) => e.content == q.content);
    saveFavorites();
  }
}


