import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock_database.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/meditation_player_provider.dart';
import '../../providers/schedule_provider.dart';
import '../../widgets/common_cards.dart';
import '../../widgets/section_header.dart';
import '../../widgets/shiva_point_of_light_widget.dart';
import '../meditation/meditation_player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categoriesEn = ['All', 'Morning Peace', 'Deep Silence', 'Focus', 'Stress Relief'];
  final List<String> _categoriesHi = ['सभी', 'प्रातः शान्ति', 'गहन मौन', 'एकाग्रता', 'तनाव मुक्ति'];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final player = context.watch<MeditationPlayerProvider>();
    final schedule = context.watch<ScheduleProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = appState.languageCode;
    final isHindi = lang == 'hi';

    final categories = isHindi ? _categoriesHi : _categoriesEn;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const ShivaPointOfLightWidget(size: 28, animate: true),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Om Shanti',
                  style: AppTypography.titleLarge(isDark: isDark).copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  isHindi ? 'प्रजापिता ब्रह्माकुमारी ईश्वरीय विश्व विद्यालय' : 'Brahma Kumaris Official',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white60 : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Language Switcher Pill (EN | HI)
          GestureDetector(
            onTap: () {
              appState.setLanguage(isHindi ? 'en' : 'hi');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceVariantDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: isDark ? [] : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'EN | HI',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Theme Toggle
          IconButton(
            icon: Icon(
              appState.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
              size: 20,
              color: isDark ? const Color(0xFFFDE68A) : AppColors.primary,
            ),
            onPressed: () => appState.toggleTheme(),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Welcome Greeting Card (Figure 1: "Good Morning, Seeker!")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      width: 1,
                    ),
                    boxShadow: isDark
                        ? []
                        : [
                            BoxShadow(
                              color: const Color(0xFF1C1917).withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? 'सुप्रभात, साधक!' : 'Good Morning, Seeker!',
                        style: AppTypography.titleLarge(isDark: isDark).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isHindi
                            ? '"शांति आपके भीतर है - स्थिरता की एक कालातीत यात्रा।"'
                            : '"Peace Begins Within - A timeless journey into stillness."',
                        style: AppTypography.bodyMedium(isDark: isDark).copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          height: 1.35,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 2. Hero Card: Amritvela Morning Meditation (Figure 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF281414), const Color(0xFF381A1A)]
                          : [const Color(0xFFFDE8E0), const Color(0xFFF9D5CA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: isDark ? const Color(0xFF5A2525) : const Color(0xFFF5C0B2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -4,
                        top: -6,
                        child: Opacity(
                          opacity: 0.9,
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.95),
                                  const Color(0xFFFDE68A).withValues(alpha: 0.4),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'ॐ',
                                style: TextStyle(
                                  fontSize: 42,
                                  color: Color(0xFFEA580C),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isHindi ? 'अमृतवेला प्रातः ध्यान' : 'Amritvela Morning\nMeditation',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF1C1917),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_rounded,
                                size: 14,
                                color: isDark ? const Color(0xFFFDE68A) : AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '4:00 AM • 20 Mins',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? const Color(0xFFFDE68A) : Colors.brown.shade800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Text(
                              isHindi
                                  ? 'आत्मिक शांति और स्पष्टता पाने के लिए एक शक्तिशाली शुरुआत।'
                                  : 'A powerful start to find inner peace and clarity.',
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.8)
                                    : Colors.brown.shade900.withValues(alpha: 0.8),
                                height: 1.35,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 3,
                              ),
                              onPressed: () {
                                final session = MockDatabase.meditationSessions.first;
                                player.playSession(session);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MeditationPlayerScreen(session: session),
                                  ),
                                );
                              },
                              child: Text(
                                isHindi ? 'ध्यान शुरू करें' : 'Start Meditation',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 3. Filter Category Chips (Figure 1: All, Morning Peace, Deep Silence, Focus, Stress Relief)
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, idx) {
                    final isSelected = _selectedCategoryIndex == idx;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedCategoryIndex = idx);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.surfaceDark : Colors.white),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark ? AppColors.borderDark : const Color(0xFFD4D0C8)),
                            width: 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            categories[idx],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? AppColors.textPrimaryDark : const Color(0xFF1C1917)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),

              // 4. Today's Practice Card (Figure 1: Circular Progress Ring 2/3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isHindi ? 'आज का अभ्यास' : "Today's Practice",
                      style: AppTypography.titleMedium(isDark: isDark).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                          width: 1,
                        ),
                        boxShadow: isDark
                            ? []
                            : [
                                BoxShadow(
                                  color: const Color(0xFF1C1917).withValues(alpha: 0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isHindi ? 'दैनिक अभ्यास प्रगति' : 'Daily Practice Progress',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : const Color(0xFF1C1917),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isHindi
                                      ? 'अभ्यास जारी रखें, साधक!\n${schedule.totalTodayCount} में से ${schedule.completedTodayCount} सत्र पूर्ण।'
                                      : 'Keep going, Seeker!\n${schedule.completedTodayCount} of ${schedule.totalTodayCount} sessions completed.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Circular Progress Ring
                          SizedBox(
                            width: 68,
                            height: 68,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: CircularProgressIndicator(
                                    value: schedule.totalTodayCount > 0
                                        ? (schedule.completedTodayCount / schedule.totalTodayCount).clamp(0.0, 1.0)
                                        : 0.67,
                                    strokeWidth: 7,
                                    backgroundColor: isDark ? const Color(0xFF382218) : const Color(0xFFF0E3D8),
                                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                                    strokeCap: StrokeCap.round,
                                  ),
                                ),
                                Text(
                                  '${schedule.completedTodayCount}/${schedule.totalTodayCount}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : const Color(0xFF1C1917),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 2. Spiritual Quick Actions Navigation Bar
              SizedBox(
                height: 84,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildQuickActionTile(
                      context: context,
                      icon: Icons.menu_book_rounded,
                      label: isHindi ? 'दैनिक मुरली' : 'Daily Murli',
                      color: AppColors.primary,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.dailyMurli),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildQuickActionTile(
                      context: context,
                      icon: Icons.live_tv_rounded,
                      label: isHindi ? 'PMTV लाइव' : 'PMTV Live',
                      color: AppColors.liveRed,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.mediaTv),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildQuickActionTile(
                      context: context,
                      icon: Icons.assignment_turned_in_rounded,
                      label: isHindi ? 'पुरुषार्थ चार्ट' : 'Spiritual Chart',
                      color: AppColors.amberGold,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.spiritualJournal),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildQuickActionTile(
                      context: context,
                      icon: Icons.auto_stories_rounded,
                      label: isHindi ? '7-दिवसीय कोर्स' : '7-Day Course',
                      color: AppColors.secondary,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.learningJourney),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildQuickActionTile(
                      context: context,
                      icon: Icons.place_rounded,
                      label: isHindi ? 'शांति केंद्र' : 'BK Centers',
                      color: AppColors.accentTeal,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.centerFinder),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildQuickActionTile(
                      context: context,
                      icon: Icons.volunteer_activism_rounded,
                      label: isHindi ? 'ईश्वरीय सेवा' : 'Seva',
                      color: AppColors.accentRose,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.seva),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 3. Featured Spotlight: Today's Daily Murli Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  borderRadius: AppSpacing.roundedLg,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.dailyMurli),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: AppSpacing.roundedLg,
                      border: Border.all(
                        color: AppColors.primary.withAlpha(80),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(20),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.wb_sunny_rounded, size: 14, color: AppColors.primary),
                                  const SizedBox(width: 4),
                                  Text(
                                    isHindi ? 'आज की मुरली' : 'TODAY\'S MURLI',
                                    style: AppTypography.labelSmall(isDark: false).copyWith(
                                      color: AppColors.primaryDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              isHindi ? 'मधुबन • 16 सितम्बर' : 'Madhuban • Today',
                              style: AppTypography.bodySmall(isDark: isDark).copyWith(
                                color: AppColors.textTertiaryLight,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isHindi ? MockDatabase.todayMurli.titleHi : MockDatabase.todayMurli.title,
                          style: AppTypography.titleMedium(isDark: isDark).copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isHindi ? MockDatabase.todayMurli.essenceHi : MockDatabase.todayMurli.essence,
                          style: AppTypography.bodySmall(isDark: isDark),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                isHindi ? 'आज का स्वमान: शांत स्वरूप आत्मा' : 'Swaman: I am a peaceful soul',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Text(
                                  isHindi ? 'पढ़ें व सुनें' : 'Read & Listen',
                                  style: AppTypography.labelSmall(isDark: isDark).copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.primary),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 4. Live Broadcast Now Banner
              if (MockDatabase.liveSessions.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SectionHeader(
                        title: isHindi ? 'वर्तमान में लाइव प्रसारण' : 'Broadcasting Live',
                        actionLabel: isHindi ? 'सभी देखें' : 'View All',
                        onAction: () => Navigator.pushNamed(context, AppRoutes.liveRoom),
                      ),
                      const SizedBox(height: 12),
                      LiveSessionCard(
                        session: MockDatabase.liveSessions.first,
                        langCode: lang,
                        onJoin: () => Navigator.pushNamed(context, AppRoutes.liveRoom),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
              ],

              // 5. Featured Meditations
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SectionHeader(
                  title: isHindi ? 'अनुशंसित ध्यान सत्र' : 'Featured Meditations',
                  actionLabel: isHindi ? 'और देखें' : 'See All',
                  onAction: () {},
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 148,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: MockDatabase.meditationSessions.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final session = MockDatabase.meditationSessions[index];
                    final isCurrentPlaying = player.currentSession?.id == session.id && player.isPlaying;
                    return SizedBox(
                      width: 290,
                      child: MeditationCard(
                        session: session,
                        langCode: lang,
                        isPlaying: isCurrentPlaying,
                        onTap: () {
                          player.playSession(session);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MeditationPlayerScreen(session: session),
                            ),
                          );
                        },
                        onFavoriteTap: () => player.toggleFavorite(session.id),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              // 6. 7-Day Foundation Course Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  borderRadius: AppSpacing.roundedLg,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.learningJourney),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                            : [const Color(0xFFFEF3C7), const Color(0xFFFFFBEB)],
                      ),
                      borderRadius: AppSpacing.roundedLg,
                      border: Border.all(
                        color: const Color(0xFFF59E0B).withAlpha(80),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withAlpha(40),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.auto_stories_rounded, color: Color(0xFFD97706)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD97706),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isHindi ? '7-दिवसीय राजयोग कोर्स' : '7-DAY FOUNDATION COURSE',
                                  style: AppTypography.labelSmall(isDark: true).copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                isHindi ? 'आत्मा, परमात्मा और कर्म का रहस्य' : 'Understand Soul, God & Law of Karma',
                                style: AppTypography.titleSmall(isDark: isDark).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: Color(0xFFD97706)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 7. Playlists
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SectionHeader(
                  title: isHindi ? 'ध्यान प्लेलिस्ट' : 'Meditation Playlists',
                  actionLabel: isHindi ? 'सभी' : 'All',
                  onAction: () {},
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 182,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: MockDatabase.playlists.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final playlist = MockDatabase.playlists[index];
                    return SizedBox(
                      width: 300,
                      child: PlaylistCard(
                        playlist: playlist,
                        langCode: lang,
                        onTap: () {
                          final firstSession = MockDatabase.meditationSessions.firstWhere(
                            (s) => playlist.sessionIds.contains(s.id),
                            orElse: () => MockDatabase.meditationSessions.first,
                          );
                          player.playSession(firstSession);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MeditationPlayerScreen(session: firstSession),
                            ),
                          );
                        },
                        onPlayAll: () {
                          final firstSession = MockDatabase.meditationSessions.first;
                          player.playSession(firstSession);
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              // 8. Nearby Centers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SectionHeader(
                  title: isHindi ? 'निकटतम शांति केंद्र' : 'Nearby Centers',
                  actionLabel: isHindi ? 'केंद्र खोजें' : 'Finder',
                  onAction: () => Navigator.pushNamed(context, AppRoutes.centerFinder),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 225,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: MockDatabase.centers.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final center = MockDatabase.centers[index];
                    return SizedBox(
                      width: 320,
                      child: CenterCard(
                        center: center,
                        langCode: lang,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.centerFinder),
                        onDirections: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Directions to ${center.name}')),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 80), // Mini player padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withAlpha(40),
        highlightColor: color.withAlpha(20),
        onTap: onTap,
        child: Ink(
          width: 88,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(isDark ? 20 : 15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: color.withAlpha(24),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: AppTypography.labelSmall(isDark: isDark).copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.1,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
