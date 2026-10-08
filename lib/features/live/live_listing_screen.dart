import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/live_session_provider.dart';
import '../../widgets/common_cards.dart';

class LiveListingScreen extends StatelessWidget {
  const LiveListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final liveProvider = context.watch<LiveSessionProvider>();
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = appState.languageCode;
    final isHindi = lang == 'hi';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isHindi ? 'विश्वव्यापी लाइव ध्यान' : 'Global Live Broadcasts',
          style: AppTypography.titleLarge(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Active Live Broadcast Now
            if (liveProvider.liveNowSession != null) ...[
              Text(
                isHindi ? 'अभी लाइव प्रसारित' : 'Broadcasting Now',
                style: AppTypography.titleMedium(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              LiveSessionCard(
                session: liveProvider.liveNowSession!,
                langCode: lang,
                onJoin: () {
                  liveProvider.joinLiveRoom(liveProvider.liveNowSession!);
                  Navigator.pushNamed(context, AppRoutes.liveRoom);
                },
              ),
              const SizedBox(height: 28),
            ],

            // Upcoming Live Sessions
            Text(
              isHindi ? 'आगामी लाइव सत्र' : 'Upcoming Spiritual Sessions',
              style: AppTypography.titleMedium(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...liveProvider.upcomingSessions.map((session) {
              final title = isHindi ? session.titleHi : session.title;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: AppSpacing.roundedLg,
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isHindi ? 'आगामी' : 'UPCOMING',
                            style: AppTypography.labelSmall(isDark: false).copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${session.durationMinutes} mins',
                          style: AppTypography.bodySmall(isDark: isDark),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: AppTypography.titleSmall(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${session.hostName} • ${session.centerName}',
                      style: AppTypography.bodySmall(isDark: isDark),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reminder set for live session!')),
                          );
                        },
                        icon: const Icon(Icons.alarm_add_rounded, size: 18),
                        label: Text(isHindi ? 'रिमाइंडर सेट करें' : 'Set Reminder'),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
