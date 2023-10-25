import '../../../core/app_export.dart';

/// This class is used in the [userpost_item_widget] screen.
class UserpostItemModel {
  UserpostItemModel({
    this.lpsinhhot20tclc,
    this.postContent,
    this.id,
  }) {
    lpsinhhot20tclc = lpsinhhot20tclc ?? Rx("Lớp sinh hoạt 20TCLC-DT4");
    postContent = postContent ??
        Rx("KHÔNG KHÍ NGÀY NHẬP HỌC NGÀY THỨ 2 CỦA TÂN SINH VIÊN K23\nSáng ngày 26/8, hàng nghìn tân sinh viên DUT đã tiến hành hoàn tất các thủ tục nhập học. Dù thời tiết chưa thật thuận lợi, K23 vẫn hoà mình với không khí sôi động của loạt sự kiện chào mừng tân sinh viên trong khuôn viên Nhà trường.\nMột hành trình mới bắt đầu, chúc K23 sẽ có nhiều kỷ niệm khó quên trong 5 năm sắp tới.");
    id = id ?? Rx("");
  }

  Rx<String>? lpsinhhot20tclc;

  Rx<String>? postContent;

  Rx<String>? id;
}
