import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
              return const Center(child: Text('No hay ligas disponibles'));
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Column(
                      children: state.leagues
                          .map(
                            (league) => LeagueCard(
                              name: league.name,
                              emblem: league.emblem,
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
                    dimension: 40,
                    child: IconButton(
                      icon: const Icon(
                        FluentIcons.back,
                        size: 20,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
              ],
            );
          } else if (state.status.isFailure) {
            return const Center(child: Text('Error al cargar las ligas'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class LeagueCard extends StatelessWidget {
  const LeagueCard({
    super.key,
    required this.name,
    required this.emblem,
  });

  final String name;
  final String emblem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Text(name),
            LeagueLogo(
              logoUrl: emblem,
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
          ],
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
