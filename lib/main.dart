import 'package:fluent_ui/fluent_ui.dart';
import 'package:scoreboard_desktop/app/app.dart';
import 'package:scoreboard_desktop/bootstrap.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(400, 215),
    center: true,
    // backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
    minimumSize: Size(400, 215),
    // skipTaskbar: true,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setAlignment(Alignment.bottomRight);
  });

  await bootstrap(() => const App());
}
