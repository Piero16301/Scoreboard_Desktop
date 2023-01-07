import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoreboard_desktop/home/home.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().initialLoading();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: const Color.fromRGBO(32, 32, 32, 100),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: ProgressRing());
          } else if (state.status.isSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  children: List<MatchCard>.generate(
                    5,
                    (index) => const MatchCard(),
                  ),
                ),
              ),
            );
          } else if (state.status.isFailure) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  const MatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            const Text('Premier League'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.network(
                      'https://crests.football-data.org/61.png',
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      'https://crests.football-data.org/65.png',
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
