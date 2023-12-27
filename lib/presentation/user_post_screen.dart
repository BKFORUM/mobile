import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/data/models/userpost_item_model.dart';
import 'package:bkforum/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';

import '../data/apiClient/userpost_item_api.dart';
import '../widgets/userpost_item_widget.dart';

class UserPostScreen extends StatelessWidget {
  UserPostScreen({
    Key? key,
  }) : super(key: key);
  final UserPostScreenController controller = Get.put(UserPostScreenController());
  final postId = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () => Get.back(),
              ),
              title: Text("Bài viết")
            ),
            body:
            Container(
              child: FutureBuilder<UserpostItemModel>(
                future: controller.getPostById(postId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final userPostObj = snapshot.data;
                    if(userPostObj?.status?.value == 'ACTIVE'){
                      return SingleChildScrollView(
                        child: Column(
                            children: [
                              UserpostItemWidget(userPostObj!),
                              // Expanded(child: CustomCommentScreen(userPostObj.id!.value, 'posts')),
                            ]),
                      );
                    } else return Center(
                      child: Text(
                        'Bài viết không tồn tại'
                      ),
                    );
                  }
                }
              ))));
  }
}

class UserPostScreenController extends GetxController {

  Future<UserpostItemModel> getPostById(String id) async {
    final userPostObj = await PostItemApiClient().fetchPostById(id);
    return Future.value(userPostObj);
  }
}