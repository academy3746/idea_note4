import 'package:flutter/material.dart';
import 'package:idea_note4/constants/sizes.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    this.fieldHeight,
    this.verticalPadding,
    required this.hintText,
    this.maxLines,
    this.maxLength,
    this.action,
  });

  final TextEditingController controller;
  final double? fieldHeight;
  final double? verticalPadding;
  final String? hintText;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fieldHeight,
      margin: const EdgeInsets.only(top: Sizes.size10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPadding!,
            horizontal: Sizes.size12,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(Sizes.size10),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
        style: const TextStyle(
          fontSize: Sizes.size12,
          color: Colors.black,
        ),
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        textInputAction: action,
      ),
    );
  }
}
