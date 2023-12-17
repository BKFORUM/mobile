import '../../../controller/event_controller.dart';
import 'package:get/get.dart';

/// A binding class for the PageEventScreen.
///
/// This class ensures that the EventController is created when the
/// PageEventScreen is first loaded.
class PageEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());
  }
}
