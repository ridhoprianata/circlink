import 'package:circlink/services/auth.dart';
import 'package:circlink/views/register/register_screen.dart';
import 'package:circlink/widgets/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/base_text_field.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  // Local Variables
  String error = "";
  bool isLoading = false;

  // External Classes
  AuthMethods authMethods = AuthMethods();

  // Controllers
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  // Forms
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Processing
  logInProcess() {
    // TODO: remove automatic login
    emailTextEditingController.text = emailTextEditingController.text == ""
        ? "admin@gmail.com"
        : emailTextEditingController.text;
    passwordTextEditingController.text =
        passwordTextEditingController.text == ""
            ? "admin123"
            : passwordTextEditingController.text;
    if (_formKey.currentState!.validate()) {
      setState(
        () {
          isLoading = true;
        },
      );
      authMethods
          .logInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then(
        (value) {
          if (value == null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavbar(),
              ),
              (Route<dynamic> route) => false,
            );
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
    return Scaffold(
      //appBar: AppBar(title: Text("FormDemo")),
      body: SingleChildScrollView(
        child: Container(
          color: HexColor.fromHex("#23272A"),
          alignment: Alignment.center,
          width: double.infinity,
          height: screenSize.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenSize.height*0.25,
                  // decoration: BoxDecoration(
                  //   color: Colors.brown,
                  //   borderRadius: BorderRadius.all(Radius.circular(50))
                  // ),
                  child: Image.asset(
                    'Assets/logo.png',
                    height: screenSize.height * 0.3,
                  ),
                ),
                Text("Circlink", style: TextStyle(color: ThemeColor.textColorLight, fontSize: 40),),
                SizedBox(
                  height: 25,
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
                  text: "LOGIN",
                  textColor: Colors.white,
                  press: () {
                    logInProcess();
                  },
                ),
                Button(
                  text: "REGISTER",
                  textColor: Colors.white,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
