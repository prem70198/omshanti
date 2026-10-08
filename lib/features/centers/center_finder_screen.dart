import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../models/center_model.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/community_provider.dart';
import '../../widgets/common_cards.dart';

class CenterFinderScreen extends StatefulWidget {
  const CenterFinderScreen({super.key});

  @override
  State<CenterFinderScreen> createState() => _CenterFinderScreenState();
}

class _CenterFinderScreenState extends State<CenterFinderScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _showCenterDetailModal(BuildContext context, CenterModel center, String lang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final name = lang == 'hi' ? center.nameHi : center.name;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(80),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: AppTypography.titleLarge(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                '${center.address}, ${center.city}',
                style: AppTypography.bodyMedium(isDark: isDark),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, size: 16, color: AppColors.accentTeal),
                  const SizedBox(width: 6),
                  Text(center.openingHours, style: AppTypography.bodySmall(isDark: isDark)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone_rounded, size: 16, color: AppColors.accentTeal),
                  const SizedBox(width: 6),
                  Text(center.phone, style: AppTypography.bodySmall(isDark: isDark)),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Daily Center Schedule',
                style: AppTypography.titleSmall(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...center.dailySchedule.map((prog) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          prog.time,
                          style: AppTypography.labelSmall(isDark: false).copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          lang == 'hi' ? prog.titleHi : prog.title,
                          style: AppTypography.bodySmall(isDark: isDark),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling ${center.phone}...')),
                        );
                      },
                      icon: const Icon(Icons.call_rounded),
                      label: const Text('Call Center'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Opening GPS directions to ${center.name}...')),
                        );
                      },
                      icon: const Icon(Icons.directions_rounded),
                      label: const Text('Directions'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          isHindi ? 'ब्रह्माकुमारीज़ शांति केंद्र' : 'Meditation Centers Finder',
          style: AppTypography.titleLarge(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => community.setCenterSearchQuery(val),
                decoration: InputDecoration(
                  hintText: isHindi ? 'शहर या केंद्र का नाम खोजें...' : 'Search city or center name...',
                  prefixIcon: const Icon(Icons.location_city_rounded),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            community.setCenterSearchQuery('');
                          },
                        )
                      : null,
                ),
              ),
            ),

            // Map preview container simulation
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                      : [const Color(0xFFCCFBF1), const Color(0xFFE0F2FE)],
                ),
                borderRadius: AppSpacing.roundedLg,
                border: Border.all(color: AppColors.accentTeal.withAlpha(60)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.map_rounded, size: 70, color: AppColors.accentTeal.withAlpha(50)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.my_location_rounded, color: AppColors.accentTeal, size: 28),
                      const SizedBox(height: 6),
                      Text(
                        isHindi ? 'निकटतम केंद्र खोजें (GPS सक्रिय)' : 'GPS Centers Locator Active',
                        style: AppTypography.labelSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Centers List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: community.filteredCenters.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final center = community.filteredCenters[index];
                  return CenterCard(
                    center: center,
                    langCode: lang,
                    onTap: () => _showCenterDetailModal(context, center, lang),
                    onDirections: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening Navigation to ${center.name}')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
