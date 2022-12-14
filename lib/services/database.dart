import 'dart:math';

import 'package:circlink/widgets/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseMethods {
  Future<Map<String, dynamic>?> getUserByEmail(String? email) async {
    DocumentSnapshot<Map<String, dynamic>>? user;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((value) => {
              user = value,
            });
    return user!.data();
  }


  getPosts(List<dynamic> followedEmails) async {
    followedEmails.add(LoggedUser.loginInfo.docs[0].get('email'));
    var posts = await FirebaseFirestore.instance
        .collection('posts')
        .where('email', whereIn: followedEmails)
        .orderBy('title', descending: true)
        .get();
    return posts;
  }

  uploadUserInfo(String email, String fullName) {
    // users
    // |-email
    // |-full_name
    // |-followed_emails
    // '-pic_id

    var rand = Random();
    List<String> followedEmails = [];
    int picId = rand.nextInt(picLinks.length);


    Map<String, dynamic> userMap = {
      'email': email,
      'full_name': fullName,
      'followed_emails': followedEmails,
      'pic_id': picId,
    };

    var newUser = FirebaseFirestore.instance.collection('users').doc(email);
    newUser.set(userMap);
  }

  addFriend(String email) async {
    var friend = FirebaseFirestore.instance.collection('users').doc(LoggedUser.currentUser.email);

    bool found = true;
    await friend.get().then((value) => {
      found = value['followed_emails'].contains(email),
    });

    if (!found) {
      friend.update(
        {
          'followed_emails': FieldValue.arrayUnion([email])
        },
      );
    }
  }

  removeFriend(String email) async {
    var friend = FirebaseFirestore.instance.collection('users').doc(LoggedUser.currentUser.email);

    bool found = true;
    await friend.get().then((value) => {
      found = value['followed_emails'].contains(email),
    });

    if (found) {
      friend.update(
        {
          'followed_emails': FieldValue.arrayRemove([email])
        },
      );
    }
  }

  uploadPost(String title, String content) async {
    // posts
    // |-id
    // |-email
    // |-full_name
    // |-title
    // |-content
    // |-likes
    // '-date
    String email = "";
    String fullName = "";
    List<String> likes = [];
    DateTime date = Timestamp.now().toDate();
    DateFormat formatter = DateFormat('yyyy-MM-dd kk:mm:ss:S');

    await LoggedUser.loginInfo.then((value) => {
          email = value['email'],
          fullName = value['full_name'],
        });

    Map<String, dynamic> postMap = {
      'email': email,
      'full_name': fullName,
      'title': title,
      'content': content,
      'likes': likes,
      'date': date,
    };

    String id = "${formatter.format(date)}-$email";
    var newPost = FirebaseFirestore.instance.collection('posts').doc(id);
    postMap['id'] = newPost.id;
    newPost.set(postMap);
  }

  removePost(String id) async {
    var post = FirebaseFirestore.instance.collection('posts').doc(id);
    post.delete();
  }

  uploadChat(String id, String email) async {
    // chats
    // |-id
    // |-name
    // |-users
    // '-messages
    List<dynamic> messages = [];
    List<String> users = [];

    await LoggedUser.loginInfo.then((value) => {
          users = [value['email'], email],
        });

    Map<String, dynamic> chatMap = {
      'users': users,
      'messages': messages,
      'id': id,
    };

    var newChat = FirebaseFirestore.instance.collection('chats').doc(id);
    newChat.set(chatMap);
  }

  uploadMessage(String message, String chatId) async {
    // chats
    // |-messages
    //   |-id
    //   |-sender_email
    //   |-sender_name
    //   |-message
    //   '-date
    String email = "";
    String fullName = "";
    DateTime date = Timestamp.now().toDate();

    await LoggedUser.loginInfo.then((value) => {
          email = value['email'],
          fullName = value['full_name'],
        });

    Map<String, dynamic> messageMap = {
      'sender_email': email,
      'sender_name': fullName,
      'message': message,
      'date': date,
    };

    var newMessage = FirebaseFirestore.instance.collection('chats').doc(chatId);
    messageMap['id'] = newMessage.id;
    newMessage.update(
      {
        'messages': FieldValue.arrayUnion([messageMap])
      },
    );
  }



  customUploadPost(
      String email, String fullName, String title, String content) {
    Map<String, dynamic> postMap = {
      'title': title,
      'content': content,
      'likes': [],
    };

    var newPost = FirebaseFirestore.instance.collection('posts').doc();
    postMap['id'] = newPost.id;
    postMap['full_name'] = fullName == ""
        ? LoggedUser.loginInfo.docs[0].get('full_name')
        : fullName;
    postMap['email'] =
        email == "" ? LoggedUser.loginInfo.docs[0].get('email') : email;
    postMap['date'] = Timestamp.now().toDate();
    newPost.set(postMap);
  }

  // init postingan
  postInit() {
    customUploadPost("admin@gmail.com", "Admin", "Admin's first post",
        "First step to Mythical Glory");
    customUploadPost("admin@gmail.com", "Admin", "Admin's second post",
        "Mythical Glory is a lie");
    customUploadPost(
        "hitungan123@gmail.com", "Alim", "Alim ngepost", "Skuyy push bareng");
    customUploadPost("handika.limanto@binus.ac.id", "Handika Limanto", "Bunno",
        "Bunnos with guns");
    customUploadPost("hitungan123@gmail.com", "Alim", "Alim nyanyi",
        "Karena kusuka, suka dirimu");
  }
// notes
// chats = val.docs[0].get("firestore_doc_name");
}
