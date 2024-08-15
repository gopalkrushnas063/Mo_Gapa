// notification_model.dart
class NotificationModel {
  final int id;
  final int storyId;
  final String status;
  final String? message;

  NotificationModel({
    required this.id,
    required this.storyId,
    required this.status,
    this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      storyId: json['storyId'],
      status: json['status'],
      message: json['message'],
    );
  }
}
