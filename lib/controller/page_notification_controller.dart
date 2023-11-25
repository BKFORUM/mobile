import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_notification_screen/models/page_notification_model.dart';
import 'package:bkforum/data/apiClient/notification_api.dart';

import '../data/models/notification_model.dart';
import '../presentation/page_notification_screen/page_notification_screen.dart';

/// A controller class for the PageNotificationScreen.
///
/// This class manages the state of the PageNotificationScreen, including the
/// current pageNotificationModelObj
class PageNotificationController extends GetxController {
  Rx<PageNotificationModel> pageNotificationModelObj = PageNotificationModel().obs;
}
