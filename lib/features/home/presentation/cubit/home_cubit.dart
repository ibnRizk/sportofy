import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/home/domain/entities/match_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(nearbyMatches: _getMockMatchesStatic())) {
    // Load mock data immediately on initialization
    loadNearbyMatches();
  }

  void changeBottomNavIndex(int index) {
    emit(state.copyWith(currentNavIndex: index));
  }

  void setLocationPermissionGranted(bool granted) {
    emit(state.copyWith(hasLocationPermission: granted));
  }

  void loadNearbyMatches() {
    // Always show mock data for UI demonstration
    final matches = _getMockMatches();
    emit(state.copyWith(
      isLoadingMatches: false,
      nearbyMatches: matches,
    ));
  }

  static List<MatchEntity> _getMockMatchesStatic() {
    return [
      const MatchEntity(
        id: '1',
        organizerName: 'Mohamed Ahmed',
        organizerAvatar: ImgAssets.mohamedAhmed,
        participantAvatars: [
          ImgAssets.organization,
          ImgAssets.salahMostafa,
          ImgAssets.mohamedAhmed,
          ImgAssets.organization,
          ImgAssets.salahMostafa,
          ImgAssets.mohamedAhmed,
        ],
        currentPlayers: 10,
        totalPlayers: 12,
        stadiumName: 'Stadium name',
        date: 'Today, 03/07',
        time: '06:00 PM',
        price: 20.00,
      ),
      const MatchEntity(
        id: '2',
        organizerName: 'Salah Mostafa',
        organizerAvatar: ImgAssets.salahMostafa,
        participantAvatars: [
          ImgAssets.mohamedAhmed,
          ImgAssets.organization,
          ImgAssets.salahMostafa,
          ImgAssets.mohamedAhmed,
        ],
        currentPlayers: 11,
        totalPlayers: 13,
        stadiumName: 'Stadium name',
        date: 'Today, 03/07',
        time: '08:00 PM',
        price: 20.00,
      ),
    ];
  }

  List<MatchEntity> _getMockMatches() {
    return [
      const MatchEntity(
        id: '1',
        organizerName: 'Mohamed Ahmed',
        organizerAvatar: ImgAssets.mohamedAhmed,
        participantAvatars: [
          ImgAssets.organization,
          ImgAssets.salahMostafa,
          ImgAssets.mohamedAhmed,
          ImgAssets.organization,
          ImgAssets.salahMostafa,
          ImgAssets.mohamedAhmed,
        ],
        currentPlayers: 10,
        totalPlayers: 12,
        stadiumName: 'Stadium name',
        date: 'Today, 03/07',
        time: '06:00 PM',
        price: 20.00,
      ),
      const MatchEntity(
        id: '2',
        organizerName: 'Salah Mostafa',
        organizerAvatar: ImgAssets.salahMostafa,
        participantAvatars: [
          ImgAssets.mohamedAhmed,
          ImgAssets.organization,
          ImgAssets.salahMostafa,
          ImgAssets.mohamedAhmed,
        ],
        currentPlayers: 11,
        totalPlayers: 13,
        stadiumName: 'Stadium name',
        date: 'Today, 03/07',
        time: '08:00 PM',
        price: 20.00,
      ),
    ];
  }
}
