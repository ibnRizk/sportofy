class MatchEntity {
  final String id;
  final String organizerName;
  final String organizerAvatar;
  final List<String> participantAvatars;
  final int currentPlayers;
  final int totalPlayers;
  final String stadiumName;
  final String date;
  final String time;
  final double price;

  const MatchEntity({
    required this.id,
    required this.organizerName,
    required this.organizerAvatar,
    required this.participantAvatars,
    required this.currentPlayers,
    required this.totalPlayers,
    required this.stadiumName,
    required this.date,
    required this.time,
    required this.price,
  });
}
