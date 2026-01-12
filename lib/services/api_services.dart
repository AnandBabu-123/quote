import 'package:dio/dio.dart';
import '../models/quote.dart';




class ApiService {
  final Dio dio = Dio();

  Future<Quote> fetchRandomQuote() async {
    try {
      final res =
      await dio.get('https://dummyjson.com/quotes/random');

      return Quote.fromJson(res.data);
    } catch (e) {
      throw Exception("Failed to load quote");
    }
  }
}
