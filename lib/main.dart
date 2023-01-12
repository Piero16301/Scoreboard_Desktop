import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:local_api_remote/local_api_remote.dart';
import 'package:local_repository/local_repository.dart';
import 'package:match_api_remote/match_api_remote.dart';
import 'package:match_repository/match_repository.dart';
import 'package:scoreboard_desktop/app/app.dart';
import 'package:scoreboard_desktop/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  // Establecer propiedades de la ventana
  const windowOptions = WindowOptions(
    size: Size(400, 216),
    center: true,
    // backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
    minimumSize: Size(400, 216),
    skipTaskbar: true,
  );

  // Establecer posición de la ventana
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setAlignment(Alignment.bottomRight);
  });

  // Configuración de shared preferences
  final preferences = await SharedPreferences.getInstance();

  // Configuración del cliente http
  final httpClient = Dio(
    BaseOptions(
      baseUrl: 'https://api.football-data.org',
      headers: {
        'X-Auth-Token': '7fc3c7ecb0744a85b5cfe0c6e8e8dcd9',
      },
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ),
  );

  // Inicializar Local API
  final localApi = LocalApiRemote(preferences: preferences);
  final localRepository = LocalRepository(localApiRemote: localApi);

  // Inicializar Match API
  final matchApi = MatchApiRemote(httpClient: httpClient);
  final matchRepository = MatchRepository(matchApiRemote: matchApi);

  await bootstrap(
    () => AppPage(
      localRepository: localRepository,
      matchRepository: matchRepository,
    ),
  );
}
