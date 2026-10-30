import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';
import 'medical_records_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              t('Settings', 'الإعدادات'),
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back, color: textColor),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Appearance Section
                Text(
                  t('Appearance', 'المظهر'),
                  style: const TextStyle(
                    color: Color(0xFF00BFA5),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
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
                    children: [
                      // Dark Mode Toggle
                      ValueListenableBuilder<bool>(
                        valueListenable: isDarkModeNotifier,
                        builder: (context, darkMode, _) {
                          return _buildSettingTile(
                            icon: darkMode ? Icons.dark_mode : Icons.light_mode,
                            iconColor: darkMode
                                ? Colors.amber
                                : const Color(0xFF00BFA5),
                            title: t('Dark Mode', 'الوضع الداكن'),
                            subtitle: t(
                              darkMode
                                  ? 'Dark theme is active'
                                  : 'Light theme is active',
                              darkMode
                                  ? 'الوضع الداكن مفعّل'
                                  : 'الوضع الفاتح مفعّل',
                            ),
                            textColor: textColor,
                            subtitleColor: subtitleColor,
                            trailing: Switch(
                              value: darkMode,
                              onChanged: (val) {
                                isDarkModeNotifier.value = val;
                              },
                              activeThumbColor: const Color(0xFF00BFA5),
                            ),
                          );
                        },
                      ),
                      Divider(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                          height: 1),
                      // Language
                      ValueListenableBuilder<bool>(
                        valueListenable: isArabicNotifier,
                        builder: (context, isArabic, _) {
                          return _buildSettingTile(
                            icon: Icons.language,
                            iconColor: Colors.blue,
                            title: t('Language', 'اللغة'),
                            subtitle: isArabic ? 'العربية' : 'English',
                            textColor: textColor,
                            subtitleColor: subtitleColor,
                            trailing: Switch(
                              value: isArabic,
                              onChanged: (val) {
                                isArabicNotifier.value = val;
                              },
                              activeThumbColor: const Color(0xFF00BFA5),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Notifications Section
                Text(
                  t('Notifications', 'الإشعارات'),
                  style: const TextStyle(
                    color: Color(0xFF00BFA5),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
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
                    children: [
                      _buildSettingTileWithSwitch(
                        icon: Icons.notifications_active,
                        iconColor: Colors.orange,
                        title: t('Push Notifications', 'الإشعارات الفورية'),
                        subtitle: t('Get notified about appointments',
                            'تلقي إشعارات حول المواعيد'),
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                        initialValue: true,
                      ),
                      Divider(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                          height: 1),
                      _buildSettingTileWithSwitch(
                        icon: Icons.email_outlined,
                        iconColor: Colors.purple,
                        title: t('Email Notifications', 'إشعارات البريد'),
                        subtitle: t('Receive updates via email',
                            'تلقي التحديثات عبر البريد'),
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                        initialValue: false,
                      ),
                      Divider(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                          height: 1),
                      _buildSettingTileWithSwitch(
                        icon: Icons.access_alarm,
                        iconColor: Colors.teal,
                        title: t('Appointment Reminders', 'تذكير المواعيد'),
                        subtitle: t('Get reminded before appointments',
                            'تذكير قبل المواعيد'),
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                        initialValue: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Account Section
                Text(
                  t('Account', 'الحساب'),
                  style: const TextStyle(
                    color: Color(0xFF00BFA5),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
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
                    children: [
                      _buildSettingNavTile(
                        context: context,
                        icon: Icons.folder_shared,
                        iconColor: const Color(0xFF00BFA5),
                        title: t('Medical Records', 'السجلات الطبية'),
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                        onTapOverride: () {
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
                      ),
                      Divider(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                          height: 1),
                      _buildSettingNavTile(
                        context: context,
                        icon: Icons.lock_outline,
                        iconColor: Colors.red,
                        title: t('Change Password', 'تغيير كلمة المرور'),
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                      ),
                      Divider(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                          height: 1),
                      _buildSettingNavTile(
                        context: context,
                        icon: Icons.privacy_tip_outlined,
                        iconColor: Colors.indigo,
                        title: t('Privacy Policy', 'سياسة الخصوصية'),
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                      ),
                      Divider(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                          height: 1),
                      _buildSettingNavTile(
                        context: context,
                        icon: Icons.info_outline,
                        iconColor: Colors.cyan,
                        title: t('About App', 'عن التطبيق'),
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark ? const Color(0xFF2A2A2A) : Colors.red.shade50,
                      foregroundColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(Icons.logout),
                    label: Text(
                      t('Sign Out', 'تسجيل الخروج'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(t('Signed out', 'تم تسجيل الخروج'))),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),

                // Version
                Center(
                  child: Text(
                    t('Version 1.0.0', 'الإصدار 1.0.0'),
                    style: TextStyle(color: subtitleColor, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color subtitleColor,
    required Widget trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(title,
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w600)),
      subtitle:
          Text(subtitle, style: TextStyle(color: subtitleColor, fontSize: 12)),
      trailing: trailing,
    );
  }

  Widget _buildSettingTileWithSwitch({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color subtitleColor,
    required bool initialValue,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool value = initialValue;
        return _buildSettingTile(
          icon: icon,
          iconColor: iconColor,
          title: title,
          subtitle: subtitle,
          textColor: textColor,
          subtitleColor: subtitleColor,
          trailing: Switch(
            value: value,
            onChanged: (val) {
              setState(() => value = val);
            },
            activeThumbColor: const Color(0xFF00BFA5),
          ),
        );
      },
    );
  }

  Widget _buildSettingNavTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color textColor,
    required Color subtitleColor,
    VoidCallback? onTapOverride,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: onTapOverride ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(title)),
        );
      },
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(title,
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: subtitleColor),
    );
  }
}
