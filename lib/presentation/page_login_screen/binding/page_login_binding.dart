import '../controller/page_login_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageLoginScreen.
///
/// This class ensures that the PageLoginController is created when the
/// PageLoginScreen is first loaded.
class PageLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageLoginController());
  }
}
