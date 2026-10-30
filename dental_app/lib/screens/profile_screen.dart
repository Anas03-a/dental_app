import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';
import 'generic_screen.dart';
import 'medical_records_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, _) {
        final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
        final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black87;
        final subtitleColor = isDark ? Colors.white60 : Colors.grey;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            centerTitle: true,
            title: Text(t('My Profile', 'الملف الشخصي'),
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const GenericScreen(
                            titleEn: 'Settings',
                            titleAr: 'الإعدادات',
                            icon: Icons.settings)));
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isDark ? Colors.white12 : Colors.grey.shade300),
                ),
                child: Icon(Icons.settings, color: textColor),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const GenericScreen(
                              titleEn: 'Edit Profile',
                              titleAr: 'تعديل الحساب',
                              icon: Icons.edit)));
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20).copyWith(bottom: 100),
            child: Column(
              children: [
                // Profile Picture
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF00BFA5), width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://i.pravatar.cc/150?img=11'),
                  ),
                ),
                const SizedBox(height: 15),

                // Name and Details
                Text(t('Alex Johnson', 'أليكس جونسون'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textColor)),
                const SizedBox(height: 5),
                Text('alex.johnson@gmail.com',
                    style: TextStyle(color: subtitleColor, fontSize: 14)),
                const SizedBox(height: 5),
                Text('+1 234 567 890 / +966 50 123 4567',
                    style: TextStyle(color: subtitleColor, fontSize: 14)),
                const SizedBox(height: 30),

                // Menu List
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          spreadRadius: 1,
                          blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildMenuItem(
                          context,
                          Icons.description,
                          t('Medical Records', 'السجلات الطبية'),
                          textColor,
                          subtitleColor,
                          isDark),
                      Divider(
                          color: isDark ? Colors.white12 : Colors.black12,
                          height: 1),
                      _buildMenuItem(
                          context,
                          Icons.payment,
                          t('Payment Methods', 'طرق الدفع والفواتير'),
                          textColor,
                          subtitleColor,
                          isDark),
                      Divider(
                          color: isDark ? Colors.white12 : Colors.black12,
                          height: 1),
                      _buildMenuItem(
                          context,
                          Icons.calendar_month,
                          t('Appointment History', 'سجل المواعيد'),
                          textColor,
                          subtitleColor,
                          isDark),
                      Divider(
                          color: isDark ? Colors.white12 : Colors.black12,
                          height: 1),
                      _buildMenuItemWithToggle(
                          context,
                          Icons.notifications,
                          t('Reminders', 'التنبيهات والتذكير'),
                          true,
                          textColor,
                          isDark),
                      Divider(
                          color: isDark ? Colors.white12 : Colors.black12,
                          height: 1),
                      _buildMenuItem(
                          context,
                          Icons.help_outline,
                          t('FAQ & Support', 'الأسئلة والدعم'),
                          textColor,
                          subtitleColor,
                          isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title,
      Color textColor, Color subtitleColor, bool isDark) {
    return ListTile(
      onTap: () {
        if (title == 'Medical Records' || title == 'السجلات الطبية') {
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
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GenericScreen(
                      titleEn: title, titleAr: title, icon: icon)));
        }
      },
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A3A35) : const Color(0xFFE0F2F1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF00BFA5)),
      ),
      title: Text(title,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: textColor)),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16, color: subtitleColor),
    );
  }

  Widget _buildMenuItemWithToggle(BuildContext context, IconData icon,
      String title, bool isToggled, Color textColor, bool isDark) {
    return StatefulBuilder(builder: (context, setState) {
      return ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A3A35) : const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF00BFA5)),
        ),
        title: Text(title,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: textColor)),
        trailing: Switch(
          value: isToggled,
          onChanged: (val) {
            setState(() {
              isToggled = val;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(title + (val ? ' On' : ' Off'))));
          },
          activeThumbColor: const Color(0xFF00BFA5),
        ),
      );
    });
  }
}
