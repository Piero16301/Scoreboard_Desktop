import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:match_api/match_api.dart';
import 'package:match_repository/match_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._matchRepository) : super(const HomeState());

  final MatchRepository _matchRepository;

  Future<void> initialMatchesLoading() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final params = {
        'competitions': 'EC',
        'dateFrom': '2021-06-26',
        'dateTo': '2021-06-30',
      };
      final matches = await _matchRepository.getMatchesOfTheDay(params);
      emit(
        state.copyWith(
          status: HomeStatus.success,
          matches: matches,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> updateMatches() async {
    try {
      final params = {
        'competitions': 'EC',
        'dateFrom': '2021-06-26',
        'dateTo': '2021-06-30',
      };
      final matches = await _matchRepository.getMatchesOfTheDay(params);
      emit(
        state.copyWith(
          matches: matches,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

// Códigos de competiciones
// BSA -> Campeonato Brasileiro Série A
// ELC -> Championship
// PL  -> Premier League
// CL  -> UEFA Champions League
// EC  -> European Championship
// FL1 -> Ligue 1
// BL1 -> Bundesliga
// SA  -> Serie A
// DED -> Eredivisie
// PPL -> Primeira Liga
// CLI -> Copa Libertadores
// PD  -> Primera Division
// WC  -> FIFA World Cup
