import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApiClient extends GetConnect {
  Future<dynamic> getUsers ({String? search, int? skip, int? take}) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getUser,
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<User> users = [];
      for (dynamic data in response.body["data"]) {
        users.add(User.mapResponseToObj(data));
      }
      return users;
    } else {
      final code = response.statusCode;
      final detail = response.statusText;
      throw Exception('Failed to fetch data, status code $code, error $detail');
    }
  }
}