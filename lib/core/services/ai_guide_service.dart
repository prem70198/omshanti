class AiGuideResponse {
  final String text;
  final String? actionTitle;
  final String? actionRoute;
  final String? actionId;

  const AiGuideResponse({
    required this.text,
    this.actionTitle,
    this.actionRoute,
    this.actionId,
  });
}

class AiGuideService {
  static AiGuideResponse generateResponse(String query, String langCode) {
    final lower = query.toLowerCase();

    // 1. Beginner / Where to start
    if (lower.contains('beginner') ||
        lower.contains('start') ||
        lower.contains('new to') ||
        lower.contains('नया') ||
        lower.contains('शुरू')) {
      if (langCode == 'hi') {
        return const AiGuideResponse(
          text:
              'ॐ शान्ति! ध्यान की शुरुआत के लिए हमारा 7-दिवसीय राजयोग आधारभूत कोर्स सबसे उत्तम है। इसमें पहले दिन आत्म-स्मृति और मन को शांत करने की सरल विधि बताई गई है।',
          actionTitle: '7-दिवसीय कोर्स खोलें (Day 1)',
          actionRoute: '/learning',
          actionId: 'course_rajyoga_7days',
        );
      }
      return const AiGuideResponse(
        text:
            'Om Shanti! To start your meditation journey, we recommend Day 1 of the 7-Day Foundation Course in Rajyoga. It gently introduces the concept of soul consciousness and creates an effortless habit of peace.',
        actionTitle: 'Open Foundation Course (Day 1)',
        actionRoute: '/learning',
        actionId: 'course_rajyoga_7days',
      );
    }

    // 2. 10 min / Short / Quick meditation / Evening
    if (lower.contains('10') ||
        lower.contains('quick') ||
        lower.contains('evening') ||
        lower.contains('short') ||
        lower.contains('शाम') ||
        lower.contains('नुमाशाम')) {
      if (langCode == 'hi') {
        return const AiGuideResponse(
          text:
              'संध्याकाल के लिए "नुमाशाम संध्या शान्ति" (15 मिनट) अथवा "संकल्पों का नियंत्रण" (10 मिनट) सत्र अत्यंत लाभकारी है। यह दिनभर की मानसिक थकान को तुरंत दूर करता है।',
          actionTitle: 'नुमाशाम ध्यान शुरू करें',
          actionRoute: '/meditation_player',
          actionId: 'med_2',
        );
      }
      return const AiGuideResponse(
        text:
            'For a quick and refreshing pause, we recommend the 10-Minute "Thought Control & Mental Silence" or the 15-Minute "Evening Peace (Numasham)" session. Both will center your mind quickly.',
        actionTitle: 'Start Evening Peace Meditation',
        actionRoute: '/meditation_player',
        actionId: 'med_2',
      );
    }

    // 3. Center / Physical visit / Location
    if (lower.contains('center') ||
        lower.contains('visit') ||
        lower.contains('near') ||
        lower.contains('address') ||
        lower.contains('केंद्र') ||
        lower.contains('पता')) {
      if (langCode == 'hi') {
        return const AiGuideResponse(
          text:
              'आप हमारे सेंटर फाइंडर द्वारा अपने निकटतम ब्रह्माकुमारीज़ राजयोग केंद्र का पता, दैनिक कार्यक्रम व समय देख सकते हैं। केंद्र पर सभी कक्षाएं व ध्यान सत्र निःशुल्क होते हैं।',
          actionTitle: 'समीप का केंद्र खोजें',
          actionRoute: '/centers',
          actionId: 'center_1',
        );
      }
      return const AiGuideResponse(
        text:
            'You can locate your nearest Brahma Kumaris Peace Center using the Center Finder. All physical centers offer free meditation sessions, morning Murli classes, and guided courses.',
        actionTitle: 'Find Nearest Center',
        actionRoute: '/centers',
        actionId: 'center_1',
      );
    }

    // 4. Live / Session / Stream
    if (lower.contains('live') ||
        lower.contains('stream') ||
        lower.contains('session') ||
        lower.contains('लाइव') ||
        lower.contains('सत्र')) {
      if (langCode == 'hi') {
        return const AiGuideResponse(
          text:
              'माउंट आबू शांतिवन से "विश्व शांति ध्यान व आध्यात्मिक व्याख्यान" का सीधा प्रसारण चल रहा है। आप लाइव जुड़कर विश्व शांति के प्रकंपन अनुभव कर सकते हैं।',
          actionTitle: 'लाइव रूम में जुड़ें',
          actionRoute: '/live',
          actionId: 'live_1',
        );
      }
      return const AiGuideResponse(
        text:
            'We have active live sessions hosted by senior Rajyoga teachers from Mount Abu Shantivan. You can join live, chat with fellow seekers, and raise your hand for guidance.',
        actionTitle: 'Join Live Room',
        actionRoute: '/live',
        actionId: 'live_1',
      );
    }

    // 5. Stress / Anxiety / Fear / Sleep
    if (lower.contains('stress') ||
        lower.contains('sleep') ||
        lower.contains('anxiety') ||
        lower.contains('fear') ||
        lower.contains('तनाव') ||
        lower.contains('नींद') ||
        lower.contains('डर')) {
      if (langCode == 'hi') {
        return const AiGuideResponse(
          text:
              'तनाव व चिंता से मुक्ति के लिए "गहन निद्रा ध्यान" तथा बीके सूरज भाई जी द्वारा निर्देशित "चिंता और भय से मुक्ति" ऑडियो गाइड सुनिए। परमात्मा की छत्रछाया में मन पूर्ण शांत हो जाता है।',
          actionTitle: 'गहन निद्रा ध्यान सुनें',
          actionRoute: '/meditation_player',
          actionId: 'med_6',
        );
      }
      return const AiGuideResponse(
        text:
            'When experiencing stress or sleep difficulty, practice our "Healing Sleep Meditation" (30 min) or guided commentary on "Overcoming Worry & Fear". Surrender your thoughts to the Ocean of Peace.',
        actionTitle: 'Play Healing Sleep Session',
        actionRoute: '/meditation_player',
        actionId: 'med_6',
      );
    }

    // Default spiritual guidance
    if (langCode == 'hi') {
      return const AiGuideResponse(
        text:
            'ॐ शान्ति! मैं आपका आध्यात्मिक साथी हूँ। आप मुझसे ध्यान सत्रों, राजयोग कोर्स, दैनिक मुरली, लाइव कक्षाओं या निकटतम केंद्र के बारे में पूछ सकते हैं।',
        actionTitle: 'दैनिक अभ्यास देखें',
        actionRoute: '/home',
      );
    }
    return const AiGuideResponse(
      text:
          'Om Shanti! I am your Resource Guide. You can ask me about meditation playlists, the 7-day foundation course, live sessions, daily Murli reflections, or finding your nearest center.',
      actionTitle: 'Explore Practice Hub',
      actionRoute: '/meditation_hub',
    );
  }
}
