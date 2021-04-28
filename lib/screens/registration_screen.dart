import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texel_chat/widgets/input_text_field.dart';
import 'package:texel_chat/widgets/screen_button.dart';

import '../constants.dart';
import 'room_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const route = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              hintText: 'Enter your email',
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            InputTextField(
              hintText: 'Enter your password',
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
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
                        color: Colors.blueAccent,
                        title: 'Register',
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await _auth.createUserWithEmailAndPassword(
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
