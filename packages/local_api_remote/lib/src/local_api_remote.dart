import 'package:local_api/local_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_api_remote}
/// Local API remote connection
/// {@endtemplate}
class LocalApiRemote implements ILocalApiRemote {
  /// {@macro local_api_remote}
  LocalApiRemote({
    required SharedPreferences preferences,
  }) : _preferences = preferences {
    _init();
  }

  final SharedPreferences _preferences;

  void _init() {
    if (_preferences.getBool('darkMode') == null) {
      _preferences.setBool('darkMode', false);
    }
    if (_preferences.getStringList('enabledLeagues') == null) {
      _preferences.setStringList('enabledLeagues', <String>[]);
    }
  }

  @override
  bool getDarkMode() {
    return _preferences.getBool('darkMode')!;
  }

  @override
  Future<void> setDarkMode({bool value = false}) async {
    await _preferences.setBool('darkMode', value);
  }

  @override
  List<String> getEnabledLeagues() {
    return _preferences.getStringList('enabledLeagues')!;
  }

  @override
  Future<void> setEnabledLeague({
    required String league,
    bool value = false,
  }) async {
    final enabledLeagues = _preferences.getStringList('enabledLeagues')!;
    if (value) {
      if (!enabledLeagues.contains(league)) {
        enabledLeagues.add(league);
      }
    } else {
      enabledLeagues.remove(league);
    }
    await _preferences.setStringList('enabledLeagues', enabledLeagues);
  }
}
