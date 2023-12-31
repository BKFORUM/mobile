import 'package:bkforum/controller/page_profile_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/profile_model.dart';
import 'package:bkforum/presentation/page_profile_screen/edit_profile_screen.dart';
import 'package:bkforum/widgets/highlightedItem.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/apiClient/profile_api.dart';
import '../../data/models/data_prop/forum.dart';
import '../../data/models/userpost_item_model.dart';
import '../../widgets/profile_stats.dart';
import '../../widgets/userpost_item_widget.dart';

// ignore: must_be_immutable
class PageProfileScreen extends GetView<PageProfileController> {
  Profile userProfile;
  Rx<List<UserpostItemModel>> postList = Rx<List<UserpostItemModel>>([]);
  Rx<List<Forum>> forumList = Rx<List<Forum>>([]);
  late final PageProfileController profileController;
  late String profileId = 'default id';

  PageProfileScreen(this.userProfile, {Key? key}) : super(key: key) {
    profileController = PageProfileController(userProfile);
  }
  void getPost() {
    postList.value.clear();
    profileController.loadPost(userProfile.id).then((value) {
      postList.value.addAll(value);
    });
  }

  void getForums() {
    forumList.value.clear();
    profileController.loadForums(userProfile.id).then((value) {
      forumList.value.addAll(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    getPost();
    getForums();
    Future<SharedPreferences> preferencesFuture =
        SharedPreferences.getInstance();

    preferencesFuture.then((preferences) {
      profileId = preferences.getString('id') ?? '';
    });
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
              child: Column(children: [
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
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                                child: (fetchedProfile.id ==
                                                        null)
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
                                                            SizedBox(
                                                                height: 10
                                                                    .adaptSize),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .all(12
                                                                      .adaptSize),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .lightBlue
                                                                      .shade50,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.adaptSize))),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    FutureBuilder<
                                                                            int>(
                                                                        future: profileController.getNumberOfForums(fetchedProfile
                                                                            .id),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return ProfileStat(
                                                                                label: 'Forum',
                                                                                value: snapshot.data.toString());
                                                                          } else {
                                                                            return ProfileStat(
                                                                                label: 'Forum',
                                                                                value: '');
                                                                          }
                                                                        }),
                                                                    FutureBuilder<
                                                                            int>(
                                                                        future: profileController.getNumberOfPosts(fetchedProfile
                                                                            .id),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return ProfileStat(
                                                                                label: 'Bài viết',
                                                                                value: snapshot.data.toString());
                                                                          } else {
                                                                            return ProfileStat(
                                                                                label: 'Bài viết',
                                                                                value: '');
                                                                          }
                                                                        }),
                                                                    FutureBuilder<
                                                                        int>(
                                                                        future: profileController.getNumberOfFriends(fetchedProfile
                                                                            .id),
                                                                        builder:
                                                                            (context,
                                                                            snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return ProfileStat(
                                                                                label: 'Bạn bè',
                                                                                value: snapshot.data.toString());
                                                                          } else {
                                                                            return ProfileStat(
                                                                                label: 'Bạn bè',
                                                                                value: '');
                                                                          }
                                                                        }),
                                                                  ]),
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .cake_rounded,
                                                                      color: Colors
                                                                          .blue
                                                                          .shade900),
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
                                                                            20),
                                                                  ),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .transgender_rounded,
                                                                      color: Colors
                                                                          .blue
                                                                          .shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    fetchedProfile.gender ==
                                                                            'MALE'
                                                                        ? 'Nam'
                                                                        : 'Nữ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .mail_rounded,
                                                                      color: Colors
                                                                          .blue
                                                                          .shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      fetchedProfile
                                                                              .email ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .home_work_rounded,
                                                                      color: Colors
                                                                          .blue
                                                                          .shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      fetchedProfile
                                                                              .address ??
                                                                          '',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .phone_iphone_rounded,
                                                                      color: Colors
                                                                          .blue
                                                                          .shade900),
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
                                                                              20)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .co_present_rounded,
                                                                      color: Colors
                                                                          .blue
                                                                          .shade900),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      fetchedProfile.type ==
                                                                              'STUDENT'
                                                                          ? 'Sinh viên'
                                                                          : 'Giảng viên',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .book_rounded,
                                                                      color: Colors
                                                                          .blue
                                                                          .shade900),
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
                                                                              20)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ])),
                                                            HighlightedItem(
                                                                child: Row(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .today_rounded,
                                                                      color: Colors
                                                                          .blue
                                                                          .shade900),
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
                                                                              20)),
                                                                  SizedBox(
                                                                      height: 30
                                                                          .adaptSize)
                                                                ]))
                                                          ])))),
                                    if (profileId == fetchedProfile.id)
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
                                            onPressed: () {
                                              Get.to(() => EditProfileScreen(),
                                                  arguments: fetchedProfile,
                                                  transition:
                                                      Transition.rightToLeft);
                                            },
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

                                  // print(postList.value.length);
                                });
                              }
                              return true;
                            },
                            child: Obx(() => RefreshIndicator(
                                  onRefresh: () async => getPost(),
                                  child: postList.value.isEmpty
                                      ? Center(
                                          child: CustomProgressIndicator(),
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
                        NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification is ScrollStartNotification) {
                            } else if (scrollNotification
                                is ScrollUpdateNotification) {
                            } else if (scrollNotification
                                is ScrollEndNotification) {}
                            return true;
                          },
                          child: Obx(() {
                            if (forumList.value.isEmpty)
                              return CustomProgressIndicator();
                            else
                              return ListView.builder(
                                itemCount: forumList.value.length,
                                itemBuilder: (context, index) {
                                  final forum = forumList.value[index];
                                  return ListTile(
                                    leading: CustomImageView(
                                      height: 36.adaptSize,
                                      width: 36.adaptSize,
                                      radius: BorderRadius.circular(9.h),
                                      fit: BoxFit.cover,
                                      url: forum.avatarUrl ??
                                          'http://res.cloudinary.com/dy7he6gby/image/upload/v1702796805/a70tpruabwfzoq819luj.jpg',
                                    ),
                                    title: Text(
                                      forum.name,
                                      style: TextStyle(
                                          color: forum.modId == userProfile.id
                                              ? Colors.blue.shade900
                                              : Colors.black),
                                    ),
                                    trailing: forum.modId == userProfile.id
                                        ? Icon(
                                            Icons.admin_panel_settings_rounded,
                                            color: Colors.blue.shade900,
                                          )
                                        : SizedBox.shrink(),
                                    onTap: () {
                                      Get.toNamed(AppRoutes.pageForumoneScreen,
                                          arguments: forum);
                                    },
                                  );
                                },
                              );
                          }),
                        ),
                      ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
