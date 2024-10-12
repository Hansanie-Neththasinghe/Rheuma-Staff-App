import 'package:flutter/material.dart';
import '../models/info_hub.dart';
import '../services/api_service.dart';

class InfoHubProvider with ChangeNotifier{
// InfoHub? _infoHub;

final ApiService _apiService = ApiService();

List<InfoHub> _infoArticles = []; // List to hold info articles
  List<InfoHub> get infoArticles => _infoArticles; // Getter for info articles
  // Fetch all info articles
  Future<List<InfoHub>> getAllInfoArticles() async {
    try {
      final articles = await _apiService.getAllInfoArticles();
      print(articles);

      _infoArticles = articles;
      print(articles);

      notifyListeners();
      return articles;
    } catch (error) {
      print('Failed to fetch info articles: $error');
      throw error;
    }
  }

  // Fetch a specific info article by ID
  Future<InfoHub> getInfoArticleById(String articleId) async {
    try {
      final article = await _apiService.getInfoArticleById(articleId);
      return article;
    } catch (error) {
      print('Failed to fetch info article: $error');
      throw error;
    }
  }
  // Filter info articles by name, category, or description
  Future<List<InfoHub>> filterInfoArticles(String searchQuery) async {
    try {
      final filteredArticles =
          await _apiService.filterInfoArticles(searchQuery);
      _infoArticles = filteredArticles;
      notifyListeners();
      return filteredArticles;
    } catch (error) {
      print('Failed to filter info articles: $error');
      throw error;
    }
  }
}
