part of 'qr_code_scanning_cubit.dart';

@immutable
sealed class QrCodeScanningState {}

final class ScanQrCodeInitial extends QrCodeScanningState {}

final class ScanQrCodeLoading extends QrCodeScanningState {}

final class ScanQrCodeScaned extends QrCodeScanningState {}

final class ScanQrCodeFailed extends QrCodeScanningState {}
