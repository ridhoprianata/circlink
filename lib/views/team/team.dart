import 'package:circlink/views/team/widget_team.dart';
import 'package:circlink/widgets/burger_bar.dart';
import 'package:circlink/widgets/color.dart';
import 'package:flutter/material.dart';


class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final urlImage =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("My Team"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: HexColor.fromHex("#23272A"),
              child: Stack(
                children: [Container(
                  
                  width: screenSize.width,
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.04),
                      Container(

                      height: screenSize.height*0.17,
                        width: screenSize.height*0.17,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.35),
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(urlImage),
                        ),
                      ),
                    ),
                      const Text("Team",style: TextStyle(color: Colors.white, fontSize: 25),),
                  ]),
                ),
                  const Positioned(
                    bottom: 0,
                    left: 20,
                    child: Text("Member",style: TextStyle(color: Colors.white, fontSize: 20)),
                  )
              ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.brown,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TeamMemberScreen(teamName: "Idho",urlImage: urlImage,),
                    const SizedBox(height: 20),
                    TeamMemberScreen(teamName: "Idho",urlImage: urlImage,),
                    const SizedBox(height: 20),
                    TeamMemberScreen(teamName: "Idho",urlImage: urlImage,),
                    const SizedBox(height: 20),
                    TeamMemberScreen(teamName: "Idho",urlImage: urlImage,),
                    const SizedBox(height: 20),
                    TeamMemberScreen(teamName: "Idho",urlImage: urlImage,),
                    const SizedBox(height: 20),
                    TeamMemberScreen(teamName: "Idho",urlImage: urlImage,),
                  ],
                ),
              ),
            ),
          )
      ]),
    );
  }
}
