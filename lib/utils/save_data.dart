import 'package:shared_preferences/shared_preferences.dart';

///Works as a wrapper for shared preferences to hold key value pairs
class SaveData {
  static String token = "token";
  static String email = "email";
  static String name = "name";
  static String role = "role";
  static String id = "id";
  static void saveData(
      String tokenData, String emailData, String nameData, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SaveData.token, tokenData);
    await prefs.setString(SaveData.email, emailData);
    await prefs.setString(SaveData.name, nameData);
    await prefs.setString(SaveData.role, role);
  }

  static void saveRole(String role, int id, String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(SaveData.role, role);
    await prefs.setInt(SaveData.id, id);
    await prefs.setString(SaveData.name, name);
  }

  static void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SaveData.role, "");
  }

  static Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SaveData.role) ?? "";
  }

  static Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SaveData.id) ?? -1;
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SaveData.token) ?? "";
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SaveData.name) ?? "";
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SaveData.email) ?? "";
  }
}
