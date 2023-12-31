import 'package:bkforum/controller/event_controller.dart';
import 'package:bkforum/data/models/data_prop/document.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../../widgets/custom_elevated_button.dart';

enum Gender { MALE, FEMALE }

// ignore: must_be_immutable
class AddEventPage extends StatelessWidget {
  final forum = Get.arguments as Forum?;
  final _formKey = GlobalKey<FormState>();
  final EventController controller = EventController();

  final TextEditingController forumNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  RxList<File> selectedImages = RxList<File>([]);

  @override
  Widget build(BuildContext context) {
    forumNameController.text = forum?.name ?? '';

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text('Thêm sự kiện'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 14.adaptSize),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Tiêu đề',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.adaptSize))),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.adaptSize, vertical: 10.adaptSize),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập tiêu đề';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 14.adaptSize),
                  child: TextFormField(
                    controller: startTimeController,
                    decoration: InputDecoration(
                      labelText: 'Thời gian bắt đầu',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.adaptSize),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.adaptSize,
                        vertical: 10.adaptSize,
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          showTimePicker(
                            context: context,
                            initialEntryMode: TimePickerEntryMode.inputOnly,
                            initialTime: TimeOfDay.now(),
                          ).then((selectedTime) {
                            if (selectedTime != null) {
                              DateTime dateTime = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedTime.hour,
                                selectedTime.minute,
                              );
                              String formattedDateTime =
                                  DateFormat('dd-MM-yyyy HH:mm')
                                      .format(dateTime);
                              startTimeController.text = formattedDateTime;
                              // print(formattedDateTime);
                            }
                          });
                        }
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập thời gian bắt đầu';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 14.adaptSize),
                  child: TextFormField(
                    controller: endTimeController,
                    decoration: InputDecoration(
                      labelText: 'Thời gian kết thúc',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.adaptSize),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.adaptSize,
                        vertical: 10.adaptSize,
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          showTimePicker(
                            context: context,
                            initialEntryMode: TimePickerEntryMode.inputOnly,
                            initialTime: TimeOfDay.now(),
                          ).then((selectedTime) {
                            if (selectedTime != null) {
                              DateTime dateTime = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedTime.hour,
                                selectedTime.minute,
                              );
                              String formattedDateTime =
                                  DateFormat('dd-MM-yyyy HH:mm')
                                      .format(dateTime);
                              endTimeController.text = formattedDateTime;
                              // print(formattedDateTime);
                            }
                          });
                        }
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập thời gian kết thúc';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 14.adaptSize),
                  child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Địa điểm',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.adaptSize))),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.adaptSize, vertical: 10.adaptSize),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập địa điểm';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 14.adaptSize),
                  child: TextFormField(
                    controller: contentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Nội dung',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.adaptSize))),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.adaptSize, vertical: 10.adaptSize),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập nội dung';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(child: Obx(() {
                  return GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            clipBehavior: Clip.hardEdge,
                            padding: EdgeInsets.fromLTRB(10.adaptSize,
                                26.adaptSize, 10.adaptSize, 10.adaptSize),
                            height: 110.adaptSize,
                            child: Column(
                              children: [
                                CustomElevatedButton(
                                  text: "Chọn từ thư viện".tr,
                                  buttonStyle: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.only(top: 7.adaptSize),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.center),
                                  buttonTextStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.fSize,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600),
                                  onTap: () async {
                                    final pickedImage =
                                    await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (pickedImage != null) {
                                      selectedImages.add(File(pickedImage.path));
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white);
                    },
                    child: selectedImages.isEmpty
                    ? Container(child: Column(
                      children: [
                        Text('Thêm hình ảnh (${selectedImages.length}/5)'),
                        Expanded(child: CustomProgressIndicator()),
                      ],
                    ))
                        : Container(
                            height: 300.adaptSize,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      CustomImageView(
                                        height: 270.adaptSize,
                                        width: 270.adaptSize,
                                        fit: BoxFit.cover,
                                        file: selectedImages[index],
                                        radius: BorderRadius.circular(32),
                                      ),
                                      Positioned(
                                          top: -13,
                                          right: -13,
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.cancel_rounded,
                                                color: Colors.red.shade700,
                                              ),
                                              onPressed: () {
                                                selectedImages.removeAt(index);
                                              }))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  );
                })),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newEvent = Event(
                        forumId: Rx(forum?.id ?? ''),
                        displayName: Rx(titleController.text.trim()),
                        content: Rx(contentController.text.trim()),
                        startAt: Rx<DateTime>(DateFormat('dd-MM-yyyy HH:mm').parse(startTimeController.text)),
                        endAt: Rx<DateTime>(DateFormat('dd-MM-yyyy HH:mm').parse(endTimeController.text)),
                        documents: RxList<PostDocument>([]),
                        location: Rx(locationController.text),
                      );
                      controller.addEvent(newEvent, selectedImages);
                    }
                  },
                  child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 20.adaptSize),
                      child: Text(
                        'Tạo',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 16.adaptSize,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Helvetica'),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
