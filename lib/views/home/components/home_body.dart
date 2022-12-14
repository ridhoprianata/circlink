import 'package:circlink/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_item.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeBody> {
  // DONE
  updateLoggedUser() async {
    // Update current user info
    LoggedUser.currentUser = authMethods.getUser();
    LoggedUser.loginInfo =
        databaseMethods.getUserByEmail(LoggedUser.currentUser.email);
  }

  Future<List<String>> getFollowedEmails() async {
    List<String> followedEmails = [];
    await LoggedUser.loginInfo.then((value) =>
    {
      followedEmails = [
        value['email'],
        ...value['followed_emails'],
      ]
    });
    return followedEmails;
  }

  @override
  void initState() {
    super.initState();

    updateLoggedUser();
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
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('email', whereIn: followedSnapshot.data!)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot postsSnapshot) {
                if (!postsSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: postsSnapshot.data!.docs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return FutureBuilder(
                      future: getPicLink(
                        postsSnapshot.data!
                            .docs[postsSnapshot.data!.docs.length - index - 1]
                            .get('email'),
                      ),
                      builder: (BuildContext futureContext,
                          AsyncSnapshot pictureLinkSnapshot) {
                        if (!pictureLinkSnapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return HomeItem(
                              index: index,
                              length: postsSnapshot.data!.docs.length,
                              snapshot: postsSnapshot.data!.docs,
                              urlImage: pictureLinkSnapshot.data!.toString(),
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
