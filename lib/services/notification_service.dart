import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  void showNotification(String title, String message) async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
      if (isAllowed) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 0,
            channelKey: 'basic_channel',
            title: title,
            body: message,
            notificationLayout: NotificationLayout.Default,
          ),
        );
      }
    });
  }
}
