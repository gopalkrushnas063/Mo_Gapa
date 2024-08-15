import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mogapabahi/data/model/story.dart';
import 'package:mogapabahi/features/notification/controller/notification_provider.dart';
import 'package:mogapabahi/utility/enum.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(notificationsProvider.notifier).fetchAndDisplayNotifications();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: notificationState.status == APIState.loading
          ? const Center(child: CircularProgressIndicator())
          : notificationState.status == APIState.failed
              ? const Center(child: Text('Failed to load notifications'))
              : ListView.builder(
                  itemCount: notificationState.stories?.length ?? 0,
                  itemBuilder: (context, index) {
                    StoryModel story = notificationState.stories![index];
                    return ListTile(
                      title: Text(story.title ?? 'No Title'),
                      subtitle: Text(story.content ?? 'No Subtitle'),
                      onTap: () {
                        // Navigate to a detailed screen with the story information
                      },
                    );
                  },
                ),
    );
  }
}
