import 'package:bkforum/data/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:bkforum/core/app_export.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../../controller/page_profile_controller.dart';
import '../../widgets/custom_elevated_button.dart';
enum Gender { MALE, FEMALE }
// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget{

  final profile = Get.arguments as Profile?;
  final _formKey = GlobalKey<FormState>();



  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  Rx<File> selectedImage = Rx<File>(File(''));
  String gender = '';

  @override
  Widget build(BuildContext context) {
   Rx<Gender>? gen = profile?.gender == 'FEMALE' ? Gender.FEMALE.obs : Gender.MALE.obs;
   nameController.text = profile?.fullName ?? '';
   dateOfBirthController.text = DateFormat('dd-MM-yyyy').format(profile?.dateOfBirth ?? DateTime.now());
   emailController.text = profile?.email ?? '';
   addressController.text = profile?.address ?? '';
   phoneNumberController.text = profile?.phoneNumber ?? '';
   final PageProfileController controller = Get.put(PageProfileController(profile!));

   return SafeArea(
     child: Scaffold(
       resizeToAvoidBottomInset: false,
       appBar: AppBar(
         leading: IconButton(
           onPressed: () {
             Get.back();
           },
           icon: Icon(Icons.arrow_back_ios_new_rounded),
         ),
         title: Text('Chỉnh sửa thông tin cá nhân'),
       ),
       body: Container(
         padding: EdgeInsets.all(16.0),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               Container(
                 height: 70.adaptSize,
                 width: 70.adaptSize,
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
                     if (profile?.avatarUrl != null &&
                         selectedImage.value.path == '') {
                       return CustomImageView(
                         url: profile?.avatarUrl!,
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
               SizedBox(height: 10.adaptSize),
               Container(
                 margin: EdgeInsets.only(bottom: 14.adaptSize),
                 child: TextFormField(
                   controller: nameController,
                   decoration: InputDecoration(
                     labelText: 'Họ và tên',
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(
                             Radius.circular(10.adaptSize))),
                     contentPadding: EdgeInsets.symmetric(
                         horizontal: 10.adaptSize, vertical: 10.adaptSize),
                   ),
                   validator: (value) {
                     if (value!.isEmpty) {
                       return 'Vui lòng nhập họ và tên';
                     }
                     return null;
                   },
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(bottom: 14.adaptSize),
                 child: TextFormField(
                   controller: dateOfBirthController,
                   decoration: InputDecoration(
                     labelText: 'Ngày sinh (dd-MM-yyyy)',
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(
                             Radius.circular(10.adaptSize))),
                     contentPadding: EdgeInsets.symmetric(
                         horizontal: 10.adaptSize, vertical: 10.adaptSize),
                   ),
                 ),
               ),
               Container(margin: EdgeInsets.only(bottom: 14.adaptSize),
                 child: TextFormField(
                   enabled: false,
                   controller: emailController,
                   decoration: InputDecoration(
                     labelText: 'Email',
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(
                             Radius.circular(10.adaptSize))),
                     contentPadding: EdgeInsets.symmetric(
                         horizontal: 10.adaptSize, vertical: 10.adaptSize),
                   ),
                 ),
               ),
               Container(margin: EdgeInsets.only(bottom: 14.adaptSize),
                 child: TextFormField(
                   controller: addressController,
                   decoration: InputDecoration(
                     labelText: 'Địa chỉ',
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(
                             Radius.circular(10.adaptSize))),
                     contentPadding: EdgeInsets.symmetric(
                         horizontal: 10.adaptSize, vertical: 10.adaptSize),
                   ),
                 ),
               ),
               Container(margin: EdgeInsets.only(bottom: 14.adaptSize),
                 child: TextFormField(
                   controller: phoneNumberController,
                   decoration: InputDecoration(
                     labelText: 'Số điện thoại',
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(
                             Radius.circular(10.adaptSize))),
                     contentPadding: EdgeInsets.symmetric(
                         horizontal: 10.adaptSize, vertical: 10.adaptSize),
                   ),
                 ),
               ),
               SizedBox(height: 14.adaptSize),
               Obx(() {
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         padding: EdgeInsets.only(left: 10.adaptSize),
                         child: Text('Giới tính',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.adaptSize,
                            fontFamily: 'Helvetica',
                            color: Colors.grey.shade700
                          ),
                         ),
                       ),
                       ListTile(
                         visualDensity: VisualDensity.compact,
                         title: Text('Nam'),
                         leading: Radio<Gender>(
                           value: Gender.MALE,
                           groupValue: gen.value,
                           toggleable: true,
                           onChanged: (Gender? value) {
                               gender = value.toString();
                               gen.value = value!;
                           },
                         ),
                       ),
                       ListTile(
                         visualDensity: VisualDensity.compact,
                         title: Text('Nữ'),
                         leading: Radio<Gender>(
                           value: Gender.FEMALE,
                           groupValue: gen.value,
                           toggleable: true,
                           onChanged: (value) {
                               gender = value.toString();
                               gen.value = value!;
                           },
                         ),
                       ),
                     ],
                   );
                 }
               ),
               Expanded(
                   child: CustomImageView(
                     url: 'https://res.cloudinary.com/dy7he6gby/image/upload/v1703859936/y0yzsfm1hhyjgjxs7qpl.png',
                   )
               ),
               ElevatedButton(
                 onPressed: () {
                   if (_formKey.currentState!.validate()) {
                     final editedProfile = Profile(
                       id: profile!.id,
                       fullName: nameController.text.trim(),
                       dateOfBirth: DateFormat('dd-MM-yyyy').parse(dateOfBirthController.text),
                       address: addressController.text.trim(),
                       phoneNumber: phoneNumberController.text.trim(),
                       gender: gender == 'Gender.FEMALE' ? 'FEMALE' : 'MALE',
                       avatarUrl: profile?.avatarUrl
                     );
                     controller.editProfile(editedProfile, selectedImage.value);
                   }
                 },
                 child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 60.adaptSize, vertical: 20.adaptSize),
                     child: Text('Lưu thông tin',
                       style: TextStyle(
                         color: Colors.yellow,
                         fontSize: 20.adaptSize,
                         fontWeight: FontWeight.w700,
                         fontFamily: 'Helvetica'
                       ),
                     )),
               ),
             ],
           ),
         ),
       ),
     ),
   );
  }

}