import 'package:circlink/widgets/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/choose_chat_body.dart';

class ChooseChat extends StatelessWidget {
  const ChooseChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        title: const Text("Choose Chat"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Container(color: HexColor.fromHex("#23272A"), child: const ChooseChatBody()),
    );
  }
}
