import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mogapabahi/features/notification/controller/notification_service.dart';
import 'package:mogapabahi/features/notification/model/notification_model.dart';

import 'package:mogapabahi/utility/enum.dart';
import 'package:mogapabahi/data/model/story.dart';

final notificationsProvider = StateNotifierProvider<NotificationProvider, NotificationViewModel>((ref) {
  return NotificationProvider(NotificationViewModel());
});

class NotificationProvider extends StateNotifier<NotificationViewModel> {
  NotificationProvider(super.state);

  fetchAndDisplayNotifications() async {
    try {
      List<NotificationModel> notifications = await NotificationService.fetchNotifications();
      List<StoryModel> stories = [];

      // Fetch the story details for each notification's storyId
      for (var notification in notifications) {
        StoryModel? story = await NotificationService.fetchStoryById("${notification.storyId}");
        if (story != null) {
          stories.add(story);
        }
      }

      state = NotificationViewModel(
        status: APIState.ready,
        stories: stories,
      );
    } catch (e) {
      state = NotificationViewModel(status: APIState.failed);
    }
  }
}

class NotificationViewModel {
  final APIState status;
  final List<StoryModel>? stories;

  NotificationViewModel({
    this.status = APIState.loading,
    this.stories,
  });
}
