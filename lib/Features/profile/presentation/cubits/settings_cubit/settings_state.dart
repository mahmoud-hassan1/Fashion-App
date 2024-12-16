part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsSuccessed extends SettingsState {}

final class SettingsInvalidData extends SettingsState {}

final class SettingsFailed extends SettingsState {
  final String errorMessage;

  SettingsFailed({required this.errorMessage});
}
