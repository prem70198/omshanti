import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_spacing.dart';
import '../core/constants/app_typography.dart';
import '../core/services/audio_player_service.dart';
import '../core/utils/formatters.dart';
import '../providers/meditation_player_provider.dart';
import '../providers/app_state_provider.dart';
import 'breathing_visualizer.dart';

class FullAudioPlayerSheet extends StatefulWidget {
  const FullAudioPlayerSheet({super.key});

  @override
  State<FullAudioPlayerSheet> createState() => _FullAudioPlayerSheetState();
}

class _FullAudioPlayerSheetState extends State<FullAudioPlayerSheet> {
  bool _showTranscript = false;

  @override
  Widget build(BuildContext context) {
    final player = context.watch<MeditationPlayerProvider>();
    final appState = context.watch<AppStateProvider>();
    final session = player.currentSession;

    if (session == null) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = appState.languageCode == 'hi' ? session.titleHi : session.title;
    final subtitle = appState.languageCode == 'hi' ? session.subtitleHi : session.subtitle;
    final guidance = appState.languageCode == 'hi' ? session.guidanceTextHi : session.guidanceText;

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : const Color(0xFF1E1B4B),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    session.instructor,
                    style: AppTypography.titleSmall(isDark: true).copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          session.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: session.isFavorite ? AppColors.accentRose : Colors.white,
                        ),
                        onPressed: () => player.toggleFavorite(session.id),
                      ),
                      IconButton(
                        icon: Icon(
                          session.isDownloaded ? Icons.download_done_rounded : Icons.download_rounded,
                          color: session.isDownloaded ? AppColors.secondaryLight : Colors.white,
                        ),
                        onPressed: () => player.toggleDownload(session.id),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main Content Area (Breathing Visualizer OR Reflection Text)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _showTranscript
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(15),
                          borderRadius: AppSpacing.roundedLg,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.auto_awesome_rounded,
                                      color: AppColors.secondaryLight, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    appState.languageCode == 'hi' ? 'चिंतन व मार्गदर्शन' : 'Reflection & Guidance',
                                    style: AppTypography.titleSmall(isDark: true).copyWith(
                                      color: AppColors.secondaryLight,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                guidance,
                                style: AppTypography.bodyLarge(isDark: true).copyWith(
                                  color: Colors.white.withAlpha(230),
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: BreathingVisualizer(
                          size: 240,
                          phase: player.breathingPhase,
                          secondsLeft: player.breathingSecondsLeft,
                        ),
                      ),
              ),
            ),

            // Toggle Visualizer / Transcript
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionChip(
                  avatar: Icon(
                    _showTranscript ? Icons.spa_rounded : Icons.menu_book_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Text(
                    _showTranscript
                        ? (appState.languageCode == 'hi' ? 'श्वास दृश्य देखें' : 'Show Breathing')
                        : (appState.languageCode == 'hi' ? 'चिंतन पढ़ें' : 'Read Guidance'),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  backgroundColor: Colors.white.withAlpha(30),
                  onPressed: () {
                    setState(() {
                      _showTranscript = !_showTranscript;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Titles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppTypography.titleLarge(isDark: true).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall(isDark: true).copyWith(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Seek Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                      activeTrackColor: AppColors.secondaryLight,
                      inactiveTrackColor: Colors.white.withAlpha(40),
                      thumbColor: Colors.white,
                      overlayColor: AppColors.secondaryLight.withAlpha(50),
                    ),
                    child: Slider(
                      value: player.position.inSeconds.toDouble().clamp(
                            0.0,
                            player.duration.inSeconds.toDouble(),
                          ),
                      max: player.duration.inSeconds > 0
                          ? player.duration.inSeconds.toDouble()
                          : 1.0,
                      onChanged: (val) {
                        player.seek(Duration(seconds: val.toInt()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Formatters.formatDuration(player.position),
                          style: AppTypography.bodySmall(isDark: true).copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          Formatters.formatDuration(player.duration),
                          style: AppTypography.bodySmall(isDark: true).copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Previous
                  IconButton(
                    icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 30),
                    onPressed: () => player.previousSession(),
                  ),
                  // Rewind 15s
                  IconButton(
                    icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 28),
                    onPressed: () => player.seekBackward15(),
                  ),
                  // Play/Pause Big Button
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.sunriseGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withAlpha(120),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        player.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                      onPressed: () => player.togglePlayPause(),
                    ),
                  ),
                  // Forward 15s
                  IconButton(
                    icon: const Icon(Icons.forward_10_rounded, color: Colors.white, size: 28),
                    onPressed: () => player.seekForward15(),
                  ),
                  // Next
                  IconButton(
                    icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 30),
                    onPressed: () => player.nextSession(),
                  ),
                ],
              ),
            ),

            // Ambient Sound & Sleep Timer Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Ambient sound selector
                  PopupMenuButton<AmbientSoundType>(
                    color: isDark ? AppColors.surfaceDark : AppColors.primaryDark,
                    onSelected: (type) => player.setAmbientSound(type),
                    itemBuilder: (ctx) => [
                      const PopupMenuItem(
                        value: AmbientSoundType.none,
                        child: Text('Ambient: None', style: TextStyle(color: Colors.white)),
                      ),
                      const PopupMenuItem(
                        value: AmbientSoundType.flute,
                        child: Text('🎵 Spiritual Flute', style: TextStyle(color: Colors.white)),
                      ),
                      const PopupMenuItem(
                        value: AmbientSoundType.rain,
                        child: Text('🌧️ Gentle Rain', style: TextStyle(color: Colors.white)),
                      ),
                      const PopupMenuItem(
                        value: AmbientSoundType.omChime,
                        child: Text('🔔 Om Soundscape', style: TextStyle(color: Colors.white)),
                      ),
                      const PopupMenuItem(
                        value: AmbientSoundType.natureBirds,
                        child: Text('🌿 Forest Stillness', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        borderRadius: AppSpacing.roundedFull,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.graphic_eq_rounded, color: AppColors.secondaryLight, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            player.ambientSound == AmbientSoundType.none
                                ? (appState.languageCode == 'hi' ? 'ध्वनि जोड़ें' : 'Ambient Sound')
                                : player.ambientSound.name.toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Sleep Timer
                  PopupMenuButton<int>(
                    color: isDark ? AppColors.surfaceDark : AppColors.primaryDark,
                    onSelected: (minutes) => player.setSleepTimer(minutes),
                    itemBuilder: (ctx) => const [
                      PopupMenuItem(value: 0, child: Text('Timer: Off', style: TextStyle(color: Colors.white))),
                      PopupMenuItem(value: 5, child: Text('5 minutes', style: TextStyle(color: Colors.white))),
                      PopupMenuItem(value: 10, child: Text('10 minutes', style: TextStyle(color: Colors.white))),
                      PopupMenuItem(value: 15, child: Text('15 minutes', style: TextStyle(color: Colors.white))),
                      PopupMenuItem(value: 30, child: Text('30 minutes', style: TextStyle(color: Colors.white))),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        borderRadius: AppSpacing.roundedFull,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.bedtime_rounded, color: Colors.white70, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            player.sleepTimerMinutes == null
                                ? (appState.languageCode == 'hi' ? 'स्लीप टाइमर' : 'Sleep Timer')
                                : '${player.sleepTimerMinutes}m timer',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
