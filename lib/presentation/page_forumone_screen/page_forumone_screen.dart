import 'package:bkforum/data/models/topic.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:bkforum/widgets/topic_label.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/apiClient/forum_list_api.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import '../../data/models/userpost_item_model.dart';
import '../../widgets/userpost_item_widget.dart';
import '../../controller/page_forumone_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';

typedef ForumCallback = void Function(Forum selectedForum);

// ignore: must_be_immutable
class PageForumoneScreen extends StatelessWidget {
  PageForumoneScreen({Key? key}) : super(key: key);
  final PageForumoneController controller = Get.put(PageForumoneController());
  late String profileId = 'hung';

  @override
  Widget build(BuildContext context) {
    final forum = Get.arguments as Forum?;
    Future<SharedPreferences> preferencesFuture =
    SharedPreferences.getInstance();

    preferencesFuture.then((preferences) {
      profileId = preferences.getString('id') ?? '';
    });
    mediaQueryData = MediaQuery.of(context);
    return FutureBuilder<Forum>(
        future: ForumListApiClient().forumDetail(forum!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final fetchedForum = snapshot.data!;

            Rx<List<UserpostItemModel>> listPost =
                Rx<List<UserpostItemModel>>([]);
            return SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      title: Text('Forum'),
                      actions: [
                        fetchedForum.yourStatus == 'ACTIVE'
                            ? IconButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.pagePostScreen,
                                      arguments: forum);
                                },
                                icon: Icon(Icons.add_circle))
                            : SizedBox.shrink()
                      ],
                    ),
                    body: SizedBox(
                        width: double.maxFinite,
                        child: Column(children: [
                          Container(
                              padding: EdgeInsets.all(8.h),
                              decoration: AppDecoration.fillGray100,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomImageView(
                                            url: fetchedForum.avatarUrl,
                                            height: 36.adaptSize,
                                            width: 36.adaptSize,
                                            fit: BoxFit.cover,
                                            radius: BorderRadius.circular(
                                                18.adaptSize),
                                          ),
                                          SizedBox(
                                            width: 8.adaptSize,
                                          ),
                                          Expanded(
                                              child: Text(
                                            fetchedForum.name,
                                            style: TextStyle(
                                                fontSize: 18.adaptSize),
                                          )),
                                          IconButton(
                                            onPressed: () {},
                                            icon: fetchedForum.yourStatus ==
                                                    'ACTIVE'
                                                ? (profileId != fetchedForum.modId) ? Icon(Icons.exit_to_app_rounded) : SizedBox(height: 18.adaptSize)
                                                : Icon(Icons.group_add_rounded),
                                          ),
                                        ]),
                                    SizedBox(height: 6.v),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .admin_panel_settings_rounded,
                                                  color: Colors.blue.shade900),
                                              Container(
                                                padding:
                                                    EdgeInsets.all(2.adaptSize),
                                                child: Text(
                                                  fetchedForum.modName,
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.dialog(Dialog(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: fetchedForum.topics!
                                                      .map((item) {
                                                    return ListTile(
                                                      title:
                                                          Text(item.name ?? ''),
                                                    );
                                                  }).toList(),
                                                ),
                                              ));
                                            },
                                            child: Row(
                                              children: [
                                                for (Topic topic in fetchedForum
                                                    .topics!
                                                    .take(2))
                                                  TopicLabel(
                                                    id: topic.id,
                                                    name: topic.name ?? 'Hihi',
                                                  ),
                                                if (fetchedForum
                                                        .topics!.length >
                                                    2)
                                                  Text(
                                                      " +${fetchedForum.topics!.length - 2}"),
                                              ],
                                            ),
                                          )
                                        ])
                                  ])),
                          Expanded(
                              child: DefaultTabController(
                            length: 4,
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                padding: EdgeInsets.symmetric(vertical: 0),
                                decoration: AppDecoration.fillOnErrorContainer,
                                child: Column(
                                  children: [
                                    TabBar(
                                      indicatorColor: Colors.indigo,
                                      isScrollable: true,
                                      tabs: [
                                        Tab(
                                            child: Row(
                                          children: [
                                            Icon(Icons.history_edu_rounded,
                                                color: Colors.indigo),
                                            SizedBox(width: 8.adaptSize),
                                            Text('Bài viết',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                        )),
                                        Tab(
                                            child: Row(
                                          children: [
                                            Icon(
                                                Icons
                                                    .supervised_user_circle_outlined,
                                                color: Colors.indigo),
                                            SizedBox(width: 8.adaptSize),
                                            Text('Thành viên',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                        )),
                                        Tab(
                                            child: Row(
                                              children: [
                                                Icon(
                                                    Icons.event,
                                                    color: Colors.indigo),
                                                SizedBox(width: 8.adaptSize),
                                                Text('Sự kiện',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                              ],
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                            )),
                                        Tab(
                                            child: Row(
                                              children: [
                                                Icon(Icons.history_edu_rounded,
                                                    color: Colors.indigo),
                                                SizedBox(width: 8.adaptSize),
                                                Text('Bài viết chờ duyệt',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                              ],
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                            )),
                                      ],
                                    ),
                                    Expanded(
                                        child: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        NotificationListener<
                                            ScrollNotification>(
                                          onNotification: (scrollNotification) {
                                            if (scrollNotification
                                                is ScrollStartNotification) {
                                            } else if (scrollNotification
                                                is ScrollUpdateNotification) {
                                            } else if (scrollNotification
                                                is ScrollEndNotification) {
                                              // controller..value.fetchMorePosts(controller
                                              //     .pageFeedModelObj.value.userpostItemList.value.length);
                                            }
                                            return true;
                                          },
                                          child: Obx(() {
                                            // Gán giá trị cho listPost trong hàm loadForumPost
                                            controller
                                                .loadForumPost(forum.id)
                                                .then((value) {
                                              listPost.value = value;
                                            });

                                            if (listPost.value.isEmpty) {
                                              return Center(
                                                  child: fetchedForum
                                                              .yourStatus !=
                                                          'ACTIVE'
                                                      ? Text(
                                                          'Forum chưa có bài viết')
                                                      : Text(
                                                          'Forum chưa có bài viết '
                                                          '\n hãy đăng bài để mọi người cùng tham gia thảo luận',
                                                          textAlign: TextAlign
                                                              .center));
                                            } else {
                                              return RefreshIndicator(
                                                onRefresh: () async {},
                                                child: ListView.separated(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          Container(
                                                    height: 10.v,
                                                    color: Colors.black12,
                                                  ),
                                                  itemCount:
                                                      listPost.value.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    UserpostItemModel model =
                                                        listPost.value[index];
                                                    model.forumName?.value = '';
                                                    return UserpostItemWidget(
                                                        model);
                                                  },
                                                ),
                                              );
                                            }
                                          }),
                                        ),
                                        if (fetchedForum.users!.isEmpty)
                                          Center(
                                              child: Text('Chưa có thành viên'))
                                        else
                                          ListView.builder(
                                            itemCount:
                                                fetchedForum.users?.length,
                                            itemBuilder: (context, index) {
                                              final user =
                                                  fetchedForum.users?[index];
                                              return ListTile(
                                                leading: CustomImageView(
                                                  height: 36.adaptSize,
                                                  width: 36.adaptSize,
                                                  radius: BorderRadius.circular(
                                                      9.h),
                                                  fit: BoxFit.cover,
                                                  url: user?.avatarUrl,
                                                ),
                                                title:
                                                    Text(user!.fullName ?? ''),
                                              );
                                            },
                                          ),
                                        Center(child: Text('hihi'),),
                                        Center(child: Text('hihi ne'),),
                                      ],
                                    )),
                                  ],
                                )),
                          )),
                        ]))));
          }
        });
  }

  /// Navigates to the pageFeedScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageFeedScreen.
  onTapIconhomeone() {
    Get.toNamed(
      AppRoutes.pageFeedScreen,
    );
  }

  /// Navigates to the pageMessageScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageMessageScreen.
  onTapIconmessageone() {
    Get.toNamed(
      AppRoutes.pageMessageScreen,
    );
  }

  /// Navigates to the pagePostScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pagePostScreen.
  onTapIconaddone() {
    Get.toNamed(
      AppRoutes.pagePostScreen,
    );
  }

  /// Navigates to the pageNotificationScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageNotificationScreen.
  onTapIconnotificatio() {
    Get.toNamed(
      AppRoutes.pageNotificationScreen,
    );
  }

  /// Navigates to the pageSettingScreen when the action is triggered.

  /// When the action is triggered, this function uses the [Get] package to
  /// push the named route for the pageSettingScreen.
  onTapIconavatarone() {
    Get.toNamed(
      AppRoutes.pageSettingScreen,
    );
  }
}
