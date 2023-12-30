// ignore: non_constant_identifier_names
import 'package:intl/intl.dart';

// ignore: non_constant_identifier_names
DateTime ConvertStringToDataTime(String dateString) {
  DateTime dateTime = DateTime.parse(dateString).toLocal();
  return dateTime;
}

String formatDateTime(String dateTime) {
  DateTime temp = ConvertStringToDataTime(dateTime);
  return DateFormat('dd-MM-yyyy – kk:mm').format(temp);
}

String formatTimeDifference(Duration difference) {
  if (difference.inDays > 0) {
    return '${difference.inDays} ngày trước';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} giờ trước';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} phút trước';
  } else {
    return 'Just now';
  }
}
