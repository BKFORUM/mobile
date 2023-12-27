import 'package:bkforum/data/models/data_prop/users.dart';
import 'package:bkforum/data/models/event.dart';
import 'package:bkforum/data/models/topic.dart';
import 'package:bkforum/presentation/page_forumone_screen/page_add_forum.dart';
import 'package:bkforum/presentation/page_forumone_screen/page_add_member.dart';
import 'package:bkforum/widgets/event_item_widget.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:bkforum/widgets/topic_label.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/apiClient/forum_list_api.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/userpost_item_model.dart';
import '../../widgets/image_slider.dart';
import '../../widgets/request_forum_icon.dart';
import '../../widgets/userpost_item_widget.dart';
import '../../controller/page_forumone_controller.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:flutter/material.dart';

import '../page_profile_screen/page_profile_screen.dart';

typedef ForumCallback = void Function(Forum selectedForum);

// ignore: must_be_immutable
class PageForumoneScreen extends StatelessWidget {
  PageForumoneScreen({Key? key}) : super(key: key);
  final PageForumoneController controller = Get.put(PageForumoneController());
  final MemberController memberController = MemberController();
  late String profileId = 'default id';
  RxList<User> members = <User>[].obs;
  final forum = Get.arguments as Forum?;
  Rx<bool> showAddButton = true.obs;

  @override
  Widget build(BuildContext context) {

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
            members.clear();
            members.addAll(fetchedForum.users ?? []);
            Rx<List<UserpostItemModel>> listPost =
                Rx<List<UserpostItemModel>>([]);

            Rx<List<Event>> listEvent = Rx<List<Event>>([]);
            RxList<UserpostItemModel> listRequestPost = RxList<UserpostItemModel>([]);
            RxList<Profile> listRequestUser = RxList<Profile>([]);


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
                                      arguments: fetchedForum);
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
                                                ? (profileId !=
                                                        fetchedForum.modId)
                                                    ? GestureDetector(
                                              onTap: (){
                                                Get.defaultDialog(
                                                  title: 'Xác nhận rời forum',
                                                  content: Text('Bạn có chắc chắn muốn rời?'),
                                                  confirm: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.all(26.adaptSize),
                                                    ),
                                                    onPressed: () async {
                                                      Get.back();
                                                      Get.dialog(
                                                        Center(
                                                          child: CircularProgressIndicator(),
                                                        ),
                                                        barrierDismissible: false,
                                                      );
                                                      bool deleted = await controller.leaveForum(fetchedForum.id);
                                                      if (deleted) {
                                                        Get.snackbar(
                                                            'Đã rời',
                                                            'Bạn đã rời khỏi forum, bạn sẽ không thể đăng bài hay tạo sự kiện',
                                                            backgroundColor: Colors.amberAccent
                                                        );
                                                        Get.toNamed(AppRoutes.pageFeedScreen);
                                                      } else {
                                                        Get.snackbar(
                                                            'Rời không thành công',
                                                            'Đã xảy ra lỗi khi rời forum.',
                                                            backgroundColor: Colors.deepOrange
                                                        );
                                                      }
                                                    },
                                                    child: Text('Có', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber),),
                                                  ),
                                                  cancel: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.all(26.adaptSize),
                                                    ),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('Không', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber),),
                                                  ),
                                                );
                                              },
                                                      child: Icon(Icons
                                                          .exit_to_app_rounded),
                                                    )
                                                    : GestureDetector(
                                                onTap: (){
                                                  Get.to(()=> PageAddForum(),
                                                    arguments: fetchedForum,
                                                    transition: Transition.rightToLeft
                                                  );
                                                }, child: Icon(Icons.edit_note_rounded))
                                                : RequestForumIcon(fetchedForum),
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
                                                    name: topic.name ?? 'topic',
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
                            length: profileId == fetchedForum.modId ? 5 : 3,
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
                                            Icon(Icons.event,
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
                                        if(profileId == fetchedForum.modId)
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
                                        if(profileId == fetchedForum.modId)
                                          Tab(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.people_rounded,
                                                      color: Colors.indigo),
                                                  SizedBox(width: 8.adaptSize),
                                                  Text('Thành viên chờ duyệt',
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
                                              controller.fetchMorePosts(forum!.id, listPost.value.length).then((newPosts) {
                                                listPost.value.addAll(newPosts);
                                              });
                                            }
                                            return true;
                                          },
                                          child: Obx(() {
                                            controller
                                                .loadForumPost(forum!.id)
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
                                                onRefresh: () async {
                                                  controller
                                                      .loadForumPost(fetchedForum.id)
                                                      .then((value) {
                                                    listPost.value = value;
                                                  });
                                                },
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
                                        if (members.isEmpty)
                                          Stack(
                                            fit: StackFit.expand,
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Center(
                                                  child: Text('Chưa có thành viên')),
                                              if(profileId == fetchedForum.modId)
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
                                                    icon: Icon(Icons.add_rounded),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        else
                                          Stack(
                                            fit: StackFit.expand,
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              NotificationListener<ScrollNotification>(
                                                onNotification: (scrollNotification) {
                                                  final metrics = scrollNotification.metrics;
                                                  if (metrics.atEdge) {
                                                    bool isTop = metrics.pixels == 0;
                                                    if (isTop == false) {
                                                      showAddButton.value = false;
                                                    } else showAddButton.value = true;
                                                  }
                                                  return true;
                                                },
                                                child: Obx(() {
                                                  // final users = RxList<User>(members);
                                                    return ListView.builder(
                                                      itemCount:
                                                      members.length,
                                                      itemBuilder: (context, index) {
                                                        final user =
                                                        members[index];
                                                        return ListTile(
                                                          leading: CustomImageView(
                                                            height: 36.adaptSize,
                                                            width: 36.adaptSize,
                                                            radius: BorderRadius.circular(
                                                                9.h),
                                                            fit: BoxFit.cover,
                                                            url: user.avatarUrl,
                                                          ),
                                                          title:
                                                              Text(user.fullName ?? ''),
                                                          trailing:
                                                          (profileId == fetchedForum.modId &&
                                                          profileId != user.id)
                                                            ? IconButton(
                                                              onPressed: () async {
                                                                onKickUser(user, fetchedForum.id);
                                                              },
                                                              icon: Icon(Icons.cancel))
                                                              : SizedBox.shrink(),
                                                          onTap: (){
                                                            final userProfile = Profile(
                                                                id: user.id!,
                                                                fullName: user.fullName!
                                                            );
                                                            Get.to(() => PageProfileScreen(userProfile),
                                                                transition: Transition.rightToLeft);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }
                                                ),
                                              ),
                                              if(profileId == fetchedForum.modId)
                                              Obx(() {
                                                if (showAddButton.isTrue)
                                                  return Positioned(
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
                                                          Get.to(() => PageAddMember(),
                                                              arguments: forum,
                                                            transition: Transition.rightToLeft
                                                          );
                                                        },
                                                        icon: Icon(Icons.add_rounded),
                                                      ),
                                                    ),
                                                  ).animate()
                                                    .shake()
                                                    .scaleXY(begin: 1.2, end: 1, duration: 50.ms, delay: 50.ms);
                                                else return SizedBox.shrink();
                                                }
                                              ),
                                            ],
                                          ),
                                        FutureBuilder<List<Event>>(
                                          future: controller
                                              .loadForumEvents(fetchedForum.id),
                                          builder: (context,snapshot) {
                                            if (snapshot.hasData) {
                                              listEvent.value = snapshot.data!;
                                              return NotificationListener<
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
                                                  if (listEvent.value.isEmpty) {
                                                    return Center(
                                                        child: fetchedForum
                                                            .yourStatus !=
                                                            'ACTIVE'
                                                            ? Text(
                                                            'Forum chưa có sự kiện')
                                                            : Text(
                                                            'Forum chưa có sự kiện '
                                                                '\n hãy tạo sự kiện để mọi người cùng tham gia',
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
                                                        listEvent.value.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          Event model =
                                                          listEvent.value[index];
                                                          return EventItemWidget(
                                                              model);
                                                        },
                                                      ),
                                                    );
                                                  }
                                                }),
                                              );
                                            }
                                            else return CustomProgressIndicator();
                                          }
                                        ),
                                        if(profileId == fetchedForum.modId)
                                          FutureBuilder<List<UserpostItemModel>>(
                                            future: controller
                                                .loadRequestPost(fetchedForum.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                listRequestPost.value = snapshot.data! ;
                                                return NotificationListener<
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
                                                    if (listRequestPost.isEmpty) {
                                                      return Center(
                                                          child: Text('Hiện chưa có bài viết chờ duyệt'));
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
                                                          listRequestPost.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            UserpostItemModel userpostItemModelObj =
                                                            listRequestPost[index];
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(vertical: 4.v),
                                                              decoration: AppDecoration.outlineGray,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 0),
                                                                    decoration: AppDecoration.fillOnErrorContainer,
                                                                    child: Row(
                                                                      children: [
                                                                        CustomImageView(
                                                                          url: userpostItemModelObj.userAvatar!.value,
                                                                          fit: BoxFit.cover,
                                                                          height: 20.adaptSize,
                                                                          width: 20.adaptSize,
                                                                          radius: BorderRadius.circular(
                                                                            10.h,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                            left: 4.h,
                                                                            top: 2.v,
                                                                          ),
                                                                          child: Text(
                                                                            userpostItemModelObj.userCreate!.value,
                                                                            style: CustomTextStyles.titleSmallRobotoBlack900,
                                                                          ),
                                                                        ),
                                                                        (userpostItemModelObj.forumModId == userpostItemModelObj.userCreateId)
                                                                            ? Container(
                                                                          margin: EdgeInsets.only(left: 4.adaptSize),
                                                                          padding: EdgeInsets.all(2.adaptSize),
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Colors.blue.shade100,),
                                                                          child: Icon(
                                                                              Icons
                                                                                  .admin_panel_settings_rounded,
                                                                              size: 12.adaptSize,
                                                                              color: Colors.blue.shade900),
                                                                        )
                                                                            : SizedBox.shrink(),
                                                                        Spacer(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Align(
                                                                      alignment: Alignment.centerRight,
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(right: 8.h),
                                                                        child: Text(
                                                                          (userpostItemModelObj.createdAt?.value != null
                                                                              ? formatTimeDifference(DateTime.now()
                                                                              .difference(userpostItemModelObj.createdAt!.value))
                                                                              : "0"),
                                                                          style: theme.textTheme.labelLarge,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {},
                                                                    child: Container(
                                                                      width: 354.h,
                                                                      padding: EdgeInsets.symmetric(
                                                                        horizontal: 6.h,
                                                                        vertical: 2.v,
                                                                      ),
                                                                      decoration: AppDecoration.fillOnErrorContainer,
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(right: 8.h),
                                                                        child: Html(
                                                                          data: userpostItemModelObj.postContent!.value,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // ignore: invalid_use_of_protected_member
                                                                  ImageSlider(userpostItemModelObj.listImages!.value),
                                                                  Align(
                                                                    alignment: Alignment.center,
                                                                    child: Container(
                                                                      height: 2.v,
                                                                      width: 9.h,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                      left: 14.h,
                                                                      top: 13.v,
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: [
                                                                        GestureDetector(
                                                                            child: Container(
                                                                              padding: EdgeInsets.all(12.adaptSize),
                                                                              child: Row(
                                                                                children: [
                                                                                  Icon(Icons.offline_pin_rounded,
                                                                                      color: Colors.green.shade400),
                                                                                  SizedBox(width: 4.adaptSize),
                                                                                  Text('Chấp nhận'.tr)
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            onTap: () async {
                                                                              await controller.acceptRequestPost(userpostItemModelObj);
                                                                              listRequestPost.removeAt(index);
                                                                            }),
                                                                        GestureDetector(
                                                                            child: Container(
                                                                              padding: EdgeInsets.all(12.adaptSize),
                                                                              child: Row(
                                                                                children: [
                                                                                  Icon(Icons.cancel_rounded,
                                                                                      color: Colors.red.shade900),
                                                                                  SizedBox(width: 4.adaptSize),
                                                                                  Text('Từ chối'.tr)
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            onTap: () async {
                                                                              await controller.rejectRequestPost(userpostItemModelObj);
                                                                              listRequestPost.removeAt(index);
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  }),
                                                );
                                              } else {
                                                return CustomProgressIndicator();
                                              }
                                            }
                                          ),
                                        if(profileId == fetchedForum.modId)
                                          FutureBuilder<List<Profile>>(
                                            future:  memberController
                                                .loadRequestUsers(forum!.id),
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData) {
                                                listRequestUser.value = snapshot.data!;
                                                return Obx((){
                                                  if (listRequestUser.isEmpty) {
                                                    return Center(
                                                        child: Text('Hiện chưa có thành viên chờ duyệt'));
                                                  } else
                                                    return ListView.builder(
                                                      itemCount:
                                                      listRequestUser.length,
                                                      itemBuilder: (context, index) {
                                                        final user = listRequestUser[index];
                                                        return ListTile(
                                                          leading: CustomImageView(
                                                            height: 36.adaptSize,
                                                            width: 36.adaptSize,
                                                            radius: BorderRadius.circular(
                                                                9.h),
                                                            fit: BoxFit.cover,
                                                            url: user.avatarUrl,
                                                          ),
                                                          title:
                                                          Text(user.fullName),
                                                          subtitle: Row(
                                                            children: [
                                                              GestureDetector(
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(12.adaptSize),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(Icons.offline_pin_rounded,
                                                                            color: Colors.green.shade400),
                                                                        SizedBox(width: 4.adaptSize),
                                                                        Text('Chấp nhận'.tr)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  onTap: () async {
                                                                    await memberController.acceptRequestMember(user, fetchedForum);
                                                                    final addedMember = User(
                                                                      id: user.id, fullName: user.fullName, avatarUrl: user.avatarUrl,
                                                                    );
                                                                    members.add(addedMember);
                                                                    listRequestUser.removeAt(index);

                                                                  }),
                                                              GestureDetector(
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(12.adaptSize),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(Icons.cancel_rounded,
                                                                            color: Colors.red.shade900),
                                                                        SizedBox(width: 4.adaptSize),
                                                                        Text('Từ chối'.tr)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  onTap: () async {
                                                                    await memberController.rejectRequestMember(user, fetchedForum);
                                                                    listRequestUser.removeAt(index);
                                                                  }),
                                                            ],
                                                          ),
                                                          onTap: (){
                                                            final userProfile = Profile(
                                                                id: user.id,
                                                                fullName: user.fullName);
                                                            Get.to(() => PageProfileScreen(userProfile),
                                                                transition: Transition.rightToLeft);
                                                          },
                                                        );
                                                      },
                                                    );
                                                });
                                              }else {
                                                return CustomProgressIndicator();
                                              }
                                            }
                                          )
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

  void onKickUser(User user, String forumId) {
    Get.defaultDialog(
      title: 'Xác nhận xóa '+user.fullName!,
      content: Text('Bạn có chắc chắn muốn xóa '+user.fullName!+' ra khỏi forum?'),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(30.adaptSize),
        ),
        onPressed: () async {
          Get.back();
          Get.dialog(
            Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );
          bool deleted = await controller.kickUser(user.id, forumId);
          if (deleted) {
            Get.back();
            Get.snackbar(
                'Xóa thành công',
                user.fullName!+' sẽ không thể đăng bài hay tạo sự kiện trong forum này',
                backgroundColor: Colors.amberAccent
            );
            members.removeWhere((member) => member.id == user.id);
          } else {
            Get.back();
            Get.snackbar(
                'Xóa không thành công',
                'Đã xảy ra lỗi khi xóa người dùng.',
                backgroundColor: Colors.deepOrange
            );
          }
        },
        child: Text('Có', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber),),
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(30.adaptSize),
        ),
        onPressed: () {
          Get.back();
        },
        child: Text('Không', style: TextStyle(fontSize: 20.adaptSize, color: Colors.amber),),
      ),
    );
  }
}
