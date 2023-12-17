import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/event.dart';

import '../data/apiClient/event_api_client.dart';

class EventController extends GetxController{
  var eventsList = <Event>[].obs;

  void fetchEvents() async {
    try {
      List<Event> tempList = await EventApiClient().fetchData();
      // print(eventsList.length);
      eventsList.assignAll(tempList);
    } catch (error) {
      print('Error fetching comments: $error');
    }
  }

  refreshEventData() {}

  void changeParticipate(Event event) {

  }
}