import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/models/user.dart';
import 'package:task_journal_mobile/services/auth_service.dart';
import 'package:task_journal_mobile/services/user_service.dart';
import 'package:task_journal_mobile/utils/theme.dart';
import 'package:task_journal_mobile/widgets/drawer.dart';
import 'package:task_journal_mobile/widgets/snackbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ super.key });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String pickedFile = 'Pick a file';
  Uint8List? imageBytes;
  User? user;
  bool editMode = false;

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
    if(result != null) {
      setState(() {
        pickedFile = result.files.first.name;
      });
    }
  }

  void toggleEditMode() {
    setState(() {
      editMode = !editMode;
    });
  }

  void logout() async {

    var confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if(confirm == null || confirm == false) return;

    final result = await Provider.of<AuthService>(context, listen: false).logout();
    
    if(!context.mounted) return;

    if(result) {
      Navigator.pushNamedAndRemoveUntil( 
        context,
        '/login',
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget.error('Error logging out'));
    }
  }

  void getIcon() async {
    final bytes = await Provider.of<UserService>(context, listen: false).getIcon();
    setState(() {
      imageBytes = bytes;
    });
  }

  void getUser() async {
    final userResult = await Provider.of<UserService>(context, listen: false).getUser();
    setState(() {
      user = userResult;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getIcon();
  }

  @override
  Widget build(BuildContext context) {
    if(user != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        drawer: const NavigationDrawerWidget(),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(kStandardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (imageBytes != null) ...[
                    CircleAvatar(
                      radius: kProfileIconRadius,
                      backgroundImage: MemoryImage(imageBytes!),
                    ),
                    const SizedBox(
                      height: kExtraSmallSpacingBoxSize,
                      width: kExtraSmallSpacingBoxSize,
                    ),
                  ],
                  if (imageBytes == null) ...[
                    CircleAvatar(
                      radius: kProfileIconRadius,
                      backgroundColor: Colors.grey.shade400,
                      child: const Icon(Icons.person, size: kAlternativeProfileIconSize),
                    ),
                    const SizedBox(
                      height: kExtraSmallSpacingBoxSize,
                      width: kExtraSmallSpacingBoxSize,
                    ),
                  ],
                  SizedBox(
                    width: kMediumInputWidth,
                    child: Text(user!.username, style: cardTextStyle,)
                  ),
                  const SizedBox(
                    height: kExtraSmallSpacingBoxSize,
                    width: kExtraSmallSpacingBoxSize,
                  ),
                  SizedBox(
                    width: kMediumInputWidth,
                    child: Text(user!.email, style: cardTextStyle,)
                  ),
                  const SizedBox(
                    height: kExtraSmallSpacingBoxSize,
                    width: kExtraSmallSpacingBoxSize,
                  ),
                  SizedBox(
                    width: kMediumInputWidth,
                    child: Text('Joined at: ${DateFormat('dd. MMM yyyy').format(user!.createdAt)}', style: cardTextStyle),
                  ),
                  const SizedBox(
                    height: kExtraSmallSpacingBoxSize,
                    width: kExtraSmallSpacingBoxSize,
                  ),
                  SizedBox(
                    width: kMediumInputWidth,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: toggleEditMode, 
                            child: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(
                          height: kSmallSpacingBoxSize,
                          width: kSmallSpacingBoxSize,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: logout, 
                            child: const Text('Log out'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        drawer: const NavigationDrawerWidget(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}