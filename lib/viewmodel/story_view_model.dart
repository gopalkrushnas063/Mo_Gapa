import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ui/model/story.dart';

class StoryViewModel extends ChangeNotifier {
  List<Story> stories = [];
  bool isLoading = false;

  Future<void> fetchDataFromApi() async {
    isLoading = true; // Set isLoading to true when data fetching starts
    notifyListeners();

    final response = await http.get(Uri.parse("https://story-book-api.onrender.com/api/story"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      stories = jsonResponse.map((data) => Story.fromJson(data)).toList();
      print(stories);

      isLoading = false; // Set isLoading to false when data is loaded
      notifyListeners();
    } else {
      throw Exception("Failed to load data from API");
    }
  }
}
