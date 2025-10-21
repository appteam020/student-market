import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendOneSignalNotification({
  required String playerId,
  required String title,
  required String body,
  String? bigPicture,
}) async {
  const String appId = "e194f4cf-c614-441e-ab70-fbc4876e3558";
  const String restApiKey =
      "os_v2_app_4gkpjt6gcrcb5k3q7pcio3rvla3swy4efkjuxe5smmnt4iod7ds2gj4rqqreddgqd673csbbx4l4xe6yx54mq2mk3xeptu2jycw6n4i";
  print(playerId);
  final response = await http.post(
    Uri.parse('https://api.onesignal.com/notifications'),
    headers: {'Content-Type': 'application/json; charset=utf-8', 'Authorization': 'Basic $restApiKey'},
    body: jsonEncode({
      "app_id": appId,
      "include_external_user_ids": [playerId],
      "headings": {"ar": title, "en": title},
      "contents": {"ar": body, "en": body},
      "big_picture": bigPicture,
    }),
  );
  print(playerId);
  if (response.statusCode == 200) {
    print(response.body);
    print("✅ تم إرسال الإشعار بنجاح");
  } else {
    print("❌ فشل إرسال الإشعار: ${response.body}");
  }
}
