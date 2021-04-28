import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../widgets/screen_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const route = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.forward();

    _controller.addListener(() {
      // setState(() {});
    });

    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: logoHeroTag,
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: _animation.value * 60,
                    ),
                  ),
                ),
                SizedBox(width: 20.0,),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 300),
                  repeatForever: true,
                  text: ['Chat'],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ScreenButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Get.to(LoginScreen());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ScreenButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  Get.to(RegistrationScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
