class DailyMurliModel {
  final String id;
  final String dateString;
  final String dateStringHi;
  final String title;
  final String titleHi;
  final String essence;
  final String essenceHi;
  final String question;
  final String questionHi;
  final String answer;
  final String answerHi;
  final List<String> dharnaPoints;
  final List<String> dharnaPointsHi;
  final String blessing;
  final String blessingHi;
  final String slogan;
  final String sloganHi;
  final String swaman;
  final String swamanHi;
  final String audioUrl;
  final int durationMinutes;

  const DailyMurliModel({
    required this.id,
    required this.dateString,
    required this.dateStringHi,
    required this.title,
    required this.titleHi,
    required this.essence,
    required this.essenceHi,
    required this.question,
    required this.questionHi,
    required this.answer,
    required this.answerHi,
    required this.dharnaPoints,
    required this.dharnaPointsHi,
    required this.blessing,
    required this.blessingHi,
    required this.slogan,
    required this.sloganHi,
    required this.swaman,
    required this.swamanHi,
    required this.audioUrl,
    this.durationMinutes = 24,
  });
}
