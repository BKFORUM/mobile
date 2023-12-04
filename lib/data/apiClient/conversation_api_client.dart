import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/core/utils/api_endpoints.dart';
import 'package:bkforum/data/models/data_prop/conversation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationAPIClient extends GetConnect{
  Future<dynamic> getConversation({String? search = '', int? skip = 0, int? take = 10}) async {
    final preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('accessToken') ?? '';
    Map<String, dynamic>? query = {
    'search': search,
    'skip': skip.toString(),
    'take': take.toString(),
  };
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await get(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getConversations,
      headers: headers,
      query: query
    );

    if (response.statusCode == 200) {
      List<Conversation> conversations = [];
      for (dynamic data in response.body['data']) {
        conversations.add(Conversation.fromJson(data));
      }

      return conversations;
    } else {
      final code = response.statusCode;
      final detail = response.statusText;
      throw Exception('Failed to fetch data, status code $code, error $detail');
    }
  }
}