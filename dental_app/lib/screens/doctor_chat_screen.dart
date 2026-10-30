import 'package:flutter/material.dart';
import 'dart:async';
import '../language_notifier.dart';
import '../theme_notifier.dart';

class DoctorChatScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const DoctorChatScreen({super.key, required this.doctor});

  @override
  State<DoctorChatScreen> createState() => _DoctorChatScreenState();
}

class _DoctorChatScreenState extends State<DoctorChatScreen>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isDoctorTyping = false;

  @override
  void initState() {
    super.initState();
    // Initial greeting from the doctor
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'isUser': false,
            'text': t(
              'Hello! I\'m ${widget.doctor['nameEn']}. How can I help you today?',
              'مرحباً! أنا ${widget.doctor['nameAr']}. كيف يمكنني مساعدتك اليوم؟',
            ),
            'time': _formatTime(DateTime.now()),
          });
        });
      }
    });
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final amPm = time.hour >= 12 ? 'PM' : 'AM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $amPm';
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final userMsg = _controller.text.trim();
    setState(() {
      _messages.add({
        'isUser': true,
        'text': userMsg,
        'time': _formatTime(DateTime.now()),
      });
      _controller.clear();
      _isDoctorTyping = true;
    });
    _scrollToBottom();

    // Simulate doctor typing
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isDoctorTyping = false;
          _messages.add({
            'isUser': false,
            'text': _getDoctorReply(userMsg),
            'time': _formatTime(DateTime.now()),
          });
        });
        _scrollToBottom();
      }
    });
  }

  String _getDoctorReply(String userMessage) {
    final msg = userMessage.toLowerCase();
    if (msg.contains('ألم') || msg.contains('pain') || msg.contains('وجع')) {
      return t(
        'I understand you\'re experiencing pain. Can you describe which tooth or area hurts? Is it sharp or dull pain? I may need to see you for an examination.',
        'أفهم أنك تعاني من ألم. هل يمكنك وصف أي سن أو منطقة تؤلمك؟ هل الألم حاد أم خفيف؟ قد أحتاج لفحصك شخصياً.',
      );
    } else if (msg.contains('موعد') ||
        msg.contains('appointment') ||
        msg.contains('حجز')) {
      return t(
        'I\'d be happy to schedule an appointment for you. You can book directly through the app, or I can arrange a convenient time. What day works best for you?',
        'يسعدني حجز موعد لك. يمكنك الحجز مباشرة من التطبيق، أو يمكنني ترتيب وقت مناسب. أي يوم يناسبك؟',
      );
    } else if (msg.contains('سعر') ||
        msg.contains('price') ||
        msg.contains('cost') ||
        msg.contains('تكلفة')) {
      return t(
        'The consultation fee is ${widget.doctor['price']}. Treatment costs vary depending on the procedure needed. I\'ll provide a detailed estimate after examination.',
        'رسوم الكشفية ${widget.doctor['price']}. تكلفة العلاج تختلف حسب الإجراء المطلوب. سأقدم تقديراً مفصلاً بعد الفحص.',
      );
    } else if (msg.contains('شكر') || msg.contains('thank')) {
      return t(
        'You\'re welcome! Don\'t hesitate to reach out anytime you need help. Take care of your dental health! 😊',
        'على الرحب والسعة! لا تتردد في التواصل في أي وقت تحتاج فيه مساعدة. اعتنِ بصحة أسنانك! 😊',
      );
    } else {
      return t(
        'Thank you for your message. I recommend scheduling an in-clinic visit so I can properly assess your situation. Would you like to book an appointment?',
        'شكراً لرسالتك. أنصح بحجز زيارة في العيادة حتى أتمكن من تقييم حالتك بشكل صحيح. هل تود حجز موعد؟',
      );
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, _) {
        final bgColor =
            isDark ? const Color(0xFF121212) : const Color(0xFFF0F4F8);
        final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black87;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            elevation: 0,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF0F4F8),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: textColor),
              ),
            ),
            title: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade300,
                      child: widget.doctor['imageUrl'] != null
                          ? ClipOval(
                              child: Image.asset(
                                widget.doctor['imageUrl'],
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(Icons.person,
                                    color: Colors.grey.shade600),
                              ),
                            )
                          : Icon(Icons.person, color: Colors.grey.shade600),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: isDark
                                  ? const Color(0xFF1E1E1E)
                                  : Colors.white,
                              width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabicNotifier.value
                            ? widget.doctor['nameAr']
                            : widget.doctor['nameEn'],
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        t('Online', 'متصل'),
                        style: const TextStyle(
                          color: Color(0xFF4CAF50),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.call, color: Color(0xFF00BFA5)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t('Calling...', 'جاري الاتصال...'))),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.videocam, color: Color(0xFF00BFA5)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(t('Starting video call...',
                            'جاري بدء مكالمة فيديو...'))),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Doctor specialization banner
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color:
                    isDark ? const Color(0xFF1A2E2A) : const Color(0xFFE0F2F1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.verified,
                        color: Color(0xFF00BFA5), size: 16),
                    const SizedBox(width: 8),
                    Text(
                      isArabicNotifier.value
                          ? widget.doctor['specAr']
                          : widget.doctor['specEn'],
                      style: const TextStyle(
                        color: Color(0xFF00BFA5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• ${widget.doctor['exp']}',
                      style: TextStyle(
                        color: isDark ? Colors.white60 : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_isDoctorTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isDoctorTyping) {
                      return _buildTypingIndicator(isDark);
                    }
                    final msg = _messages[index];
                    final isUser = msg['isUser'] as bool;
                    return _buildMessageBubble(
                        msg, isUser, isDark, textColor, cardColor);
                  },
                ),
              ),

              // Input field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                    .copyWith(bottom: 12),
                decoration: BoxDecoration(
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      offset: const Offset(0, -2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.attach_file,
                            color: isDark ? Colors.white60 : Colors.grey),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(t('Attach file', 'إرفاق ملف'))),
                          );
                        },
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2A2A2A)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              hintText: t('Type a message...', 'اكتب رسالة...'),
                              hintStyle: TextStyle(
                                color: isDark ? Colors.white38 : Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _sendMessage,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.send,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg, bool isUser, bool isDark,
      Color textColor, Color cardColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: const Color(0xFF00BFA5),
              child: Text(
                (isArabicNotifier.value
                        ? widget.doctor['nameAr']
                        : widget.doctor['nameEn'])
                    .toString()
                    .substring(0, 1),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                        colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                      )
                    : null,
                color: isUser
                    ? null
                    : (isDark ? const Color(0xFF2A2A2A) : cardColor),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    msg['text'],
                    style: TextStyle(
                      color: isUser ? Colors.white : textColor,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        msg['time'] ?? '',
                        style: TextStyle(
                          color: isUser ? Colors.white60 : Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.done_all,
                            color: Colors.white60, size: 14),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFF00BFA5),
            child: Text(
              (isArabicNotifier.value
                      ? widget.doctor['nameAr']
                      : widget.doctor['nameEn'])
                  .toString()
                  .substring(0, 1),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(1),
                const SizedBox(width: 4),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                const Color(0xFF00BFA5).withValues(alpha: 0.3 + (value * 0.7)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
