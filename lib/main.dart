import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/room_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TexelChat());
}

class TexelChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: WelcomeScreen.route,
      getPages: [
        GetPage(name: WelcomeScreen.route, page: () => WelcomeScreen()),
        GetPage(
            name: RegistrationScreen.route, page: () => RegistrationScreen()),
        GetPage(name: LoginScreen.route, page: () => LoginScreen()),
        GetPage(name: ChatScreen.route, page: () => ChatScreen()),
        GetPage(name: RoomScreen.route, page: () => RoomScreen()),
      ],
    );
  }
}
