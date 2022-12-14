import 'package:circlink/services/auth.dart';
import 'package:circlink/services/database.dart';
import 'package:circlink/views/login/login_screen.dart';
import 'package:circlink/widgets/bottom_navigation_bar.dart';
import 'package:circlink/widgets/globals.dart';
import 'package:flutter/material.dart';

import '../../widgets/base_text_field.dart';
import '../../widgets/button.dart';
import '../../widgets/color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

// GANTI JADI STATEFUL
class RegisterState extends State<RegisterScreen> {
  // Local Variables
  String error = "";
  late String fullNameValue;
  late String emailValue;
  late String passwordValue;
  bool isLoading = false;

  // Controllers
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Processing
  registerProcess() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        fullNameValue = fullNameTextEditingController.text;
        emailValue = emailTextEditingController.text;
        passwordValue = passwordTextEditingController.text;
      });
      var fullName = fullNameValue;
      var email = emailValue;
      var password = passwordValue;

      authMethods.registerWithEmailAndPassword(email, password).then(
        (value) {
          // error value masukin ke view
          if (value == null) {
            databaseMethods.uploadUserInfo(email, fullName);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BottomNavbar()));
          } else {
            setState(() {
              error = value;
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      //appBar: AppBar(title: Text("FormDemo")),
      child: Scaffold(
        appBar: AppBar(
          actions: [

          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.brown,
          title: Text(
            "Register",
            textAlign: TextAlign.center,
            style:TextStyle(color: Colors.white, fontSize: 32),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            color: HexColor.fromHex("#23272A"),
            width: double.infinity,
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 25,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  BaseTextField(
                    controller: fullNameTextEditingController,
                    hintText: "Full Name",
                    icon: Icons.account_box,
                    isPass: false,
                    onChanged: (value) {},
                  ),
                  BaseTextField(
                    controller: emailTextEditingController,
                    hintText: "Email",
                    icon: Icons.email,
                    isPass: false,
                    onChanged: (value) {},
                  ),
                  BaseTextField(
                    controller: passwordTextEditingController,
                    hintText: "Password",
                    icon: Icons.lock,
                    isPass: true,
                    onChanged: (value) {},
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  ),
                  Button(
                    text: "REGISTER",
                    textColor: Colors.white,
                    press: () {
                      registerProcess();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
