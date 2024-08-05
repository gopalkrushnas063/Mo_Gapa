import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ui/data/model/story.dart';
import 'package:http/http.dart' as http;

class StoryViewModel extends ChangeNotifier {
  List<StoryModel> stories = [];
  bool isLoading = false;
  String error = "";

  Future<void> fetchDataFromApi() async {
    isLoading = true;
    error = "";

    try {
      final response = await http.get(
        Uri.parse(
            "https://gopalkrushnas.github.io/storybook_api/storybookapi.json"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        stories = jsonResponse.map((data) => StoryModel.fromJson(data)).toList();
        isLoading = false;
      } else {
        error = "Failed to load data from API";
      }
    } catch (e) {
      error = "An error occurred: $e";
    }

    notifyListeners();
  }
}
