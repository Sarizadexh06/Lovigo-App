import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthService {

  final String baseUrl = "http://lovigo.net/oauth/token";
  final String clientId = "9ca71a69-989a-4b81-b8ed-30c96df799e7";
  final String clientSecret = "AJ8mbgnqifvYAU02PH4SmtSkM3T66Ftmcn8205fp";

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse(baseUrl);

    final body = {
      'grant_type': 'password',
      'username': email,
      'password': password,
      'client_id': clientId,
      'client_secret': clientSecret,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&'),
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      print('Login failed with status: ${response.statusCode}');
      print('Response: ${response.body}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo(String accessToken) async {
    // JWT'yi çöz ve kullanıcı kimliğini çıkar
    final jwt = JWT.decode(accessToken);
    final userId = jwt.payload['sub'];

    final url = Uri.parse("http://lovigo.net/api/v1/users/$userId");

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to get user info with status: ${response.statusCode}');
      print('Response: ${response.body}');
      return null;
    }
  }
  final String baseUrlUpdate = "http://lovigo.net/api/v1";

  Future<bool> updateUserInfo(String accessToken, Map<String, dynamic> updatedData) async {
    final jwt = JWT.decode(accessToken);
    final userId = jwt.payload['sub'];

    final url = Uri.parse('$baseUrlUpdate/users/$userId');
    print('Sending update request to $url with data: ${json.encode(updatedData)}');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(updatedData),
    );

    print('Response Body: ${response.body}');

    return response.statusCode == 200;
  }

}
