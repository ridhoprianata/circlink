import 'package:circlink/widgets/burger_bar.dart';
import 'package:circlink/widgets/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/post_body.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Post"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Container(color: HexColor.fromHex("#23272A"), child: const PostBody()),
    );
  }
}
