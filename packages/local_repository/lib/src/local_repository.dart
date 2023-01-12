import 'package:local_api/local_api.dart';

/// {@template local_repository}
/// Local repository connection
/// {@endtemplate}
class LocalRepository {
  /// {@macro local_repository}
  const LocalRepository({
    required ILocalApiRemote localApiRemote,
  }) : _apiRemote = localApiRemote;

  final ILocalApiRemote _apiRemote;

  /// Retorna si está activado el modo oscuro
  bool getDarkMode() {
    return _apiRemote.getDarkMode();
  }

  /// Activa o desactiva el modo oscuro
  Future<void> setDarkMode({bool value = false}) async {
    await _apiRemote.setDarkMode(value: value);
  }

  /// Obtiene la lista de ligas habilitadas
  List<String> getEnabledLeagues() {
    return _apiRemote.getEnabledLeagues();
  }

  /// Habilita o deshabilita una liga
  Future<void> setEnabledLeague({
    required String league,
    bool value = false,
  }) async {
    await _apiRemote.setEnabledLeague(league: league, value: value);
  }
}
