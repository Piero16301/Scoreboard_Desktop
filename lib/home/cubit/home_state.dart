part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.matches = const <Match>[],
  });

  final HomeStatus status;
  final List<Match> matches;

  HomeState copyWith({
    HomeStatus? status,
    List<Match>? matches,
  }) {
    return HomeState(
      status: status ?? this.status,
      matches: matches ?? this.matches,
    );
  }

  @override
  List<Object> get props => [
        status,
        matches,
      ];
}
