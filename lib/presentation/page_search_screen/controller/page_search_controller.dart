import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_search_screen/models/page_search_model.dart';

/// A controller class for the PageSearchScreen.
///
/// This class manages the state of the PageSearchScreen, including the
/// current pageSearchModelObj
class PageSearchController extends GetxController {
  Rx<PageSearchModel> pageSearchModelObj =
      PageSearchModel().obs;
}