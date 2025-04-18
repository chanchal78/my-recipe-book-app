import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _endpoint =
      'https://www.themealdb.com/api/json/v1/1/search.php?s=chicken';

  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    final response = await http.get(Uri.parse(_endpoint));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final meals = data['meals'] as List<dynamic>;
      return meals.map((meal) => meal as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
