import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard_desktop/home/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  late StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    context.read<HomeCubit>().initialMatchesLoading();

    _subscription = Stream<void>.periodic(
      const Duration(seconds: 20),
    ).listen(
      (_) => context.read<HomeCubit>().updateMatches(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _subscription.resume();
    } else {
      if (!_subscription.isPaused) _subscription.pause();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      color: const Color.fromRGBO(32, 32, 32, 100),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: ProgressRing());
          } else if (state.status.isSuccess) {
            if (state.matches.isEmpty) {
              return Stack(
                children: const [
                  Center(
                    child: Text(
                      'No hay partidos para hoy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Column(
                      children: state.matches
                          .map(
                            (match) => MatchCard(
                              competitionName: match.competition.name,
                              competitionLogo: match.competition.emblem,
                              homeTeamName: match.homeTeam.name,
                              homeTeamLogo: match.homeTeam.crest,
                              homeTeamScore:
                                  match.score.fullTime.home.toString(),
                              awayTeamName: match.awayTeam.name,
                              awayTeamLogo: match.awayTeam.crest,
                              awayTeamScore:
                                  match.score.fullTime.away.toString(),
                              matchTime: getMatchState(
                                match.status,
                                match.utcDate,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 7,
                  child: SizedBox.square(
                    dimension: 20,
                    child: IconButton(
                      icon: const Icon(
                        FluentIcons.settings,
                        size: 20,
                      ),
                      onPressed: () => debugPrint('Settings'),
                    ),
                  ),
                ),
              ],
            );
          } else if (state.status.isFailure) {
            // return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String getMatchState(String status, DateTime date) {
    switch (status) {
      case 'SCHEDULED':
        return DateFormat('hh:mm a').format(date);
      case 'TIMED':
        return DateFormat('hh:mm a').format(date);
      case 'IN_PLAY':
        return 'En vivo';
      case 'PAUSED':
        return 'Pausado';
      case 'FINISHED':
        return 'Finalizado';
      case 'POSTPONED':
        return 'Postergado';
      case 'SUSPENDED':
        return 'Suspendido';
      case 'CANCELED':
        return 'Cancelado';
      case 'AWARDED':
        return 'Otorgado';
      default:
        return 'Desconocido';
    }
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
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
            fit: BoxFit.fill,
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
    final isLiveMacth = matchTime == 'En vivo' || matchTime == 'Pausado';

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
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          if (isLiveMacth) const SizedBox(height: 5),
          if (isLiveMacth)
            const SizedBox(
              width: 50,
              child: ProgressBar(activeColor: Colors.white),
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
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.network(
          logoUrl,
          fit: fit,
          // height: height,
          // width: width,
        ),
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
