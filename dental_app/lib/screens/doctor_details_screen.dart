import 'package:flutter/material.dart';

import '../language_notifier.dart';
import '../theme_notifier.dart';
import 'appointments_screen.dart';
import 'doctor_chat_screen.dart';
import 'generic_screen.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
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
          body: Stack(
            children: [
              // Doctor Image Background
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 350,
                child: doctor['imageUrl'] != null
                    ? Image.asset(doctor['imageUrl'], fit: BoxFit.cover)
                    : Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ),
              ),

              // Back Button and Actions
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GenericScreen(
                                titleEn: 'Favorites',
                                titleAr: 'المفضلة',
                                icon: Icons.favorite,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Color(0xFF00BFA5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Details Card
              Positioned(
                top: 300,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      bottom: 100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isArabicNotifier.value
                                        ? doctor['nameAr']
                                        : doctor['nameEn'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    isArabicNotifier.value
                                        ? doctor['specAr']
                                        : doctor['specEn'],
                                    style: const TextStyle(
                                      color: Color(0xFF00BFA5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    doctor['rating'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatCard(
                              context,
                              Icons.people,
                              t('Patients', 'المرضى'),
                              '+1000',
                              isDark,
                              cardColor,
                              textColor,
                              subtitleColor,
                            ),
                            _buildStatCard(
                              context,
                              Icons.work,
                              t('Experience', 'الخبرة'),
                              doctor['exp'],
                              isDark,
                              cardColor,
                              textColor,
                              subtitleColor,
                            ),
                            _buildStatCard(
                              context,
                              Icons.star_rate,
                              t('Reviews', 'تقييمات'),
                              doctor['reviews'],
                              isDark,
                              cardColor,
                              textColor,
                              subtitleColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // Communication & Location
                        Text(
                          t('Contact & Location', 'المراسلة والموقع'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DoctorChatScreen(doctor: doctor),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1A3A35)
                                        : const Color(0xFFE0F2F1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.chat,
                                        color: Color(0xFF00BFA5),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        t('Message', 'مراسلة'),
                                        style: const TextStyle(
                                          color: Color(0xFF00BFA5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const GenericScreen(
                                        titleEn: 'Calling Clinic...',
                                        titleAr: 'جاري الاتصال بالعيادة...',
                                        icon: Icons.call,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1A3A35)
                                        : const Color(0xFFE0F2F1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.call,
                                        color: Color(0xFF00BFA5),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        t('Call', 'اتصال'),
                                        style: const TextStyle(
                                          color: Color(0xFF00BFA5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Clinic Location
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.05),
                                spreadRadius: 1,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          t('Clinic Location', 'موقع العيادة'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: textColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          t(
                                            doctor['locationEn'] ??
                                                "Ma'an City, Main Street",
                                            doctor['locationAr'] ??
                                                'مدينة معان، الشارع الرئيسي',
                                          ),
                                          style: TextStyle(
                                            color: subtitleColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Go to Location Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isDark
                                        ? const Color(0xFF1A3A35)
                                        : Colors.blue.shade50,
                                    foregroundColor: Colors.blue,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: const Icon(Icons.directions,
                                      color: Colors.blue),
                                  label: Text(
                                    t('Go to Location', 'اذهب إلى الموقع'),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          t(
                                            'Opening maps to ${doctor['locationEn'] ?? "clinic"}...',
                                            'جارٍ فتح الخرائط إلى ${doctor['locationAr'] ?? "العيادة"}...',
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Price
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.05),
                                spreadRadius: 1,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.payments,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t('Consultation Fee',
                                          'رسوم الكشفية'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      t(
                                        doctor['priceEn'] ?? doctor['price'],
                                        doctor['price'],
                                      ),
                                      style: const TextStyle(
                                        color: Color(0xFF00BFA5),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF1A3A35)
                                      : const Color(0xFFE0F2F1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  t('JD', 'د.أ'),
                                  style: const TextStyle(
                                    color: Color(0xFF00BFA5),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Description
                        Text(
                          t('About Doctor', 'عن الطبيب'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isArabicNotifier.value
                              ? doctor['descAr']
                              : doctor['descEn'],
                          style:
                              TextStyle(color: subtitleColor, height: 1.5),
                        ),
                        const SizedBox(height: 25),

                        // Working Hours
                        Text(
                          t('Working Hours', 'ساعات العمل'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.05),
                                spreadRadius: 1,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildWorkingHourRow(
                                t('Sat - Thu', 'السبت - الخميس'),
                                t('9:00 AM - 5:00 PM',
                                    '9:00 ص - 5:00 م'),
                                true,
                                textColor,
                                subtitleColor,
                              ),
                              Divider(
                                  color: isDark
                                      ? Colors.white10
                                      : Colors.grey.shade200),
                              _buildWorkingHourRow(
                                t('Friday', 'الجمعة'),
                                t('Closed', 'مغلق'),
                                false,
                                textColor,
                                subtitleColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Book Appointment Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SizedBox(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppointmentsScreen(),
                          ),
                        );
                      },
                      child: Text(
                        t('Book Appointment', 'احجز موعد الآن'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    String title,
    String value,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1A3A35)
                  : const Color(0xFFE0F2F1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF00BFA5), size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: textColor),
          ),
          const SizedBox(height: 5),
          Text(title,
              style: TextStyle(color: subtitleColor, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildWorkingHourRow(
    String day,
    String hours,
    bool isOpen,
    Color textColor,
    Color subtitleColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: isOpen ? const Color(0xFF00BFA5) : Colors.red,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                day,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isOpen
                  ? const Color(0xFF00BFA5).withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              hours,
              style: TextStyle(
                color: isOpen ? const Color(0xFF00BFA5) : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
