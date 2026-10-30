import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';
import 'generic_screen.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Hello! How can I help you today with your dental health?',
      'arText': 'مرحباً! كيف يمكنني مساعدتك اليوم في صحة أسنانك؟',
    }
  ];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final userMsg = _controller.text.trim();
    setState(() {
      _messages.add({
        'isUser': true,
        'text': userMsg,
        'arText': userMsg,
      });
      _controller.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'isUser': false,
            'text':
                'فهم ذلك. يرجى استشارة أطباء الأسنان لدينا للحصول على نصيحة أدق.',
            'arText':
                'أفهم ذلك. يرجى استشارة أطباء الأسنان لدينا للحصول على نصيحة أدق.',
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

  void _uploadImage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const GenericScreen(
                titleEn: 'Upload Image',
                titleAr: 'رفع صورة',
                icon: Icons.image)));
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
            isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
        final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black87;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              t('AI Assistant', 'المساعد الذكي'),
              style: TextStyle(
                  color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(20),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isTyping) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                    final msg = _messages[index];
                    final isUser = msg['isUser'];
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: isUser
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF00BFA5),
                                    Color(0xFF00897B)
                                  ],
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
                            )
                          ],
                        ),
                        child: Text(
                          t(msg['text'], msg['arText'] ?? msg['text']),
                          style: TextStyle(
                            color: isUser ? Colors.white : textColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                        .copyWith(bottom: 110),
                decoration: BoxDecoration(
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      offset: const Offset(0, -2),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image_outlined,
                          color: Color(0xFF00BFA5)),
                      onPressed: _uploadImage,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: t('Type a message...', 'اكتب رسالة...'),
                          hintStyle: TextStyle(
                              color: isDark ? Colors.white38 : Colors.grey),
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
            ],
          ),
        );
      },
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
