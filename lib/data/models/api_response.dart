
import 'package:bkforum/presentation/page_feed_screen/models/data_prop/post_data.dart';

class ApiResponse {
  int skippedRecords;
  int totalRecords;
  List<Data> data;
  int pages;
  int currPage;
  int payloadSize;
  bool hasNext;

  ApiResponse({
    required this.skippedRecords,
    required this.totalRecords,
    required this.data,
    required this.pages,
    required this.currPage,
    required this.payloadSize,
    required this.hasNext
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      skippedRecords: json['skippedRecords'],
      totalRecords: json['totalRecords'],
      data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
      pages: json['pages'],
      currPage: json['currPage'],
      payloadSize: json['payloadSize'],
      hasNext: json['hasNext'],
    );
  }
}