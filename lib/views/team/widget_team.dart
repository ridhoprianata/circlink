import 'package:flutter/material.dart';


class TeamMemberScreen extends StatefulWidget {
  final String teamName;
  final String urlImage;
  const TeamMemberScreen({Key? key, required this.teamName, required this.urlImage}) : super(key: key);
  @override
  _TeamMemberScreenState createState() => _TeamMemberScreenState();
}

class _TeamMemberScreenState extends State<TeamMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex:2,child: CircleAvatar(radius: 25, backgroundImage: NetworkImage(widget.urlImage))),
        Expanded(flex:1,child: Container()),
        Expanded(flex:6,child: Text(widget.teamName, style: const TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left,)),
        Expanded(flex:2,child: CircleAvatar(radius: 25, backgroundImage: NetworkImage(widget.urlImage))),
        Expanded(flex:2,child: CircleAvatar(radius: 25, backgroundImage: NetworkImage(widget.urlImage))),
      ],
    );
  }
}
