import 'package:flutter/material.dart';

class TextInputArea extends StatefulWidget {
  const TextInputArea(
      {Key key,
      this.controller,
      this.intialText,
      this.readOnly,
      this.maxlength})
      : super(key: key);

  final TextEditingController controller;
  final String intialText;
  final bool readOnly;
  final int maxlength;

  @override
  _TextInputAreaState createState() => _TextInputAreaState();
}

class _TextInputAreaState extends State<TextInputArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        maxLines: 7,
        maxLength: widget.maxlength,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            filled: true,
            fillColor: Colors.grey[300],
            hintText: widget.intialText,
            hintStyle: TextStyle(fontSize: 18)),
      ),
    );
  }
}
