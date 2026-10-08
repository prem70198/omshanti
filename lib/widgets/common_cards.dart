import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_spacing.dart';
import '../core/constants/app_typography.dart';
import '../models/meditation_session.dart';
import '../models/playlist.dart';
import '../models/resource.dart';
import '../models/center_model.dart';
import '../models/event_model.dart';
import '../models/live_session.dart';
import 'spiritual_image.dart';

// ==========================================
// 1. MEDITATION CARD
// ==========================================
class MeditationCard extends StatelessWidget {
  final MeditationSession session;
  final String langCode;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  final bool isPlaying;
  final bool isCompact;

  const MeditationCard({
    super.key,
    required this.session,
    required this.langCode,
    required this.onTap,
    this.onFavoriteTap,
    this.isPlaying = false,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = langCode == 'hi' ? session.titleHi : session.title;
    final subtitle = langCode == 'hi' ? session.subtitleHi : session.subtitle;

    return Card(
      child: InkWell(
        borderRadius: AppSpacing.roundedLg,
        onTap: onTap,
        child: Padding(
          padding: isCompact
              ? const EdgeInsets.symmetric(horizontal: 14, vertical: 10)
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Play/Aura icon container
              Container(
                width: isCompact ? 44 : 52,
                height: isCompact ? 44 : 52,
                decoration: BoxDecoration(
                  gradient: isPlaying ? AppColors.auraGradient : AppColors.sereneGradient,
                  shape: BoxShape.circle,
                  boxShadow: isPlaying
                      ? [
                          BoxShadow(
                            color: AppColors.primaryLight.withAlpha(120),
                            blurRadius: 12,
                            spreadRadius: 2,
                          )
                        ]
                      : [],
                ),
                child: Center(
                  child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: isCompact ? 24 : 28,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Title and metadata
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: AppSpacing.roundedSm,
                          ),
                          child: Text(
                            '${session.durationMinutes} min',
                            style: AppTypography.labelSmall(isDark: false).copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            session.instructor,
                            style: AppTypography.bodySmall(isDark: isDark).copyWith(
                              color: AppColors.textTertiaryLight,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      title,
                      style: AppTypography.titleSmall(isDark: isDark).copyWith(
                        fontWeight: FontWeight.w600,
                        color: isPlaying ? AppColors.primaryLight : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!isCompact) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTypography.bodySmall(isDark: isDark).copyWith(
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Favorite action
              if (onFavoriteTap != null)
                IconButton(
                  icon: Icon(
                    session.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: session.isFavorite ? AppColors.accentRose : AppColors.textTertiaryLight,
                    size: 20,
                  ),
                  onPressed: onFavoriteTap,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. PLAYLIST CARD
// ==========================================
class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final String langCode;
  final VoidCallback onTap;
  final VoidCallback? onPlayAll;

  const PlaylistCard({
    super.key,
    required this.playlist,
    required this.langCode,
    required this.onTap,
    this.onPlayAll,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = langCode == 'hi' ? playlist.titleHi : playlist.title;
    final desc = langCode == 'hi' ? playlist.descriptionHi : playlist.description;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [AppColors.cardBgDark, AppColors.surfaceVariantDark]
                  : [Colors.white, AppColors.surfaceVariantLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: AppSpacing.roundedSm,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.playlist_play_rounded,
                            size: 15, color: Color(0xFF78350F)),
                        const SizedBox(width: 4),
                        Text(
                          '${playlist.sessionCount} sessions • ${playlist.totalDurationMinutes}m',
                          style: AppTypography.labelSmall(isDark: false).copyWith(
                            color: const Color(0xFF78350F),
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onPlayAll != null)
                    FilledButton.tonalIcon(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: onPlayAll,
                      icon: const Icon(Icons.play_arrow_rounded, size: 16),
                      label: Text(
                        langCode == 'hi' ? 'चलाएं' : 'Play All',
                        style: AppTypography.labelSmall(isDark: isDark).copyWith(
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: AppTypography.titleSmall(isDark: isDark).copyWith(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                desc,
                style: AppTypography.bodySmall(isDark: isDark),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. RESOURCE CARD
// ==========================================
class ResourceCard extends StatelessWidget {
  final Resource resource;
  final String langCode;
  final VoidCallback onTap;

  const ResourceCard({
    super.key,
    required this.resource,
    required this.langCode,
    required this.onTap,
  });

  IconData _getTypeIcon() {
    switch (resource.type) {
      case ResourceType.audio:
        return Icons.headphones_rounded;
      case ResourceType.video:
        return Icons.videocam_rounded;
      case ResourceType.article:
        return Icons.article_rounded;
      case ResourceType.pdf:
        return Icons.picture_as_pdf_rounded;
      case ResourceType.dailyThought:
        return Icons.wb_sunny_rounded;
      case ResourceType.book:
        return Icons.menu_book_rounded;
      case ResourceType.workshop:
        return Icons.groups_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = langCode == 'hi' ? resource.titleHi : resource.title;
    final desc = langCode == 'hi' ? resource.descriptionHi : resource.description;

    return Card(
      child: InkWell(
        borderRadius: AppSpacing.roundedLg,
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.compactCardPadding,
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: AppSpacing.roundedMd,
                ),
                child: Icon(_getTypeIcon(), color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          resource.category.toUpperCase(),
                          style: AppTypography.labelSmall(isDark: isDark).copyWith(
                            color: AppColors.primaryLight,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '• ${resource.durationMinutes} min',
                          style: AppTypography.bodySmall(isDark: isDark),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: AppTypography.titleSmall(isDark: isDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      desc,
                      style: AppTypography.bodySmall(isDark: isDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiaryLight),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. CENTER CARD
// ==========================================
class CenterCard extends StatelessWidget {
  final CenterModel center;
  final String langCode;
  final VoidCallback onTap;
  final VoidCallback onDirections;

  const CenterCard({
    super.key,
    required this.center,
    required this.langCode,
    required this.onTap,
    required this.onDirections,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final name = langCode == 'hi' ? center.nameHi : center.name;
    final programTitle =
        langCode == 'hi' ? center.todayProgramTitleHi : center.todayProgramTitle;

    return Card(
      child: InkWell(
        borderRadius: AppSpacing.roundedLg,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: AppTypography.titleMedium(isDark: isDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.accentTeal.withAlpha(30),
                      borderRadius: AppSpacing.roundedSm,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.near_me_rounded,
                            size: 13, color: AppColors.accentTeal),
                        const SizedBox(width: 4),
                        Text(
                          '${center.distanceKm} km',
                          style: AppTypography.labelSmall(isDark: isDark).copyWith(
                            color: AppColors.accentTeal,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 15, color: AppColors.textTertiaryLight),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${center.address}, ${center.city}',
                      style: AppTypography.bodySmall(isDark: isDark).copyWith(fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Today's Program callout
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                  borderRadius: AppSpacing.roundedMd,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.event_note_rounded,
                        size: 16, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            programTitle,
                            style: AppTypography.labelSmall(isDark: isDark).copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            center.todayProgramTime,
                            style: AppTypography.bodySmall(isDark: isDark).copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: onTap,
                      icon: const Icon(Icons.info_outline_rounded, size: 14),
                      label: Text(
                        langCode == 'hi' ? 'विवरण' : 'View Details',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: onDirections,
                      icon: const Icon(Icons.directions_rounded, size: 14),
                      label: Text(
                        langCode == 'hi' ? 'मार्ग' : 'Directions',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 5. EVENT CARD
// ==========================================
class EventCard extends StatelessWidget {
  final EventModel event;
  final String langCode;
  final VoidCallback onTap;
  final VoidCallback onRegister;

  const EventCard({
    super.key,
    required this.event,
    required this.langCode,
    required this.onTap,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = langCode == 'hi' ? event.titleHi : event.title;

    return Card(
      child: InkWell(
        borderRadius: AppSpacing.roundedLg,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SpiritualImage(
                  imageUrl: event.imageUrl,
                  width: double.infinity,
                  height: 90,
                  title: title,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: event.isOnline
                          ? AppColors.primaryContainer
                          : AppColors.secondaryContainer,
                      borderRadius: AppSpacing.roundedSm,
                    ),
                    child: Text(
                      event.isOnline
                          ? (langCode == 'hi' ? 'ऑनलाइन' : 'ONLINE')
                          : (langCode == 'hi' ? 'ऑफलाइन' : 'IN-PERSON'),
                      style: AppTypography.labelSmall(isDark: false).copyWith(
                        color: event.isOnline ? AppColors.primaryDark : const Color(0xFF78350F),
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Text(
                    event.timeString,
                    style: AppTypography.bodySmall(isDark: isDark).copyWith(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTypography.titleMedium(isDark: isDark).copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.place_outlined,
                      size: 15, color: AppColors.textTertiaryLight),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${event.centerName} • ${event.organizer}',
                      style: AppTypography.bodySmall(isDark: isDark).copyWith(fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${event.durationMinutes} min duration',
                    style: AppTypography.bodySmall(isDark: isDark).copyWith(fontSize: 11),
                  ),
                  event.isRegistered
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.success.withAlpha(25),
                            borderRadius: AppSpacing.roundedSm,
                            border: Border.all(color: AppColors.success),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle_rounded,
                                  size: 15, color: AppColors.success),
                              const SizedBox(width: 4),
                              Text(
                                langCode == 'hi' ? 'पंजीकृत (Pass)' : 'Registered',
                                style: AppTypography.labelSmall(isDark: isDark).copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: onRegister,
                          child: Text(
                            langCode == 'hi' ? 'पंजीकरण करें' : 'Register',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 6. LIVE SESSION CARD
// ==========================================
class LiveSessionCard extends StatelessWidget {
  final LiveSession session;
  final String langCode;
  final VoidCallback onJoin;

  const LiveSessionCard({
    super.key,
    required this.session,
    required this.langCode,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    final title = langCode == 'hi' ? session.titleHi : session.title;

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.sereneGradient,
        borderRadius: AppSpacing.roundedLg,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(100),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: AppSpacing.cardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Live pulsing tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.liveRed,
                  borderRadius: AppSpacing.roundedFull,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      langCode == 'hi' ? 'लाइव' : 'LIVE NOW',
                      style: AppTypography.labelSmall(isDark: true).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),

              // Participants count
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.people_outline_rounded, size: 16, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    '${session.participantCount} online',
                    style: AppTypography.bodySmall(isDark: true).copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTypography.titleMedium(isDark: true).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${session.hostName} (${session.hostRole}) • ${session.centerName}',
            style: AppTypography.bodySmall(isDark: true).copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryDark,
              minimumSize: const Size(double.infinity, 44),
            ),
            onPressed: onJoin,
            icon: const Icon(Icons.play_circle_fill_rounded, color: AppColors.primary),
            label: Text(
              langCode == 'hi' ? 'लाइव सत्र में जुड़ें' : 'Join Live Session',
              style: AppTypography.labelLarge(isDark: false).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
