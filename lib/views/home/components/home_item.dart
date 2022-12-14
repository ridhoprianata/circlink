import 'package:circlink/widgets/globals.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatefulWidget {
  final int index;
  final int length;
  final dynamic snapshot;
  final String urlImage;

  const HomeItem({
    Key? key,
    required this.index,
    required this.length,
    required this.snapshot,
    required this.urlImage,
  }) : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var mediumSpacing = screenSize.width * 0.03;
    var smallSpacing = screenSize.width * 0.02;

    int index = widget.length - widget.index - 1;

    if (index < 0 || index >= widget.length) {
      return const Text("Error: Post not found");
    }

    var snapshot = widget.snapshot[index];
    String fullName = snapshot.get('full_name');
    String email = snapshot.get('email');
    String title = snapshot.get('title');
    String content = snapshot.get('content');
    String id = snapshot.get('id');

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      margin: widget.index == 0
          ? EdgeInsets.only(
              top: mediumSpacing,
              left: mediumSpacing,
              right: mediumSpacing,
              bottom: mediumSpacing,
            )
          : EdgeInsets.only(
              left: mediumSpacing,
              right: mediumSpacing,
              bottom: mediumSpacing,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 25, backgroundImage: NetworkImage(widget.urlImage)),
              SizedBox(height: smallSpacing, width: smallSpacing),
              Text(fullName),
            ],
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(
                    top: smallSpacing,
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(content),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => print("like"),
                  icon: Icon(
                    Icons.thumb_up_alt_rounded,
                    color: Colors.blue,
                    size: 30,
                  )),
              // IconButton(
              //     onPressed: () => print("comment"),
              //     icon: Icon(
              //       Icons.comment,
              //       color: Colors.blue,
              //       size: 30,
              //     )),
              // IconButton(
              //     onPressed: () => print("share"),
              //     icon: Icon(
              //       Icons.share,
              //       color: Colors.blue,
              //       size: 30,
              //     )),
              if (LoggedUser.currentUser.email == email)
                IconButton(
                  onPressed: () => {
                    databaseMethods
                        .removePost(id)
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
