import 'package:online_shopping/Features/search/domain/repo/speech_to_text_repo.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextRepoImpl implements SpeechToTextRepo {
  @override
  SpeechToText speechToText = SpeechToText();

  @override
  Future<void> init() async {
    await speechToText.initialize();
  }

  @override
  Future<void> startListening(void Function(SpeechRecognitionResult result) onResult) async {
    await speechToText.listen(onResult: onResult);
  }

  @override
  Future<void> stopListening() async {
    await speechToText.stop();
  }
}
