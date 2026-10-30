import 'package:flutter/material.dart';
import '../language_notifier.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        title: Text(t('Notifications', 'الإشعارات'),
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black87),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          List<Map<String, String>> notifs = [
            {
              'en': 'Your appointment is confirmed for tomorrow at 10:30 AM.',
              'ar': 'تم تأكيد موعدك غداً الساعة 10:30 صباحاً.'
            },
            {
              'en': 'Don\'t forget to brush your teeth before bed!',
              'ar': 'لا تنسى غسل أسنانك قبل النوم!'
            },
            {
              'en': 'New offer: 20% off on Teeth Whitening.',
              'ar': 'عرض جديد: خصم 20% على تبييض الأسنان.'
            },
            {
              'en': 'Dr. Sarah replied to your message.',
              'ar': 'قامت د. سارة بالرد على رسالتك.'
            },
          ];
          return Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.05),
                    spreadRadius: 1,
                    blurRadius: 5)
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color(0xFFE0F2F1), shape: BoxShape.circle),
                  child:
                      const Icon(Icons.notifications, color: Color(0xFF00BFA5)),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t(notifs[index]['en']!, notifs[index]['ar']!),
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      Text(t('2 hours ago', 'منذ ساعتين'),
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
