import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_repository/match_repository.dart';
import 'package:scoreboard_desktop/home/home.dart';
import 'package:scoreboard_desktop/l10n/l10n.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required MatchRepository matchRepository,
  }) : _matchRepository = matchRepository;

  final MatchRepository _matchRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _matchRepository),
      ],
      child: FluentApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
