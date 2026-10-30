import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

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

        final List<Map<String, dynamic>> records = [
          {
            'date': '2026-09-15',
            'typeEn': 'Regular Checkup',
            'typeAr': 'فحص دوري',
            'doctorEn': 'Dr. Sarah Johnson',
            'doctorAr': 'د. سارة الأحمد',
            'statusEn': 'Completed',
            'statusAr': 'مكتمل',
            'notesEn':
                'Overall dental health is good. Minor plaque buildup on lower molars. Recommended professional cleaning.',
            'notesAr':
                'صحة الأسنان العامة جيدة. تراكم بسيط للبلاك على الأضراس السفلية. ينصح بتنظيف مهني.',
            'icon': Icons.check_circle,
            'color': const Color(0xFF4CAF50),
          },
          {
            'date': '2026-08-20',
            'typeEn': 'Teeth Cleaning',
            'typeAr': 'تنظيف أسنان',
            'doctorEn': 'Dr. Michael Chen',
            'doctorAr': 'د. محمود حسن',
            'statusEn': 'Completed',
            'statusAr': 'مكتمل',
            'notesEn':
                'Professional scaling and polishing performed. All teeth cleaned thoroughly. No issues found.',
            'notesAr':
                'تم إجراء تقشير وتلميع مهني. تم تنظيف جميع الأسنان بشكل شامل. لم يتم العثور على مشاكل.',
            'icon': Icons.cleaning_services,
            'color': const Color(0xFF2196F3),
          },
          {
            'date': '2026-07-10',
            'typeEn': 'Tooth Filling',
            'typeAr': 'حشوة سن',
            'doctorEn': 'Dr. Sarah Johnson',
            'doctorAr': 'د. سارة الأحمد',
            'statusEn': 'Completed',
            'statusAr': 'مكتمل',
            'notesEn':
                'Composite filling placed on upper left premolar (#5). Cavity was moderate depth. Post-operative sensitivity expected for 1-2 weeks.',
            'notesAr':
                'تم وضع حشوة مركبة على الضاحك العلوي الأيسر (#5). كان التسوس بعمق متوسط. من المتوقع حساسية بعد العملية لمدة 1-2 أسبوع.',
            'icon': Icons.build,
            'color': const Color(0xFFFF9800),
          },
          {
            'date': '2026-06-05',
            'typeEn': 'Root Canal',
            'typeAr': 'علاج عصب',
            'doctorEn': 'Dr. Olivia Wilson',
            'doctorAr': 'د. نورة سالم',
            'statusEn': 'Completed',
            'statusAr': 'مكتمل',
            'notesEn':
                'Root canal treatment performed on lower left premolar (#9). Three canals cleaned and filled. Crown recommended within 4 weeks.',
            'notesAr':
                'تم إجراء علاج عصب على الضاحك السفلي الأيسر (#9). تم تنظيف وحشو ثلاث قنوات. ينصح بتلبيسة خلال 4 أسابيع.',
            'icon': Icons.medical_services,
            'color': const Color(0xFFF44336),
          },
          {
            'date': '2026-04-18',
            'typeEn': 'X-Ray Examination',
            'typeAr': 'فحص أشعة سينية',
            'doctorEn': 'Dr. James Smith',
            'doctorAr': 'د. طارق زيدان',
            'statusEn': 'Completed',
            'statusAr': 'مكتمل',
            'notesEn':
                'Full mouth panoramic X-ray taken. Found early signs of cavity on tooth #5 and #9. Bone levels normal.',
            'notesAr':
                'تم أخذ أشعة بانورامية كاملة للفم. تم العثور على علامات مبكرة لتسوس في السن #5 و #9. مستويات العظم طبيعية.',
            'icon': Icons.image,
            'color': const Color(0xFF9C27B0),
          },
          {
            'date': '2026-02-10',
            'typeEn': 'Orthodontic Consultation',
            'typeAr': 'استشارة تقويم',
            'doctorEn': 'Dr. Sarah Johnson',
            'doctorAr': 'د. سارة الأحمد',
            'statusEn': 'Completed',
            'statusAr': 'مكتمل',
            'notesEn':
                'Initial orthodontic assessment. Mild crowding on lower anterior teeth. Treatment plan discussed.',
            'notesAr':
                'تقييم تقويم أولي. ازدحام طفيف في الأسنان الأمامية السفلية. تمت مناقشة خطة العلاج.',
            'icon': Icons.straighten,
            'color': const Color(0xFF00BCD4),
          },
        ];

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              t('Medical Records', 'السجلات الطبية'),
              style: TextStyle(
                color: textColor,
                fontSize: 18,
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
            actions: [
              IconButton(
                icon: Icon(Icons.download, color: textColor),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t(
                          'Downloading records...', 'جارٍ تحميل السجلات...')),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Summary Card
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color(0xFF00BFA5).withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryItem(
                      '${records.length}',
                      t('Total Visits', 'إجمالي الزيارات'),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white24,
                    ),
                    _buildSummaryItem(
                      '85%',
                      t('Health Score', 'نتيجة الصحة'),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white24,
                    ),
                    _buildSummaryItem(
                      '45',
                      t('Days Ago', 'يوم مضى'),
                    ),
                  ],
                ),
              ),

              // Records List
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return _buildRecordCard(context, record, index, isDark,
                        cardColor, textColor, subtitleColor);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildRecordCard(
    BuildContext context,
    Map<String, dynamic> record,
    int index,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: InkWell(
        onTap: () => _showRecordDetail(context, record, isDark, cardColor,
            textColor, subtitleColor),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
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
                  color: (record['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  record['icon'] as IconData,
                  color: record['color'] as Color,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t(record['typeEn'], record['typeAr']),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t(record['doctorEn'], record['doctorAr']),
                      style: TextStyle(color: subtitleColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    record['date'],
                    style: TextStyle(color: subtitleColor, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      t(record['statusEn'], record['statusAr']),
                      style: const TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
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

  void _showRecordDetail(
    BuildContext context,
    Map<String, dynamic> record,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
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
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: (record['color'] as Color).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  record['icon'] as IconData,
                  color: record['color'] as Color,
                  size: 40,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                t(record['typeEn'], record['typeAr']),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                t(record['doctorEn'], record['doctorAr']),
                style: TextStyle(color: subtitleColor, fontSize: 14),
              ),
              const SizedBox(height: 5),
              Text(
                record['date'],
                style: TextStyle(color: subtitleColor, fontSize: 12),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t('Doctor\'s Notes', 'ملاحظات الطبيب'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t(record['notesEn'], record['notesAr']),
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.8),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    t('Close', 'إغلاق'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
