import 'dart:convert';

import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page_feed_screen/models/api_response.dart';
// import 'package:http/http.dart' as http;

class PostItemApiClient extends GetConnect {
  Future<dynamic> fetchData() async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
        ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.posts,
        headers: headers,
    );
    if (response.statusCode == 200) {
        // final apiResponse = ApiResponse.fromJson(response.body);
      final jsonData = {
        "skippedRecords": 0,
        "totalRecords": 34,
        "data": [
          {
            "id": "02a8947d-199a-4bd8-b4ab-3489694b7ff1",
            "forum": {
              "id": "4e28dbe9-3f05-430c-8288-76e2a5d70697",
              "name": "Hôm nay",
              "modId": "df17de4e-3eb3-47f6-bd71-fe551736452a",
              "avatarUrl": "http://res.cloudinary.com/dy7he6gby/image/upload/v1698855307/vrkcq2ptdv49oq7qqjmo.jpg"
            },
            "content": "<p>Lại một ngày nữa trôi qua</p>\n",
            "user": {
              "id": "45f54676-ee9f-4ddd-89c4-a0dd42f7b1e6",
              "avatarUrl": "http://cb.dut.udn.vn/ImageSV/20/102200172.jpg",
              "fullName": "Nguyễn Nhật Hưng"
            },
            "documents": [
              {
                "id": "a7cd69f7-46c4-408f-b26d-daaad763c860",
                "fileName": "209217129_846400339642745_3102259239596572643_n",
                "fileUrl": "http://res.cloudinary.com/dy7he6gby/image/upload/v1698910759/idlckuhufondtumqjysu.jpg"
              }
            ],
            "status": "ACTIVE",
            "createdAt": "2023-11-02T07:39:20.332Z",
            "_count": {
              "likes": 0,
              "comments": 0
            }
          }
        ],
        "pages": 34,
        "currPage": 1,
        "payloadSize": 1,
        "hasNext": true
      };
      final apiResponse = ApiResponse.fromJson(jsonData);
      return apiResponse;
    } else {
      final code = response.statusCode;
      throw Exception('Failed to fetch data, status code $code');
    }
  }
}

