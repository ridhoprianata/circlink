import 'package:circlink/views/live_chat/live_chat_screen.dart';
import 'package:circlink/widgets/color.dart';
import 'package:circlink/widgets/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatefulWidget {
  final int index;
  final int length;
  final dynamic snapshot;
  final String urlImage;

  const ChatItem({
    Key? key,
    required this.index,
    required this.length,
    required this.snapshot,
    required this.urlImage,
  }) : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  String fullName = "";

  getFullName() async {
    await databaseMethods
        .getUserByEmail(
            getOtherUser(widget.snapshot[widget.index].get('users')))
        .then(
          (value) => setState(() => fullName = value!['full_name']),
        );
  }

  @override
  void initState() {
    super.initState();

    getFullName();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    int index = widget.index;

    if (index < 0 || index >= widget.length) {
      return const Text("Error: Chat not found");
    }

    var snapshot = widget.snapshot[index];
    String email = getOtherUser(snapshot.get('users'));
    List<dynamic> messages = snapshot.get('messages');
    int messagesLength = messages.length;
    int lastMessageIndex = messagesLength - 1;
    String lastMessage =
        (lastMessageIndex < 0 || messages[lastMessageIndex]['message'] == null)
            ? ""
            : messages[lastMessageIndex]['message'];
    String lastMessageDate = lastMessage == ""
        ? ""
        : DateFormat('MM/dd/yyyy, hh:mm a')
            .format(messages[lastMessageIndex]['date'].toDate());

    return fullName.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LiveChatScreen(
                      id: snapshot.get('id'), email: email),
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
                          backgroundImage: NetworkImage(widget.urlImage)),
                      SizedBox(
                        height: screenSize.height * 0.02,
                        width: screenSize.height * 0.02,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  fullName,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " ($email)",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white,),
                                ),
                              ],
                            ),
                            Text(
                              lastMessage,
                              textAlign: TextAlign.start,
                              style:  TextStyle(color: Colors.white,),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  lastMessageDate,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
