import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoreboard_desktop/home/home.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().initialLoading();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      color: const Color.fromRGBO(32, 32, 32, 100),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: ProgressRing());
          } else if (state.status.isSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            const Text('Premier League'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                TeamBlock(
                  teamLogo: 'https://crests.football-data.org/61.png',
                  teamName: 'Chelsea',
                ),
                TeamBlock(
                  teamName: 'Manchester City',
                  teamLogo: 'https://crests.football-data.org/65.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TeamBlock extends StatelessWidget {
  const TeamBlock({
    super.key,
    required this.teamName,
    required this.teamLogo,
  });

  final String teamName;
  final String teamLogo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 130,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Image.network(
            teamLogo,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : const Center(child: ProgressRing()),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Icon(
                FluentIcons.error,
                color: Colors.red,
                size: 40,
              ),
            ),
            fit: BoxFit.cover,
            height: 70,
            width: 70,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                teamName,
                style: GoogleFonts.poppins(),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
