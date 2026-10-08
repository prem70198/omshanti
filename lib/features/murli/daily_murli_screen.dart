import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/backend_api_service.dart';
import '../../data/mock_database.dart';
import '../../providers/app_state_provider.dart';

class DailyMurliScreen extends StatefulWidget {
  const DailyMurliScreen({super.key});

  @override
  State<DailyMurliScreen> createState() => _DailyMurliScreenState();
}

class _DailyMurliScreenState extends State<DailyMurliScreen> {
  bool _isPlayingAudio = false;
  final TextEditingController _reflectionController = TextEditingController();
  bool _isSavingReflection = false;
  final String _todayKey = DateTime.now().toIso8601String().substring(0, 10);

  // Purusharth Checklist states (Figure 4)
  bool _amritvelaCompleted = true;
  bool _murliStudyCompleted = true;
  bool _trafficControlCompleted = true;
  bool _showFullMurli = false;

  @override
  void initState() {
    super.initState();
    _loadSavedReflection();
  }

  Future<void> _loadSavedReflection() async {
    final saved = await BackendApiService.getMurliReflection(_todayKey);
    if (saved != null && mounted) {
      _reflectionController.text = saved;
    }
  }

  Future<void> _saveReflection() async {
    setState(() => _isSavingReflection = true);
    await BackendApiService.saveMurliReflection(_todayKey, _reflectionController.text.trim());
    if (mounted) {
      setState(() => _isSavingReflection = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('मंथन डायरी सुरक्षित कर ली गई है (Reflection Saved)'),
          backgroundColor: AppColors.primary,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _reflectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final murli = MockDatabase.todayMurli;
    final appState = context.watch<AppStateProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = appState.languageCode == 'hi';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFFAF8F3),
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFFAF8F3),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: isDark ? Colors.white : AppColors.textPrimaryLight),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              appState.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
              size: 20,
              color: isDark ? const Color(0xFFFDE68A) : AppColors.primary,
            ),
            onPressed: () => appState.toggleTheme(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Date Header & Audio Listen Button (Figure 4)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? 'आज, ९ अक्टूबर' : 'आज, ९ अक्टूबर',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : const Color(0xFF443D36),
                        ),
                      ),
                      Text(
                        'Today, 9 October',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white54 : const Color(0xFF78716C),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() => _isPlayingAudio = !_isPlayingAudio);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isPlayingAudio
                              ? 'मुरली ऑडियो शुरू हुआ (Playing Audio Murli)'
                              : 'ऑडियो रोका गया (Paused)'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark ? AppColors.surfaceVariantDark : const Color(0xFFEDE8DE),
                            border: Border.all(
                              color: isDark ? Colors.white24 : const Color(0xFFDCD6C9),
                            ),
                          ),
                          child: Icon(
                            _isPlayingAudio ? Icons.pause_rounded : Icons.headphones_rounded,
                            size: 22,
                            color: isDark ? Colors.white : const Color(0xFF2C241D),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isHindi ? 'सुनें (Listen)' : 'सुनें (Listen)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : const Color(0xFF574E45),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 2. Main Title (Figure 4)
              Text(
                'Daily Murli & Spiritual Journal\n(आज की मुरली एवं मंथन डायरी)',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF231C16),
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 16),

              // 3. Card 1: Essence (सार) (Figure 4)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : const Color(0xFFECE7DE),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Essence (सार)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF2C241D),
                          ),
                        ),
                        Icon(
                          Icons.spa_outlined,
                          size: 20,
                          color: isDark ? const Color(0xFFFDE68A) : const Color(0xFFB47D4C),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isHindi
                          ? murli.essenceHi
                          : 'हमेशा आत्माभिमानी स्थिति और शांति का अभ्यास बनाए रखें।',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF1C1917),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      murli.essence,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : const Color(0xFF57534E),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // 4. Card 2: Blessing (वरदान) (Figure 4: Gold accented border & radiant background)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF221A12) : const Color(0xFFFFFDF8),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? const Color(0xFF8B642B) : const Color(0xFFE5C07B),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.08),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Blessing (वरदान)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? const Color(0xFFFDE68A) : const Color(0xFF8A531C),
                          ),
                        ),
                        const Text(
                          'ॐ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC08C5D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isHindi
                          ? murli.blessingHi
                          : 'सदा शांत स्वरूप बन, सर्व आत्माओं को शांति की किरणें देने वाले शांतचित्त भव।',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF2C241D),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      murli.blessing,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : const Color(0xFF6B5E50),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 5. Card 3: Daily Purusharth Chart (दैनिक पुरुषार्थ चार्ट) (Figure 4)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : const Color(0xFFECE7DE),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Purusharth Chart (दैनिक पुरुषार्थ चार्ट)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF2C241D),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Checklist 1: Amritvela Practice
                    _buildChecklistRow(
                      title: isHindi
                          ? 'अमृतवेला योग 4:00 AM (पूर्ण)'
                          : 'Amritvela Practice 4:00 AM (Completed)',
                      isChecked: _amritvelaCompleted,
                      isDark: isDark,
                      onChanged: (val) => setState(() => _amritvelaCompleted = val ?? false),
                    ),
                    const SizedBox(height: 10),

                    // Checklist 2: Murli Study
                    _buildChecklistRow(
                      title: isHindi ? 'मुरली अध्ययन (पूर्ण)' : 'Murli Study (Completed)',
                      isChecked: _murliStudyCompleted,
                      isDark: isDark,
                      onChanged: (val) => setState(() => _murliStudyCompleted = val ?? false),
                    ),
                    const SizedBox(height: 10),

                    // Checklist 3: Traffic Control Pauses
                    _buildChecklistRow(
                      title: isHindi
                          ? 'ट्रैफिक कंट्रोल मौन (5/5 पूर्ण)'
                          : 'Traffic Control Pauses (5/5)',
                      isChecked: _trafficControlCompleted,
                      isDark: isDark,
                      onChanged: (val) => setState(() => _trafficControlCompleted = val ?? false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 6. Card 4: My Murli Realizations & Journal (Figure 4)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : const Color(0xFFECE7DE),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Murli Realizations & Journal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF2C241D),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _reflectionController,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white : const Color(0xFF2C241D),
                        height: 1.4,
                      ),
                      decoration: InputDecoration(
                        hintText: 'आज की मुरली से मुझे क्या शिक्षा मिली... /\nShare your insights here...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white38 : const Color(0xFF9E948A),
                          height: 1.4,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Golden-Bronze Save Button (Figure 4)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC08C5D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        onPressed: _isSavingReflection ? null : _saveReflection,
                        child: _isSavingReflection
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : Text(
                                isHindi ? 'सुरक्षित करें (Save)' : 'Save (सुरक्षित करें)',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 7. Full Sakar Murli Mahavakyas Toggle (Bonus deep spiritual reader)
              Center(
                child: TextButton.icon(
                  onPressed: () => setState(() => _showFullMurli = !_showFullMurli),
                  icon: Icon(
                    _showFullMurli ? Icons.keyboard_arrow_up_rounded : Icons.menu_book_rounded,
                    color: AppColors.primary,
                  ),
                  label: Text(
                    _showFullMurli
                        ? (isHindi ? 'संक्षिप्त करें' : 'Hide Full Murli')
                        : (isHindi ? 'संपूर्ण साकार मुरली महावाक्य पढ़ें' : 'Read Full Sakar Murli Discourse'),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              if (_showFullMurli) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : const Color(0xFFECE7DE),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? 'प्रश्न व उत्तर' : 'Question & Answer',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isHindi ? murli.questionHi : murli.question,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                      const Divider(height: 24),
                      Text(
                        isHindi ? 'धारणा के लिए मुख्य सार' : 'Essence for Dharna',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (final pt in (isHindi ? murli.dharnaPointsHi : murli.dharnaPoints)) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(pt, style: const TextStyle(fontSize: 14, height: 1.35)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistRow({
    required String title,
    required bool isChecked,
    required bool isDark,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: isChecked ? const Color(0xFFC08C5D) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isChecked
                    ? const Color(0xFFC08C5D)
                    : (isDark ? Colors.white38 : const Color(0xFFC4BBB0)),
                width: 1.5,
              ),
            ),
            child: isChecked
                ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : const Color(0xFF382F26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
