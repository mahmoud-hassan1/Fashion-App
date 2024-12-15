import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

abstract class SpeechToTextRepo {
  late final SpeechToText speechToText;

  Future<void> init();
  Future<void> startListening(final void Function(SpeechRecognitionResult result) onResult);
  Future<void> stopListening();
}
