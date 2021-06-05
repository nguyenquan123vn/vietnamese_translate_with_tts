import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_xltn_api/service/translate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_xltn_api/global/voice_chooser.dart';
import 'package:flutter_xltn_api/screens/widget/dropdown.dart';
import 'package:flutter_xltn_api/screens/widget/text_input.dart';
import 'package:flutter_xltn_api/service/voice_api.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double value = 0.0;

  String convertValue(double value1) {
    double convert = 1.0 + value1 / 10;
    return convert.toString();
  }

  @override
  Widget build(BuildContext context) {
    VoiceChooser voiceChooser = context.read<VoiceChooser>();
    TextEditingController textControl = TextEditingController();
    TextEditingController translateTextControl = TextEditingController();
    VoiceAPI voiceApi = VoiceAPI();
    TranslateApi translateApi = TranslateApi();
    AudioPlayer audio = AudioPlayer();

    return Scaffold(
        appBar: AppBar(
          title: Text('Vietnamese Translator TTS'),
        ),
        body: ListView(
          padding: EdgeInsets.all(15),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Input text: ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            TextInputArea(
              controller: textControl,
              intialText: "Tap to enter text",
              readOnly: false,
              maxlength: 200,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Translate text: ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            TextInputArea(
              controller: translateTextControl,
              intialText: "Vietnamese Translation",
              readOnly: true,
              maxlength: 300,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                  onPressed: () async {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      // I am connected to a mobile network.
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('No internet connection found!!'),
                                content: Text(
                                    'No internet connection found, please check your internet connection!!'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'))
                                ],
                              ));
                    } else {
                      if (textControl.text != '') {
                        translateTextControl.text =
                            await translateApi.translate(textControl.text);
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('No text found!!'),
                                  content: Text(
                                      'Please input text in the text field and press translate to start!'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'))
                                  ],
                                ));
                      }
                    }
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Translate'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.translate_rounded,
                          size: 20,
                        )
                      ])),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: VoiceDropdown(
                  voice: voiceChooser,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('Speed: ', style: TextStyle(fontSize: 18.0)),
                        Slider(
                          value: value,
                          min: -3.0,
                          max: 3.0,
                          divisions: 6,
                          label: value.toString(),
                          onChanged: (double newValue) {
                            setState(() {
                              value = newValue;
                            });
                          },
                        )
                      ]),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Speak'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.volume_up_outlined,
                        size: 20,
                      )
                    ]),
                onPressed: () async {
                  if (translateTextControl.text != '') {
                    Uint8List data = await voiceApi.getVoice(
                        voiceChooser.selectedVoiceID,
                        translateTextControl.text,
                        convertValue(value));

                    await audio.playBytes(data);
                    textControl.clear();
                    translateTextControl.clear();
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('No translate text found!!'),
                              content: Text(
                                  'Please translate your text first before using this function!'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'))
                              ],
                            ));
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              ),
            ),
          ],
        ));
  }
}
