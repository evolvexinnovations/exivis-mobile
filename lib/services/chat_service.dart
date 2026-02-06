import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  static const String baseUrl = "https://api.exivis.pro/api"; // base url

  static Future<Map<String, dynamic>?> sendMessage(String message) async {
    try {
      // Get token from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      if (token == null) return null;

      final response = await http.post(
        Uri.parse("$baseUrl/chat"), // your chat endpoint
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Chat Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Chat Exception: $e");
    }
    return null;
  }
}
