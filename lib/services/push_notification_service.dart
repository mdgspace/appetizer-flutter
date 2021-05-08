import 'package:appetizer/locator.dart';
import 'package:appetizer/services/local_storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialise() async {
    var settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // save device token to local storage
      _localStorageService.fcmToken = await _fcm.getToken();

      // allow notifications when app is in foreground
      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get any messages which caused the application to open from a terminated state.
      var _initialMessage = await _fcm.getInitialMessage();
      if (_initialMessage != null) {
        // app has been opened by a notification
        await _serialiseMessageAndNavigate(_initialMessage);
      }

      // handle FCM while app is in background
      FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) => _serialiseMessageAndNavigate(message));
    }
  }

  Future<void> _serialiseMessageAndNavigate(RemoteMessage message) async {}

  Future<void> subscribeToTopic(String topic) => _fcm.subscribeToTopic(topic);

  Future<void> unsubscribeFromTopic(String topic) =>
      _fcm.unsubscribeFromTopic(topic);
}
