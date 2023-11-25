import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_setting_screen/models/page_setting_model.dart';

/// A controller class for the PageSettingScreen.
///
/// This class manages the state of the PageSettingScreen, including the
/// current pageSettingModelObj
class PageSettingController extends GetxController {
  Rx<PageSettingModel> pageSettingModelObj = PageSettingModel().obs;
}
