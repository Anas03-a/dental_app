import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late DateTime _currentMonth;
  int? _selectedDay;
  String? _selectedTime;
  late AnimationController _confirmAnimController;
  late Animation<double> _confirmAnimation;
  bool _isConfirmed = false;

  final List<String> _availableTimes = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  // Some slots are "booked" already
  final List<String> _bookedTimes = ['09:30 AM', '11:00 AM', '03:00 PM'];

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(2026, DateTime.now().month, 1);
    _confirmAnimController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _confirmAnimation = CurvedAnimation(
      parent: _confirmAnimController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _confirmAnimController.dispose();
    super.dispose();
  }

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _firstDayOfWeek(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday % 7;
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
      _selectedDay = null;
      _selectedTime = null;
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
      _selectedDay = null;
      _selectedTime = null;
    });
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    const monthsAr = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    return t(months[month - 1], monthsAr[month - 1]);
  }

  void _confirmAppointment() {
    if (_selectedDay == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t(
            'Please select a date and time',
            'يرجى اختيار تاريخ ووقت',
          )),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isConfirmed = true);
    _confirmAnimController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

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

        if (_isConfirmed) {
          return _buildConfirmationScreen(
              isDark, bgColor, textColor, subtitleColor);
        }

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              t('Book Appointment', 'حجز موعد'),
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
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Calendar Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(25),
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
                          // Month navigation
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: _previousMonth,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF2A2A2A)
                                        : const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.arrow_back_ios,
                                      size: 16, color: textColor),
                                ),
                              ),
                              Text(
                                '${_monthName(_currentMonth.month)} ${_currentMonth.year}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              InkWell(
                                onTap: _nextMonth,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF2A2A2A)
                                        : const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.arrow_forward_ios,
                                      size: 16, color: textColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Day names
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              for (var d in (isArabicNotifier.value
                                  ? [
                                      'أحد',
                                      'إثنين',
                                      'ثلاثاء',
                                      'أربعاء',
                                      'خميس',
                                      'جمعة',
                                      'سبت'
                                    ]
                                  : [
                                      'Sun',
                                      'Mon',
                                      'Tue',
                                      'Wed',
                                      'Thu',
                                      'Fri',
                                      'Sat'
                                    ]))
                                SizedBox(
                                  width: 36,
                                  child: Center(
                                    child: Text(
                                      d,
                                      style: TextStyle(
                                        color: subtitleColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Calendar grid
                          _buildCalendarGrid(isDark, textColor, subtitleColor),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Selected date display
                    if (_selectedDay != null)
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 10 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isDark
                                  ? [
                                      const Color(0xFF1A3A35),
                                      const Color(0xFF1E2E2A)
                                    ]
                                  : [
                                      const Color(0xFFE0F2F1),
                                      const Color(0xFFB2DFDB)
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.event, color: Color(0xFF00BFA5)),
                              const SizedBox(width: 12),
                              Text(
                                t(
                                  'Selected: ${_monthName(_currentMonth.month)} $_selectedDay, ${_currentMonth.year}',
                                  'المحدد: $_selectedDay ${_monthName(_currentMonth.month)} ${_currentMonth.year}',
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 25),

                    // Available Time
                    Text(
                      t('Available Time', 'الأوقات المتاحة'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      t('Select a time slot', 'اختر وقتاً متاحاً'),
                      style: TextStyle(color: subtitleColor, fontSize: 12),
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _availableTimes.map((time) {
                        final isBooked = _bookedTimes.contains(time);
                        final isSelected = _selectedTime == time;
                        return _buildTimeChip(
                            time, isSelected, isBooked, isDark, textColor);
                      }).toList(),
                    ),

                    if (_selectedTime != null) ...[
                      const SizedBox(height: 20),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) {
                          return Opacity(opacity: value, child: child);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF00BFA5)
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Color(0xFF00BFA5)),
                              const SizedBox(width: 12),
                              Text(
                                t('Selected time: $_selectedTime',
                                    'الوقت المحدد: $_selectedTime'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Confirm Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(20).copyWith(bottom: 30),
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (_selectedDay != null && _selectedTime != null)
                              ? const Color(0xFF00BFA5)
                              : Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: (_selectedDay != null && _selectedTime != null)
                          ? 8
                          : 0,
                      shadowColor:
                          const Color(0xFF00BFA5).withValues(alpha: 0.4),
                    ),
                    onPressed: _confirmAppointment,
                    child: Text(
                      t('Confirm Appointment', 'تأكيد الحجز'),
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

  Widget _buildCalendarGrid(bool isDark, Color textColor, Color subtitleColor) {
    final daysInMonth = _daysInMonth(_currentMonth);
    final firstDay = _firstDayOfWeek(_currentMonth);
    final today = DateTime.now();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: firstDay + daysInMonth,
      itemBuilder: (context, index) {
        if (index < firstDay) return const SizedBox();

        final day = index - firstDay + 1;
        final isSelected = _selectedDay == day;
        final isToday = today.day == day &&
            today.month == _currentMonth.month &&
            today.year == _currentMonth.year;
        final isPast =
            DateTime(_currentMonth.year, _currentMonth.month, day).isBefore(
          DateTime(today.year, today.month, today.day),
        );

        return GestureDetector(
          onTap: isPast
              ? null
              : () {
                  setState(() {
                    _selectedDay = day;
                    _selectedTime = null; // Reset time on day change
                  });
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF00BFA5)
                  : isToday
                      ? const Color(0xFF00BFA5).withValues(alpha: 0.15)
                      : Colors.transparent,
              shape: BoxShape.circle,
              border: isToday && !isSelected
                  ? Border.all(color: const Color(0xFF00BFA5), width: 2)
                  : null,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : isPast
                          ? (isDark ? Colors.white24 : Colors.grey.shade300)
                          : textColor,
                  fontWeight: (isSelected || isToday)
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeChip(String time, bool isSelected, bool isBooked,
      bool isDark, Color textColor) {
    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
              setState(() => _selectedTime = time);
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isBooked
              ? (isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade100)
              : isSelected
                  ? const Color(0xFF00BFA5)
                  : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isBooked
                ? Colors.transparent
                : isSelected
                    ? Colors.transparent
                    : (isDark ? Colors.white12 : Colors.grey.shade300),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00BFA5).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isBooked)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(Icons.block, size: 14, color: Colors.grey.shade400),
              ),
            Text(
              time,
              style: TextStyle(
                color: isBooked
                    ? Colors.grey.shade400
                    : isSelected
                        ? Colors.white
                        : textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
                decoration: isBooked ? TextDecoration.lineThrough : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationScreen(
      bool isDark, Color bgColor, Color textColor, Color subtitleColor) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: ScaleTransition(
          scale: _confirmAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF00BFA5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 50),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                t('Appointment Confirmed!', 'تم تأكيد الحجز!'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                t(
                  '${_monthName(_currentMonth.month)} $_selectedDay, ${_currentMonth.year} at $_selectedTime',
                  '$_selectedDay ${_monthName(_currentMonth.month)} ${_currentMonth.year} الساعة $_selectedTime',
                ),
                style: TextStyle(color: subtitleColor, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                t('Redirecting...', 'جاري التحويل...'),
                style: const TextStyle(color: Color(0xFF00BFA5), fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
