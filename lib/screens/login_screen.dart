import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:texel_chat/widgets/input_text_field.dart';
import 'package:texel_chat/widgets/screen_button.dart';

import '../constants.dart';
import 'room_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

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
                inputType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                hintText: 'Enter your email'),
            SizedBox(
              height: 8.0,
            ),
            InputTextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              hintText: 'Enter your password',
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Builder(
                builder: (context) => _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ScreenButton(
                        title: 'Log In',
                        color: Colors.lightBlueAccent,
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            Get.to(RoomScreen());
                          } catch (e) {
                            print(e);
                            Get.snackbar(
                              'Error',
                              e.toString(),
                              backgroundColor: Colors.black87,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
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
