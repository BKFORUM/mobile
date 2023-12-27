import 'package:bkforum/data/models/profile_model.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:bkforum/core/app_export.dart';

import '../../controller/page_forumone_controller.dart';
import '../../data/apiClient/forum_list_api.dart';
import '../../data/models/data_prop/forum.dart';

class PageAddMember extends StatelessWidget {
  PageAddMember({Key? key}) : super(key: key);

  final MemberController controller = MemberController();
  final forum = Get.arguments as Forum?;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Get.back(),
          ),
          title: Text("Thêm thành viên")),
      body: Column(
        children: [
          Obx(() {
            return Container(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Column(
                children: [
                  Container(
                    height: 80.adaptSize,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.addedUsers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              CustomImageView(
                                height: 64.adaptSize,
                                width: 64.adaptSize,
                                fit: BoxFit.cover,
                                url: controller.addedUsers[index].avatarUrl ??
                                    'http://res.cloudinary.com/dy7he6gby/image/upload/v1702796805/a70tpruabwfzoq819luj.jpg',
                                radius: BorderRadius.circular(32),
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
                                        controller.addedUsers.removeAt(index);
                                      }))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(12.adaptSize),
                            child: Row(
                              children: [
                                Icon(Icons.cancel_rounded,
                                    color: Colors.red.shade400),
                                SizedBox(width: 4.adaptSize),
                                Text('Xóa tất cả'.tr)
                              ],
                            ),
                          ),
                          onTap: () {
                            controller.addedUsers.clear();
                          }),
                      GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(12.adaptSize),
                            child: Row(
                              children: [
                                Icon(Icons.add_reaction_rounded,
                                    color: Colors.blue.shade900),
                                SizedBox(width: 4.adaptSize),
                                Text('Thêm thành viên'.tr)
                              ],
                            ),
                          ),
                          onTap: () {
                            final addedUsers = controller.addedUsers;
                            controller.addUsersToForum(addedUsers, forum!);
                          }),
                    ],
                  )
                ],
              ),
            );
          }),
          Expanded(
            child: FutureBuilder<List<Profile>>(
                future: ForumListApiClient().searchNotInUsers(forum!.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data;
                    return ListView.builder(
                      itemCount: users?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CustomImageView(
                            height: 48.adaptSize,
                            width: 48.adaptSize,
                            fit: BoxFit.cover,
                            url: users?[index].avatarUrl ??
                                'http://res.cloudinary.com/dy7he6gby/image/upload/v1702796805/a70tpruabwfzoq819luj.jpg',
                            radius: BorderRadius.circular(24),
                          ),
                          title: Text(users?[index].fullName ?? ''),
                          subtitle: Text(users?[index].email ?? ''),
                          onTap: () {
                            if(!controller.addedUsers.contains(users![index]))
                            controller.addedUsers.add(users[index]);
                          },
                        );
                      },
                    );
                  } else {
                    return CustomProgressIndicator();
                  }
                }),
          )
        ],
      ),
    ));
  }
}
