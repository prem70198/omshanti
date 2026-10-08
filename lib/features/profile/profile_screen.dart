import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/shiva_point_of_light_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _amritvelaAlarmEnabled = true;
  bool _trafficControlEnabled = true;
  bool _dailyThoughtEnabled = true;

  void _showLogoutDialog(BuildContext context, AppStateProvider appState, bool isHindi) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            const Icon(Icons.logout_rounded, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              isHindi ? 'लॉग आउट पुष्टि' : 'Sign Out Confirmation',
              style: AppTypography.titleMedium(),
            ),
          ],
        ),
        content: Text(
          isHindi
              ? 'क्या आप सचमुच अपनी आध्यात्मिक सत्र से बाहर निकलना चाहते हैं?'
              : 'Are you sure you want to sign out from your spiritual session?',
          style: AppTypography.bodyMedium(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(isHindi ? 'रद्द करें' : 'Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              appState.logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: Text(isHindi ? 'लॉग आउट' : 'Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final user = appState.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = appState.languageCode == 'hi';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isHindi ? 'आध्यात्मिक प्रोफ़ाइल' : 'Spiritual Profile',
          style: AppTypography.titleLarge(isDark: isDark).copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: isHindi ? 'लॉग आउट' : 'Sign Out',
            onPressed: () => _showLogoutDialog(context, appState, isHindi),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Spiritual Identity Hero Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.paramdhamGradient,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withAlpha(40),
                            ),
                          ),
                          Container(
                            width: 68,
                            height: 68,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFBBF24),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person_rounded,
                                size: 40,
                                color: Color(0xFF78350F),
                              ),
                            ),
                          ),
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: ShivaPointOfLightWidget(size: 20, animate: true),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.name,
                        style: AppTypography.titleLarge(isDark: true).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        user.email,
                        style: AppTypography.bodySmall(isDark: true).copyWith(
                          color: Colors.white.withAlpha(220),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(35),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withAlpha(60)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.verified_rounded, size: 14, color: Color(0xFFFDE68A)),
                            const SizedBox(width: 6),
                            Text(
                              isHindi
                                  ? 'राजयोग साधक • नियमित अभ्यासी'
                                  : 'Rajyoga Seeker • Dedicated Practitioner',
                              style: AppTypography.labelSmall(isDark: true).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isHindi
                            ? 'आज का स्वमान: शांत स्वरूप आत्मा'
                            : 'Swaman: I am a peaceful soul • शांत स्वरूप आत्मा',
                        style: AppTypography.spiritualQuote(isDark: true).copyWith(
                          fontSize: 12,
                          color: const Color(0xFFFDE68A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // 2. Sadhana Milestones Statistics Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context: context,
                      value: '${user.totalMeditationMinutes}m',
                      label: isHindi ? 'कुल ध्यान' : 'Total Meditated',
                      icon: Icons.self_improvement_rounded,
                      accentColor: AppColors.primary,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      context: context,
                      value: '${user.currentStreakDays} ${isHindi ? 'दिन' : 'Days'}',
                      label: isHindi ? 'निरंतरता' : 'Current Streak',
                      icon: Icons.local_fire_department_rounded,
                      accentColor: AppColors.accentSunrise,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      context: context,
                      value: '${user.sevaHours}h',
                      label: isHindi ? 'ईश्वरीय सेवा' : 'Seva Volunteered',
                      icon: Icons.volunteer_activism_rounded,
                      accentColor: AppColors.accentTeal,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Card: Spiritual Routine & Sadhana Preferences
              _buildSectionHeader(
                icon: Icons.access_time_filled_rounded,
                title: isHindi ? 'दैनिक साधना प्राथमिकताएँ' : 'Spiritual Routine & Sadhana',
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
                child: Column(
                  children: [
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.wb_twilight_rounded,
                        bgColor: AppColors.primaryContainer,
                        iconColor: AppColors.primary,
                      ),
                      title: Text(
                        isHindi ? 'अमृतवेला ध्यान अलार्म' : 'Amritvela Morning Alarm',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'प्रातः 4:00 बजे पवित्र ध्यान स्मृति' : '4:00 AM sacred silence reminder',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: Switch(
                        value: _amritvelaAlarmEnabled,
                        activeTrackColor: AppColors.primary,
                        onChanged: (val) => setState(() => _amritvelaAlarmEnabled = val),
                      ),
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16),
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.hourglass_top_rounded,
                        bgColor: AppColors.secondaryContainer,
                        iconColor: const Color(0xFF78350F),
                      ),
                      title: Text(
                        isHindi ? 'ट्रैफिक कंट्रोल (मौन विराम)' : 'Hourly Traffic Control',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'प्रत्येक घंटे 1-मिनट आत्म-चिंतन' : 'Pause for 1 minute of soul silence',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: Switch(
                        value: _trafficControlEnabled,
                        activeTrackColor: AppColors.primary,
                        onChanged: (val) => setState(() => _trafficControlEnabled = val),
                      ),
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16),
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.assignment_rounded,
                        bgColor: const Color(0xFFFEF3C7),
                        iconColor: const Color(0xFFD97706),
                      ),
                      title: Text(
                        isHindi ? 'दैनिक पुरुषार्थ चार्ट व मंथन' : 'Daily Sadhana Chart & Journal',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'अपनी आत्मिक प्रगति दर्ज करें' : 'Track contemplation and daily score',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.spiritualJournal),
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16),
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.flag_rounded,
                        bgColor: const Color(0xFFCCFBF1),
                        iconColor: AppColors.accentTeal,
                      ),
                      title: Text(
                        isHindi ? 'मुख्य साधना लक्ष्य' : 'Primary Meditation Goal',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'आत्मिक शांति व एकाग्रता' : 'Inner Peace & Calm',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isHindi ? 'सक्रिय' : 'Active',
                          style: AppTypography.labelSmall(isDark: false).copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 4. Card: App Display & Spiritual Language
              _buildSectionHeader(
                icon: Icons.palette_rounded,
                title: isHindi ? 'प्रदर्शन व भाषा प्राथमिकताएँ' : 'Display, Language & Thoughts',
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
                child: Column(
                  children: [
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.dark_mode_rounded,
                        bgColor: AppColors.surfaceVariantDark,
                        iconColor: isDark ? AppColors.primaryLight : Colors.grey,
                      ),
                      title: Text(
                        isHindi ? 'डार्क थीम (गहन रात्रि ध्यान)' : 'Dark Void Theme',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isDark
                            ? (isHindi ? 'सक्रिय • शांत रात्रि' : 'Active • Low Eye Strain')
                            : (isHindi ? 'निष्क्रिय • शांत प्रकाश' : 'Light Serene Mode Active'),
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: Switch(
                        value: appState.isDarkMode,
                        activeTrackColor: AppColors.primary,
                        onChanged: (_) => appState.toggleTheme(),
                      ),
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16),
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.translate_rounded,
                        bgColor: AppColors.secondaryContainer,
                        iconColor: const Color(0xFF78350F),
                      ),
                      title: Text(
                        isHindi ? 'भाषा प्राथमिकता' : 'Spiritual Language',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(isHindi ? 'हिन्दी (Hindi)' : 'English (Default)'),
                      trailing: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => appState.setLanguage(isHindi ? 'en' : 'hi'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primary.withAlpha(60)),
                          ),
                          child: Text(
                            isHindi ? 'Switch to English' : 'हिन्दी चुनें',
                            style: AppTypography.labelSmall(isDark: false).copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => appState.setLanguage(isHindi ? 'en' : 'hi'),
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16),
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.wb_sunny_rounded,
                        bgColor: const Color(0xFFFEF3C7),
                        iconColor: AppColors.amberGold,
                      ),
                      title: Text(
                        isHindi ? 'दैनिक ईश्वरीय विचार' : 'Daily Thought of the Day',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'प्रातः समय आत्मिक प्रेरणा' : 'Receive uplifting morning wisdom',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: Switch(
                        value: _dailyThoughtEnabled,
                        activeTrackColor: AppColors.primary,
                        onChanged: (val) => setState(() => _dailyThoughtEnabled = val),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 5. Card: Centers & Worldwide Spiritual Community
              _buildSectionHeader(
                icon: Icons.groups_rounded,
                title: isHindi ? 'केंद्र व ईश्वरीय परिवार' : 'Centers & BK Global Family',
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
                child: Column(
                  children: [
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.place_rounded,
                        bgColor: AppColors.secondaryContainer,
                        iconColor: const Color(0xFF78350F),
                      ),
                      title: Text(
                        isHindi ? 'निकटतम शांति केंद्र खोजें' : 'Locate 8,500+ Worldwide Centers',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'अपने शहर में निःशुल्क राजयोग सीखें' : 'Free Rajyoga meditation near you',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.centerFinder),
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16),
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.live_tv_rounded,
                        bgColor: const Color(0xFFFEE2E2),
                        iconColor: AppColors.liveRed,
                      ),
                      title: Text(
                        isHindi ? 'पीस ऑफ माइंड टीवी व रेडियो' : 'Peace of Mind TV & Radio',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? '24x7 लाइव प्रसारण व ईश्वरीय गीत' : 'Live broadcasts, discourses & songs',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.mediaTv),
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16),
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.volunteer_activism_rounded,
                        bgColor: const Color(0xFFFCE7F3),
                        iconColor: AppColors.accentRose,
                      ),
                      title: Text(
                        isHindi ? 'निःस्वार्थ सेवा के अवसर' : 'Selfless Seva Community',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'समय, कौशल व शुभ भावनाओं का दान' : 'Contribute your time & good wishes',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.seva),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 6. Card: Support & Organization Info
              _buildSectionHeader(
                icon: Icons.info_outline_rounded,
                title: isHindi ? 'संस्था परिचय व डेटा' : 'Organization & Data Storage',
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: AppSpacing.roundedLg),
                child: Column(
                  children: [
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.public_rounded,
                        bgColor: AppColors.primaryContainer,
                        iconColor: AppColors.primary,
                      ),
                      title: Text(
                        'brahmakumaris.com',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'आधिकारिक वैश्विक वेबसाइट' : 'Official Worldwide Portal',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Opening https://www.brahmakumaris.com')),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16),
                    ListTile(
                      leading: _buildTileIcon(
                        icon: Icons.cleaning_services_rounded,
                        bgColor: const Color(0xFFF1F5F9),
                        iconColor: Colors.blueGrey,
                      ),
                      title: Text(
                        isHindi ? 'सधना कैश व डेटा रीसेट' : 'Clear Offline Sadhana Cache',
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? 'स्थान रिक्त करें (लॉगिन सुरक्षित रहेगा)' : 'Free space without losing profile',
                        style: AppTypography.bodySmall(isDark: isDark),
                      ),
                      trailing: const Icon(Icons.refresh_rounded, size: 18),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Offline Murli & audio cache cleaned successfully.'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 7. Sign Out Action Button
              SecondaryButton(
                label: isHindi ? 'सत्र से बाहर निकलें (Log Out)' : 'Sign Out of Sanctuary',
                icon: Icons.logout_rounded,
                onPressed: () => _showLogoutDialog(context, appState, isHindi),
              ),
              const SizedBox(height: 14),

              // App Version Footer
              Center(
                child: Text(
                  'Om Shanti App • v2.4.0 • Madhuban Edition',
                  style: AppTypography.bodySmall(isDark: isDark).copyWith(
                    color: AppColors.textTertiaryLight,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTypography.titleSmall(isDark: isDark).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTileIcon({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String value,
    required String label,
    required IconData icon,
    required Color accentColor,
    required bool isDark,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: AppSpacing.roundedMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accentColor, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTypography.titleSmall(isDark: isDark).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.labelSmall(isDark: isDark).copyWith(
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
