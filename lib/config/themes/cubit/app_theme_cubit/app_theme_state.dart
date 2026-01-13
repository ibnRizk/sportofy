part of 'app_theme_cubit.dart';

class AppThemeState extends Equatable {
  final bool isLight;

  const AppThemeState({required this.isLight});

  @override
  List<Object> get props => [isLight];
}
