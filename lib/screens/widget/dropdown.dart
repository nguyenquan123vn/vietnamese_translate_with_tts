import 'package:flutter/material.dart';
import 'package:flutter_xltn_api/global/voice_chooser.dart';

class VoiceDropdown extends StatefulWidget {
  VoiceDropdown({Key key, this.voice}) : super(key: key);
  final VoiceChooser voice;
  @override
  _VoiceDropdownState createState() => _VoiceDropdownState();
}

class _VoiceDropdownState extends State<VoiceDropdown> {
  String dropDownValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Please choose a voice'),
      value: dropDownValue,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      iconSize: 20,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 18),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          widget.voice.selectVoice(newValue);
          dropDownValue = widget.voice.selectedVoice;
        });
      },
      items: widget.voice.voiceOptions.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.key)))
          .toList(),
    );
  }
}
