import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/profile_model.dart';
import 'package:bkforum/presentation/page_search_screen/models/page_search_model.dart';

import '../data/apiClient/forum_list_api.dart';
import '../data/models/data_prop/forum.dart';

/// A controller class for the PageSearchScreen.
///
/// This class manages the state of the PageSearchScreen, including the
/// current pageSearchModelObj
class PageSearchController extends GetxController {

  // List<Forum> forumResults = [];
  RxList<Forum> forumResults = <Forum>[].obs;

  RxList<Profile> userResults = <Profile>[].obs;

  Rx<PageSearchModel> pageSearchModelObj =
      PageSearchModel().obs;



  // LOADMORE ==> them SKIP, them LOAD
  void handleSearch(String value) {
    ForumListApiClient apiClient = ForumListApiClient();
    apiClient.searchForums(value).then((searchedForums) {
      forumResults.clear();
      forumResults.addAll(searchedForums);
    });
    apiClient.searchUsers(value).then((searchedUsers) {
      userResults.clear();
      userResults.addAll(searchedUsers);
    });
  }
}