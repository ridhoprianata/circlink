import 'package:flutter/material.dart';

import 'text_field_container.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final bool isPass;
  final bool? isUsername;

  const BaseTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.icon,
    this.onChanged,
    this.isPass = false,
    this.isUsername = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          buildInputField(),
        ],
      ),
    );
  }

  Widget buildInputField() {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: isPass,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.amber),
          hintText: hintText,
          border: InputBorder.none,
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Required";
          }
          if (hintText == "Password") {
            if (value.length < 6) {
              return "Password cannot be less than 6";
            }
          } else if (hintText == "Username") {
            if (value.length < 6) {
              return "Username cannot be less than 6";
            }
          }
          return null;
        },
      ),
    );
  }
}
