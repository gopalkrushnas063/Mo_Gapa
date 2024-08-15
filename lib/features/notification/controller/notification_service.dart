import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mogapabahi/data/https/https.dart';
import 'package:mogapabahi/data/model/story.dart';
import 'package:mogapabahi/features/notification/model/notification_model.dart';

class NotificationService {

  static Future<List<NotificationModel>> fetchNotifications() async {
    try {
      var res = await Http.apiURL.get('/all-notification');
      if (res.data != null) {
        return (res.data as List)
            .map((json) => NotificationModel.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
      return [];
    }
  }

  static Future<StoryModel?> fetchStoryById(String storyId) async {
    try {
      var res = await Http.apiURL.get('/story/$storyId');
      if (res.data != null) {
        return StoryModel.fromJson(res.data);
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching story: $e");
      return null;
    }
  }
}
