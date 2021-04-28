import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'welcome_screen.dart';

var _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const route = '/chat';
  static const roomId = 'roomId';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _auth = FirebaseAuth.instance;
  var user;
  var message;
  var roomId;
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        user = currentUser;
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    roomId = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                try {
                  await _auth.signOut();
                  Get.to(WelcomeScreen());
                } catch (e) {
                  print(e);
                }
              }),
        ],
        title: Text('$roomId'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(currentUser: user, currentRoom: roomId),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection(roomId).add({
                        'text': message,
                        'userEmail': user.email,
                        'ts': FieldValue.serverTimestamp()
                      });
                      setState(() {
                        textController.clear();
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.fromMe});

  final String sender;
  final String text;
  final bool fromMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft:
                  fromMe ? Radius.circular(messageBubbleRadius) : Radius.zero,
              topRight:
                  fromMe ? Radius.zero : Radius.circular(messageBubbleRadius),
              bottomLeft: Radius.circular(messageBubbleRadius),
              bottomRight: Radius.circular(messageBubbleRadius),
            ),
            color: fromMe ? Colors.lightBlueAccent : Colors.white,
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 17.0,
                  color: fromMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  MessageStream({@required this.currentUser, @required this.currentRoom});

  final User currentUser;
  final String currentRoom;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(currentRoom).orderBy("ts").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Widget> messageWidgets = [];
        final messages = snapshot.data.docs.reversed;
        for (var message in messages) {
          final messageText = message.data()['text'];
          final senderEmail = message.data()['userEmail'];
          messageWidgets.add(
            MessageBubble(
              text: messageText,
              sender: senderEmail,
              fromMe: currentUser.email == senderEmail,
            ),
          );
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.all(5.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
