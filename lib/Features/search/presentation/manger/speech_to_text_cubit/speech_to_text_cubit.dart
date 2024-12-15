import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/search/domain/repo/speech_to_text_repo.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

part 'speech_to_text_state.dart';

class SpeechToTextCubit extends Cubit<SpeechToTextState> {
  SpeechToTextCubit(this.speechToTextRepo) : super(SpeechToTextInitial());

  final SpeechToTextRepo speechToTextRepo;

  Future<void> init() async {
    try {
      await speechToTextRepo.init();
    } catch (_) {}
  }

  Future<void> startListening(final void Function(SpeechRecognitionResult result) onResult) async {
    try {
      emit(SpeechToTextLoading());
      await speechToTextRepo.startListening(onResult);
      emit(SpeechToTextSuccess());
    } catch (_) {
      emit(SpeechToTextFailed());
    }
  }

  Future<void> stopListening() async {
    try {
      emit(SpeechToTextLoading());
      await speechToTextRepo.stopListening();
      emit(SpeechToTextSuccess());
    } catch (_) {
      emit(SpeechToTextFailed());
    }
  }

  bool get isListening => speechToTextRepo.speechToText.isListening;
}
