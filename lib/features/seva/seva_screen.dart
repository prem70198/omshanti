import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/community_provider.dart';

class SevaScreen extends StatelessWidget {
  const SevaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final community = context.watch<CommunityProvider>();
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = appState.languageCode;
    final isHindi = lang == 'hi';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isHindi ? 'निःस्वार्थ सेवा व योगदान' : 'Selfless Seva & Volunteering',
          style: AppTypography.titleLarge(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Seva Summary Stats Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF1E1B4B), const Color(0xFF311042)]
                      : [const Color(0xFFD97706), const Color(0xFFF59E0B)],
                ),
                borderRadius: AppSpacing.roundedLg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 28),
                      const SizedBox(height: 6),
                      Text(
                        '${community.totalJoinedSevaCount}',
                        style: AppTypography.titleLarge(isDark: true).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isHindi ? 'पंजीकृत सेवा' : 'Joined Activities',
                        style: AppTypography.labelSmall(isDark: true).copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                  Container(width: 1, height: 48, color: Colors.white24),
                  Column(
                    children: [
                      const Icon(Icons.alarm_on_rounded, color: Colors.white, size: 28),
                      const SizedBox(height: 6),
                      Text(
                        '${community.totalVolunteerHours} hrs',
                        style: AppTypography.titleLarge(isDark: true).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isHindi ? 'समर्पित घंटे' : 'Volunteer Hours',
                        style: AppTypography.labelSmall(isDark: true).copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              isHindi ? 'उपलब्ध सेवा अवसर' : 'Open Community Opportunities',
              style: AppTypography.titleMedium(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Seva List
            ...community.filteredSeva.map((seva) {
              final title = isHindi ? seva.titleHi : seva.title;
              final desc = isHindi ? seva.descriptionHi : seva.description;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: AppSpacing.roundedLg,
                  border: Border.all(
                    color: seva.isJoined
                        ? AppColors.success
                        : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  ),
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
                            color: AppColors.secondaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            seva.category.name.toUpperCase(),
                            style: AppTypography.labelSmall(isDark: false).copyWith(
                              color: const Color(0xFF78350F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${seva.filledSlots}/${seva.totalSlots} Slots Filled',
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
                      desc,
                      style: AppTypography.bodySmall(isDark: isDark),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${seva.centerName}, ${seva.location}',
                            style: AppTypography.bodySmall(isDark: isDark),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: seva.isJoined ? AppColors.success : AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          community.toggleJoinSeva(seva.id);
                        },
                        child: Text(
                          seva.isJoined
                              ? (isHindi ? 'पंजीकृत (स्थान सुरक्षित)' : 'Joined (Slot Reserved)')
                              : (isHindi ? 'सेवा में योगदान दें' : 'Volunteer Now'),
                        ),
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
