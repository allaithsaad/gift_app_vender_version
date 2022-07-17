import 'package:flutter/material.dart';

class InputFileds extends StatelessWidget {
  final TextEditingController controller;
  final String feildName;
  final TextInputAction textInputAction;
  final int maxline;
  final bool autofocus;
  final TextInputType textInputType;
  InputFileds(this.feildName, this.controller, this.maxline,
      this.textInputAction, this.autofocus, this.textInputType);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          textInputAction: textInputAction,
          autofocus: autofocus,
          keyboardType: textInputType,
          controller: controller,
          maxLines: maxline,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: feildName,
          ),
        ),
      ),
    );
  }
}
