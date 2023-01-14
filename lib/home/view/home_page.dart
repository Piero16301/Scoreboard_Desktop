import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_repository/local_repository.dart';
import 'package:match_repository/match_repository.dart';
import 'package:scoreboard_desktop/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        context.read<LocalRepository>(),
        context.read<MatchRepository>(),
      ),
      child: const HomeView(),
    );
  }
}
