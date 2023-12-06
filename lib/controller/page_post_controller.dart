import 'package:bkforum/core/app_export.dart';
import 'package:bkforum/presentation/page_post_screen/models/page_post_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bkforum/data/models/data_prop/forum.dart';

import '../core/utils/conpress_image.dart';
import '../data/apiClient/upload_image.dart';
import '../data/apiClient/upload_post_api.dart';
import '../data/models/data_prop/document.dart';
import '../data/models/upload_post_model.dart';
import '../presentation/page_post_screen/page_post_screen.dart';

/// A controller class for the PagePostScreen.
///
/// This class manages the state of the PagePostScreen, including the
/// current pagePostModelObj
class PagePostController extends GetxController {
  // TextEditingController forumpostoneController = TextEditingController();

  var selectedPostForum =
      Forum(id: 'default id', name: '', modName: 'Unknown').obs;
  Forum get getSelectedForum => selectedPostForum.value;

  Rx<PagePostModel> pagePostModelObj = PagePostModel().obs;

  Future<void> uploadPost(
      BuildContext context, String forumId, String content) async {
    List<PostDocument> documents = [];

    if (content.trim().isNotEmpty) {
      if (selectedImages.value.isNotEmpty) {
        for (final File selectedImage in selectedImages.value) {

          final compressedItem = await testCompressAndGetFile(selectedImage, "compressed_");
          PostDocument document = await uploadImage(compressedItem);
          documents.add(document);
        }

        for (final PostDocument document in documents) {
          print('fileUrl: ${document.fileUrl}');
          print('fileName: ${document.fileName}');
        }
      }
      var postUpload = UploadPostModel(
          forumId: forumId,
          content: '<p>' + content + '</p>',
          document: documents);
      // print(postUpload.document?[0].fileUrl);
      statusCode = await uploadPostAPI(postUpload);

      if (statusCode == 201) {
        postUpload.reset();
        Get.snackbar('Đăng bài thành công', '',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.amberAccent);
      } else {
        Get.snackbar('Đăng bài không thành công $statusCode', '',
            duration: Duration(seconds: 2), backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar('Đăng bài không thành công, vui lòng nhập nội dung', '',
          duration: Duration(seconds: 2), backgroundColor: Colors.red);
    }
  }

  Future<void> editPost(BuildContext context, Rx<String>? id, String content,
      RxList allImages) async {
    List<PostDocument> documents = [];
    if (content.trim().isNotEmpty) {
      if (allImages.isNotEmpty) {
        for (final item in allImages) {
          if (item is File) {
            final compressedItem = await testCompressAndGetFile(item, "compressed_");
            PostDocument document = await uploadImage(compressedItem);
            documents.add(document);
          } if (item is PostDocument){
            documents.add(item);
          } else{
            continue;
          }
        }

        for (final PostDocument document in documents) {
          print('fileUrl: ${document.fileUrl}');
          print('fileName: ${document.fileName}');
        }
      }
      var postEdit = UploadPostModel(
          content: '<p>' + content + '</p>',
          document: documents
      );
      statusCode = await editPostAPI(postEdit, id);

      if (statusCode == 204) {
        postEdit.reset();
        Get.snackbar('Chỉnh sửa thành công', '',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.amberAccent);
      } else {
        Get.snackbar('Chỉnh sửa không thành công $statusCode', '',
            duration: Duration(seconds: 2), backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar('Chỉnh sửa không thành công, vui lòng nhập nội dung', '',
          duration: Duration(seconds: 2), backgroundColor: Colors.red);
    }
  }


}
