import 'package:circlink/views/choose_chat/choose_chat_screen.dart';
import 'package:circlink/widgets/burger_bar.dart';
import 'package:circlink/widgets/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/chat_body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Chat"),
        backgroundColor: Colors.brown,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add Chat",
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChooseChat(),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        color: HexColor.fromHex("#23272A"),
        child: const ChatBody(),
      ),
    );
  }
}
