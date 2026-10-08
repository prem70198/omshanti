import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_spacing.dart';
import '../core/constants/app_typography.dart';
import '../providers/meditation_player_provider.dart';
import '../providers/app_state_provider.dart';
import 'full_audio_player_sheet.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<MeditationPlayerProvider>();
    final appState = context.watch<AppStateProvider>();
    final session = player.currentSession;

    if (!player.isMiniPlayerVisible || session == null) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = appState.languageCode == 'hi' ? session.titleHi : session.title;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        elevation: 8,
        borderRadius: AppSpacing.roundedLg,
        shadowColor: Colors.black.withAlpha(60),
        child: InkWell(
          borderRadius: AppSpacing.roundedLg,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (ctx) => const FullAudioPlayerSheet(),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [AppColors.surfaceDark, AppColors.cardBgDark]
                    : [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: AppSpacing.roundedLg,
              border: Border.all(
                color: Colors.white.withAlpha(40),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Mini Player Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      // Glowing icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(30),
                        ),
                        child: const Icon(
                          Icons.self_improvement_rounded,
                          color: AppColors.secondaryLight,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Title & Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title,
                              style: AppTypography.titleSmall(isDark: true).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${session.instructor} • ${player.breathingPhase}',
                              style: AppTypography.bodySmall(isDark: true).copyWith(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),

                      // Play/Pause button
                      IconButton(
                        icon: Icon(
                          player.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                        onPressed: () {
                          player.togglePlayPause();
                        },
                      ),

                      // Next button
                      IconButton(
                        icon: const Icon(Icons.skip_next_rounded, color: Colors.white70, size: 24),
                        onPressed: () {
                          player.nextSession();
                        },
                      ),

                      // Close button
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white60, size: 20),
                        onPressed: () {
                          player.dismissMiniPlayer();
                        },
                      ),
                    ],
                  ),
                ),

                // Linear progress bar along the bottom of the card
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppSpacing.radiusLg)),
                  child: LinearProgressIndicator(
                    value: player.progress,
                    minHeight: 3,
                    backgroundColor: Colors.white.withAlpha(30),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondaryLight),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
