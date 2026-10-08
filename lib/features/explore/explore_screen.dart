import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock_database.dart';
import '../../models/resource.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/common_cards.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Video Discourses',
    'Daily Murli',
    'Audio Podcasts',
    'Books & PDF',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = appState.languageCode;
    final isHindi = lang == 'hi';

    // Filter resources
    final filtered = MockDatabase.resources.where((res) {
      if (_selectedCategory == 'Video Discourses' && res.type != ResourceType.video) return false;
      if (_selectedCategory == 'Daily Murli' && res.type != ResourceType.dailyThought) return false;
      if (_selectedCategory == 'Audio Podcasts' && res.type != ResourceType.audio) return false;
      if (_selectedCategory == 'Books & PDF' && res.type != ResourceType.pdf) return false;

      if (_searchController.text.trim().isNotEmpty) {
        final q = _searchController.text.toLowerCase();
        return res.title.toLowerCase().contains(q) ||
            res.titleHi.contains(q) ||
            res.author.toLowerCase().contains(q);
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          isHindi ? 'अन्वेषण व प्रवचन' : 'Explore Spiritual Wisdom',
          style: AppTypography.titleLarge(isDark: isDark).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: isHindi ? 'खोजें: शांति, तनाव, कर्म, ध्यान...' : 'Search: Peace, Karma, Focus, Murli...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                ),
              ),
            ),

            // Category Filter Chips
            SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: isDark ? AppColors.primaryLight : AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (sel) {
                      if (sel) setState(() => _selectedCategory = cat);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Resource List
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 48, color: Colors.grey.withAlpha(150)),
                          const SizedBox(height: 12),
                          Text(
                            isHindi ? 'कोई सामग्री नहीं मिली' : 'No spiritual resources found',
                            style: AppTypography.bodyMedium(isDark: isDark),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final resource = filtered[index];
                        return ResourceCard(
                          resource: resource,
                          langCode: lang,
                          onTap: () {
                            if (resource.type == ResourceType.dailyThought) {
                              Navigator.pushNamed(context, AppRoutes.dailyMurli);
                            } else if (resource.type == ResourceType.video || resource.type == ResourceType.audio) {
                              Navigator.pushNamed(context, AppRoutes.mediaTv);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Opening ${isHindi ? resource.titleHi : resource.title}...'),
                                ),
                              );
                            }
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
