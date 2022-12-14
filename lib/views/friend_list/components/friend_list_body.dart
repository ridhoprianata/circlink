import 'package:cached_network_image/cached_network_image.dart';
import 'package:circlink/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendListBody extends StatefulWidget {
  const FriendListBody({Key? key}) : super(key: key);

  @override
  _FriendListBodyState createState() => _FriendListBodyState();
}

class _FriendListBodyState extends State<FriendListBody> {
  List<bool> isFriends = List.generate(100, (index) => true);
  var followedEmails = [];
  List<Map<String, dynamic>> userList = [];

  Future getRandomUsers() async {
    if (followedEmails.isEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(LoggedUser.currentUser.email)
          .get()
          .then((value) => {
                followedEmails = [
                  ...value['followed_emails'],
                ],
              });
      List<String> commonUsers = [];
      Map<String, dynamic> userMap;

      await FirebaseFirestore.instance
          .collection('users')
          .where('email', whereIn: followedEmails)
          .get()
          .then((value) => {
                value.docs.forEach(
                  (doc) => {
                    commonUsers = [],
                    for (var user in followedEmails)
                      {
                        if (doc['followed_emails'].contains(user) &&
                            user != LoggedUser.currentUser.email)
                          {
                            commonUsers = [
                              ...commonUsers,
                              user,
                            ],
                          },
                      },
                    userMap = {
                      'email': doc['email'],
                      'full_name': doc['full_name'],
                      'pic_id': doc['pic_id'],
                      'common_users_count': commonUsers.length,
                    },
                    userList = [...userList, userMap],
                  },
                ),
              });
    }

    return userList;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getRandomUsers(),
      builder: (BuildContext futureContext, AsyncSnapshot randomUserSnapshot) {
        if (!randomUserSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return CustomScrollView(
            shrinkWrap: false,
            primary: false,
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.50),
                              spreadRadius: 0,
                              blurRadius: 6,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: CachedNetworkImage(
                                    imageUrl: picLinks[randomUserSnapshot
                                        .data![index]['pic_id']],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: screenSize.height * 0.1,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      randomUserSnapshot.data![index]
                                          ['full_name'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          height: 1.2,
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          "${randomUserSnapshot.data![index]['common_users_count']}",
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: const Text(
                                          "in common",
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: isFriends[index] == false
                                            ? FlatButton(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40,
                                                        vertical: 20),
                                                color: Colors.purple,
                                                onPressed: () {
                                                  databaseMethods.addFriend(
                                                      randomUserSnapshot
                                                              .data![index]
                                                          ['email']);
                                                  setState(() {
                                                    isFriends[index] = true;
                                                  });
                                                },
                                                child: const Text(
                                                  "Connect",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : FlatButton(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40,
                                                        vertical: 20),
                                                color: Colors.red,
                                                onPressed: () {
                                                  databaseMethods.removeFriend(
                                                      randomUserSnapshot
                                                              .data![index]
                                                          ['email']);
                                                  setState(() {
                                                    isFriends[index] = false;
                                                  });
                                                },
                                                child: const Text(
                                                  "Disconnect",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: randomUserSnapshot.data!.length,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
