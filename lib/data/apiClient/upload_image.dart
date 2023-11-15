import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page_feed_screen/models/data_prop/document.dart';

Future<PostDocument> uploadImage(File imageFile) async {

  final preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('accessToken') ?? '';
  final headers = {
    'Authorization': 'Bearer $token',
  };

  var url = Uri.parse('http://52.139.152.154/api/v1/images');
  var request = http.MultipartRequest('POST', url);
  request.files.add(await http.MultipartFile.fromPath('documents', imageFile.path));
  request.headers.addAll(headers);

  var response = await request.send();

  if (response.statusCode == 201) {
    var responseData = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseData);
    var imageUrl = jsonResponse[0]['fileUrl'];
    var fileName = jsonResponse[0]['fileName'];

    return PostDocument(
      id: 'id_value',
      fileName: fileName,
      fileUrl: imageUrl,
    );
  } else {
    print('Upload hình ảnh thất bại. Mã phản hồi: ${response.statusCode}');
    return PostDocument();
  }
}
