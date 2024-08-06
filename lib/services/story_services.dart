import 'package:flutter/material.dart';
import 'package:mogapabahi/data/https/https.dart';
import 'package:mogapabahi/data/model/story.dart';

class StoryServices {
  static Future<List<StoryModel>?> getStories() async {
    try {
      var res = await Http.apiURL.get('/storybookapi.json');
      if (res.data != null && res.data is List) {
        List<StoryModel> stories = (res.data as List)
            .map((storyJson) => StoryModel.fromJson(storyJson))
            .toList();
        return stories;
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching stories: $e");
      return null;
    }
  }
}
