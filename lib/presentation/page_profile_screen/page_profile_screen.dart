import 'package:bkforum/controller/page_profile_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/profile_model.dart';
import 'package:bkforum/widgets/highlightedItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/userpost_item_model.dart';
import '../../widgets/profile_stats.dart';
import '../../widgets/userpost_item_widget.dart';

// ignore: must_be_immutable
class PageProfileScreen extends GetView<PageProfileController> {

  Profile userProfile;
  Rx<List<UserpostItemModel>> postList = Rx<List<UserpostItemModel>>([]);
  late final PageProfileController profileController;

  PageProfileScreen(this.userProfile, {Key? key}) : super(key: key) {
    profileController = PageProfileController(userProfile);
  }
  void getPost() {
    postList.value.clear();
    profileController.loadPost(userProfile.id).then((value) {
      postList.value.addAll(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    getPost();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text('Thông tin cá nhân'),
        ),
        body: Container(
          child: DefaultTabController(
            length: 3,
            child: Container(
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.indigo,
                    tabs: [
                      Tab(
                          child: Row(
                            children: [
                              Icon(Icons.supervised_user_circle_outlined,
                                  color: Colors.indigo),
                              SizedBox(width: 8.adaptSize),
                              Text('Giới thiệu',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                      Tab(
                          child: Row(
                        children: [
                          Icon(Icons.history_edu_rounded, color: Colors.indigo),
                          SizedBox(width: 8.adaptSize),
                          Text('Bài viết',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )),
                      Tab(
                          child: Row(
                            children: [
                              Icon(Icons.attribution_rounded, color: Colors.indigo),
                              SizedBox(width: 8.adaptSize),
                              Text('Forum',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.bottomRight,
                          children: [
                            SingleChildScrollView(
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child:
                                  // ignore: unnecessary_null_comparison
                                  (userProfile.id == null)
                                      ? CircularProgressIndicator()
                                      : Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          CustomImageView(
                                              url: userProfile.avatarUrl,
                                              height: 70.adaptSize,
                                              width: 70.adaptSize,
                                              fit: BoxFit.cover,
                                              radius: BorderRadius.circular(
                                                  35.adaptSize)),
                                          SizedBox(width: 20),
                                          Text(
                                            userProfile.fullName,
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          ProfileStat(
                                              label: 'Forum',
                                              value: userProfile.forums!.length
                                                  .toString()),
                                          ProfileStat(
                                              label: 'Bài viết',
                                              value: postList.value.length.toString()),
                                          ProfileStat(
                                              label: 'Bạn bè', value: '500'),
                                        ]),
                                      SizedBox(height: 20),
                                      HighlightedItem(
                                        child: Row(
                                          children: [
                                            Text('Ngày sinh:'),
                                            SizedBox(width: 10),
                                            Text(
                                              DateFormat('dd-MM-yyyy').format(
                                                  userProfile.dateOfBirth ??
                                                      DateTime.now()),
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            SizedBox(height: 30.adaptSize)
                                          ])),
                                      HighlightedItem(
                                        child: Row(
                                          children: [
                                            Text('Giới tính:'),
                                            SizedBox(width: 10),
                                            Text(
                                              userProfile.gender ?? 'Không có dữ liệu',
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            SizedBox(height: 30.adaptSize)
                                          ])),
                                      HighlightedItem(
                                        child: Row(
                                          children: [
                                            Text('Email:'),
                                            SizedBox(width: 10),
                                            Text(userProfile.email ?? '',
                                                style: TextStyle(fontSize: 22)),
                                            SizedBox(height: 30.adaptSize)
                                          ])),
                                      HighlightedItem(
                                        child: Row(
                                          children: [
                                            Text('Địa chỉ:'),
                                            SizedBox(width: 10),
                                            Text(userProfile.address ?? '',
                                                style: TextStyle(fontSize: 22)),
                                            SizedBox(height: 30.adaptSize)
                                          ])),
                                      HighlightedItem(
                                        child: Row(
                                          children: [
                                            Text('Số điện thoại:'),
                                            SizedBox(width: 10),
                                            Text(
                                                userProfile.phoneNumber != null ? '${userProfile.phoneNumber}' : 'Không có',
                                                style: TextStyle(fontSize: 22)),
                                            SizedBox(height: 30.adaptSize)
                                          ])),
                                      HighlightedItem(
                                        child: Row(
                                          children: [
                                            Text('Kiểu:'),
                                            SizedBox(width: 10),
                                            Text(userProfile.type ?? '',
                                                style: TextStyle(fontSize: 22)),
                                            SizedBox(height: 30.adaptSize)
                                          ])),
                                      HighlightedItem(
                                        child: Row(
                                          children: [
                                            Text('Khoa:'),
                                            SizedBox(width: 10),
                                            Text(
                                                userProfile.faculty?.name ?? '',
                                                style: TextStyle(fontSize: 22)),
                                            SizedBox(height: 30.adaptSize)
                                          ])),
                                      HighlightedItem(
                                        child: Row(
                                          children: [
                                            Text('Ngày tham gia:'),
                                            SizedBox(width: 10),
                                            Text(
                                                DateFormat('dd-MM-yyyy').format(
                                                    userProfile.createdAt ??
                                                        DateTime.now()),
                                                style: TextStyle(fontSize: 22)),
                                            SizedBox(height: 30.adaptSize)
                                          ]))
                                    ])))),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ],
                        ),
                        NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              if (scrollNotification
                                  is ScrollStartNotification) {
                              } else if (scrollNotification
                                  is ScrollUpdateNotification) {
                              } else if (scrollNotification
                                  is ScrollEndNotification) {
                                profileController.fetchMorePosts(userProfile.id, postList.value.length)
                                    .then((newPosts) {
                                  postList.value.addAll(newPosts);

                                  print(postList.value.length);
                                });
                              }
                              return true;
                            },
                            child: Obx(() => RefreshIndicator(
                                  onRefresh: () async => getPost(),
                                  child: postList.value.isEmpty
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.separated(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          separatorBuilder: (context, index) {
                                            return Container(
                                              height: 10.v,
                                              color: Colors.black12,
                                            );
                                          },
                                          itemCount: postList.value.length.obs.value,
                                          itemBuilder: (context, index) {
                                            UserpostItemModel model =
                                            postList.value[index];
                                            return UserpostItemWidget(model);
                                          },
                                        ),
                                ))),
                        Center(child: Text('Tính năng đang cập nhật'))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
