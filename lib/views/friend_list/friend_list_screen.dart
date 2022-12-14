import 'package:circlink/views/friend_list/components/friend_list_body.dart';
import 'package:circlink/widgets/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({Key? key}) : super(key: key);

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.brown,
          title: const Text("Friend List"),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          color: HexColor.fromHex("#23272A"),
          child: (const FriendListBody()),
        ),
      ),
    );
  }
}
