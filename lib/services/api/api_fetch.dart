import 'package:crud_operations/services/models/models.dart';
import 'package:http/http.dart' as http;

Future<List<PostResponse>> fetchPost() async {
  var client = http.Client();
  final response = await client.get(
    Uri.parse("https://jsonplaceholder.typicode.com/posts"),
  );

  if (response.statusCode == 200) {
    List<PostResponse> posts = postResponseFromJson(response.body);
    return posts;
  } else {
    return [];
  }
}
