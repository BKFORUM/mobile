import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_forumtwo_screen/models/page_forumtwo_model.dart';

/// A controller class for the PageForumtwoScreen.
///
/// This class manages the state of the PageForumtwoScreen, including the
/// current pageForumtwoModelObj
class PageForumtwoController extends GetxController {
  Rx<PageForumtwoModel> pageForumtwoModelObj = PageForumtwoModel().obs;
}
