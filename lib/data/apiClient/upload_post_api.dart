import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../core/utils/api_endpoints.dart';
import '../models/upload_post_model.dart';
import '../models/profile_model.dart';


Future<int> uploadPostAPI(UploadPostModel postModel) async {

  final preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('accessToken') ?? '';
  final headers = {
    "Content-type": "application/json",
    'Authorization': 'Bearer $token',
  };

  var url = Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.posts);

  final jsonData = jsonEncode(postModel.toJson());
  print(jsonData);
  final response = await post(
    url,
    body: jsonData,
    headers: headers,
  );

  return response.statusCode;
}