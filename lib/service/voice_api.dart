import 'dart:convert' as convert;
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class VoiceAPI {
  String url = 'https://viettelgroup.ai/voice/api/tts/v1/rest/syn';

  Future<Uint8List> getVoice(
      String voiceOption, String text, String speed) async {
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'token':
              'BfbuhY5qwCIp01PxM3hi7lcNiaUhNZZMR3Ot2IvscHPH9SvXi6JBVJAU8I1QRzH7'
        },
        body: convert.jsonEncode({
          'text': text,
          'voice': voiceOption,
          'id': '1',
          'without_filter': false,
          'speed': speed,
          'tts_return_options': '1'
        }));
    if (response.statusCode == 200) {
      print(voiceOption + '\n' + text + '\n' + speed);
      print(response.body);
      return response.bodyBytes;
    } else {
      return null;
    }
  }
}
