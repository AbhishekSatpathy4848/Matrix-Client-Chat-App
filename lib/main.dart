import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:matrix_chat_app/features/chat/pages/chat_home_page.dart';
import 'package:matrix_chat_app/features/login_registration/pages/login_home.dart';
import 'package:matrix_chat_app/features/login_registration/pages/sign_in_page.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/page_1.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/page_1.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = Client(
    'Matrix Example Chat',
    databaseBuilder: (_) async {
      final dir = await getApplicationSupportDirectory();
      final db = HiveCollectionsDatabase('matrix_example_chat', dir.path);
      await db.open();
      return db;
    },
  );
  await client.init();
  final profile = await client.getUserProfile(client.userID!);
  profile.avatarUrl;
  profile.displayname;

  runApp(MaterialApp(
      title: 'Matrix Example Chat',
      builder: (context, child) => Provider<Client>(
            create: (context) => client,
            child: child,
          ),
      home: client.isLogged()
          ? ChatHomePage(
              client: client,
              profile: ProfileInformation(
                  displayname: profile.displayname,
                  avatarUrl: profile.avatarUrl))
          : const Login()));
}
