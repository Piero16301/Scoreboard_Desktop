// ignore_for_file: one_member_abstracts

import 'package:match_api/match_api.dart';

/// {@template match_api}
/// Match API connection
/// {@endtemplate}
abstract class IMatchApiRemote {
  /// Obtiene los partidos del día
  Future<List<Match>> getMatchesOfTheDay(Map<String, dynamic> params);
}
