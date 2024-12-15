part of 'speech_to_text_cubit.dart';

@immutable
sealed class SpeechToTextState {}

final class SpeechToTextInitial extends SpeechToTextState {}

final class SpeechToTextLoading extends SpeechToTextState {}

final class SpeechToTextSuccess extends SpeechToTextState {}

final class SpeechToTextRecognized extends SpeechToTextState {
  final String text;

  SpeechToTextRecognized(this.text);
}

final class SpeechToTextFailed extends SpeechToTextState {}
