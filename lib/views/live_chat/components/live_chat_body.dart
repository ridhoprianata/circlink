import 'package:circlink/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class LiveChatBody extends StatefulWidget {
  final String id;

  const LiveChatBody({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _LiveChatBodyState createState() => _LiveChatBodyState();
}

class _LiveChatBodyState extends State<LiveChatBody> {
  TextEditingController messageTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  late String message;

  addPostProcess() {
    message = messageTextEditingController.text;
    databaseMethods.uploadMessage(message, widget.id);
    messageTextEditingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .doc(widget.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              return ListView.builder(
                itemCount: snapshot.data!['messages'].length,
                itemBuilder: (context, index) => MessageBubble(
                  message: snapshot.data!['messages'][index]['message'],
                  sentByMe: snapshot.data!['messages'][index]['sender_email'] ==
                          LoggedUser.currentUser.email
                      ? true
                      : false,
                ),
              );
            },
          ),
        ),
        Container(
          //color: Colors.purple,
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: messageTextEditingController,
                        decoration: const InputDecoration(
                          hintText: "Message ...",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    addPostProcess();
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(5),
                    primary: Colors.blue, // <-- Button color
                    onPrimary: Colors.blue, // <-- Splash color
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
