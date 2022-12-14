import 'package:circlink/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Components/live_chat_body.dart';

class LiveChatScreen extends StatefulWidget {
  final String id;
  final String email;

  const LiveChatScreen({
    Key? key,
    required this.id,
    required this.email,
  }) : super(key: key);

  @override
  _LiveChatScreenState createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  checkIfChatNotExists() async {
    var document = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.id)
        .get();
    if (document.exists == false) {
      databaseMethods.uploadChat(widget.id, widget.email);
    }
  }

  @override
  void initState() {
    super.initState();

    checkIfChatNotExists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.brown,
        title: Text(
          widget.email,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.yellow,
          child: LiveChatBody(id: widget.id),
        ),
      ),
    );
  }
}
