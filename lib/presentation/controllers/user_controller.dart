import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/data/models/user_model.dart';

String get apiUrl => dotenv.env['API_URL']!;
final path = '$apiUrl/user';

_extractUsersFromResponse(String body) {
  List<dynamic> json = jsonDecode(body);
  return json
      .map((json) => User.fromJson(json as Map<String, dynamic>))
      .toList();
}

Future<List<User>> getAllUsersRequest() async {
  final response = await http.get(Uri.parse(path));
  return _extractUsersFromResponse(response.body);
}

Future<User> getUserByIdRequest(int id) async {
  final response = await http.get(Uri.parse('$path/$id'));
  return User.fromJson(jsonDecode(response.body));
}

Future<User> getUserByEmail(String email) async {
  final response = await http.get(Uri.parse('$path/email/$email'));
  return User.fromJson(jsonDecode(response.body));
}

Future<List<User>> getFollowersRequest(int id) async {
  final response = await http.get(Uri.parse('$path/$id/followers'));
  return _extractUsersFromResponse(response.body);
}

Future<List<User>> getFollowingRequest(int id) async {
  final response = await http.get(Uri.parse('$path/$id/following'));
  return _extractUsersFromResponse(response.body);
}

Future<http.Response> createUserRequest(User user) async {
  return await http.post(
    Uri.parse(path),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );
}

Future<http.Response> updateUserRequest(User user) async {
  return await http.put(
    Uri.parse(path),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );
}

Future<http.Response> deleteUserRequest(int id) async {
  return await http.delete(Uri.parse('$path/$id'));
}

Future<http.Response> followUserRequest(int id, int targetId) async {
  return await http.post(Uri.parse('$path/$id/follow/$targetId'));
}

Future<http.Response> unfollowUserRequest(int id, int targetId) async {
  return await http.post(Uri.parse('$path/$id/unfollow/$targetId'));
}

Future<http.Response> likePostRequest(int id, int postId) async {
  return await http.post(Uri.parse('$path/$id/like/$postId'));
}

Future<http.Response> dislikePostRequest(int id, int postId) async {
  return await http.post(Uri.parse('$path/$id/dislike/$postId'));
}
