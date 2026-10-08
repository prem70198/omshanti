import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/services/audio_player_service.dart';
import '../../core/utils/formatters.dart';
import '../../models/meditation_session.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/meditation_player_provider.dart';

class MeditationPlayerScreen extends StatefulWidget {
  final MeditationSession session;

  const MeditationPlayerScreen({super.key, required this.session});

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  bool _showTranscript = false;

  void _showSleepTimerSheet(BuildContext context, MeditationPlayerProvider player) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141022),
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
              Text(
                'Sleep Timer (स्लीप टाइमर)',
                style: AppTypography.titleMedium(isDark: true).copyWith(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [
                  _buildTimerChip('Off', null, player),
                  _buildTimerChip('10 Mins', 10, player),
                  _buildTimerChip('15 Mins', 15, player),
                  _buildTimerChip('30 Mins', 30, player),
                  _buildTimerChip('45 Mins', 45, player),
                  _buildTimerChip('60 Mins', 60, player),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimerChip(String label, int? minutes, MeditationPlayerProvider player) {
    final isSelected = player.sleepTimerMinutes == minutes;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.primary,
      backgroundColor: const Color(0xFF221C38),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          player.setSleepTimer(minutes);
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = context.watch<MeditationPlayerProvider>();
    final appState = context.watch<AppStateProvider>();
    final session = player.currentSession ?? widget.session;
    final isHindi = appState.languageCode == 'hi';

    final title = isHindi ? session.titleHi : session.title;
    final subtitle = isHindi ? session.subtitleHi : session.subtitle;
    final guidance = isHindi ? session.guidanceTextHi : session.guidanceText;

    return Scaffold(
      backgroundColor: const Color(0xFF07050C),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.cosmicVoidGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Top Bar (Figure 2: Chevron Down, Dots Menu)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Column(
                      children: [
                        Text(
                          isHindi ? 'वर्तमान ध्यान सत्र' : 'NOW MEDITATING',
                          style: const TextStyle(
                            color: Color(0xFFFDE68A),
                            fontSize: 11,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          session.instructor,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz_rounded, color: Colors.white, size: 26),
                      onPressed: () {
                        setState(() => _showTranscript = !_showTranscript);
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),

              // 2. Central Paramdham Aura Pulsating Visualizer (Figure 2)
              if (!_showTranscript)
                _ParamdhamAuraVisualizer(isPlaying: player.isPlaying)
              else
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 14),
                          Text(
                            isHindi ? 'चिंतन व आत्म-संवाद' : 'Reflection & Guidance',
                            style: const TextStyle(
                              color: Color(0xFFFDE68A),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            guidance,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              height: 1.75,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const Spacer(flex: 1),

              // 3. Track Title & Subtitle (Figure 2)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // 4. Golden Progress Slider & Timestamps (Figure 2)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFFF59E0B),
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.15),
                        thumbColor: const Color(0xFFFDE68A),
                        trackHeight: 3.5,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                        overlayColor: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                      ),
                      child: Slider(
                        value: player.progress.clamp(0.0, 1.0),
                        onChanged: (val) {
                          final newSeconds = (val * player.duration.inSeconds).toInt();
                          player.seek(Duration(seconds: newSeconds));
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
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            Formatters.formatDuration(player.duration),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // 5. Playback Controls (Figure 2: Rewind 15s, Luminous Crimson Play/Pause, Forward 15s)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 34,
                    icon: const Icon(Icons.replay_10_rounded, color: Colors.white70),
                    onPressed: () => player.seekBackward15(),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () => player.togglePlayPause(),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFC8321B),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA92815).withValues(alpha: 0.6),
                            blurRadius: 24,
                            spreadRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        player.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  IconButton(
                    iconSize: 34,
                    icon: const Icon(Icons.forward_10_rounded, color: Colors.white70),
                    onPressed: () => player.seekForward15(),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // 6. Ambient Sound Mix Pills Row (Figure 2: Tanpura, Gentle Stream, Chime Bell)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAmbientPill(
                          label: 'Tanpura',
                          icon: Icons.music_note_rounded,
                          isActive: player.ambientSound == AmbientSoundType.omChime,
                          onTap: () {
                            player.setAmbientSound(
                              player.ambientSound == AmbientSoundType.omChime
                                  ? AmbientSoundType.none
                                  : AmbientSoundType.omChime,
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildAmbientPill(
                          label: 'Gentle Stream',
                          icon: Icons.water_rounded,
                          isActive: player.ambientSound == AmbientSoundType.oceanWaves,
                          onTap: () {
                            player.setAmbientSound(
                              player.ambientSound == AmbientSoundType.oceanWaves
                                  ? AmbientSoundType.none
                                  : AmbientSoundType.oceanWaves,
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildAmbientPill(
                          label: 'Chime Bell',
                          icon: Icons.notifications_active_rounded,
                          isActive: player.ambientSound == AmbientSoundType.bellChimes,
                          onTap: () {
                            player.setAmbientSound(
                              player.ambientSound == AmbientSoundType.bellChimes
                                  ? AmbientSoundType.none
                                  : AmbientSoundType.bellChimes,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 7. Bottom Actions Row (Figure 2: Sleep Timer & Favorite)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _showSleepTimerSheet(context, player),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 18,
                            color: player.sleepTimerMinutes != null
                                ? const Color(0xFFF59E0B)
                                : Colors.white60,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            player.sleepTimerMinutes != null
                                ? 'Sleep Timer ${player.sleepTimerMinutes}m'
                                : 'Sleep Timer',
                            style: TextStyle(
                              color: player.sleepTimerMinutes != null
                                  ? const Color(0xFFFDE68A)
                                  : Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => player.toggleFavorite(session.id),
                      child: Row(
                        children: [
                          Icon(
                            session.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 18,
                            color: session.isFavorite ? const Color(0xFFF59E0B) : Colors.white60,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            session.isFavorite ? 'Favorited' : 'Favorite',
                            style: TextStyle(
                              color: session.isFavorite ? const Color(0xFFFDE68A) : Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmbientPill({
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF281C10)
              : const Color(0xFF141020).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFFE5C07B) : Colors.white.withValues(alpha: 0.15),
            width: 1.2,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.25),
                    blurRadius: 10,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isActive ? const Color(0xFFFDE68A) : Colors.white60,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? const Color(0xFFFDE68A) : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Paramdham Undulating Aura Ring Visualizer (Figure 2)
class _ParamdhamAuraVisualizer extends StatefulWidget {
  final bool isPlaying;
  const _ParamdhamAuraVisualizer({required this.isPlaying});

  @override
  State<_ParamdhamAuraVisualizer> createState() => _ParamdhamAuraVisualizerState();
}

class _ParamdhamAuraVisualizerState extends State<_ParamdhamAuraVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final val = _controller.value;
        return Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. Outer ambient golden-amber radiating aura
                Container(
                  width: 230 + (val * 16),
                  height: 230 + (val * 16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.3 + (val * 0.15)),
                        blurRadius: 36 + (val * 12),
                        spreadRadius: 4 + (val * 4),
                      ),
                      BoxShadow(
                        color: const Color(0xFFA92815).withValues(alpha: 0.25),
                        blurRadius: 50,
                        spreadRadius: 8,
                      ),
                    ],
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFDE68A).withValues(alpha: 0.25),
                        const Color(0xFFF59E0B).withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                // 2. Wavy golden aura ring border
                Container(
                  width: 200 + (val * 8),
                  height: 200 + (val * 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFDE68A).withValues(alpha: 0.85),
                      width: 3.5,
                    ),
                  ),
                ),

                // 3. Inner crimson-vermilion radiant ring
                Container(
                  width: 168,
                  height: 168,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFEA580C).withValues(alpha: 0.9),
                      width: 3.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFA92815).withValues(alpha: 0.5),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                ),

                // 4. Cosmic void stillness center
                Container(
                  width: 154,
                  height: 154,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF090710),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
