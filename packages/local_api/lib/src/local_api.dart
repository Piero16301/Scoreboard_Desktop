/// {@template local_api}
/// Local API connection
/// {@endtemplate}
abstract class ILocalApiRemote {
  /// Retorna si está activado el modo oscuro
  bool getDarkMode();

  /// Activa o desactiva el modo oscuro
  Future<void> setDarkMode({bool value});

  /// Obtiene la lista de ligas habilitadas
  List<String> getEnabledLeagues();

  /// Habilita o deshabilita una liga
  Future<void> setEnabledLeague({required String league, bool value = false});
}
