import 'package:circlink/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_item.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({
    Key? key,
  }) : super(key: key);

  @override
  _ChatBodyAppState createState() => _ChatBodyAppState();
}

class _ChatBodyAppState extends State<ChatBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: LoggedUser.currentUser.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot chatsSnapshot) {
          if (!chatsSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: chatsSnapshot.data!.docs.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext buildContext, int index) {
              return FutureBuilder(
                future: getPicLink(getOtherUser(chatsSnapshot.data.docs![index].get('users'))),
                builder:
                    (BuildContext futureContext, AsyncSnapshot pictureLinkSnapshot) {
                  if (!pictureLinkSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ChatItem(
                      index: index,
                      length: chatsSnapshot.data!.docs.length,
                      snapshot: chatsSnapshot.data!.docs,
                      urlImage: pictureLinkSnapshot.data!.toString(),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
