import 'package:bkforum/controller/page_forumone_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/topic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../data/models/data_prop/forum.dart';
import '../../widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class PageAddForum extends StatelessWidget {
  PageAddForum({Key? key}) : super(key: key);

  final PageForumoneController controller = Get.put(PageForumoneController());
  final List<Topic> topics = [];
  final forum = Get.arguments as Forum?;
  String forumName = '';
  Rx<Topic> topic = Topic(id: '').obs;
  Rx<File> selectedImage = Rx<File>(File(''));
  TextEditingController forumNameController = TextEditingController();
  RxList<Topic> addedTopics = <Topic>[].obs;

  @override
  Widget build(BuildContext context) {

    if (forum?.topics?.length != 0) {
      addedTopics.assignAll(forum?.topics ?? []);
    }

    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Get.back(),
            ),
            title: forum?.id == null
                ? Text("Tạo forum")
                : Text("Chỉnh sửa forum ${forum?.name}")),
        body: Container(
          padding: EdgeInsets.all(10.adaptSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 14),
              Text(
                'Ảnh đại diện',
                style: TextStyle(fontSize: 16.adaptSize),
              ),
              SizedBox(height: 10),
              Container(
                height: 140.adaptSize,
                width: 140.adaptSize,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius:
                        BorderRadius.all(Radius.circular(20.adaptSize))),
                child: GestureDetector(
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
                                    selectedImage.value =
                                        File(pickedImage.path);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        backgroundColor: Colors.white);
                  },
                  child: Obx(() {
                    if (forum?.avatarUrl != null &&
                        selectedImage.value.path == '') {
                      return CustomImageView(
                        url: forum?.avatarUrl!,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return CustomImageView(
                        file: selectedImage.value,
                      );
                    }
                  }),
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                initialValue: forum?.name ?? '',
                // controller: forumNameController,
                onChanged: (value) {
                  forumName = value;
                },
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Tên forum'.tr,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.adaptSize))),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.adaptSize, vertical: 28.adaptSize),
                ),
              ),
              SizedBox(height: 14),
              Obx(() {
                return Container(
                  height: 76.adaptSize,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: addedTopics.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 60.adaptSize,
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.symmetric(vertical: 6.adaptSize),
                              padding: EdgeInsets.all(10.adaptSize),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.indigo.shade200),
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(addedTopics[index].name ?? ''),
                            ),
                            Positioned(
                                bottom: -13,
                                right: -13,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.red.shade400,
                                    ),
                                    onPressed: () {
                                      addedTopics.removeAt(index);
                                    }))
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
              Container(
                child: FutureBuilder<List<Topic>>(
                    future: controller.getAllTopics(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Obx(() {
                          List<Topic>? topics = snapshot.data;
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.adaptSize))),
                                contentPadding: EdgeInsets.all(10.adaptSize)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: (topic.value.name != '')
                                    ? topic.value.name
                                    : topics?.first.name,
                                icon: const Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                elevation: 8,
                                menuMaxHeight: 400.adaptSize,
                                padding:
                                    EdgeInsets.fromLTRB(3.h, 2.v, 3.h, 2.v),
                                focusColor: CupertinoColors.opaqueSeparator,
                                borderRadius: BorderRadiusStyle.circleBorder20,
                                onChanged: (String? value) {
                                  int? selectedIndex = topics?.indexOf(
                                      topics.firstWhere((topicCheck) =>
                                          value == topicCheck.name));
                                  topic.value = Topic(
                                      id: topics![selectedIndex ?? 0].id,
                                      name: value);
                                  // print(topic.value);
                                  if (!addedTopics.any(
                                      (value) => value.id == topic.value.id)) {
                                    final List<Topic> currentList =
                                        addedTopics.toList();
                                    currentList.insert(0, topic.value);
                                    addedTopics.assignAll(currentList);
                                  }
                                },
                                items: topics?.map((topicValue) {
                                  return DropdownMenuItem<String>(
                                    value: topicValue.name,
                                    child: Text(topicValue.name ?? ''),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        });
                      } else
                        return SizedBox(height: 20.adaptSize);
                    }),
              ),
              // SizedBox(height: 14),
              Spacer(),
              CustomElevatedButton(
                onTap: () {
                  if (forumName == '' && forum?.name != null) forumName = forum?.name ?? '' ;
                  if (forumName.isNotEmpty && addedTopics.isNotEmpty) {
                    if (forum?.id == null)
                      controller.createForum(
                          forumName, addedTopics, selectedImage.value);
                    else
                      controller.editForum(forumName, addedTopics,
                          selectedImage.value, forum?.avatarUrl, forum?.id);
                  } else
                    Get.snackbar('Thiếu thông tin',
                        'Vui lòng nhập đầy đủ thông tin forum',
                        backgroundColor: Colors.red.shade200);
                },
                text: forum?.id == null ? 'Tạo' : 'Lưu',
              )
            ],
          ),
        ),
      ),
    );
  }
}
