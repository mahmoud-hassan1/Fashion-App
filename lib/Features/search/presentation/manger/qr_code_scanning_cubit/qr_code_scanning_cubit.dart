import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/features/search/domain/repo/search_repo.dart';

part 'qr_code_scanning_state.dart';

class QrCodeScanningCubit extends Cubit<QrCodeScanningState> {
  QrCodeScanningCubit(this.searchRepo) : super(ScanQrCodeInitial());

  final SearchRepo searchRepo;

  Future<String> scanQRCode() async {
    String qrREsult = '';

    try {
      emit(ScanQrCodeLoading());
      qrREsult = (await searchRepo.scanQRCode()).rawContent;
      emit(ScanQrCodeScaned());
    } catch (_) {
      emit(ScanQrCodeFailed());
    }
    return qrREsult;
  }
}
