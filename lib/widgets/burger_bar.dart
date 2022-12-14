import 'package:circlink/views/friend_list/friend_list_screen.dart';
import 'package:circlink/views/login/login_screen.dart';
import 'package:circlink/views/user/user_page.dart';
import 'package:circlink/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(LoggedUser.currentUser.email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot userSnapshot) {
        if (!userSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return FutureBuilder(
          future: getPicLink(userSnapshot.data!.get('email')),
          builder:
              (BuildContext futureContext, AsyncSnapshot pictureLinkSnapshot) {
            if (!pictureLinkSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Drawer(
                child: Material(
                  color: Colors.brown,
                  child: ListView(
                    children: <Widget>[
                      buildHeader(
                        urlImage: pictureLinkSnapshot.data!.toString(),
                        name: userSnapshot.data!.get('full_name'),
                        email: userSnapshot.data!.get('email'),
                        onClicked: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserPage(),
                        )),
                      ),
                      Container(
                        padding: padding,
                        child: Column(
                          children: [
                            buildMenuItem(
                              text: 'Home',
                              icon: Icons.favorite_border,
                              onClicked: () => selectedItem(context, 0),
                            ),
                            const SizedBox(height: 16),
                            buildMenuItem(
                              text: 'Friend List',
                              icon: Icons.group,
                              onClicked: () => selectedItem(context, 2),
                            ),
                            const SizedBox(height: 16),
                            buildMenuItem(
                              text: 'Logout',
                              icon: Icons.favorite_border,
                              onClicked: () => selectedItem(context, 1),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget buildHeader({
    required String urlImage,
    String? name,
    String? email,
    VoidCallback? onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(urlImage),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name!,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email!,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    String? text,
    IconData? icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text!, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavbar()),
            (Route<dynamic> route) => false);
        break;
      case 1:
        authMethods.logOut();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false);
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FriendListScreen()),
        );

        break;
    }
  }
}
