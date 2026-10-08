import '../models/meditation_session.dart';
import '../models/playlist.dart';
import '../models/resource.dart';
import '../models/learning_course.dart';
import '../models/live_session.dart';
import '../models/center_model.dart';
import '../models/event_model.dart';
import '../models/seva_opportunity.dart';
import '../models/schedule_item.dart';
import '../models/daily_murli_model.dart';
import '../models/media_item_model.dart';

class MockDatabase {
  // ----------------------------------------------------
  // Daily Murli & Soul Sustenance (दैनिक मुरली व महावाक्य)
  // ----------------------------------------------------
  static const DailyMurliModel todayMurli = DailyMurliModel(
    id: 'murli_today',
    dateString: 'Today, 16 Sep • Madhuban',
    dateStringHi: 'आज की प्रातः मुरली, 16 सितम्बर • मधुबन',
    title: 'Essence of Purity & Soul Consciousness',
    titleHi: 'पवित्रता और आत्म-अभिमानी स्थिति का दिव्य सार',
    essence:
        'Sweet children, you are the jewels of the Ocean of Knowledge. Remain constantly aware of your spiritual identity as a sparkling point of light. Seeing every brother soul with benevolent vision dissolves all attachment.',
    essenceHi:
        'मीठे बच्चे, तुम ज्ञान-सूर्य परमात्मा के दिव्य प्रकाश हो। सदा स्वयं को भृकुटि के मध्य चमकती हुई ज्योति बिंदु आत्मा समझकर कर्म करो। सर्व आत्माओं के प्रति कल्याणकारी दृष्टि रखो।',
    question:
        'Which spiritual practice ensures that no negative influence of Maya can disturb you during daily actions?',
    questionHi:
        'कर्म करते समय माया के किसी भी विघ्न से बचने की सबसे सहज और शक्तिशाली विधि कौन-सी है?',
    answer:
        'Constantly remember that you are a trustee and a child of the Almighty Father. Perform every task as selfless service (Seva) and surrender all fruits to the Supreme.',
    answerHi:
        'सदा इस स्मृति में रहो कि मैं इस देह में मेहमान हूँ और ईश्वर का ट्रस्टी हूँ। हर कर्म को निष्काम ईश्वरीय सेवा समझकर करो।',
    dharnaPoints: [
      '1. Practice soul consciousness before speaking with anyone. Speak sweet, measured words of peace.',
      '2. Guard your thoughts through Traffic Control moments of silence throughout the day.',
      '3. Transform waste thoughts into good wishes and pure feelings for all.',
    ],
    dharnaPointsHi: [
      '1. किसी से भी बात करने से पहले स्वयं को शांत आत्मा अनुभव करो। सदा मधुर और कल्याणकारी बोल बोलो।',
      '2. दिनभर में ट्रैफिक कंट्रोल के समय मन को एकाग्र कर परमात्मा से शक्तियाँ प्राप्त करो।',
      '3. व्यर्थ संकल्पों को शुभ-भावना और शुभकामना में परिवर्तित करो।',
    ],
    blessing:
        'May you be an embodiment of peace who remains unshakable in all circumstances by holding the hand of the Supreme Companion.',
    blessingHi:
        'सर्वशक्तिमान परमात्मा को अपना सच्चा साथी बनाकर सदा अचल-अडोल रहने वाले शांति के सागर, मास्टर सर्वशक्तिमान भव।',
    slogan:
        'Those whose minds are aligned with God become magnets of peace and contentment.',
    sloganHi:
        'जिनका मन परमात्मा से जुड़ा है, वे स्वयं शांति और संतुष्टता का प्रकाश स्तंभ बन जाते हैं।',
    swaman: 'I am an eternal soul, radiating rays of peace and pure love to the universe.',
    swamanHi: 'मैं शांत स्वरूप, पवित्र और सर्वशक्तिमान पिता की लाडली आत्मा हूँ।',
    audioUrl: 'https://media.brahmakumaris.org/audio/murli/murli_today.mp3',
    durationMinutes: 26,
  );

  // ----------------------------------------------------
  // Peace of Mind TV & Media Library (PMTV & Awakening)
  // ----------------------------------------------------
  static const List<MediaItemModel> mediaItems = [
    MediaItemModel(
      id: 'media_pmtv_live',
      title: 'Peace of Mind TV (24x7 Live Stream)',
      titleHi: 'पीस ऑफ माइंड टीवी (24x7 लाइव प्रसारण)',
      speaker: 'Brahma Kumaris World HQ',
      channelName: 'PMTV Live',
      duration: 'LIVE',
      thumbnailUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&auto=format&fit=crop&q=80',
      streamUrl: 'https://live.pmtv.in/hls/stream.m3u8',
      category: MediaCategory.tvChannel,
      isLive: true,
    ),
    MediaItemModel(
      id: 'media_awakening',
      title: 'Awakening with BK Shivani: Freedom from Stress',
      titleHi: 'अवेकनिंग: तनाव और चिंताओं से सहज मुक्ति',
      speaker: 'Sister BK Shivani',
      channelName: 'Awakening TV',
      duration: '22:15',
      thumbnailUrl: 'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=800&auto=format&fit=crop&q=80',
      streamUrl: 'mock_video_awakening',
      category: MediaCategory.discourse,
    ),
    MediaItemModel(
      id: 'media_song_1',
      title: 'Jyoti Bindu Paramdham Niwasi (Divine Song)',
      titleHi: 'ज्योति बिंदु परमधाम निवासी (मधुर गीत)',
      speaker: 'Madhuban Singers',
      channelName: 'BK Divine Melodies',
      duration: '06:40',
      thumbnailUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800&auto=format&fit=crop&q=80',
      streamUrl: 'mock_audio_song_1',
      category: MediaCategory.bkSongs,
    ),
    MediaItemModel(
      id: 'media_comm_1',
      title: 'Deep Silence: 15-Minute Rajyoga Commentary',
      titleHi: 'परम शांति: 15-मिनट राजयोग ध्यान कॉमेंट्री',
      speaker: 'BK Suraj Bhai',
      channelName: 'Madhuban Commentary',
      duration: '15:00',
      thumbnailUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=800&auto=format&fit=crop&q=80',
      streamUrl: 'mock_audio_comm_1',
      category: MediaCategory.commentary,
    ),
  ];

  // ----------------------------------------------------
  // Meditation Sessions
  // ----------------------------------------------------
  static final List<MeditationSession> meditationSessions = [
    const MeditationSession(
      id: 'med_1',
      title: 'Amritvela Morning Silence',
      titleHi: 'अमृतवेला प्रातः शान्ति',
      subtitle: 'Awaken the soul in the nectar hours of dawn',
      subtitleHi: 'उषाकाल में आत्म-स्मृति और शांति का अनुभव',
      instructor: 'BK Shivani',
      durationMinutes: 15,
      category: MeditationCategory.morning,
      audioUrl: 'mock_audio_amritvela',
      imageUrl: 'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=800&auto=format&fit=crop&q=80',
      guidanceText:
          'Sit comfortably. Withdraw your thoughts from the physical world. Focus gently on the center of the forehead. Feel yourself as a minute star of pure, radiating white light. You are peaceful, eternal, and detached from worry.',
      guidanceTextHi:
          'सहजता से बैठें। अपनी दृष्टि और विचारों को भीतर समेटें। भृकुटि के मध्य में चमकती हुई शांत दिव्य आत्मा पर ध्यान केंद्रित करें। मैं शांत स्वरूप आत्मा हूँ।',
      isFeatured: true,
    ),
    const MeditationSession(
      id: 'med_2',
      title: 'Evening Peace (Numasham)',
      titleHi: 'नुमाशाम संध्या शान्ति',
      subtitle: 'Release the day\'s tension into ocean of peace',
      subtitleHi: 'दिनभर की थकान मिटाकर शांति के सागर में विश्राम',
      instructor: 'BK Suraj Bhai',
      durationMinutes: 15,
      category: MeditationCategory.evening,
      audioUrl: 'mock_audio_evening',
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
      guidanceText:
          'As twilight approaches, disconnect from all duties. Surrender every thought to the Supreme Light. Feel waves of cool, serene vibrations bathing your mind, dissolving all stress and fatigue.',
      guidanceTextHi:
          'संध्या के समय सभी कर्मों से उपराम होकर परमपिता परमात्मा की छत्रछाया में बैठें। शांति की शीतल किरणें आपके मन को शांत और निर्मल बना रही हैं।',
      isFeatured: true,
    ),
    const MeditationSession(
      id: 'med_3',
      title: 'Soul Consciousness Experience',
      titleHi: 'आत्म-स्मृति का अभ्यास',
      subtitle: 'Recognize your true spiritual identity as light',
      subtitleHi: 'स्वयं को ज्योति बिंदु आत्मा के रूप में अनुभव करें',
      instructor: 'Dadi Janki',
      durationMinutes: 20,
      category: MeditationCategory.peace,
      audioUrl: 'mock_audio_soul_light',
      imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&auto=format&fit=crop&q=80',
      guidanceText:
          'I am not this perishable body; I am the conscious master within. Like a driver in a car, I watch, decide, and remain serene. Experiencing my natural state of love, bliss, and purity.',
      guidanceTextHi:
          'मैं यह नश्वर शरीर नहीं, बल्कि इसमें निवास करने वाली अमर चैतन्य ज्योति हूँ। मन, बुद्धि, और संस्कारों का मालिक हूँ।',
      isFeatured: true,
    ),
    const MeditationSession(
      id: 'med_4',
      title: 'Connecting with the Supreme Source',
      titleHi: 'परमपिता परमात्मा से योग',
      subtitle: 'Receive rays of unconditional love and power',
      subtitleHi: 'सर्वशक्तिमान से शक्तियों और पवित्रता का संचार',
      instructor: 'BK Usha Didi',
      durationMinutes: 25,
      category: MeditationCategory.peace,
      audioUrl: 'mock_audio_supreme',
      imageUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=800&auto=format&fit=crop&q=80',
      guidanceText:
          'Rise beyond the physical stars into the golden-red world of silence (Paramdham). Stand before the Supreme Soul, the Sun of Knowledge. Absorb peace, pure love, and spiritual fortitude.',
      guidanceTextHi:
          'भौतिक जगत से परे मुक्तिधाम (परमधाम) में पहुँचें। ज्योति स्वरूप परमात्मा के सम्मुख बैठकर उनकी सर्वशक्तियों को अपने भीतर समाहित करें।',
      isFeatured: true,
    ),
    const MeditationSession(
      id: 'med_5',
      title: 'Thought Control & Mental Silence',
      titleHi: 'संकल्पों का नियंत्रण व एकाग्रता',
      subtitle: 'Calm rapid thoughts and restore inner tranquility',
      subtitleHi: 'व्यर्थ संकल्पों को रोककर मन को एकाग्र बनाएं',
      instructor: 'BK Brij Mohan',
      durationMinutes: 10,
      category: MeditationCategory.focus,
      audioUrl: 'mock_audio_thought_control',
      imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&auto=format&fit=crop&q=80',
      guidanceText:
          'Observe the thoughts in your mind like clouds passing in the sky. Do not struggle with them; simply apply a full stop of silence. Inhale peace, exhale noise.',
      guidanceTextHi:
          'मन के विचारों को साक्षी होकर देखें। उन पर नियंत्रण पाएं और सकारात्मकता का चुनाव करें। शांत संकल्प करें।',
    ),
    const MeditationSession(
      id: 'med_6',
      title: 'Healing Sleep Meditation',
      titleHi: 'गहन निद्रा ध्यान',
      subtitle: 'Gentle relaxation for restoring peaceful sleep',
      subtitleHi: 'चिंताओं से मुक्त होकर गहरी सुखद नींद पाएं',
      instructor: 'Sister Jayanti',
      durationMinutes: 30,
      category: MeditationCategory.sleep,
      audioUrl: 'mock_audio_sleep',
      imageUrl: 'https://images.unsplash.com/photo-1513002749550-c59d786b8e6c?w=800&auto=format&fit=crop&q=80',
      guidanceText:
          'Place all responsibilities at God\'s feet. Relax your crown, eyes, neck, shoulders, and chest. Float into gentle stillness. Sleep peacefully under divine protection.',
      guidanceTextHi:
          'दिनभर की सभी बातें ईश्वर को समर्पित कर दें। शरीर के प्रत्येक अंग को शिथिल करें और निश्चिंत होकर सो जाएं।',
    ),
  ];

  // ----------------------------------------------------
  // Playlists
  // ----------------------------------------------------
  static final List<Playlist> playlists = [
    const Playlist(
      id: 'pl_1',
      title: 'Morning Peace',
      titleHi: 'प्रातःकालीन शांति',
      description: 'Start your day grounded in calm, gratitude, and divine power.',
      descriptionHi: 'अपने दिन की शुरुआत दिव्यता और आत्म-शक्ति के साथ करें।',
      coverImageUrl: 'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=800&auto=format&fit=crop&q=80',
      sessionIds: ['med_1', 'med_3', 'med_5'],
      totalDurationMinutes: 45,
      sessionCount: 3,
      category: MeditationCategory.morning,
    ),
    const Playlist(
      id: 'pl_2',
      title: 'Evening Calm',
      titleHi: 'संध्याकालीन विश्राम',
      description: 'Slow down, reflect, and surrender mental baggage before rest.',
      descriptionHi: 'दिन के अंत में मन को शांत और हल्का करने का सुंदर संगम।',
      coverImageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
      sessionIds: ['med_2', 'med_4', 'med_6'],
      totalDurationMinutes: 70,
      sessionCount: 3,
      category: MeditationCategory.evening,
    ),
    const Playlist(
      id: 'pl_3',
      title: 'Pure Peace & Silence',
      titleHi: 'परम शांति व मौन',
      description: 'Immerse deep into the original jewel of your soul\'s peace.',
      descriptionHi: 'आत्मा के मूल संस्कार शांति में पूरी तरह लीन हो जाएं।',
      coverImageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&auto=format&fit=crop&q=80',
      sessionIds: ['med_3', 'med_4'],
      totalDurationMinutes: 45,
      sessionCount: 2,
      category: MeditationCategory.peace,
    ),
    const Playlist(
      id: 'pl_4',
      title: 'Focus & Positive Thoughts',
      titleHi: 'सकारात्मक सोच व एकाग्रता',
      description: 'Strengthen determination and cultivate pure, uplifting thoughts.',
      descriptionHi: 'सकारात्मकता और आत्म-विश्वास बढ़ाने वाले ध्यान सत्र।',
      coverImageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&auto=format&fit=crop&q=80',
      sessionIds: ['med_5', 'med_3'],
      totalDurationMinutes: 30,
      sessionCount: 2,
      category: MeditationCategory.positiveThoughts,
    ),
  ];

  // ----------------------------------------------------
  // 7-Day Foundation Course
  // ----------------------------------------------------
  static final LearningCourse foundationCourse = LearningCourse(
    id: 'course_rajyoga_7days',
    title: '7-Day Foundation in Rajyoga',
    titleHi: '7-दिवसीय राजयोग आधारभूत कोर्स',
    description:
        'A systematic spiritual journey to understand the Soul, Supreme Soul, Law of Karma, and practical meditation.',
    descriptionHi:
        'आत्मा, परमात्मा, कर्म का नियम और व्यावहारिक राजयोग ध्यान को समझने की संपूर्ण यात्रा।',
    level: 'Beginner to Intermediate',
    lessons: [
      const LearningLesson(
        dayNumber: 1,
        title: 'Introduction to Meditation & Soul Consciousness',
        titleHi: 'ध्यान का परिचय व आत्म-स्मृति',
        subtitle: 'Discover the immortal conscious light within',
        subtitleHi: 'शरीर से भिन्न चैतन्य ज्योति की पहचान',
        durationMinutes: 12,
        content:
            'Who am I? For ages, humans have identified primarily with physical form, name, nationality, and roles. Rajyoga begins by shifting perspective from body-consciousness to soul-consciousness. The soul is an infinitesimal point of living light situated at the center of the forehead. It possesses three subtle faculties: Mind (generates thoughts), Intellect (judges and visualizes), and Sanskars (accumulated tendencies and habits). When you know yourself as a peaceful soul, inner friction dissolves.',
        contentHi:
            'मैं कौन हूँ? हम प्रायः स्वयं को शरीर, नाम और पद से पहचानते हैं। राजयोग हमें आत्म-स्मृति सिखाता है। आत्मा भृकुटि के मध्य में स्थित एक दिव्य ज्योति बिंदु है। इसके तीन मुख्य अंग हैं: मन, बुद्धि और संस्कार।',
        keyTakeaway:
            'You are an eternal, peaceful spiritual entity occupying a temporary physical body.',
        keyTakeawayHi:
            'आप एक शांत स्वरूप, अजर-अमर आत्मा हैं जो शरीर के माध्यम से कर्म करती है।',
        contemplationPrompt:
            'Today, pause every two hours for 30 seconds. Remind yourself: "I am a peaceful soul."',
        contemplationPromptHi:
            'आज दिनभर हर 2 घंटे में 30 सेकंड के लिए रुकें और याद करें: "मैं शांत आत्मा हूँ।"',
        isCompleted: true,
      ),
      const LearningLesson(
        dayNumber: 2,
        title: 'Understanding the Supreme Soul (God)',
        titleHi: 'परमात्मा का सत्य परिचय',
        subtitle: 'The Ocean of Peace, Love, and Purity',
        subtitleHi: 'परमधाम निवासी, ज्ञान व शांति के सागर',
        durationMinutes: 15,
        content:
            'Just as the human soul is a point of light, the Supreme Soul (Shiva / God) is also an eternal point of light, but unbound by birth, rebirth, and karma. Residing in the Soul World (Paramdham), the Supreme is an inexhaustible reservoir of unconditional love, pristine peace, and supreme wisdom. Meditation is establishing a mental link between your soul and the Supreme Source.',
        contentHi:
            'परमात्मा भी ज्योति बिंदु स्वरूप हैं, जो जन्म-मरण के बंधन से मुक्त परमधाम में रहते हैं। वे ज्ञान, प्रेम और शांति के सागर हैं। ध्यान का अर्थ है अपनी आत्मा का परमात्मा से संबंध जोड़ना।',
        keyTakeaway:
            'God is a loving Supreme Parent and Friend, easily accessible through pure thoughts.',
        keyTakeawayHi:
            'ईश्वर हमारे परमपिता और सच्चे मित्र हैं, जिन्हें केवल सच्चे मन से याद किया जा सकता है।',
        contemplationPrompt:
            'Visualize yourself resting in the gentle, protective light of the Supreme Parent.',
        contemplationPromptHi:
            'अनुभव करें कि परमात्मा की सुखद छत्रछाया आपके सिर पर है और आप पूर्णतः सुरक्षित हैं।',
        isCompleted: true,
      ),
      const LearningLesson(
        dayNumber: 3,
        title: 'The Three Worlds (Cosmology)',
        titleHi: 'तीन लोकों का रहस्य',
        subtitle: 'Physical, Subtle, and the Soul World',
        subtitleHi: 'साकार, सूक्ष्म और परमधाम (मुक्तिधाम)',
        durationMinutes: 14,
        content:
            'Understand our cosmic existence: 1) The Corporeal World (where physical bodies exist), 2) The Subtle World (Angelic realm of light), and 3) The Incorporeal World / Paramdham (The original home of all souls and the Supreme). In Rajyoga, we fly beyond the physical dimension into the golden stillness of Paramdham.',
        contentHi:
            'सृष्टि के तीन आयाम हैं: साकार वतन (भौतिक संसार), सूक्ष्म वतन (प्रकाशमय देव लोक), और निराकार परमधाम (शांति धाम)। ध्यान में हम परमधाम की शांति में स्थिर होते हैं।',
        keyTakeaway:
            'Your original spiritual home is a realm of absolute silence, purity, and freedom.',
        keyTakeawayHi:
            'हमारा असली घर परमधाम है जहाँ केवल परम शांति और मुक्ति का अनुभव होता है।',
        contemplationPrompt:
            'Close your eyes and journey in thought to the quiet, golden-red world of silence.',
        contemplationPromptHi:
            'नेत्र बंद कर मन की गति से परमधाम के स्वर्ण-लाल प्रकाशमय धाम की यात्रा करें।',
      ),
      const LearningLesson(
        dayNumber: 4,
        title: 'The Law of Karma & Destiny',
        titleHi: 'कर्म का गुह्य सिद्धांत',
        subtitle: 'As you sow, so shall you reap',
        subtitleHi: 'जैसी करनी वैसी भरनी - जीवन का गहरा नियम',
        durationMinutes: 16,
        content:
            'Every action begins with a thought. Thoughts create actions, actions form habits, habits forge character, and character shapes destiny. The law of karma is impartial and precise. By purifying our thoughts with Rajyoga, we neutralize old bitter accounts and sow seeds of peace, health, and spiritual nobility.',
        contentHi:
            'हर कर्म की शुरुआत संकल्प से होती है। कर्म का सिद्धांत अटल है। राजयोग द्वारा हम अपने विचारों को शुद्ध कर श्रेष्ठ कर्म और उज्ज्वल भविष्य का निर्माण करते हैं।',
        keyTakeaway:
            'You are the conscious master and creator of your own future through pure intentions.',
        keyTakeawayHi:
            'आप अपने भाग्य के विधाता स्वयं हैं। श्रेष्ठ संकल्प से श्रेष्ठ भाग्य बनता है।',
        contemplationPrompt:
            'Observe your reactions today: choose calm understanding instead of irritation.',
        contemplationPromptHi:
            'आज किसी भी विपरीत परिस्थिति में गुस्सा करने के बजाय शांति का चुनाव करें।',
      ),
      const LearningLesson(
        dayNumber: 5,
        title: 'The Kalpa World Cycle',
        titleHi: 'सृष्टि चक्र का ज्ञान',
        subtitle: 'The 5000-year cycle of Gold, Silver, Copper, and Iron Ages',
        subtitleHi: 'सत्ययुग, त्रेता, द्वापर और कलियुग की ज्ञानपूर्ण कहानी',
        durationMinutes: 18,
        content:
            'Time moves in an eternal cycle of 5000 years: Golden Age (Satya Yug), Silver Age (Treta Yug), Copper Age (Dwapar Yug), and Iron Age (Kali Yug). At the auspicious confluence (Sangam Yug), God incarnates to renew the world from darkness to golden light. We stand now at this pivotal dawn.',
        contentHi:
            'समय 5000 वर्ष के चक्र में घूमता है। संगमयुग पर परमात्मा अवतरित होकर कलियुग को सत्ययुग में बदलने का कार्य करते हैं।',
        keyTakeaway:
            'We are at the historic Confluence Age, the prime opportunity for personal transformation.',
        keyTakeawayHi:
            'यह संगमयुग आत्म-परिवर्तन और विश्व-कल्याण का सबसे सुंदर समय है।',
        contemplationPrompt:
            'Feel proud of being an instrument for creating a peaceful golden world.',
        contemplationPromptHi:
            'स्वयं को स्वर्णिम संसार की स्थापना में परमात्मा का मददगार अनुभव करें।',
      ),
      const LearningLesson(
        dayNumber: 6,
        title: 'The Tree of Humanity & Religions',
        titleHi: 'कल्पवृक्ष और मानव परिवार',
        subtitle: 'The universal family rooted in One Supreme Seed',
        subtitleHi: 'एक पिता की संतान, वसुधैव कुटुंबकम',
        durationMinutes: 15,
        content:
            'Visualize humanity as an expansive inverted tree. The incorporeal Supreme is the Eternal Seed at the top. The trunk represents the primordial deity religion of absolute purity. As time passes, branches emerge for various spiritual traditions. Though branches differ, all are nourished by the same Divine Seed.',
        contentHi:
            'समस्त मानव जाति एक कल्पवृक्ष के समान है जिसके बीज परमात्मा हैं। सभी धर्म और संस्कृतियाँ उस एक ही वृक्ष की सुंदर शाखाएं हैं।',
        keyTakeaway:
            'All human beings are brothers, children of One Supreme Father.',
        keyTakeawayHi:
            'हम सभी आत्माएं परस्पर भाई-भाई हैं और एक ही परमपिता की संतान हैं।',
        contemplationPrompt:
            'Radiate pure brotherhood and compassion to souls of every creed and background.',
        contemplationPromptHi:
            'सर्व आत्माओं को अपने भाई के रूप में देखकर आत्मीयता का भाव रखें।',
      ),
      const LearningLesson(
        dayNumber: 7,
        title: 'Daily Spiritual Lifestyle & 8 Powers of Rajyoga',
        titleHi: 'राजयोग की 8 शक्तियां व जीवनशैली',
        subtitle: 'Practical powers: Withdraw, Pack up, Tolerate, Accommodate, Discern...',
        subtitleHi: 'सहनशक्ति, समाने की शक्ति, निर्णय शक्ति और अन्य दिव्य गुण',
        durationMinutes: 20,
        content:
            'Rajyoga is not mere theory; it is a lifestyle. Practitioners awaken early for Amritvela (nectar dawn meditation), consume pure satvik vegetarian food prepared in loving remembrance, and cultivate the 8 spiritual powers: Power to Withdraw, Pack-up, Tolerate, Accommodate, Discern, Judge, Face, and Cooperate.',
        contentHi:
            'राजयोग एक पवित्र जीवनशैली है। इसमें अमृतवेला योग, शुद्ध सात्विक भोजन और 8 आध्यात्मिक शक्तियों का दैनिक अभ्यास शामिल है।',
        keyTakeaway:
            'Meditation is master of the mind, resulting in an unshakeable, joyous everyday life.',
        keyTakeawayHi:
            'राजयोग जीवन में शांति, शक्ति, और आनंद का सच्चा आधार है।',
        contemplationPrompt:
            'Select one spiritual power today (such as the Power to Accommodate) and practice it consciously.',
        contemplationPromptHi:
            'आज किसी एक शक्ति (जैसे समाने की शक्ति) को चुनकर उसका अभ्यास करें।',
      ),
    ],
  );

  // ----------------------------------------------------
  // Approved Resources
  // ----------------------------------------------------
  static final List<Resource> resources = [
    const Resource(
      id: 'res_1',
      title: 'The Art of Mindful Responding',
      titleHi: 'प्रतिक्रिया की जगह समझदारी',
      author: 'BK Shivani',
      category: 'Wisdom',
      type: ResourceType.video,
      durationMinutes: 18,
      description: 'Learn how to avoid impulsive emotional reactions and respond from calmness.',
      descriptionHi: 'भावुकता से बचकर शांति और धैर्य से निर्णय लेने की कला।',
      contentUrl: 'mock_resource_video_1',
      thumbnailUrl: 'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=800&auto=format&fit=crop&q=80',
    ),
    const Resource(
      id: 'res_2',
      title: 'Daily Murli Reflection: Sweet Thoughts for Today',
      titleHi: 'आज की प्रातः मुरली चिंतन',
      author: 'Brahma Kumaris HQ',
      category: 'Daily Thought',
      type: ResourceType.dailyThought,
      durationMinutes: 8,
      description: 'Essence: See everyone\'s virtues and keep your heart clean like a lotus.',
      descriptionHi: 'सार: सभी के गुणों को देखें और अपने मन को कमल के समान निर्लिप्त रखें।',
      contentUrl: 'mock_resource_murli',
      thumbnailUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800&auto=format&fit=crop&q=80',
      isFavorite: true,
    ),
    const Resource(
      id: 'res_3',
      title: 'Guided Commentary: Overcoming Worry & Fear',
      titleHi: 'चिंता और भय से मुक्ति का ध्यान',
      author: 'BK Suraj Bhai',
      category: 'Audio',
      type: ResourceType.audio,
      durationMinutes: 14,
      description: 'A soothing commentary invoking the protective power of the Supreme.',
      descriptionHi: 'ईश्वरीय शक्तियों द्वारा मन के भय को मिटाने वाला शांतिदायक ध्यान।',
      contentUrl: 'mock_resource_audio_1',
      thumbnailUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=800&auto=format&fit=crop&q=80',
      isDownloaded: true,
    ),
    const Resource(
      id: 'res_4',
      title: 'The Secret of Karmic Accounts (PDF Guide)',
      titleHi: 'कर्मों के खाते का रहस्य (ई-बुक)',
      author: 'Literature Department',
      category: 'Books',
      type: ResourceType.pdf,
      durationMinutes: 25,
      description: 'Comprehensive reading material on how our subtle intentions shape life outcomes.',
      descriptionHi: 'हमारे संकल्प और कर्म कैसे भविष्य बनाते हैं, इस पर विस्तृत मार्गदर्शिका।',
      contentUrl: 'mock_resource_pdf_1',
      thumbnailUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800&auto=format&fit=crop&q=80',
    ),
  ];

  // ----------------------------------------------------
  // Live Sessions
  // ----------------------------------------------------
  static final List<LiveSession> liveSessions = [
    LiveSession(
      id: 'live_1',
      title: 'Global Peace Meditation & Spiritual Discourse',
      titleHi: 'विश्व शांति ध्यान व आध्यात्मिक व्याख्यान',
      hostName: 'BK Sister Shivani',
      hostRole: 'Senior Rajyoga Teacher',
      centerName: 'Mount Abu Shantivan HQ',
      scheduledTime: DateTime.now().subtract(const Duration(minutes: 15)),
      durationMinutes: 45,
      participantCount: 412,
      isLiveNow: true,
      streamUrl: 'mock_live_stream_1',
      description:
          'Join hundreds of seekers globally in creating a collective canopy of peace vibrations for the world.',
      descriptionHi:
          'विश्व शांति के लिए एक साथ जुड़कर शांति और शक्ति के प्रकंपन पूरे संसार में फैलाएं।',
    ),
    LiveSession(
      id: 'live_2',
      title: 'Numasham Evening Yog & Q&A',
      titleHi: 'संध्याकालीन नुमाशाम योग व जिज्ञासा समाधान',
      hostName: 'BK Suraj Bhai',
      hostRole: 'Spiritual Guide',
      centerName: 'Gyan Sarovar Center',
      scheduledTime: DateTime.now().add(const Duration(hours: 3)),
      durationMinutes: 30,
      participantCount: 0,
      isLiveNow: false,
      streamUrl: 'mock_live_stream_2',
      description:
          'Experience profound silence and have your questions on daily spiritual practice answered.',
      descriptionHi:
          'गहन शांति का अनुभव करें और अपनी साधना से जुड़े प्रश्नों के उत्तर पाएं।',
    ),
  ];

  // ----------------------------------------------------
  // Physical Centers
  // ----------------------------------------------------
  static final List<CenterModel> centers = [
    const CenterModel(
      id: 'center_1',
      name: 'Brahma Kumaris Shantivan World HQ',
      nameHi: 'ब्रह्माकुमारीज़ शांतिवन विश्व मुख्यालय',
      address: 'Abu Road, Mount Abu',
      city: 'Mount Abu, Rajasthan',
      distanceKm: 0.0,
      phone: '+91 2974 228101',
      email: 'shantivan@bkivv.org',
      openingHours: '4:00 AM – 9:00 PM (Daily)',
      latitude: 24.5926,
      longitude: 72.7156,
      todayProgramTitle: 'Universal Amritvela & Murli Class',
      todayProgramTitleHi: 'सामूहिक अमृतवेला व प्रातः मुरली क्लास',
      todayProgramTime: '6:30 AM – 7:45 AM',
      dailySchedule: [
        CenterProgram(
          time: '4:00 AM',
          title: 'Amritvela Yog (Silence)',
          titleHi: 'अमृतवेला सामूहिक योग',
          type: 'Meditation',
        ),
        CenterProgram(
          time: '6:30 AM',
          title: 'Daily Murli Class',
          titleHi: 'प्रातः मुरली क्लास',
          type: 'Class',
        ),
        CenterProgram(
          time: '6:30 PM',
          title: 'Evening Meditation (Numasham)',
          titleHi: 'नुमाशाम शांति योग',
          type: 'Meditation',
        ),
      ],
    ),
    const CenterModel(
      id: 'center_2',
      name: 'Brahma Kumaris Peace Center',
      nameHi: 'ब्रह्माकुमारीज़ शांति केंद्र',
      address: 'Plot 12, Institutional Area, Lodhi Road',
      city: 'New Delhi',
      distanceKm: 2.3,
      phone: '+91 11 2469 1234',
      email: 'delhi.peace@bk.org',
      openingHours: '6:00 AM – 8:30 PM (Daily)',
      latitude: 28.5912,
      longitude: 77.2274,
      todayProgramTitle: 'Evening Guided Meditation (Numasham)',
      todayProgramTitleHi: 'संध्याकालीन सामूहिक राजयोग ध्यान',
      todayProgramTime: '6:30 PM – 7:30 PM',
      dailySchedule: [
        CenterProgram(
          time: '6:00 AM',
          title: 'Amritvela Meditation & Murli',
          titleHi: 'अमृतवेला ध्यान व मुरली',
          type: 'Class',
        ),
        CenterProgram(
          time: '6:30 PM',
          title: 'Evening Meditation (Numasham)',
          titleHi: 'नुमाशाम योग',
          type: 'Meditation',
        ),
      ],
    ),
    const CenterModel(
      id: 'center_3',
      name: 'Brahma Kumaris Harmony House',
      nameHi: 'ब्रह्माकुमारीज़ हार्मोनी हाउस',
      address: 'Bandra West, Hill Road',
      city: 'Mumbai',
      distanceKm: 4.8,
      phone: '+91 22 2642 9876',
      email: 'mumbai.harmony@bk.org',
      openingHours: '6:30 AM – 8:00 PM (Daily)',
      latitude: 19.0596,
      longitude: 72.8295,
      todayProgramTitle: 'Stress Management Rajyoga Workshop',
      todayProgramTitleHi: 'तनाव प्रबंधन राजयोग कार्यशाला',
      todayProgramTime: '7:00 PM – 8:00 PM',
      dailySchedule: [
        CenterProgram(
          time: '6:30 AM',
          title: 'Morning Spiritual Class',
          titleHi: 'प्रातः क्लास',
          type: 'Class',
        ),
        CenterProgram(
          time: '7:00 PM',
          title: 'Evening Rajyoga Discourse',
          titleHi: 'संध्या राजयोग व्याख्यान',
          type: 'Workshop',
        ),
      ],
    ),
  ];

  // ----------------------------------------------------
  // Events
  // ----------------------------------------------------
  static final List<EventModel> events = [
    EventModel(
      id: 'evt_1',
      title: 'Global Meditation Hour: Radiating Peace to Nature',
      titleHi: 'विश्व ध्यान घंटा: प्रकृति को शांति के प्रकंपन',
      description:
          'An international synchronized meditation initiative uniting thousands of souls across 110 countries to send loving vibrations to Mother Earth and humanity.',
      descriptionHi:
          '110 से अधिक देशों में एक साथ जुड़कर समस्त प्रकृति और मानव जाति को शांति और प्रेम के प्रकंपन प्रेषित करने का अंतरराष्ट्रीय उपक्रम।',
      eventDate: DateTime.now().add(const Duration(days: 2)),
      timeString: 'Sunday • 6:30 PM – 7:30 PM IST',
      durationMinutes: 60,
      location: 'Online / Shantivan Auditorium',
      centerName: 'Global Online & Madhuban HQ',
      organizer: 'Brahma Kumaris Environment Wing',
      isOnline: true,
      imageUrl: 'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=800&auto=format&fit=crop&q=80',
    ),
    EventModel(
      id: 'evt_2',
      title: 'Silence Retreat: Reclaiming Inner Equilibrium',
      titleHi: 'मौन साधना शिविर: अंतर्मन की गहराइयों में विश्राम',
      description:
          'A three-day immersive residential retreat at Gyan Sarovar, Mount Abu. Experience structured silence, experiential workshops, and peaceful nature walks.',
      descriptionHi:
          'ज्ञान सरोवर, माउंट आबू में 3-दिवसीय गहन आवासीय मौन साधना शिविर। पूर्ण मौन में आत्मा की अलौकिक शांति का अनुभव।',
      eventDate: DateTime.now().add(const Duration(days: 12)),
      timeString: 'Fri–Sun • Residential',
      durationMinutes: 2880,
      location: 'Gyan Sarovar Academy, Mount Abu',
      centerName: 'Gyan Sarovar Academy, Mount Abu',
      organizer: 'Retreat Coordination Council',
      isOnline: false,
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&auto=format&fit=crop&q=80',
    ),
  ];

  // ----------------------------------------------------
  // Seva Opportunities
  // ----------------------------------------------------
  static final List<SevaOpportunity> sevaOpportunities = [
    SevaOpportunity(
      id: 'seva_1',
      title: 'Spiritual Translation & Content Proofing',
      titleHi: 'आध्यात्मिक साहित्य अनुवाद व संपादन सेवा',
      description:
          'Help translate daily spiritual sustenance thoughts and short articles into regional Indian and world languages (Hindi, Tamil, Spanish, French).',
      descriptionHi:
          'दैनिक मुरली चिंतन व आध्यात्मिक लेखों का विभिन्न भाषाओं में अनुवाद और प्रूफरीडिंग करने की सेवा।',
      location: 'Virtual / Remote',
      centerName: 'Literature Dept, Mount Abu',
      category: SevaCategory.education,
      date: DateTime.now().add(const Duration(days: 3)),
      timeString: '10:00 AM – 1:00 PM',
      totalSlots: 10,
      filledSlots: 4,
      estimatedHours: 3,
    ),
    SevaOpportunity(
      id: 'seva_2',
      title: 'Peace Center Reception & Hospitality Seva',
      titleHi: 'शांति केंद्र स्वागत व अतिथि सत्कार सेवा',
      description:
          'Welcome new seekers visiting the meditation room, offer them water with drishti, and guide them to beginners courses.',
      descriptionHi:
          'केंद्र में आने वाले नए जिज्ञासुओं का आत्मीय स्वागत करें और उन्हें राजयोग कोर्स की जानकारी दें।',
      location: 'Local BK Center',
      centerName: 'Lodhi Road Peace Center',
      category: SevaCategory.community,
      date: DateTime.now().add(const Duration(days: 5)),
      timeString: '4:00 PM – 8:00 PM',
      totalSlots: 6,
      filledSlots: 2,
      estimatedHours: 4,
    ),
  ];

  // ----------------------------------------------------
  // Default Practice Schedule Items
  // ----------------------------------------------------
  static final List<ScheduleItem> defaultSchedules = [
    const ScheduleItem(
      id: 'sch_amritvela',
      title: 'Amritvela Meditation',
      titleHi: 'अमृतवेला योग',
      timeString: '04:00 AM',
      hour: 4,
      minute: 0,
      durationMinutes: 45,
      sessionOrPlaylistTitle: 'Amritvela Morning Silence',
      meditationSessionId: 'med_1',
      isCompletedToday: true,
    ),
    const ScheduleItem(
      id: 'sch_murli',
      title: 'Daily Murli Class',
      titleHi: 'प्रातः मुरली क्लास',
      timeString: '06:30 AM',
      hour: 6,
      minute: 30,
      durationMinutes: 60,
      sessionOrPlaylistTitle: 'Madhuban Sakar Murli',
      meditationSessionId: 'med_3',
      isCompletedToday: false,
    ),
    const ScheduleItem(
      id: 'sch_traffic_1',
      title: 'Traffic Control Pause',
      titleHi: 'ट्रैफिक कंट्रोल (मौन क्षण)',
      timeString: '11:00 AM',
      hour: 11,
      minute: 0,
      durationMinutes: 3,
      sessionOrPlaylistTitle: 'Thought Control',
      meditationSessionId: 'med_5',
      isCompletedToday: true,
    ),
    const ScheduleItem(
      id: 'sch_numasham',
      title: 'Evening Numasham Yog',
      titleHi: 'नुमाशाम संध्या योग',
      timeString: '06:30 PM',
      hour: 18,
      minute: 30,
      durationMinutes: 30,
      sessionOrPlaylistTitle: 'Evening Peace (Numasham)',
      meditationSessionId: 'med_2',
      isCompletedToday: false,
    ),
    const ScheduleItem(
      id: 'sch_night',
      title: 'Night Chart & Rest',
      titleHi: 'रात्रि आत्म-निरीक्षण व शयन',
      timeString: '09:30 PM',
      hour: 21,
      minute: 30,
      durationMinutes: 15,
      sessionOrPlaylistTitle: 'Healing Sleep Meditation',
      meditationSessionId: 'med_6',
      isCompletedToday: false,
    ),
  ];
}
