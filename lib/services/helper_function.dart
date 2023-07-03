import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class HelperFunction {
  static String userKey = "USERID";
  static String? userId;

  Future<String?> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(userKey);
    if (userId == null) {
      userId = const Uuid().v4();
      await prefs.setString(userKey, userId!);
    }
    return userId;
  }
}
