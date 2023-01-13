import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_repository/local_repository.dart';
import 'package:match_repository/match_repository.dart';
import 'package:scoreboard_desktop/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(
        context.read<LocalRepository>(),
        context.read<MatchRepository>(),
      ),
      child: const SettingsView(),
    );
  }
}
