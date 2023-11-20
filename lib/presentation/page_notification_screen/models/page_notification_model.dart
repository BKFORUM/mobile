import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../data/apiClient/notification_api.dart';
import 'notification_model.dart';

/// This class defines the variables used in the [page_notification_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// class PageNotificationModel {
//
//   Rx<List<NotificationModel>> notifications = Rx<List<NotificationModel>>([]);
//   int displayedNotifications = 0;
//   int loadedNotifications = 0;
//
//   void fetchMoreNotifications() {
//     int take = 10;
//     int skip = loadedNotifications;
//     print(take);
//     NotificationApiClient().fetchNotifications(take, skip).then((newNotifications){
//       notifications.update(newNotifications);
//       loadedNotifications += newNotifications.length;
//       displayedNotifications += newNotifications.length;
//     }).catchError((error) {
//       print('Error: $error');
//     });
//   }
//
//   PageNotificationModel(){
//     NotificationApiClient().fetchNotifications(10, loadedNotifications).then((value) {
//       notifications.update((list) {
//         list!.addAll(value);
//       });
//     });
//   }
// }

class PageNotificationModel {
  RxList<NotificationModel> notifications = RxList<NotificationModel>([]);
  // int displayedNotifications = 0;
  int loadedNotifications = 0;

  void fetchMoreNotifications(int loaded) {
    int take = 10;
    int skip = loaded;
    // print(loaded);
    NotificationApiClient().fetchNotifications(take, skip).then((newNotifications) {
      notifications.addAll(newNotifications);
      loadedNotifications += newNotifications.length;
      // displayedNotifications += newNotifications.length;
    }).catchError((error) {
      print('Error: $error');
    });
  }

  PageNotificationModel() {
    NotificationApiClient().fetchNotifications(20, loadedNotifications).then((value) {
      // print('heheee ${value[0].content?.value}');
      notifications.addAll(value);
    });
  }
}
