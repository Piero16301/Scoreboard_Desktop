import 'package:fluent_ui/fluent_ui.dart';
import 'package:scoreboard_desktop/home/home.dart';
import 'package:scoreboard_desktop/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
