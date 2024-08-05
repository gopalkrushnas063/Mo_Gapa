import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/data/model/story.dart';
import 'package:ui/features/content/viewmodel/content_viewmodel.dart';
import 'package:ui/services/story_services.dart';
import 'package:ui/utility/enum.dart';

final contentControllerProvider =
    StateNotifierProvider<ContentController, ContentViewModel>((ref) {
  final controller = ContentController(ContentViewModel());
  // Fetch data when the controller is created
  controller.getFlightStatsData();
  return controller;
});

class ContentController extends StateNotifier<ContentViewModel> {
  ContentController(super.state);

  Future<void> getFlightStatsData() async {
    try {
      List<StoryModel>? res = await StoryServices.getStories();
      if (res != null && res.isNotEmpty) {
        state = ContentViewModel(
          status: APIState.ready,
          stories: res,
        );
      } else {
        state = ContentViewModel(
          status: APIState.ready,
          stories: [], // Empty list if no stories are found
        );
      }
    } catch (e) {
      state = ContentViewModel(
        status: APIState.failed,
      );
    }
  }
}
