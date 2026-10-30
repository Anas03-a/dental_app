import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text':
          'Hello! I\'m your AI dental assistant. You can ask me any questions about dental health, or upload an image for analysis.',
      'arText':
          'مرحباً! أنا مساعدك الذكي لصحة الأسنان. يمكنك سؤالي أي سؤال حول صحة الأسنان، أو رفع صورة للتحليل.',
      'type': 'text',
    }
  ];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final userMsg = _controller.text.trim();
    setState(() {
      _messages.add({
        'isUser': true,
        'text': userMsg,
        'arText': userMsg,
        'type': 'text',
      });
      _controller.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'isUser': false,
            'text': _getAiResponse(userMsg),
            'arText': _getAiResponseAr(userMsg),
            'type': 'text',
          });
        });
        _scrollToBottom();
      }
    });
  }

  String _getAiResponse(String query) {
    final lowerQuery = query.toLowerCase();
    if (lowerQuery.contains('tooth') || lowerQuery.contains('سن')) {
      return 'Based on your description, I recommend visiting a dentist for a proper examination. In the meantime, you can use a soft-bristled toothbrush and fluoride toothpaste.';
    } else if (lowerQuery.contains('pain') || lowerQuery.contains('ألم')) {
      return 'Tooth pain can be caused by various factors like cavities, gum disease, or cracked teeth. I suggest scheduling an appointment with your dentist as soon as possible.';
    } else if (lowerQuery.contains('whiten') || lowerQuery.contains('تبييض')) {
      return 'For teeth whitening, professional treatments at a dental clinic are the safest option. Avoid using lemon juice or baking soda directly, as they can damage enamel.';
    } else {
      return 'Thank you for your question. For personalized dental advice, I recommend consulting with one of our professional dentists. Would you like me to help you find a specialist?';
    }
  }

  String _getAiResponseAr(String query) {
    final lowerQuery = query.toLowerCase();
    if (lowerQuery.contains('tooth') || lowerQuery.contains('سن')) {
      return 'بناءً على وصفك، أنصح بزيارة طبيب الأسنان لفحص مناسب. في هذه الأثناء، يمكنك استخدام فرشاة ناعمة ومعجون بالفلورايد.';
    } else if (lowerQuery.contains('pain') || lowerQuery.contains('ألم')) {
      return 'ألم الأسنان يمكن أن يكون بسبب عدة عوامل مثل التسوس أو أمراض اللثة أو تشقق الأسنان. أنصح بحجز موعد مع طبيب الأسنان في أقرب وقت.';
    } else if (lowerQuery.contains('whiten') || lowerQuery.contains('تبييض')) {
      return 'لتبييض الأسنان، العلاجات المهنية في عيادة الأسنان هي الخيار الأكثر أماناً. تجنب استخدام عصير الليمون أو صودا الخبز مباشرة.';
    } else {
      return 'شكراً لسؤالك. للحصول على نصيحة شخصية، أنصح باستشارة أحد أطبائنا المتخصصين. هل تريد مساعدتك في إيجاد متخصص؟';
    }
  }

  void _uploadImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ValueListenableBuilder<bool>(
          valueListenable: isDarkModeNotifier,
          builder: (context, isDark, _) {
            final cardColor =
                isDark ? const Color(0xFF1E1E1E) : Colors.white;
            final textColor = isDark ? Colors.white : Colors.black87;

            return Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
              ),
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
                  Text(
                    t('Upload Image for Analysis',
                        'رفع صورة للتحليل'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t('Take a photo or choose from gallery for AI analysis',
                        'التقط صورة أو اختر من المعرض للتحليل بالذكاء الاصطناعي'),
                    style: TextStyle(
                      color: isDark ? Colors.white60 : Colors.grey,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: _buildUploadOption(
                          icon: Icons.camera_alt,
                          label: t('Camera', 'الكاميرا'),
                          color: const Color(0xFF00BFA5),
                          isDark: isDark,
                          textColor: textColor,
                          onTap: () {
                            Navigator.pop(context);
                            _simulateImageUpload();
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildUploadOption(
                          icon: Icons.photo_library,
                          label: t('Gallery', 'المعرض'),
                          color: const Color(0xFF2196F3),
                          isDark: isDark,
                          textColor: textColor,
                          onTap: () {
                            Navigator.pop(context);
                            _simulateImageUpload();
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildUploadOption(
                          icon: Icons.insert_drive_file,
                          label: t('Files', 'الملفات'),
                          color: const Color(0xFFFF9800),
                          isDark: isDark,
                          textColor: textColor,
                          onTap: () {
                            Navigator.pop(context);
                            _simulateImageUpload();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String label,
    required Color color,
    required bool isDark,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isDark ? 0.15 : 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 35),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _simulateImageUpload() {
    setState(() {
      _messages.add({
        'isUser': true,
        'text': '📷 Image uploaded for analysis',
        'arText': '📷 تم رفع صورة للتحليل',
        'type': 'image',
      });
      _isTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'isUser': false,
            'text':
                '🔍 I\'ve analyzed the image. Everything looks normal! Your teeth appear healthy. I recommend:\n\n✅ Continue regular brushing\n✅ Floss daily\n✅ Schedule your next checkup\n\nWould you like me to provide more details?',
            'arText':
                '🔍 لقد حللت الصورة. كل شيء يبدو طبيعياً! أسنانك تبدو صحية. أنصح بـ:\n\n✅ الاستمرار في التنظيف المنتظم\n✅ استخدام الخيط يومياً\n✅ حجز موعد الفحص القادم\n\nهل تريد مزيداً من التفاصيل؟',
            'type': 'text',
          });
        });
        _scrollToBottom();
      }
    });
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
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, _) {
        final bgColor =
            isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
        final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black87;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            centerTitle: true,
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
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _glowAnimation,
                  builder: (context, _) {
                    return Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00BFA5)
                                .withValues(alpha: _glowAnimation.value),
                            const Color(0xFF00897B)
                                .withValues(alpha: _glowAnimation.value),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00BFA5)
                                .withValues(alpha: _glowAnimation.value * 0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 16,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  t('AI Dental Assistant', 'مساعد الأسنان الذكي'),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh, color: textColor),
                onPressed: () {
                  setState(() {
                    _messages.removeRange(1, _messages.length);
                  });
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Quick Actions
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildQuickChip(
                      t('Tooth Pain', 'ألم الأسنان'),
                      isDark,
                    ),
                    _buildQuickChip(
                      t('Whitening', 'تبييض الأسنان'),
                      isDark,
                    ),
                    _buildQuickChip(
                      t('Gum Care', 'العناية باللثة'),
                      isDark,
                    ),
                    _buildQuickChip(
                      t('Braces', 'التقويم'),
                      isDark,
                    ),
                    _buildQuickChip(
                      t('Implants', 'الزراعة'),
                      isDark,
                    ),
                  ],
                ),
              ),

              // Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(20),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isTyping) {
                      return _buildTypingIndicator(cardColor);
                    }
                    final msg = _messages[index];
                    final isUser = msg['isUser'] as bool;
                    return _buildMessageBubble(
                        msg, isUser, isDark, cardColor, textColor);
                  },
                ),
              ),

              // Input Bar
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 10),
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: _uploadImage,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00BFA5)
                                .withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_photo_alternate,
                            color: Color(0xFF00BFA5),
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            hintText: t('Ask about dental health...',
                                'اسأل عن صحة الأسنان...'),
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white38 : Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      InkWell(
                        onTap: _sendMessage,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF00BFA5),
                                Color(0xFF00897B)
                              ],
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

  Widget _buildQuickChip(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          _controller.text = label;
          _sendMessage();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF1A3A35)
                : const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF00BFA5).withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF00BFA5),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg, bool isUser,
      bool isDark, Color cardColor, Color textColor) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: isUser
              ? const LinearGradient(
                  colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                )
              : null,
          color: isUser ? null : cardColor,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: isUser
                ? const Radius.circular(0)
                : const Radius.circular(20),
            bottomLeft: !isUser
                ? const Radius.circular(0)
                : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (msg['type'] == 'image' && isUser)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: Colors.white70, size: 40),
                      SizedBox(height: 5),
                      Text(
                        'dental_scan.jpg',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            if (!isUser)
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.auto_awesome,
                          color: Colors.white, size: 12),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'AI',
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            Text(
              t(msg['text'], msg['arText'] ?? msg['text']),
              style: TextStyle(
                color: isUser ? Colors.white : textColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(Color cardColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomLeft: const Radius.circular(0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome,
                  color: Colors.white, size: 12),
            ),
            const SizedBox(width: 10),
            _buildTypingDot(0),
            const SizedBox(width: 4),
            _buildTypingDot(1),
            const SizedBox(width: 4),
            _buildTypingDot(2),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, _) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFF00BFA5).withValues(alpha: value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
