import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_forumone_screen/models/page_forumone_model.dart';

import '../../page_feed_screen/models/data_prop/forum.dart';

/// A controller class for the PageForumoneScreen.
///
/// This class manages the state of the PageForumoneScreen, including the
/// current pageForumoneModelObj
class PageForumoneController extends GetxController {
  var selectedForum = Forum(id: '', name: '', modName: 'Unknown').obs;
  Forum get getSelectedForum => selectedForum.value;

  // Rx<PageForumoneModel> getPostsByForumId(String forumId) {
  //   Rx<PageForumoneModel> pageForumoneModelObj = Rx<PageForumoneModel>(PageForumoneModel(forumId));
  //   pageForumoneModelObj.value.loadForumPost(forumId).then((value) {
  //     pageForumoneModelObj.value.userpostForumItemList.value.addAll(value);
  //   });
  //   return pageForumoneModelObj;
  // }
  Rx<PageForumoneModel> getPostsByForumId(String forumId) {
    Rx<PageForumoneModel> pageForumoneModelObj = Rx<PageForumoneModel>(PageForumoneModel(forumId));

    pageForumoneModelObj.value.loadForumPost(forumId).then((value) {
      pageForumoneModelObj.value.userpostForumItemList.value.addAll(value);
    });

    return pageForumoneModelObj;
  }

}
