import 'package:circlink/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'choose_chat_item.dart';

class ChooseChatBody extends StatefulWidget {
  const ChooseChatBody({
    Key? key,
  }) : super(key: key);

  @override
  _ChatBodyAppState createState() => _ChatBodyAppState();
}

class _ChatBodyAppState extends State<ChooseChatBody> {
  Future<List<String>> getFollowedEmails() async {
    List<String> followedEmails = [];
    await LoggedUser.loginInfo.then((value) => {
          followedEmails = [...value['followed_emails']],
        });
    return followedEmails;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: FutureBuilder(
        future: getFollowedEmails(),
        builder:
            (BuildContext followedContext, AsyncSnapshot followedSnapshot) {
          if (!followedSnapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if(followedSnapshot.data!.length == 0) {
              return Text("It seems like you haven't added any friends. Go to My Network menu to find some");
            }
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('email', whereIn: followedSnapshot.data!)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return FutureBuilder(
                      future:
                          getPicLink(snapshot.data!.docs[index].get('email')),
                      builder: (BuildContext futureContext,
                          AsyncSnapshot futureSnapshot) {
                        if (!futureSnapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ChooseChatItem(
                            name: snapshot.data!.docs[index].get('full_name'),
                            email: snapshot.data!.docs[index].get('email'),
                            urlImage: futureSnapshot.data!.toString(),
                          );
                        }
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
