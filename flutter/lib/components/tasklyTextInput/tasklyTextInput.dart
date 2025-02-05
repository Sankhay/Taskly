import 'package:flutter/material.dart';

class TasklyTextInput extends StatefulWidget {
  final String hintText;
  final String errorText;
  final bool obscureText;
  final String fieldName;
  final TextEditingController controller;

  const TasklyTextInput({super.key, required this.hintText, required this.errorText, this.obscureText = false, this.fieldName = "", required this.controller});

  @override
  State<TasklyTextInput> createState() => _TasklyTextInputState();
}

class _TasklyTextInputState extends State<TasklyTextInput> {
  @override
  Widget build(BuildContext context) {
    return Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 50),
                width: MediaQuery.of(context).size.width * 0.96,
                child: TextFormField(
                      controller: widget.controller,
                      obscureText: widget.obscureText,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0)
                        )
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return widget.errorText;
                        }
                        return null;
                      }
                    ),
                ),
              );
  }
}