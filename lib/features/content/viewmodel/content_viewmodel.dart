import 'package:ui/data/model/story.dart';
import 'package:ui/utility/enum.dart';

class ContentViewModel {
  final APIState status;
  final List<StoryModel>? stories;

  ContentViewModel({
    this.status = APIState.loading,
    this.stories,
  });
}