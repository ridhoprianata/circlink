import 'package:circlink/widgets/button.dart';
import 'package:circlink/widgets/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  _PostBodyState createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  late String title;
  late String content;

  addPostProcess() {
    title = titleTextEditingController.text;
    content = contentTextEditingController.text;
    databaseMethods.uploadPost(title, content);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: screenSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: titleTextEditingController,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Title",
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: contentTextEditingController,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Description",
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              Button(
                text: "Submit",
                textColor: Colors.white,
                press: () async {
                  if (contentTextEditingController.text == "" ||
                      contentTextEditingController.text == null ||
                      titleTextEditingController.text == "" ||
                      titleTextEditingController.text == null) {
                    showPop("Input can't be null!", context);
                    return;
                  }
                  await addPostProcess();
                  showPop("Post added!", context);
                  contentTextEditingController.text = "";
                  titleTextEditingController.text = "";
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPop(String label, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    //  We can return any object from here
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                      elevation: 1,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.circular((30.0))),
                    ),
                  ),
                ],
              ),
              elevation: 12.0,
            ));
    setState(() {});
  }
}
