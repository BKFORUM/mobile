import 'package:bkforum/controller/page_profile_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/profile_model.dart';
import 'package:bkforum/widgets/highlightedItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/apiClient/profile_api.dart';
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

    mediaQueryData = MediaQuery.of(context);
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
                        FutureBuilder<Profile>(
                            future: ProfileApi().fetchProfile(userProfile.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                // return Center(
                                //     child: CircularProgressIndicator(
                                //   color: Colors.white.withOpacity(0.1),
                                //   backgroundColor: Colors.white,
                                // ));
                                return Skeleton.ignore(child: Container());
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final fetchedProfile = snapshot.data!;
                                return Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    SingleChildScrollView(
                                        child: Center(
                                            child: Container(
                                                padding: EdgeInsets.all(20),
                                                // ignore: unnecessary_null_comparison
                                                child: (fetchedProfile.id == null)
                                                    ? CircularProgressIndicator()
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                            Row(
                                                              children: [
                                                                CustomImageView(
                                                                    url: fetchedProfile
                                                                        .avatarUrl,
                                                                    height: 70
                                                                        .adaptSize,
                                                                    width: 70
                                                                        .adaptSize,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    radius: BorderRadius
                                                                        .circular(
                                                                            35.adaptSize)),
                                                                SizedBox(
                                                                    width: 20),
                                                                Text(
                                                                  fetchedProfile
                                                                      .fullName,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 10.adaptSize),
                                                            Container(
                                                              padding: EdgeInsets.all(12.adaptSize),
                                                              decoration: BoxDecoration(
                                                                color: Colors.lightBlue.shade50,
                                                                borderRadius: BorderRadius.all(Radius.circular(15.adaptSize))
                                                              ),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ProfileStat(
                                                                        label:
                                                                            'Forum',
                                                                        value: fetchedProfile
                                                                            .forums!
                                                                            .length
                                                                            .toString()),
                                                                    ProfileStat(
                                                                        label:
                                                                            'Bài viết',
                                                                        value:
                                                                            '23'),
                                                                    ProfileStat(
                                                                        label:
                                                                            'Bạn bè',
                                                                        value:
                                                                            '5'),
                                                                  ]),
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(Icons.cake_rounded,
                                                                      color: Colors.blue.shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    DateFormat('dd-MM-yyyy').format(fetchedProfile
                                                                            .dateOfBirth ??
                                                                        DateTime
                                                                            .now()),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            22),
                                                                  ),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(Icons.transgender_rounded,
                                                                      color: Colors.blue.shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    fetchedProfile
                                                                            .gender ??
                                                                        'Không có dữ liệu',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            22),
                                                                  ),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(Icons.mail_rounded, color: Colors.blue.shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      fetchedProfile
                                                                              .email ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(Icons.home_work_rounded,
                                                                      color: Colors.blue.shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      fetchedProfile
                                                                              .address ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(Icons.phone_iphone_rounded,
                                                                  color: Colors.blue.shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      fetchedProfile.phoneNumber !=
                                                                              null
                                                                          ? '${fetchedProfile.phoneNumber}'
                                                                          : 'Không có',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(Icons.co_present_rounded,
                                                                      color: Colors.blue.shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      fetchedProfile
                                                                              .type ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(Icons.book_rounded,
                                                                      color: Colors.blue.shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      fetchedProfile
                                                                              .faculty
                                                                              ?.name ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(Icons.today_rounded,
                                                                      color: Colors.blue.shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      DateFormat('dd-MM-yyyy').format(fetchedProfile
                                                                              .createdAt ??
                                                                          DateTime
                                                                              .now()),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
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
                                );
                              }
                            }),
                        NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              if (scrollNotification
                                  is ScrollStartNotification) {
                              } else if (scrollNotification
                                  is ScrollUpdateNotification) {
                              } else if (scrollNotification
                                  is ScrollEndNotification) {
                                profileController
                                    .fetchMorePosts(
                                        userProfile.id, postList.value.length)
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
                                          itemCount:
                                              postList.value.length.obs.value,
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
