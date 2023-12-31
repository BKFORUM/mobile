import 'dart:io';

import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:flutter/material.dart';

import '../core/utils/conpress_image.dart';
import '../data/apiClient/event_api_client.dart';
import '../data/apiClient/upload_image.dart';
import '../data/models/data_prop/document.dart';

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

  Future<void> addEvent(Event newEvent, RxList<File> selectedImages) async {
    if(newEvent.endAt!.value.isAfter(newEvent.startAt!.value)){
      for(File selectedImage in selectedImages){
        final compressedItem = await testCompressAndGetFile(selectedImage, "compressed_");
        PostDocument document = await uploadImage(compressedItem);
        newEvent.documents?.add(document);
      }
      EventApiClient().addEvent(newEvent);
    } else{
      Get.snackbar('Lỗi thời gian', 'Thời gian kết thúc sau thời gian bắt đầu',
      backgroundColor: Colors.red.shade300);
    }
  }
}