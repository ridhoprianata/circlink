import 'package:circlink/views/friend_search/components/friend_search_body.dart';
import 'package:circlink/widgets/burger_bar.dart';
import 'package:circlink/widgets/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendSearchScreen extends StatefulWidget {
  const FriendSearchScreen({Key? key}) : super(key: key);

  @override
  _FriendSearchScreenState createState() => _FriendSearchScreenState();
}

class _FriendSearchScreenState extends State<FriendSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          actions: const [],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.brown,
          title: const Text("My Network"),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          color: HexColor.fromHex("#23272A"),
          child: (const FriendSearchBody()),
        ),
      ),
    );
  }
}
