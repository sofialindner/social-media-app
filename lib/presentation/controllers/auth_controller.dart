import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/data/models/user_model.dart';

String get apiUrl => dotenv.env['API_URL']!;
final path = '$apiUrl/user';

Future<User> loginRequest(User user) async {
  final response = await http.post(
    Uri.parse('$path/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );
  return User.fromJson(jsonDecode(response.body));
}
