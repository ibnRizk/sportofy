part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int currentNavIndex;
  final bool hasLocationPermission;
  final bool isLoadingMatches;
  final List<MatchEntity> nearbyMatches;

  const HomeState({
    this.currentNavIndex = 0,
    this.hasLocationPermission = false,
    this.isLoadingMatches = false,
    this.nearbyMatches = const [],
  });

  HomeState copyWith({
    int? currentNavIndex,
    bool? hasLocationPermission,
    bool? isLoadingMatches,
    List<MatchEntity>? nearbyMatches,
  }) {
    return HomeState(
      currentNavIndex: currentNavIndex ?? this.currentNavIndex,
      hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
      isLoadingMatches: isLoadingMatches ?? this.isLoadingMatches,
      nearbyMatches: nearbyMatches ?? this.nearbyMatches,
    );
  }

  @override
  List<Object?> get props => [
        currentNavIndex,
        hasLocationPermission,
        isLoadingMatches,
        nearbyMatches,
      ];
}
