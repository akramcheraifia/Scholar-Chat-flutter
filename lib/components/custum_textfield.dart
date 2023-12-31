import 'package:flutter/material.dart';

class CustumTextField extends StatelessWidget {
  CustumTextField(
      {super.key, required this.hintText, this.onChanged, this.hide = false});
  String? hintText;
  Function(String)? onChanged;
  bool hide;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hide,
      validator: (data) {
        if (data!.isEmpty) {
          return "This field can't be empty";
        } else {
          return null;
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
