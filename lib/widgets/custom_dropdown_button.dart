import 'package:bkforum/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/apiClient/profile_api.dart';
import '../data/models/profile_model.dart';
import 'package:bkforum/data/models/data_prop/forum.dart';
import '../data/apiClient/forum_list_api.dart';
import '../presentation/page_forumone_screen/page_forumone_screen.dart';
import '../controller/page_post_controller.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({
    Key? key,
    this.dropdownColor,
    this.padding,
    this.style,
    this.focusColor,
    this.borderRadius,
    this.hint,
    this.onForumSelected,
  }) : super(
          key: key,
        );
  final Color? dropdownColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Color? focusColor;
  final BorderRadius? borderRadius;
  final Widget? hint;
  final ForumCallback? onForumSelected;

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  List<Forum> forums = [];
  String dropdownValue = '';

  @override
  void initState() {
    // print('object');
    fetchData();
    super.initState();
  }

  void fetchData() async {
    try {
      Profile? fetchedProfile = await ProfileApi().fetchProfile('');
      ForumListApiClient().fetchForums(fetchedProfile.id).then((fetchedForums) {
        setState(() {
          forums = fetchedForums.isNotEmpty ? fetchedForums : <Forum>[];
          if (forums.isNotEmpty) {}
        });
      }).catchError((error) {
        print('Error fetching forums: $error');
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
      future: ProfileApi().fetchProfile(''),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var fetchedProfile = snapshot.data!;
          return FutureBuilder<List<Forum>>(
            future: ForumListApiClient().fetchForums(fetchedProfile.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                forums = snapshot.data!;
                return Container(
                  child: DropdownButton<String>(
                    value:
                        dropdownValue.isNotEmpty ? dropdownValue : forums.first.name,
                    icon: const Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    elevation: 8,
                    style: CustomTextStyles.titleSmallBlack900,
                    dropdownColor: widget.dropdownColor,
                    padding: EdgeInsets.fromLTRB(3.h, 2.v, 3.h, 2.v),
                    focusColor: CupertinoColors.opaqueSeparator,
                    borderRadius: BorderRadiusStyle.circleBorder20,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                        int selectedIndex = forums.indexOf(forums
                            .firstWhere((forum) => forum.name == dropdownValue));
                        var selectedPostForum =
                            Get.find<PagePostController>().selectedPostForum;
                        selectedPostForum.value = forums[selectedIndex];
                      });
                    },
                    items: forums.map<DropdownMenuItem<String>>((Forum forum) {
                      return DropdownMenuItem<String>(
                        value: forum.name,
                        child: Text(forum.name),
                      );
                    }).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Text('Error: ${snapshot.error}');
              } else {
                return Container();
              }
            },
          );
        }
        else {
          return Container();
        }
      }
    );
  }
}
