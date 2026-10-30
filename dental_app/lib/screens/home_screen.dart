import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';
import 'doctor_details_screen.dart';
import 'appointments_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';
import 'generic_screen.dart';
import 'articles_screen.dart';
import 'article_detail_screen.dart';
import 'medical_records_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _counterAnimController;
  late Animation<double> _counterAnimation;

  final List<Map<String, dynamic>> doctors = [
    {
      'nameEn': 'Dr. Michael Chen',
      'nameAr': 'د. محمود حسن',
      'specEn': 'Oral Surgeon',
      'specAr': 'جراح فم وأسنان',
      'exp': '15 Years',
      'rating': '5.0',
      'reviews': '(2350)',
      'price': '25 د.أ',
      'priceEn': '25 JD',
      'city': 'عمّان',
      'cityEn': 'Amman',
      'locationEn': 'Abdali Medical Center, Amman',
      'locationAr': 'مركز العبدلي الطبي، عمّان',
      'imageUrl': 'doctor/2.jpg',
      'descEn':
          'Dr. Michael specializes in oral surgery, implants and complex extractions.',
      'descAr':
          'متخصص في جراحة الفم والزراعة وخلع الأسنان المعقدة باستخدام أحدث التقنيات.'
    },
    {
      'nameEn': 'Dr. Ahmad Khalil',
      'nameAr': 'د. أحمد خليل',
      'specEn': 'Orthodontist',
      'specAr': 'أخصائي تقويم الأسنان',
      'exp': '10 Years',
      'rating': '4.9',
      'reviews': '(1820)',
      'price': '35 د.أ',
      'priceEn': '35 JD',
      'city': 'إربد',
      'cityEn': 'Irbid',
      'locationEn': 'Irbid Specialty Dental Clinic, University St.',
      'locationAr': 'عيادة إربد التخصصية للأسنان، شارع الجامعة',
      'imageUrl': 'doctor/1.jpg',
      'descEn':
          'Dr. Ahmad has over 10 years of experience in orthodontics and offers the best services.',
      'descAr':
          'يمتلك د. أحمد خبرة تزيد عن 10 سنوات في تقويم الأسنان وتقديم أفضل الحلول للحصول على ابتسامة مثالية.'
    },
    {
      'nameEn': 'Dr. Omar Nasser',
      'nameAr': 'د. عمر ناصر',
      'specEn': 'Pediatric Dentist',
      'specAr': 'طبيب أسنان أطفال',
      'exp': '8 Years',
      'rating': '4.8',
      'reviews': '(950)',
      'price': '15 د.أ',
      'priceEn': '15 JD',
      'city': 'معان',
      'cityEn': "Ma'an",
      'locationEn': "Ma'an Dental Care, Main Street",
      'locationAr': 'عيادة معان لطب الأسنان، الشارع الرئيسي',
      'imageUrl': 'doctor/3.jpg',
      'descEn':
          'Friendly and gentle approach making kids comfortable during dental visits.',
      'descAr':
          'طبيب ودود ولطيف في التعامل مع الأطفال لضمان راحة طفلك أثناء زيارة العيادة.'
    },
    {
      'nameEn': 'Dr. Lina Haddad',
      'nameAr': 'د. لينا حداد',
      'specEn': 'Cosmetic Dentist',
      'specAr': 'أخصائية تجميل أسنان',
      'exp': '12 Years',
      'rating': '4.7',
      'reviews': '(1120)',
      'price': '30 د.أ',
      'priceEn': '30 JD',
      'city': 'عمّان',
      'cityEn': 'Amman',
      'locationEn': 'Sweifieh Medical Complex, Amman',
      'locationAr': 'مجمع الصويفية الطبي، عمّان',
      'imageUrl': 'doctor/4.jpg',
      'descEn':
          'Expert in veneers, teeth whitening, and full mouth rehabilitation.',
      'descAr':
          'خبيرة في ابتسامة هوليود وتبييض الأسنان وإعادة تأهيل الفم بالكامل.'
    },
    {
      'nameEn': 'Dr. Olivia Wilson',
      'nameAr': 'د. نورة سالم',
      'specEn': 'Endodontist',
      'specAr': 'علاج عصب الأسنان',
      'exp': '9 Years',
      'rating': '4.9',
      'reviews': '(1450)',
      'price': '20 د.أ',
      'priceEn': '20 JD',
      'city': 'الزرقاء',
      'cityEn': 'Zarqa',
      'locationEn': 'Zarqa Modern Dental Center, King Abdullah St.',
      'locationAr': 'مركز الزرقاء الحديث للأسنان، شارع الملك عبدالله',
      'imageUrl': 'doctor/5.jpg',
      'descEn':
          'Painless root canal treatments using the latest micro-dentistry tools.',
      'descAr':
          'علاج جذور وعصب الأسنان بدون ألم باستخدام أحدث تقنيات طب الأسنان المجهري.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _counterAnimController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
    _counterAnimation = CurvedAnimation(
      parent: _counterAnimController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _counterAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isArabicNotifier,
      builder: (context, isArabic, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: isDarkModeNotifier,
          builder: (context, isDark, _) {
            final bgColor =
                isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
            final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
            final textColor = isDark ? Colors.white : Colors.black87;
            final subtitleColor = isDark ? Colors.white60 : Colors.grey;

            return Scaffold(
              backgroundColor: bgColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20).copyWith(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    'https://i.pravatar.cc/150?img=11'),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const NotificationsScreen()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.grey.withValues(alpha: 0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Icon(Icons.notifications_none,
                                      color: textColor),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Settings Button
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const SettingsScreen()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.grey.withValues(alpha: 0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Icon(Icons.settings, color: textColor),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Dark Mode Toggle
                              InkWell(
                                onTap: () {
                                  isDarkModeNotifier.value = !isDark;
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF2A2A2A)
                                        : const Color(0xFF00BFA5)
                                            .withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (child, animation) {
                                      return RotationTransition(
                                        turns: animation,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      isDark
                                          ? Icons.light_mode
                                          : Icons.dark_mode,
                                      key: ValueKey(isDark),
                                      color: isDark
                                          ? Colors.amber
                                          : const Color(0xFF00BFA5),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ValueListenableBuilder<bool>(
                                valueListenable: isArabicNotifier,
                                builder: (context, isAr, child) => InkWell(
                                  onTap: () {
                                    isArabicNotifier.value = !isAr;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00BFA5)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      isAr ? 'EN' : 'عربي',
                                      style: const TextStyle(
                                        color: Color(0xFF00BFA5),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(t('Good Morning,', 'صباح الخير،'),
                                  style: TextStyle(
                                      color: subtitleColor, fontSize: 14)),
                              Text('Alex 👋',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: textColor)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Search Bar with Filter
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.05),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: TextField(
                                textAlign: isArabicNotifier.value
                                    ? TextAlign.right
                                    : TextAlign.left,
                                style: TextStyle(color: textColor),
                                decoration: InputDecoration(
                                  hintText:
                                      t('Search doctor...', 'ابحث عن طبيب...'),
                                  hintStyle: TextStyle(color: subtitleColor),
                                  border: InputBorder.none,
                                  suffixIcon:
                                      Icon(Icons.search, color: subtitleColor),
                                  prefixIcon: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Color(0xFF00BFA5)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => _showSearchFilter(context, isDark,
                                cardColor, textColor, subtitleColor),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00BFA5),
                                    Color(0xFF00897B)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00BFA5)
                                        .withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.tune,
                                  color: Colors.white, size: 22),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // ========== STATUS TRACKING COUNTERS ==========
                      Text(
                        t('Health Status', 'حالة الصحة'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                              child: _buildCounterCard(
                            icon: Icons.calendar_month,
                            label: t('Visits', 'الزيارات'),
                            count: 12,
                            color: const Color(0xFF00BFA5),
                            isDark: isDark,
                            cardColor: cardColor,
                            textColor: textColor,
                            subtitleColor: subtitleColor,
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: _buildCounterCard(
                            icon: Icons.medical_services,
                            label: t('Treatments', 'العلاجات'),
                            count: 5,
                            color: Colors.blue,
                            isDark: isDark,
                            cardColor: cardColor,
                            textColor: textColor,
                            subtitleColor: subtitleColor,
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: _buildCounterCard(
                            icon: Icons.favorite,
                            label: t('Health', 'الصحة'),
                            count: 85,
                            suffix: '%',
                            color: Colors.green,
                            isDark: isDark,
                            cardColor: cardColor,
                            textColor: textColor,
                            subtitleColor: subtitleColor,
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: _buildCounterCard(
                            icon: Icons.star,
                            label: t('Score', 'النقاط'),
                            count: 750,
                            color: Colors.amber,
                            isDark: isDark,
                            cardColor: cardColor,
                            textColor: textColor,
                            subtitleColor: subtitleColor,
                          )),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Next Appointment Card
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AppointmentsScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00BFA5)
                                    .withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(Icons.sentiment_satisfied_alt,
                                      color: Color(0xFF00BFA5), size: 50),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t('Your Next Appointment',
                                          'موعدك القادم'),
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text('Dr. Michael Chen',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text(t('Oral Surgeon', 'جراح فم وأسنان'),
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12)),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            color: Colors.white, size: 14),
                                        const SizedBox(width: 5),
                                        Text(
                                          t('May 28 - 10:30 AM',
                                              '28 مايو - 10:30 ص'),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const AppointmentsScreen()));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withValues(alpha: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white
                                                .withValues(alpha: 0.5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(t('Reschedule', 'تعديل'),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(width: 5),
                                            const Icon(Icons.arrow_forward,
                                                color: Colors.white, size: 16),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Quick Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t('Quick Actions', 'إجراءات سريعة'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: textColor)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const GenericScreen(
                                          titleEn: 'All Actions',
                                          titleAr: 'جميع الإجراءات',
                                          icon: Icons.dashboard)));
                            },
                            child: Text(t('See All', 'عرض الكل'),
                                style: const TextStyle(
                                    color: Color(0xFF00BFA5),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildQuickAction(
                              context,
                              Icons.local_hospital,
                              'Emergency',
                              'طوارئ 24/7',
                              Colors.red.shade100,
                              Colors.red,
                              isDark,
                              textColor),
                          _buildQuickAction(
                              context,
                              Icons.article,
                              'Articles',
                              'مقالات',
                              Colors.green.shade100,
                              Colors.green,
                              isDark,
                              textColor),
                          _buildQuickAction(
                              context,
                              Icons.folder_shared,
                              'Your Records',
                              'سجلاتك',
                              Colors.purple.shade100,
                              Colors.purple,
                              isDark,
                              textColor),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Dental Health Score
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const GenericScreen(
                                      titleEn: 'Health Score',
                                      titleAr: 'التقييم الصحي',
                                      icon: Icons.health_and_safety)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.05),
                                spreadRadius: 1,
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        t('Dental Health Score',
                                            'تقييم صحة الأسنان'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: textColor)),
                                    const SizedBox(height: 5),
                                    Text(t('Great! 👍', 'ممتاز ورائع 👍'),
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(
                                      t("You're doing an amazing job caring for your teeth.",
                                          "أنت تقوم بعمل رائع في العناية بأسنانك."),
                                      style: TextStyle(
                                          color: subtitleColor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: AnimatedBuilder(
                                      animation: _counterAnimation,
                                      builder: (context, _) {
                                        return CircularProgressIndicator(
                                          value: 0.85 * _counterAnimation.value,
                                          strokeWidth: 8,
                                          backgroundColor: isDark
                                              ? Colors.white10
                                              : Colors.grey.shade200,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(Color(0xFF00BFA5)),
                                        );
                                      },
                                    ),
                                  ),
                                  AnimatedBuilder(
                                    animation: _counterAnimation,
                                    builder: (context, _) {
                                      return Text(
                                        '${(85 * _counterAnimation.value).toInt()}%',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xFF00BFA5)),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Dentists
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t('Book with your doctor', 'احجز موعد مع طبيبك'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: textColor)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const GenericScreen(
                                          titleEn: 'All Dentists',
                                          titleAr: 'جميع الأطباء',
                                          icon: Icons.medical_information)));
                            },
                            child: Text(t('See All', 'عرض الكل'),
                                style: const TextStyle(
                                    color: Color(0xFF00BFA5),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            return _buildDoctorCard(context, doctors[index],
                                isDark, cardColor, textColor, subtitleColor);
                          },
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Latest Articles
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t('Latest Articles', 'أحدث المقالات'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: textColor)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ArticlesScreen()));
                            },
                            child: Text(t('See All', 'عرض الكل'),
                                style: const TextStyle(
                                    color: Color(0xFF00BFA5),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ...ArticlesScreen.articles.take(3).map(
                            (article) => _buildArticleCard(context, article,
                                isDark, cardColor, textColor, subtitleColor),
                          ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ========== STATUS COUNTER CARD ==========
  Widget _buildCounterCard({
    required IconData icon,
    required String label,
    required int count,
    String suffix = '',
    required Color color,
    required bool isDark,
    required Color cardColor,
    required Color textColor,
    required Color subtitleColor,
  }) {
    return AnimatedBuilder(
      animation: _counterAnimation,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(height: 8),
              Text(
                '${(count * _counterAnimation.value).toInt()}$suffix',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(color: subtitleColor, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickAction(
      BuildContext context,
      IconData icon,
      String enTitle,
      String arTitle,
      Color bgColor,
      Color iconColor,
      bool isDark,
      Color textColor) {
    return InkWell(
      onTap: () {
        if (enTitle == 'Articles') {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ArticlesScreen()));
        } else if (enTitle == 'Your Records') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Directionality(
                        textDirection: isArabicNotifier.value
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: const MedicalRecordsScreen(),
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GenericScreen(
                      titleEn: enTitle, titleAr: arTitle, icon: icon)));
        }
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isDark ? bgColor.withValues(alpha: 0.2) : bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: iconColor.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: iconColor, size: 30),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(t(enTitle, arTitle),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isDark ? Colors.white : Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, Map<String, dynamic> doctor,
      bool isDark, Color cardColor, Color textColor, Color subtitleColor) {
    bool isAr = isArabicNotifier.value;
    String name = isAr ? doctor['nameAr'] : doctor['nameEn'];
    String spec = isAr ? doctor['specAr'] : doctor['specEn'];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetailsScreen(doctor: doctor)));
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isDark ? Colors.white12 : const Color(0xFFE0F2F1),
              width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor)),
                  Text(doctor['exp'],
                      style: TextStyle(color: subtitleColor, fontSize: 12)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(' ${doctor['rating']} ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor)),
                      Text(doctor['reviews'],
                          style: TextStyle(color: subtitleColor, fontSize: 12)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1A3A35)
                          : const Color(0xFFE0F2F1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(spec,
                        style: const TextStyle(
                            color: Color(0xFF00BFA5),
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 80,
                height: 100,
                color: Colors.grey.shade300,
                child: Image.asset(
                  doctor['imageUrl'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(
    BuildContext context,
    Map<String, dynamic> article,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: (article['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                article['icon'] as IconData,
                color: article['color'] as Color,
                size: 26,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t(article['titleEn'], article['titleAr']),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t(article['summaryEn'], article['summaryAr']),
                    style: TextStyle(color: subtitleColor, fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: subtitleColor),
          ],
        ),
      ),
    );
  }

  void _showSearchFilter(BuildContext context, bool isDark, Color cardColor,
      Color textColor, Color subtitleColor) {
    String selectedCity = '';
    String selectedSort = '';

    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      t('Search Filters', 'فلتر البحث'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Location Filter
                  Text(
                    t('Location', 'الموقع'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildFilterChip(
                          t('Amman', 'عمّان'), selectedCity == 'amman', isDark,
                          () {
                        setModalState(() => selectedCity =
                            selectedCity == 'amman' ? '' : 'amman');
                      }),
                      _buildFilterChip(
                          t('Irbid', 'إربد'), selectedCity == 'irbid', isDark,
                          () {
                        setModalState(() => selectedCity =
                            selectedCity == 'irbid' ? '' : 'irbid');
                      }),
                      _buildFilterChip(
                          t('Ma\'an', 'معان'), selectedCity == 'maan', isDark,
                          () {
                        setModalState(() => selectedCity =
                            selectedCity == 'maan' ? '' : 'maan');
                      }),
                      _buildFilterChip(t('Zarqa', 'الزرقاء'),
                          selectedCity == 'zarqa', isDark, () {
                        setModalState(() => selectedCity =
                            selectedCity == 'zarqa' ? '' : 'zarqa');
                      }),
                      _buildFilterChip(
                          t('Aqaba', 'العقبة'), selectedCity == 'aqaba', isDark,
                          () {
                        setModalState(() => selectedCity =
                            selectedCity == 'aqaba' ? '' : 'aqaba');
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sort Filter
                  Text(
                    t('Sort By', 'ترتيب حسب'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildFilterChip(t('Lowest Price', 'الأقل سعراً'),
                          selectedSort == 'price_low', isDark, () {
                        setModalState(() => selectedSort =
                            selectedSort == 'price_low' ? '' : 'price_low');
                      }),
                      _buildFilterChip(t('Highest Price', 'الأعلى سعراً'),
                          selectedSort == 'price_high', isDark, () {
                        setModalState(() => selectedSort =
                            selectedSort == 'price_high' ? '' : 'price_high');
                      }),
                      _buildFilterChip(t('Highest Rating', 'الأعلى تقييماً'),
                          selectedSort == 'rating', isDark, () {
                        setModalState(() => selectedSort =
                            selectedSort == 'rating' ? '' : 'rating');
                      }),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFA5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        shadowColor:
                            const Color(0xFF00BFA5).withValues(alpha: 0.4),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                t('Filters applied!', 'تم تطبيق الفلاتر!')),
                          ),
                        );
                      },
                      child: Text(
                        t('Apply Filters', 'تطبيق الفلاتر'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Reset Button
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setModalState(() {
                          selectedCity = '';
                          selectedSort = '';
                        });
                      },
                      child: Text(
                        t('Reset All', 'إعادة تعيين'),
                        style: const TextStyle(
                          color: Color(0xFF00BFA5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterChip(
      String label, bool isSelected, bool isDark, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                )
              : null,
          color: isSelected
              ? null
              : (isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00BFA5)
                : (isDark ? Colors.white12 : Colors.grey.shade300),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.black54),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
