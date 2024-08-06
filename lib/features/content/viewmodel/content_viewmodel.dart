import 'package:mogapabahi/data/model/story.dart';
import 'package:mogapabahi/utility/enum.dart';

class ContentViewModel {
  final APIState status;
  final List<StoryModel>? stories;

  ContentViewModel({
    this.status = APIState.loading,
    this.stories,
  });
}