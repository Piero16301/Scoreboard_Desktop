import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoreboard_desktop/settings/settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SettingsCubit>().loadAvailableLeagues();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      color: const Color.fromRGBO(32, 32, 32, 100),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: ProgressRing());
          } else if (state.status.isSuccess) {
            if (state.leagues.isEmpty) {
              return Stack(
                children: [
                  Center(
                    child: Text(
                      'No hay ligas disponibles',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 7,
                    child: SizedBox.square(
                      dimension: 40,
                      child: IconButton(
                        icon: const Icon(
                          FluentIcons.back,
                          size: 20,
                        ),
                        onPressed: () => context.go('/home'),
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
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Ligas disponibles',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...state.leagues.map(
                          (league) => LeagueCard(
                            name: league.name,
                            emblem: league.emblem,
                            leagueCode: league.code,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 7,
                  child: SizedBox.square(
                    dimension: 40,
                    child: IconButton(
                      icon: const Icon(
                        FluentIcons.back,
                        size: 20,
                      ),
                      onPressed: () => context.go('/home'),
                    ),
                  ),
                ),
              ],
            );
          } else if (state.status.isFailure) {
            return Stack(
              children: [
                Center(
                  child: Text(
                    'Error al cargar las ligas',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 7,
                  child: SizedBox.square(
                    dimension: 40,
                    child: IconButton(
                      icon: const Icon(
                        FluentIcons.back,
                        size: 20,
                      ),
                      onPressed: () => context.go('/home'),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class LeagueCard extends StatefulWidget {
  const LeagueCard({
    super.key,
    required this.name,
    required this.emblem,
    required this.leagueCode,
  });

  final String name;
  final String emblem;
  final String leagueCode;

  @override
  State<LeagueCard> createState() => _LeagueCardState();
}

class _LeagueCardState extends State<LeagueCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 360,
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Checkbox(
          checked: context.select(
            (SettingsCubit cubit) =>
                cubit.state.leaguesEnabled[widget.leagueCode]!,
          ),
          onChanged: (value) => setState(() {
            context.read<SettingsCubit>().saveLeague(
                  leagueCode: widget.leagueCode,
                  value: value!,
                );
          }),
          style: CheckboxThemeData(
            icon: FluentIcons.soccer,
            checkedIconColor: ButtonState.all<Color>(
              const Color.fromRGBO(20, 20, 20, 1),
            ),
            checkedDecoration: ButtonState.all<Decoration>(
              BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          content: Row(
            children: [
              const SizedBox(width: 10),
              LeagueLogo(
                logoUrl: widget.emblem,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              Text(
                widget.name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeagueLogo extends StatelessWidget {
  const LeagueLogo({
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
    if (logoUrl.endsWith('.png')) {
      final newLogo = logoUrl.endsWith('CL.png')
          ? 'https://www.pbcc.com.co/wp-content/uploads/2016/12/uefa-champions-league.png'
          : logoUrl;
      final newBoxFit = logoUrl.endsWith('CL.png') ? BoxFit.cover : fit;
      return Image.network(
        newLogo,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            FluentIcons.error,
            color: Colors.red,
            size: height * 0.57,
          ),
        ),
        fit: newBoxFit,
        height: height,
        width: width,
      );
    } else {
      final newUrl = logoUrl.endsWith('764.svg')
          ? 'https://upload.wikimedia.org/wikipedia/pt/4/42/Campeonato_Brasileiro_S%C3%A9rie_A_logo.png'
          : logoUrl.endsWith('SAM.svg')
              ? 'https://logodownload.org/wp-content/uploads/2018/10/copa-libertadores-logo.png'
              : 'https://upload.wikimedia.org/wikipedia/en/thumb/2/26/UEFA_Euro_2024_Logo.svg/1200px-UEFA_Euro_2024_Logo.svg.png';
      return Image.network(
        newUrl,
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
