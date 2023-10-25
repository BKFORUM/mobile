import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_forumone_screen/models/page_forumone_model.dart';

/// A controller class for the PageForumoneScreen.
///
/// This class manages the state of the PageForumoneScreen, including the
/// current pageForumoneModelObj
class PageForumoneController extends GetxController {
  Rx<PageForumoneModel> pageForumoneModelObj = PageForumoneModel().obs;
}
