part of 'settings_cubit.dart';

enum SettingsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == SettingsStatus.initial;
  bool get isLoading => this == SettingsStatus.loading;
  bool get isSuccess => this == SettingsStatus.success;
  bool get isFailure => this == SettingsStatus.failure;
}

class SettingsState extends Equatable {
  const SettingsState({
    this.status = SettingsStatus.initial,
    this.leagues = const <League>[],
    this.leaguesEnabled = const <String, bool>{},
  });

  final SettingsStatus status;
  final List<League> leagues;
  final Map<String, bool> leaguesEnabled;

  SettingsState copyWith({
    SettingsStatus? status,
    List<League>? leagues,
    Map<String, bool>? leaguesEnabled,
  }) {
    return SettingsState(
      status: status ?? this.status,
      leagues: leagues ?? this.leagues,
      leaguesEnabled: leaguesEnabled ?? this.leaguesEnabled,
    );
  }

  @override
  List<Object?> get props => [
        status,
        leagues,
        leaguesEnabled,
      ];
}
