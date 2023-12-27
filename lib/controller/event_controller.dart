import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/event.dart';

import '../data/apiClient/event_api_client.dart';

class EventController extends GetxController{
  var eventsList = <Event>[].obs;

  Future<List<Event>> fetchEvents() async {
    try {
      List<Event> tempList = await EventApiClient().fetchData();
      return tempList;
    } catch (error) {
      print('Error fetching comments: $error');
      return eventsList;
    }
  }

  refreshEventData() {

  }

  void changeParticipate(Event event) {
    if(event.isSubscriber!.value){
      EventApiClient().subscribe(event);
    } else EventApiClient().unSubscribe(event);
  }

  Future<Event> getEventById(String eventId) async {
    try {
      Event event = await EventApiClient().fetchEventById(eventId);
      return event;
    } catch (error) {
      print('Error fetching comments: $error');
      return Event();
    }
  }
}