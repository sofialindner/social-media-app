import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app/data/models/post_model.dart';

String get apiUrl => dotenv.env['API_URL']!;
final path = '$apiUrl/posts';

_extractPostsFromResponse(String body) {
  List<dynamic> json = jsonDecode(body);
  return json
      .map((json) => Post.fromJson(json as Map<String, dynamic>))
      .toList();
}

Future<List<Post>> getAllPostsRequest() async {
  final response = await http.get(Uri.parse('$path/'));
  return _extractPostsFromResponse(response.body);
}

Future<List<Post>> getPostsFromUserRequest(int id) async {
  final response = await http.get(Uri.parse('$path/$id'));
  return _extractPostsFromResponse(response.body);
}

Future<http.StreamedResponse> createPostRequest(
  int id,
  Map<String, String> images,
  String description,
) async {
  var req = http.MultipartRequest('POST', Uri.parse(path));
  req.fields['user_id'] = id.toString();
  req.fields['description'] = description;

  images.forEach((k, v) async {
    req.files.add(
      await http.MultipartFile.fromPath(
        'images',
        k,
        contentType: MediaType('image', v),
      ),
    );
  });

  var res = await req.send();
  return res;
}

Future<http.Response> deletePostRequest(int userId, int postId) async {
  return await http.delete(Uri.parse('$path/$postId/user/$userId'));
}
