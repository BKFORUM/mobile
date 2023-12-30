import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../core/utils/api_endpoints.dart';
import '../models/upload_post_model.dart';

Future<void> uploadPostAPI(UploadPostModel postModel, Forum forum) async {
  final preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('accessToken') ?? '';
  String profileId = preferences.getString('id') ?? '';
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
  if (response.statusCode == 201) {
    if (profileId == forum.modId)
      Get.snackbar('Đăng bài thành công', '',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green.shade300);
    else Get.snackbar('Gửi bài thành công', 'Chờ sự chấp thuận từ moderator',
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green.shade300);
    Get.offNamed(AppRoutes.appNavigationScreen);
  } else {
    Get.snackbar('Đăng bài không thành công ${response.statusCode}', '',
        duration: Duration(seconds: 2), backgroundColor: Colors.red);
    Get.back();
  }
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
