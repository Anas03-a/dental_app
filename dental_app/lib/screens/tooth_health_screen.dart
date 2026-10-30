import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../language_notifier.dart';
import '../theme_notifier.dart';
import 'medical_records_screen.dart';

class ToothHealthScreen extends StatefulWidget {
  const ToothHealthScreen({super.key});

  @override
  State<ToothHealthScreen> createState() => _ToothHealthScreenState();
}

class _ToothHealthScreenState extends State<ToothHealthScreen>
    with TickerProviderStateMixin {
  int _selectedTab = 2; // Overview default
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _progressController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;

  // Health data
  final double _overallHealth = 0.85;
  final double _gumHealth = 0.78;
  final double _plaqueLevel = 0.15;
  final int _cavities = 2;
  final int _lastCheckupDays = 45;

  // Tooth map data
  final List<Map<String, dynamic>> _toothData = [
    {
      'id': 1,
      'name': 'Upper Right Molar',
      'nameAr': 'ضرس علوي أيمن',
      'status': 'healthy',
      'health': 0.95
    },
    {
      'id': 2,
      'name': 'Upper Right Premolar',
      'nameAr': 'ضاحك علوي أيمن',
      'status': 'healthy',
      'health': 0.90
    },
    {
      'id': 3,
      'name': 'Upper Canine',
      'nameAr': 'ناب علوي',
      'status': 'warning',
      'health': 0.70
    },
    {
      'id': 4,
      'name': 'Upper Incisor',
      'nameAr': 'قاطع علوي',
      'status': 'healthy',
      'health': 0.92
    },
    {
      'id': 5,
      'name': 'Upper Left Premolar',
      'nameAr': 'ضاحك علوي أيسر',
      'status': 'cavity',
      'health': 0.55
    },
    {
      'id': 6,
      'name': 'Upper Left Molar',
      'nameAr': 'ضرس علوي أيسر',
      'status': 'healthy',
      'health': 0.88
    },
    {
      'id': 7,
      'name': 'Lower Right Molar',
      'nameAr': 'ضرس سفلي أيمن',
      'status': 'healthy',
      'health': 0.93
    },
    {
      'id': 8,
      'name': 'Lower Incisor',
      'nameAr': 'قاطع سفلي',
      'status': 'healthy',
      'health': 0.97
    },
    {
      'id': 9,
      'name': 'Lower Left Premolar',
      'nameAr': 'ضاحك سفلي أيسر',
      'status': 'cavity',
      'health': 0.45
    },
    {
      'id': 10,
      'name': 'Lower Left Molar',
      'nameAr': 'ضرس سفلي أيسر',
      'status': 'warning',
      'health': 0.65
    },
  ];


  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, _) {
        final bgColor =
            isDark ? const Color(0xFF121212) : const Color(0xFFF0F7FA);
        final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black87;
        final subtitleColor = isDark ? Colors.white60 : Colors.grey;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              t('Tooth Health', 'صحة الأسنان'),
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.circle,
                border: Border.all(
                    color: isDark ? Colors.white12 : Colors.grey.shade300),
              ),
              child: PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: textColor),
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(value)),
                  );
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: t('Export Report', 'تصدير التقرير'),
                      child: Text(t('Export Report', 'تصدير التقرير'))),
                  PopupMenuItem(
                      value: t('Share with Doctor', 'مشاركة مع الطبيب'),
                      child: Text(t('Share with Doctor', 'مشاركة مع الطبيب'))),
                  PopupMenuItem(
                      value: t('Print Report', 'طباعة التقرير'),
                      child: Text(t('Print Report', 'طباعة التقرير'))),
                ],
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  _showDetailedReport(
                      context, isDark, cardColor, textColor, subtitleColor);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: cardColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: isDark ? Colors.white12 : Colors.grey.shade300),
                  ),
                  child: Icon(Icons.arrow_forward, color: textColor),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 120),
                child: Column(
                  children: [
                    // Tabs
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: _buildTab(t('Analysis', 'التحليل'), 0,
                                  isDark, textColor)),
                          Expanded(
                              child: _buildTab(t('Overview', 'نظرة عامة'), 2,
                                  isDark, textColor)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Tab Content
                    if (_selectedTab == 2)
                      _buildOverviewTab(
                          isDark, cardColor, textColor, subtitleColor),
                    if (_selectedTab == 0)
                      _buildAnalysisTab(
                          isDark, cardColor, textColor, subtitleColor),
                  ],
                ),
              ),

              // Floating Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(20).copyWith(bottom: 90),
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor:
                          const Color(0xFF00BFA5).withValues(alpha: 0.4),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Directionality(
                            textDirection: isArabicNotifier.value
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: const MedicalRecordsScreen(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      t('View Full Report', 'عرض التقرير الكامل'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============== TABS ==============

  Widget _buildTab(String title, int index, bool isDark, Color textColor) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedTab = index);
        _progressController.reset();
        _progressController.forward();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00BFA5) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.white60 : Colors.grey),
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // ============== OVERVIEW TAB ==============

  Widget _buildOverviewTab(
      bool isDark, Color cardColor, Color textColor, Color subtitleColor) {
    return Column(
      children: [
        // Animated Tooth
        _buildAnimatedTooth(isDark),
        const SizedBox(height: 25),

        // Overall Status Card
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t('Overall Status', 'الحالة العامة'),
                      style: TextStyle(color: subtitleColor, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getHealthLabel(_overallHealth),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                      Text(
                        '${(_overallHealth * 100 * _progressAnimation.value).toInt()}%',
                        style: TextStyle(
                          color: _getHealthColor(_overallHealth),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _overallHealth * _progressAnimation.value,
                      backgroundColor:
                          isDark ? Colors.white10 : Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          _getHealthColor(_overallHealth)),
                      minHeight: 10,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 15),

        // Metrics Row
        Row(
          children: [
            Expanded(
                child: _buildMetricCardAnimated(
              t('Gum Health', 'اللثة'),
              _gumHealth,
              Icons.favorite,
              isDark,
              cardColor,
              textColor,
              subtitleColor,
            )),
            const SizedBox(width: 10),
            Expanded(
                child: _buildMetricCardAnimated(
              t('Plaque', 'الجير'),
              _plaqueLevel,
              Icons.blur_on,
              isDark,
              cardColor,
              textColor,
              subtitleColor,
            )),
            const SizedBox(width: 10),
            Expanded(
                child: _buildCavityCard(
                    isDark, cardColor, textColor, subtitleColor)),
          ],
        ),
        const SizedBox(height: 15),

        // Next Checkup Reminder
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1A3A35), const Color(0xFF1E2E2A)]
                  : [const Color(0xFFE0F2F1), const Color(0xFFB2DFDB)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child:
                    const Icon(Icons.event, color: Color(0xFF00BFA5), size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t('Next Checkup', 'الفحص القادم'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: textColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t('$_lastCheckupDays days since last visit',
                          'مضى $_lastCheckupDays يوم منذ آخر زيارة'),
                      style: TextStyle(color: subtitleColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  t('Book', 'حجز'),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============== ANALYSIS TAB ==============

  Widget _buildAnalysisTab(
      bool isDark, Color cardColor, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tooth Map
        Text(
          t('Tooth Map', 'خريطة الأسنان'),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
        ),
        const SizedBox(height: 5),
        Text(
          t('Tap on a tooth to see details', 'اضغط على سن لرؤية التفاصيل'),
          style: TextStyle(color: subtitleColor, fontSize: 12),
        ),
        const SizedBox(height: 15),

        // Tooth Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: _toothData.length,
          itemBuilder: (context, index) {
            final tooth = _toothData[index];
            return _buildToothGridItem(tooth, isDark, cardColor, textColor);
          },
        ),
        const SizedBox(height: 20),

        // Legend
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(
                  t('Healthy', 'سليم'), const Color(0xFF4CAF50), textColor),
              _buildLegendItem(t('Warning', 'تحذير'), Colors.orange, textColor),
              _buildLegendItem(t('Cavity', 'تسوس'), Colors.red, textColor),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Detailed Health Bars
        Text(
          t('Detailed Analysis', 'تحليل تفصيلي'),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
        ),
        const SizedBox(height: 15),
        _buildHealthBar(t('Enamel Strength', 'قوة المينا'), 0.88, isDark,
            cardColor, textColor),
        const SizedBox(height: 10),
        _buildHealthBar(
            t('Gum Health', 'صحة اللثة'), 0.78, isDark, cardColor, textColor),
        const SizedBox(height: 10),
        _buildHealthBar(t('Root Integrity', 'سلامة الجذور'), 0.92, isDark,
            cardColor, textColor),
        const SizedBox(height: 10),
        _buildHealthBar(t('Bite Alignment', 'اتساق الإطباق'), 0.75, isDark,
            cardColor, textColor),
        const SizedBox(height: 10),
        _buildHealthBar(t('Plaque Level', 'مستوى الجير'), 0.15, isDark,
            cardColor, textColor,
            isInverse: true),
      ],
    );
  }


  // ============== HELPER WIDGETS ==============


  Widget _buildAnimatedTooth(bool isDark) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: AnimatedBuilder(
            animation: _rotateController,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow ring
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          const Color(0xFF00BFA5).withValues(alpha: 0.1),
                          const Color(0xFF00BFA5).withValues(alpha: 0.4),
                          const Color(0xFF00BFA5).withValues(alpha: 0.1),
                          const Color(0xFF00BFA5).withValues(alpha: 0.4),
                          const Color(0xFF00BFA5).withValues(alpha: 0.1),
                        ],
                        transform: GradientRotation(
                            _rotateController.value * 2 * math.pi),
                      ),
                    ),
                  ),
                  // Main circle
                  Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: isDark
                            ? [const Color(0xFF1A3A35), const Color(0xFF0D2520)]
                            : [
                                const Color(0xFFB2DFDB),
                                const Color(0xFF80CBC4)
                              ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00BFA5).withValues(alpha: 0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: _buildToothIcon(isDark),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildToothIcon(bool isDark) {
    return CustomPaint(
      size: const Size(120, 140),
      painter: ToothPainter(
        color: isDark ? Colors.white : Colors.white,
        glowColor: const Color(0xFF00BFA5),
        health: _overallHealth,
      ),
    );
  }

  Widget _buildMetricCardAnimated(
    String title,
    double value,
    IconData icon,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: _getHealthColor(value), size: 20),
              const SizedBox(height: 8),
              Text(title,
                  style: TextStyle(color: subtitleColor, fontSize: 11),
                  textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Text(
                '${(value * 100 * _progressAnimation.value).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _getHealthColor(value),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCavityCard(
      bool isDark, Color cardColor, Color textColor, Color subtitleColor) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
            ),
          ),
          child: Column(
            children: [
              const Icon(Icons.warning_amber, color: Colors.orange, size: 20),
              const SizedBox(height: 8),
              Text(t('Cavities', 'التسوس'),
                  style: TextStyle(color: subtitleColor, fontSize: 11),
                  textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Text(
                '0${(_cavities * _progressAnimation.value).toInt()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToothGridItem(Map<String, dynamic> tooth, bool isDark,
      Color cardColor, Color textColor) {
    Color statusColor;
    switch (tooth['status']) {
      case 'healthy':
        statusColor = const Color(0xFF4CAF50);
        break;
      case 'warning':
        statusColor = Colors.orange;
        break;
      case 'cavity':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () => _showToothDetail(tooth, isDark, cardColor, textColor),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 300 + ((tooth['id'] as int) * 100)),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: statusColor.withValues(alpha: 0.5), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.medical_services, color: statusColor, size: 28),
              const SizedBox(height: 4),
              Text(
                '#${tooth['id']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, Color textColor) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: textColor, fontSize: 12)),
      ],
    );
  }

  Widget _buildHealthBar(
      String title, double value, bool isDark, Color cardColor, Color textColor,
      {bool isInverse = false}) {
    final displayColor = isInverse
        ? (value < 0.3 ? const Color(0xFF4CAF50) : Colors.orange)
        : _getHealthColor(value);

    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                  Text('${(value * 100 * _progressAnimation.value).toInt()}%',
                      style: TextStyle(
                          color: displayColor, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: value * _progressAnimation.value,
                  backgroundColor:
                      isDark ? Colors.white10 : Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(displayColor),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  // ============== DIALOGS ==============

  void _showToothDetail(Map<String, dynamic> tooth, bool isDark,
      Color cardColor, Color textColor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        Color statusColor;
        String statusText;
        switch (tooth['status']) {
          case 'healthy':
            statusColor = const Color(0xFF4CAF50);
            statusText = t('Healthy', 'سليم');
            break;
          case 'warning':
            statusColor = Colors.orange;
            statusText = t('Needs Attention', 'يحتاج اهتمام');
            break;
          case 'cavity':
            statusColor = Colors.red;
            statusText = t('Cavity Detected', 'تسوس مكتشف');
            break;
          default:
            statusColor = Colors.grey;
            statusText = t('Unknown', 'غير معروف');
        }

        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              Icon(Icons.medical_services, color: statusColor, size: 50),
              const SizedBox(height: 15),
              Text(
                t(tooth['name'], tooth['nameAr']),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: textColor),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(statusText,
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(t('Health: ', 'الصحة: '),
                      style:
                          TextStyle(color: textColor.withValues(alpha: 0.7))),
                  Text('${(tooth['health'] * 100).toInt()}%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                          fontSize: 18)),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    value: tooth['health'],
                    backgroundColor:
                        isDark ? Colors.white10 : Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showDetailedReport(BuildContext context, bool isDark, Color cardColor,
      Color textColor, Color subtitleColor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2))),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      t('Full Dental Report', 'التقرير الطبي الكامل'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: textColor),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      t('Generated on Oct 7, 2026',
                          'تم إنشاؤه في 7 أكتوبر 2026'),
                      style: TextStyle(color: subtitleColor, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _reportItem(
                      t('Overall Health', 'الصحة العامة'),
                      '${(_overallHealth * 100).toInt()}%',
                      _getHealthColor(_overallHealth),
                      textColor),
                  _reportItem(
                      t('Gum Health', 'صحة اللثة'),
                      '${(_gumHealth * 100).toInt()}%',
                      _getHealthColor(_gumHealth),
                      textColor),
                  _reportItem(
                      t('Plaque Level', 'مستوى الجير'),
                      '${(_plaqueLevel * 100).toInt()}%',
                      Colors.orange,
                      textColor),
                  _reportItem(t('Cavities Found', 'عدد التسوسات'), '$_cavities',
                      Colors.red, textColor),
                  _reportItem(t('Days Since Checkup', 'أيام منذ الفحص'),
                      '$_lastCheckupDays', Colors.blue, textColor),
                  const SizedBox(height: 20),
                  Text(t('Recommendations', 'التوصيات'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor)),
                  const SizedBox(height: 10),
                  _recommendationItem(
                      t('Schedule a cleaning appointment', 'حدد موعد تنظيف'),
                      textColor,
                      subtitleColor),
                  _recommendationItem(
                      t('Treat the 2 cavities soon', 'علاج التسوسات قريباً'),
                      textColor,
                      subtitleColor),
                  _recommendationItem(
                      t('Use fluoride toothpaste', 'استخدم معجون بالفلورايد'),
                      textColor,
                      subtitleColor),
                  _recommendationItem(
                      t('Floss daily', 'استخدم خيط الأسنان يومياً'),
                      textColor,
                      subtitleColor),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _reportItem(String label, String value, Color color, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: textColor, fontSize: 14)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(value,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _recommendationItem(
      String text, Color textColor, Color subtitleColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF00BFA5), size: 18),
          const SizedBox(width: 10),
          Expanded(
              child:
                  Text(text, style: TextStyle(color: textColor, fontSize: 13))),
        ],
      ),
    );
  }

  // ============== UTILS ==============

  Color _getHealthColor(double value) {
    if (value >= 0.8) return const Color(0xFF4CAF50);
    if (value >= 0.6) return Colors.orange;
    return Colors.red;
  }

  String _getHealthLabel(double value) {
    if (value >= 0.8) return t('Excellent', 'ممتازة');
    if (value >= 0.6) return t('Good', 'جيدة');
    return t('Needs Attention', 'تحتاج اهتمام');
  }
}

// Custom Tooth Painter
class ToothPainter extends CustomPainter {
  final Color color;
  final Color glowColor;
  final double health;

  ToothPainter(
      {required this.color, required this.glowColor, required this.health});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Draw tooth shape
    // Crown
    path.moveTo(w * 0.2, h * 0.35);
    path.quadraticBezierTo(w * 0.15, h * 0.1, w * 0.3, h * 0.05);
    path.quadraticBezierTo(w * 0.5, h * 0.0, w * 0.7, h * 0.05);
    path.quadraticBezierTo(w * 0.85, h * 0.1, w * 0.8, h * 0.35);

    // Body
    path.quadraticBezierTo(w * 0.85, h * 0.5, w * 0.75, h * 0.6);

    // Right root
    path.quadraticBezierTo(w * 0.78, h * 0.75, w * 0.7, h * 0.9);
    path.quadraticBezierTo(w * 0.67, h * 0.95, w * 0.6, h * 0.85);

    // Middle
    path.quadraticBezierTo(w * 0.5, h * 0.7, w * 0.4, h * 0.85);

    // Left root
    path.quadraticBezierTo(w * 0.33, h * 0.95, w * 0.3, h * 0.9);
    path.quadraticBezierTo(w * 0.22, h * 0.75, w * 0.25, h * 0.6);

    path.quadraticBezierTo(w * 0.15, h * 0.5, w * 0.2, h * 0.35);
    path.close();

    // Draw glow
    canvas.drawPath(path, glowPaint);
    // Draw tooth
    canvas.drawPath(path, paint);

    // Draw smile on tooth
    final smilePaint = Paint()
      ..color = glowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Eyes
    canvas.drawCircle(
        Offset(w * 0.38, h * 0.25), 4, Paint()..color = glowColor);
    canvas.drawCircle(
        Offset(w * 0.62, h * 0.25), 4, Paint()..color = glowColor);

    // Smile
    final smilePath = Path();
    smilePath.moveTo(w * 0.35, h * 0.38);
    smilePath.quadraticBezierTo(w * 0.5, h * 0.5, w * 0.65, h * 0.38);
    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
