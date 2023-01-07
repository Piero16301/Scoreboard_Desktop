import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  children: const [
                    MatchCard(
                      competitionName: 'La Liga',
                      competitionLogo:
                          'https://crests.football-data.org/PD.png',
                      homeTeamName: 'Real Madrid CF',
                      homeTeamLogo: 'https://crests.football-data.org/86.png',
                      homeTeamScore: '0',
                      awayTeamName: 'FC Barcelona',
                      awayTeamLogo: 'https://crests.football-data.org/81.svg',
                      awayTeamScore: '4',
                      matchTime: '90+5',
                    ),
                    MatchCard(
                      competitionName: 'Premier League',
                      competitionLogo:
                          'https://crests.football-data.org/PL.png',
                      homeTeamName: 'Manchester City FC',
                      homeTeamLogo: 'https://crests.football-data.org/65.png',
                      homeTeamScore: '3',
                      awayTeamName: 'Liverpool FC',
                      awayTeamLogo: 'https://crests.football-data.org/64.png',
                      awayTeamScore: '2',
                      matchTime: '90+3',
                    ),
                    MatchCard(
                      competitionName: 'Seria A',
                      competitionLogo:
                          'https://crests.football-data.org/SA.png',
                      homeTeamName: 'Juventus FC',
                      homeTeamLogo: 'https://crests.football-data.org/109.svg',
                      homeTeamScore: '2',
                      awayTeamName: 'FC Internazionale Milano',
                      awayTeamLogo: 'https://crests.football-data.org/108.png',
                      awayTeamScore: '4',
                      matchTime: '90+6',
                    ),
                  ],
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
  const MatchCard({
    super.key,
    required this.competitionName,
    required this.competitionLogo,
    required this.homeTeamName,
    required this.homeTeamLogo,
    required this.homeTeamScore,
    required this.awayTeamName,
    required this.awayTeamLogo,
    required this.awayTeamScore,
    required this.matchTime,
  });

  final String competitionName;
  final String competitionLogo;

  final String homeTeamName;
  final String homeTeamLogo;
  final String homeTeamScore;

  final String awayTeamName;
  final String awayTeamLogo;
  final String awayTeamScore;

  final String matchTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Opacity(
                opacity: 0.1,
                child: TeamLogo(
                  logoUrl: competitionLogo,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Card(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                Text(
                  competitionName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TeamBlock(
                      teamName: homeTeamName,
                      teamLogo: homeTeamLogo,
                    ),
                    MatchScore(
                      homeTeamScore: homeTeamScore,
                      awayTeamScore: awayTeamScore,
                      matchTime: matchTime,
                    ),
                    TeamBlock(
                      teamName: awayTeamName,
                      teamLogo: awayTeamLogo,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
          TeamLogo(
            logoUrl: teamLogo,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
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

class MatchScore extends StatelessWidget {
  const MatchScore({
    super.key,
    required this.homeTeamScore,
    required this.awayTeamScore,
    required this.matchTime,
  });

  final String homeTeamScore;
  final String awayTeamScore;
  final String matchTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                homeTeamScore,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '-',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                awayTeamScore,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            matchTime,
            style: GoogleFonts.poppins(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class TeamLogo extends StatelessWidget {
  const TeamLogo({
    super.key,
    required this.logoUrl,
    required this.height,
    required this.width,
    required this.fit,
  });

  final String logoUrl;
  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (logoUrl.endsWith('.svg')) {
      if (logoUrl.contains('109')) {
        return SvgPicture.network(
          logoUrl,
          fit: fit,
          height: height,
          width: width,
          color: Colors.white,
        );
      }
      return SvgPicture.network(
        logoUrl,
        fit: fit,
        height: height,
        width: width,
      );
    } else {
      return Image.network(
        logoUrl,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : const Center(child: ProgressRing()),
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            FluentIcons.error,
            color: Colors.red,
            size: height * 0.57,
          ),
        ),
        fit: fit,
        height: height,
        width: width,
      );
    }
  }
}
