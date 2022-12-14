import 'package:circlink/views/chat/chat_screen.dart';
import 'package:circlink/views/friend_search/friend_search_screen.dart';
import 'package:circlink/views/home/home_screen.dart';
import 'package:circlink/views/post/post_screen.dart';
import 'package:circlink/views/team/team.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  BottomNavbarState createState() => BottomNavbarState();
}

class BottomNavbarState extends State<BottomNavbar> {
  late List<Widget> _pages;
  late PageController _pageController;
  int _selectedPageIndex = 1;

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;

    _pages = [
      const HomeScreen(),
      const FriendSearchScreen(),
      const PostScreen(),
      const ChatScreen(),
      const TeamScreen(),
    ];
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: Icon(Icons.group_add_outlined),
            label: 'My Network',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: Icon(Icons.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: Icon(Icons.people),
            label: 'My Team',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedPageIndex,
        onTap: (selectedPageIndex) {
          setState(() {
            _selectedPageIndex = selectedPageIndex;
            _pageController.jumpToPage(selectedPageIndex);
          });
        },
      ),
    );
  }
}
