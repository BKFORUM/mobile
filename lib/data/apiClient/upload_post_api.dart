import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../core/utils/api_endpoints.dart';
import '../models/upload_post_model.dart';
import '../models/profile_model.dart';
import '../models/userpost_item_model.dart';

Future<int> uploadPostAPI(UploadPostModel postModel) async {
  final preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('accessToken') ?? '';
  final headers = {
    "Content-type": "application/json",
    'Authorization': 'Bearer $token',
  };

  var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts);

  final jsonData = jsonEncode(postModel.toJson());
  final response = await post(
    url,
    body: jsonData,
    headers: headers,
  );

  return response.statusCode;
}

Future<int> editPostAPI(UploadPostModel postEdit, Rx<String>? id) async {
  final preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('accessToken') ?? '';
  final headers = {
    "Content-type": "application/json",
    'Authorization': 'Bearer $token',
  };

  var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts + '/$id');

  final jsonData = jsonEncode(postEdit.toJson());
  print(jsonData);
  final response = await put(
    url,
    body: jsonData,
    headers: headers,
  );

  return response.statusCode;
}

void likePostAPI(String id) async{
  final preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('accessToken') ?? '';
  final headers = {
    'Authorization': 'Bearer $token',
  };
  var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts + '/$id/likes');
  final response = await post(url, headers: headers);
  if(response.statusCode == 201){
  } else print('Error while like: ${response.statusCode}');
}

void unlikePostAPI(String id) async{
  final preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('accessToken') ?? '';
  final headers = {
    'Authorization': 'Bearer $token',
  };
  var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.posts + '/$id/likes');
  final response = await delete(url, headers: headers);
  if(response.statusCode == 201){
  } else print('Error while unlike: ${response.statusCode}');
}
