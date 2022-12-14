import 'package:circlink/widgets/save_button.dart';
import 'package:circlink/widgets/color.dart';
import 'package:circlink/widgets/globals.dart';
import 'package:flutter/material.dart';



class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String email = "";
  String fullName = "";
  String picLink = "";

  getName() async {
    await databaseMethods.getUserByEmail(LoggedUser.currentUser.email).then(
          (value) => setState(
            () => {
              email = value!['email'],
              fullName = value['full_name'],
              picLink = picLinks[value['pic_id']],
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    getName();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: HexColor.fromHex("#171a21"),
        centerTitle: true,
      ),
      body: email.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: HexColor.fromHex("#1b2838"),
                    child: Stack(
                      children: [
                        Container(
                          width: screenSize.width,

                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: screenSize.height * 0.04),
                                Container(
                                  height: screenSize.height * 0.17,
                                  width: screenSize.height * 0.17,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blueAccent.withOpacity(0.4),
                                        spreadRadius: 3,
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(picLink),
                                    ),
                                  ),
                                ),

                                Text(
                                  fullName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,

                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "ABOUT\n",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Set your profile name and details. Providing additional "
                                        "information like your real name can help friends find you "
                                        "on the Circlink Community\n\n"
                                        "Your profile name and avatar represent you throughout Circlink, and "
                                        "must be appropriate for all audiences.\n",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "GENERAL",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.blueGrey,
                                  thickness: 3,
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "\nProfile Name",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                                // Container(

                                //   height: 100,
                                //   padding: const EdgeInsets.all(10),
                                //   child: Row(
                                //
                                //     children: [
                                //       Expanded(
                                //         flex:7,
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius: const BorderRadius.all(
                                //                 Radius.circular(10)),
                                //             border: Border.all(
                                //                 width: 1, color: Colors.black),
                                //           ),
                                //         ),
                                //       ),
                                //       Expanded(
                                //         flex:1,
                                //         child: Container(
                                //
                                //         ),
                                //       ),
                                //       Expanded(
                                //         flex:7,
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius: const BorderRadius.all(
                                //                 Radius.circular(10)),
                                //             border: Border.all(
                                //               width: 1,
                                //               color: Colors.black,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                Container(
                                  height: 65,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(

                                          decoration: BoxDecoration(
                                            color: HexColor.fromHex("#171a21"),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                          ),
                                          child: TextFormField(

                                            style: TextStyle(color: Colors.white),
                                            // controller: titleTextEditingController,
                                            decoration: const InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Real Name",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                                Container(
                                  height: 65,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor.fromHex("#171a21"),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                          ),
                                          child: TextFormField(

                                            style: TextStyle(color: Colors.white),
                                            // controller: titleTextEditingController,
                                            decoration: const InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "\nLOCATION",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.blueGrey,
                                  thickness: 3,
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "\nCountry",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                                Container(
                                  height: 65,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor.fromHex("#171a21"),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                          ),
                                          child: TextFormField(

                                            style: TextStyle(color: Colors.white),
                                            // controller: titleTextEditingController,
                                            decoration: const InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "\nSUMMARY",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.blueGrey,
                                  thickness: 3,
                                ),
                                Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor.fromHex("#171a21"),                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                          ),
                                          child: TextFormField(

                                            style: TextStyle(color: Colors.white),
                                            // controller: titleTextEditingController,
                                            decoration: const InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                            ),
                                            maxLines: 5,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                saveButton(

                                  text: "Save",
                                  textColor: Colors.white,
                                  press: () async {
                                  //   if (contentTextEditingController.text == "" ||
                                  //       contentTextEditingController.text == null ||
                                  //       titleTextEditingController.text == "" ||
                                  //       titleTextEditingController.text == null) {
                                  //     showPop("Input can't be null!", context);
                                  //     return;
                                  //   }
                                  //   await addPostProcess();
                                  //   showPop("Post added!", context);
                                  //   contentTextEditingController.text = "";
                                  //   titleTextEditingController.text = "";
                                  },

                                  // SizedBox(
                                  //
                                  // )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
