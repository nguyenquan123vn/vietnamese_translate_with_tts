import 'package:flutter/cupertino.dart';

class VoiceChooser extends ChangeNotifier {
  Map<String, String> _voiceOptions = {
    'Northern Vietnamese Male Voice': 'phamtienquan',
    'Northern Vietnamese Female Voice': 'doanngocle',
    'Southern Vietnamese Male Voice': 'hcm-minhquan',
    'Southern Vietnamese Female Voice': 'lethiyen',
    'Central Vietnamese Male Voice': 'hue-baoquoc',
    'Central Vietnamese Female Voice': 'hue-maingoc'
  };

  String _selectedVoice = 'Nam miền Bắc';
  String _selectedVoiceID = 'phamtienquan';

  Map<String, String> get voiceOptions => _voiceOptions;
  String get selectedVoice => _selectedVoice;
  String get selectedVoiceID => _selectedVoiceID;

  void selectVoice(String voice) {
    _selectedVoice = voice;
    _selectedVoiceID = _voiceOptions[voice];
    notifyListeners();
  }
}
