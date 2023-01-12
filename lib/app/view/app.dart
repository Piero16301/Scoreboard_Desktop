import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_repository/local_repository.dart';
import 'package:match_repository/match_repository.dart';
import 'package:scoreboard_desktop/app/app.dart';
import 'package:scoreboard_desktop/l10n/l10n.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required LocalRepository localRepository,
    required MatchRepository matchRepository,
  })  : _localRepository = localRepository,
        _matchRepository = matchRepository;

  final LocalRepository _localRepository;
  final MatchRepository _matchRepository;

  @override
  Widget build(BuildContext context) {
    final router = goRouter();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _matchRepository),
        RepositoryProvider.value(value: _localRepository),
      ],
      child: FluentApp.router(
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData.dark(),
        color: Colors.grey,
      ),
    );
  }
}
