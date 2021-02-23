import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void pushNotification() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _messageText = "Push Messaging message: $message";
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        _messageText = "Push Messaging message: $message";
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        _messageText = "Push Messaging message: $message";
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      _homeScreenText = "Push Messaging token: $token";
      print(_homeScreenText);
    });
  }
}
