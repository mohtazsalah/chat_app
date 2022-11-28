import 'package:chat_app/constant/color_constants.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    required this.hint,
    required this.onChange,
    required this.obscure,
    required this.type
  }) : super(key: key);

  final String hint;
  final Function(String value) onChange;
  final bool obscure ;
  final TextInputType type ;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      obscureText: obscure,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: orangeColor ,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: blueColor ,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
