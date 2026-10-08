class TimeUtils {
  /// Returns spiritual greeting based on time of day (Amritvela, Morning, Afternoon, Evening, Night)
  static String getSpiritualGreeting({String lang = 'en'}) {
    final hour = DateTime.now().hour;
    if (hour >= 3 && hour < 6) {
      return lang == 'hi' ? 'शुभ अमृतवेला (ब्रह्म मुहूर्त)' : 'Sacred Amritvela (Dawn of Peace)';
    } else if (hour >= 6 && hour < 12) {
      return lang == 'hi' ? 'शुभ प्रभात' : 'Serene Morning';
    } else if (hour >= 12 && hour < 17) {
      return lang == 'hi' ? 'शुभ दोपहर' : 'Peaceful Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return lang == 'hi' ? 'शुभ संध्या (नुमाशाम)' : 'Sacred Twilight (Numasham)';
    } else {
      return lang == 'hi' ? 'शुभ रात्रि (अन्तः शांति)' : 'Peaceful Night';
    }
  }

  /// Converts minute duration to friendly string
  static String formatMinutes(int minutes, {String lang = 'en'}) {
    if (minutes < 60) {
      return lang == 'hi' ? '$minutes मिनट' : '$minutes mins';
    }
    final hours = minutes ~/ 60;
    final remaining = minutes % 60;
    if (remaining == 0) {
      return lang == 'hi' ? '$hours घंटे' : '$hours hrs';
    }
    return lang == 'hi' ? '$hours घंटे $remaining मिनट' : '$hours hr $remaining min';
  }

  /// Format clock time into 12-hour AM/PM string
  static String formatTimeOfDay(int hour, int minute) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute $period';
  }
}
