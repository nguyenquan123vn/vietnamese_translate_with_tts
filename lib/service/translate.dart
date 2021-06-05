import 'package:translator/translator.dart';

class TranslateApi {
  final translator = GoogleTranslator();

  Future<String> translate(String input) async {
    var translationText = await translator.translate(input, to: 'vi');
    return translationText.text;
  }
}
