
import 'dart:math';

import '../models/quote.dart';

class DummyQuoteService {
  final List<Quote> quotes = [
    Quote(content: "Stay hungry, stay foolish.", author: "Steve Jobs"),
    Quote(content: "Dream big and dare to fail.", author: "Norman Vaughan"),
    Quote(content: "Do one thing every day that scares you.", author: "Eleanor Roosevelt"),
    Quote(content: "Believe you can and you're halfway there.", author: "Theodore Roosevelt"),
    Quote(content: "Success is not final, failure is not fatal.", author: "Winston Churchill"),
  ];

  Quote getRandomQuote() {
    final rand = Random();
    return quotes[rand.nextInt(quotes.length)];
  }
}
