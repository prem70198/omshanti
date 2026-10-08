import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../data/mock_database.dart';
import '../../models/media_item_model.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/meditation_player_provider.dart';
import '../../widgets/spiritual_image.dart';

class MediaTvScreen extends StatefulWidget {
  const MediaTvScreen({super.key});

  @override
  State<MediaTvScreen> createState() => _MediaTvScreenState();
}

class _MediaTvScreenState extends State<MediaTvScreen> {
  MediaItemModel? _activePlayingItem;
  bool _isPlayingTv = true;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _activePlayingItem = MockDatabase.mediaItems.first;
  }

  void _selectMedia(MediaItemModel item) {
    setState(() {
      _activePlayingItem = item;
      _isPlayingTv = true;
    });

    if (item.category == MediaCategory.bkSongs || item.category == MediaCategory.commentary) {
      // Also notify global meditation player
      final player = context.read<MeditationPlayerProvider>();
      final session = MockDatabase.meditationSessions.first;
      player.playSession(session);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = appState.languageCode == 'hi';

    final items = MockDatabase.mediaItems.where((m) {
      if (_selectedCategory == 'TV Channels' && m.category != MediaCategory.tvChannel) return false;
      if (_selectedCategory == 'Awakening' && m.category != MediaCategory.discourse) return false;
      if (_selectedCategory == 'BK Songs' && m.category != MediaCategory.bkSongs) return false;
      if (_selectedCategory == 'Commentaries' && m.category != MediaCategory.commentary) return false;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isHindi ? 'पीस ऑफ माइंड टीवी व मीडिया' : 'Peace of Mind TV & Media',
          style: AppTypography.titleMedium(isDark: isDark).copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Featured TV / Video Player Stream Box
            if (_activePlayingItem != null) _buildPlayerBox(_activePlayingItem!, isDark, isHindi),

            // 2. Category Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildChip('All', isDark),
                    const SizedBox(width: 8),
                    _buildChip('TV Channels', isDark),
                    const SizedBox(width: 8),
                    _buildChip('Awakening', isDark),
                    const SizedBox(width: 8),
                    _buildChip('BK Songs', isDark),
                    const SizedBox(width: 8),
                    _buildChip('Commentaries', isDark),
                  ],
                ),
              ),
            ),

            // 3. Media Items List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = _activePlayingItem?.id == item.id;
                  final title = isHindi ? item.titleHi : item.title;

                  return InkWell(
                    borderRadius: AppSpacing.roundedLg,
                    onTap: () => _selectMedia(item),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer)
                            : (isDark ? AppColors.surfaceDark : Colors.white),
                        borderRadius: AppSpacing.roundedLg,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.borderDark : AppColors.borderLight),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              SpiritualImage(
                                imageUrl: item.thumbnailUrl,
                                width: 92,
                                height: 64,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withAlpha(120),
                                    ),
                                    child: Icon(
                                      item.isLive ? Icons.sensors_rounded : Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              if (item.isLive)
                                Positioned(
                                  top: 4,
                                  left: 4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.liveRed,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'LIVE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.channelName,
                                  style: AppTypography.labelSmall(isDark: isDark).copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  title,
                                  style: AppTypography.titleSmall(isDark: isDark).copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${item.speaker} • ${item.duration}',
                                  style: AppTypography.bodySmall(isDark: isDark).copyWith(
                                    color: AppColors.textTertiaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerBox(MediaItemModel item, bool isDark, bool isHindi) {
    final title = isHindi ? item.titleHi : item.title;

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SpiritualImage(
                imageUrl: item.thumbnailUrl,
                width: double.infinity,
                height: 220,
              ),
              Container(
                width: double.infinity,
                height: 220,
                color: Colors.black.withAlpha(90),
              ),

              // Play / Pause Overlay
              IconButton(
                iconSize: 56,
                icon: Icon(
                  _isPlayingTv ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                  color: Colors.white,
                ),
                onPressed: () => setState(() => _isPlayingTv = !_isPlayingTv),
              ),

              // Live Status Badge
              if (item.isLive)
                Positioned(
                  top: 12,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.liveRed,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, color: Colors.white, size: 8),
                        SizedBox(width: 6),
                        Text(
                          '24x7 BROADCAST',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Sound / Fullscreen controls
              Positioned(
                bottom: 8,
                right: 8,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 20),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.fullscreen_rounded, color: Colors.white, size: 22),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Player Title info bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: isDark ? AppColors.surfaceDark : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.titleSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${item.channelName} • ${item.speaker}',
                        style: AppTypography.bodySmall(isDark: isDark).copyWith(
                          color: AppColors.textTertiaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Media broadcast shared!')),
                    );
                  },
                  icon: const Icon(Icons.share_rounded, size: 16),
                  label: Text(isHindi ? 'शेयर' : 'Share'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isDark) {
    final isSelected = _selectedCategory == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: isDark ? AppColors.primaryLight : AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
      onSelected: (sel) {
        if (sel) setState(() => _selectedCategory = label);
      },
    );
  }
}
