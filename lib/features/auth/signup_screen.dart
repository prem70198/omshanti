import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/shiva_point_of_light_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  String _selectedGoal = 'Inner Peace & Calm';
  String _selectedExperience = 'Seeker';
  String _selectedLanguage = 'en';
  RegistrationButtonState _buttonState = RegistrationButtonState.idle;

  final List<Map<String, dynamic>> _goals = [
    {
      'title': 'Inner Peace & Calm',
      'titleHi': 'आत्मिक शान्ति',
      'icon': Icons.spa_rounded,
    },
    {
      'title': 'Thought Control & Focus',
      'titleHi': 'मन का नियंत्रण',
      'icon': Icons.self_improvement_rounded,
    },
    {
      'title': 'Morning Amritvela Habit',
      'titleHi': 'अमृतवेला साधना',
      'icon': Icons.wb_twilight_rounded,
    },
    {
      'title': 'Stress Relief & Healing',
      'titleHi': 'तनाव मुक्ति व हीलिंग',
      'icon': Icons.healing_rounded,
    },
    {
      'title': 'Deepen Rajyoga Knowledge',
      'titleHi': 'राजयोग ज्ञान मंथन',
      'icon': Icons.auto_stories_rounded,
    },
  ];

  final List<Map<String, String>> _experienceLevels = [
    {'id': 'Seeker', 'label': 'New Seeker', 'labelHi': 'नया साधक'},
    {'id': 'Regular', 'label': 'Practicing BK', 'labelHi': 'नियमित अभ्यासी'},
    {'id': 'Dedicated', 'label': 'Deep Meditator', 'labelHi': 'गहन योगी'},
  ];

  void _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _buttonState = RegistrationButtonState.loading);
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      final appState = context.read<AppStateProvider>();
      appState.login(
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
      );
      appState.setLanguage(_selectedLanguage);

      setState(() => _buttonState = RegistrationButtonState.success);
      await Future.delayed(const Duration(milliseconds: 600));

      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.mainShell);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = _selectedLanguage == 'hi';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          isHindi ? 'साधना पंजीकरण' : 'Create Account',
          style: AppTypography.titleLarge(isDark: isDark).copyWith(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          // Language Switch Pill
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedLanguage = _selectedLanguage == 'en' ? 'hi' : 'en';
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 18, top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.translate_rounded, size: 14, color: AppColors.primary),
                  const SizedBox(width: 5),
                  Text(
                    _selectedLanguage == 'hi' ? 'English' : 'हिन्दी',
                    style: AppTypography.labelSmall(isDark: false).copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Serene Hero Section (Spacious, modern, inspirational)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/app_logo.png',
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const ShivaPointOfLightWidget(size: 42, animate: true),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isHindi ? 'विश्व शांति साधक परिवार' : 'Global Seeker Family',
                          textAlign: TextAlign.center,
                          style: AppTypography.displayMedium(isDark: isDark).copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            isHindi
                                ? 'शांति आपका स्वधर्म है। अपनी साधना को व्यक्तिगत स्वरूप दें।'
                                : 'Peace is your true nature. Personalize your soul-conscious journey.',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodyMedium(isDark: isDark).copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // 2. Personal Information Section
                Text(
                  isHindi ? 'व्यक्तिगत विवरण' : 'Personal Details',
                  style: AppTypography.titleMedium(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isHindi ? 'साधना प्रोफाइल और रिकॉर्ड के लिए' : 'For your meditation profile and sync',
                  style: AppTypography.bodySmall(isDark: isDark),
                ),
                const SizedBox(height: 18),

                // Name Field
                Text(
                  isHindi ? 'आपका शुभ नाम' : 'Your Spiritual / Full Name',
                  style: AppTypography.labelMedium(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  style: AppTypography.bodyMedium(isDark: isDark),
                  decoration: InputDecoration(
                    hintText: isHindi ? 'उदा. राहुल शर्मा' : 'e.g. Rahul Sharma',
                    prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
                  ),
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: AppSpacing.inputGap),

                // Email Field
                Text(
                  isHindi ? 'ईमेल पता' : 'Email Address',
                  style: AppTypography.labelMedium(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTypography.bodyMedium(isDark: isDark),
                  decoration: const InputDecoration(
                    hintText: 'name@example.com',
                    prefixIcon: Icon(Icons.alternate_email_rounded, size: 20),
                  ),
                  validator: (val) {
                    if (val == null || !val.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.inputGap),

                // Password Field
                Text(
                  isHindi ? 'गुप्त पासवर्ड बनाएँ' : 'Create Secure Password',
                  style: AppTypography.labelMedium(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: AppTypography.bodyMedium(isDark: isDark),
                  decoration: InputDecoration(
                    hintText: isHindi ? 'न्यूनतम 6 अक्षर' : 'Minimum 6 characters',
                    prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (val) => val == null || val.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 32),

                // 3. Spiritual Aim Selection (Spacious, beautiful cards)
                Text(
                  isHindi ? 'साधना का मुख्य लक्ष्य' : 'Primary Spiritual Aim',
                  style: AppTypography.titleMedium(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isHindi
                      ? 'यह आपके दैनिक अभ्यास व मुरली चिंतन को अनुकूलित करेगा।'
                      : 'Tailors your daily meditation recommendations and Murli reflections.',
                  style: AppTypography.bodySmall(isDark: isDark),
                ),
                const SizedBox(height: 16),

                // Goals interactive cards (Breathable wrap)
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _goals.map((goal) {
                    final isSelected = _selectedGoal == goal['title'];
                    final label = isHindi ? goal['titleHi'] : goal['title'];

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        setState(() => _selectedGoal = goal['title']);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark
                                  ? AppColors.primary.withValues(alpha: 0.25)
                                  : AppColors.primaryContainer.withValues(alpha: 0.7))
                              : (isDark ? AppColors.surfaceDark : Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark ? AppColors.borderDark : AppColors.borderLight),
                            width: isSelected ? 1.6 : 1.0,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.12),
                                    blurRadius: 12,
                                    offset: const Offset(0, 3),
                                  )
                                ]
                              : (isDark ? [] : AppColors.cardShadowLight),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              goal['icon'] as IconData,
                              size: 19,
                              color: isSelected
                                  ? AppColors.primary
                                  : (isDark ? Colors.white60 : AppColors.textSecondaryLight),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              label,
                              style: AppTypography.labelMedium(isDark: isDark).copyWith(
                                color: isSelected
                                    ? AppColors.primary
                                    : (isDark ? Colors.white : AppColors.textPrimaryLight),
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.check_circle_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),

                // 4. Spiritual Experience Level Segmented
                Text(
                  isHindi ? 'साधना अनुभव स्तर' : 'Spiritual Experience Level',
                  style: AppTypography.titleMedium(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isHindi
                      ? 'अपनी साधना गहराई के अनुसार उपयुक्त सामग्री प्राप्त करें।'
                      : 'Helps curate guided vs silent contemplative sessions.',
                  style: AppTypography.bodySmall(isDark: isDark),
                ),
                const SizedBox(height: 16),

                // Clean segmented selector
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceVariantLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    children: _experienceLevels.map((lvl) {
                      final isSelected = _selectedExperience == lvl['id'];
                      final label = isHindi ? lvl['labelHi']! : lvl['label']!;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedExperience = lvl['id']!);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark ? AppColors.surfaceVariantDark : Colors.white)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isSelected && !isDark
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.04),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                label,
                                style: AppTypography.labelSmall(isDark: isDark).copyWith(
                                  color: isSelected
                                      ? AppColors.primary
                                      : (isDark ? Colors.white60 : AppColors.textSecondaryLight),
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                  fontSize: 12.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 40),

                // 5. Interactive Complete Registration Button
                RegistrationCompletionButton(
                  label: isHindi ? 'पंजीकरण पूर्ण करें' : 'Complete Registration',
                  successLabel: isHindi ? 'पंजीकरण सफल • ओम शान्ति!' : 'Registration Complete • Om Shanti!',
                  state: _buttonState,
                  icon: Icons.volunteer_activism_rounded,
                  onPressed: _handleSignUp,
                ),
                const SizedBox(height: 20),

                // Subtle spiritual commitment note
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 14,
                        color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isHindi
                            ? 'आपकी जानकारी ईश्वरीय मर्यादा में पूर्णतः सुरक्षित है।'
                            : 'Pure vibrations & total spiritual privacy guaranteed.',
                        style: AppTypography.bodySmall(isDark: isDark).copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Sign in link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isHindi ? 'पहले से खाता है?' : 'Already have an account?',
                        style: AppTypography.bodyMedium(isDark: isDark),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                        },
                        child: Text(
                          isHindi ? 'लॉग इन करें' : 'Sign In',
                          style: AppTypography.labelLarge(isDark: isDark).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
