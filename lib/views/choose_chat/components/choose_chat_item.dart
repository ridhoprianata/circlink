import 'package:circlink/views/live_chat/live_chat_screen.dart';
import 'package:circlink/widgets/color.dart';
import 'package:circlink/widgets/globals.dart';
import 'package:flutter/material.dart';

class ChooseChatItem extends StatefulWidget {
  final String email;
  final String name;
  final String urlImage;

  const ChooseChatItem({
    Key? key,
    required this.name,
    required this.email,
    required this.urlImage,
  }) : super(key: key);

  @override
  _ChooseChatItemState createState() => _ChooseChatItemState();
}

class _ChooseChatItemState extends State<ChooseChatItem> {
  Future<String> getChatId() async {
    String? email;
    await LoggedUser.loginInfo.then((value) => {
          email = value['email'],
        });

    String id = widget.email.toLowerCase().compareTo(email!.toLowerCase()) < 0
        ? "${widget.email}|$email"
        : "$email|${widget.email}";

    return id;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FutureBuilder(
              future: getChatId(),
              builder:
                  (BuildContext futureContext, AsyncSnapshot futureSnapshot) {
                if (!futureSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return LiveChatScreen(
                    id: futureSnapshot.data!.toString(),
                    email: widget.email,
                  );
                }
              },
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.urlImage),
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                  width: screenSize.height * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      widget.name,
                      textAlign: TextAlign.start,
                      style:
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " (${widget.email})",
                      textAlign: TextAlign.start,
                      style:
                      const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
