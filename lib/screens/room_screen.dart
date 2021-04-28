import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texel_chat/widgets/input_text_field.dart';
import 'package:texel_chat/widgets/screen_button.dart';

import '../constants.dart';
import 'chat_screen.dart';

class RoomScreen extends StatefulWidget {
  static const route = '/room';

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  String roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: logoHeroTag,
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            InputTextField(
              hintText: 'Enter room ID',
              onChanged: (value) {
                roomId = value;
              },
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Builder(
                builder: (context) => ScreenButton(
                  color: Colors.blueAccent,
                  title: 'Join',
                  onPressed: () {
                    if (roomId.isEmpty) {
                      Get.snackbar(
                        'Room ID is empty',
                        'Please enter room ID',
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.toNamed(ChatScreen.route, arguments: roomId);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
