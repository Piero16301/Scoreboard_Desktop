import 'package:match_api/match_api.dart';

/// {@template match_repository}
/// Match repository connection
/// {@endtemplate}
class MatchRepository {
  /// {@macro match_repository}
  const MatchRepository({
    required IMatchApiRemote matchApiRemote,
  }) : _apiRemote = matchApiRemote;

  final IMatchApiRemote _apiRemote;

  /// Obtiene los partidos del día
  Future<List<Match>> getMatchesOfTheDay(Map<String, dynamic> params) async {
    return _apiRemote.getMatchesOfTheDay(params);
  }

  /// Obtiene las ligas disponibles en el plan
  Future<List<League>> getAvailableLeagues() async {
    return _apiRemote.getAvailableLeagues();
  }
}
