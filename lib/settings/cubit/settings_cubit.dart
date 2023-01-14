import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_repository/local_repository.dart';
import 'package:match_api/match_api.dart';
import 'package:match_repository/match_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.localRepository, this.matchRepository)
      : super(const SettingsState());

  final LocalRepository localRepository;
  final MatchRepository matchRepository;

  Future<void> loadAvailableLeagues() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      final leagues = await matchRepository.getAvailableLeagues();
      leagues.sort((a, b) => a.id.compareTo(b.id));

      final leaguesEnabled = <String, bool>{
        for (var league in leagues) league.code: false,
      };

      final localEnabledLeagues = localRepository.getEnabledLeagues();

      for (final league in localEnabledLeagues) {
        leaguesEnabled[league] = true;
      }

      emit(
        state.copyWith(
          status: SettingsStatus.success,
          leagues: leagues,
          leaguesEnabled: leaguesEnabled,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: SettingsStatus.failure));
    }
  }

  Future<void> saveLeague({
    required String leagueCode,
    required bool value,
  }) async {
    final leaguesEnabled = state.leaguesEnabled;
    leaguesEnabled[leagueCode] = value;
    emit(state.copyWith(leaguesEnabled: leaguesEnabled));

    await localRepository.setEnabledLeague(
      league: leagueCode,
      value: value,
    );
  }
}
