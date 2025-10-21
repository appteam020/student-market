import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotiController extends ChangeNotifier {
  bool isNotificationsEnabled = false;

  Future<void> initStatus() async {
    final isOptedIn = OneSignal.User.pushSubscription.optedIn;
    isNotificationsEnabled = isOptedIn ?? false;
    notifyListeners();
  }

  Future<void> toggleNotifications(bool enabled) async {
    if (enabled) {
      await OneSignal.User.pushSubscription.optIn(); // تفعيل
    } else {
      await OneSignal.User.pushSubscription.optOut(); // إيقاف
    }

    // ✅ تحديث الحالة محلياً بدل انتظار OneSignal
    isNotificationsEnabled = enabled;
    notifyListeners();
  }
}
