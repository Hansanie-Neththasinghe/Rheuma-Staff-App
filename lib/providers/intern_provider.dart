import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/intern.dart';
import '../services/api_service.dart';

class InternProvider with ChangeNotifier {
  Intern? _intern;
  final ApiService _apiService = ApiService();

  Intern? get intern => _intern;


  // Login intern
  Future<String> loginIntern(String email, String password) async {
    try {
      final response = await _apiService.loginIntern(email, password);

      // Ensure that we check for '_id' instead of 'patientId'
      final internId = response['id'] ?? response['_id'];
      _intern = Intern.fromJson(response);
      if (internId == null) {
        throw Exception('No internId returned in the login response');
      }

      notifyListeners();
      return internId;
    } catch (error) {
      print("Login error: $error");
      throw error;
    }
  }

Future<void> fetchIntern(String internId) async {
    try {
      _intern = await _apiService.fetchInternDetails(internId);
      notifyListeners();
    } catch (error) {
      print('Failed to fetch intern details: $error');
    }
  }

Future<void> logoutIntern(BuildContext context) async {
    try {
      // Clear the saved token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      // Clear the patient data locally
      _intern = null;
      notifyListeners();

      // Redirect to the login page
      Navigator.of(context).pushReplacementNamed('/initial');
    } catch (error) {
      print('Error logging out intern: $error');
    }
  }

}