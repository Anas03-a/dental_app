import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'tooth_health_screen.dart';
import 'profile_screen.dart';
import 'chatbot_screen.dart';
import 'ai_chat_screen.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 3; // Home default (was 4, now 3 because removed appointments)
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  // Position variables for draggable AI button
  double _aiButtonX = 20.0; // distance from right
  double _aiButtonY = 100.0; // distance from bottom
  bool _isSnapping = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _fabAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _snapToNearestEdge(double screenWidth, double buttonSize) {
    final double currentLeft = screenWidth - _aiButtonX - buttonSize;
    final double centerX = screenWidth / 2;

    setState(() {
      _isSnapping = true;
      if (currentLeft + buttonSize / 2 < centerX) {
        // Snap to left edge
        _aiButtonX = screenWidth - buttonSize - 10;
      } else {
        // Snap to right edge
        _aiButtonX = 10;
      }
    });

    // Reset snapping flag after animation
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _isSnapping = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, _) {
        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: isArabicNotifier,
                builder: (context, isArabic, child) {
                  final pages = [
                    const ProfileScreen(),
                    const ChatbotScreen(),
                    const ToothHealthScreen(),
                    const HomeScreen(),
                  ];
                  return Directionality(
                    textDirection:
                        isArabic ? TextDirection.rtl : TextDirection.ltr,
                    child: pages[_selectedIndex],
                  );
                },
              ),
              // Floating AI Button - only visible on Home screen
              if (_selectedIndex == 3)
                Builder(
                  builder: (context) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final screenHeight = MediaQuery.of(context).size.height;
                    const double buttonSize = 60.0;
                    const double bottomNavHeight = 90.0;
                    final double maxY = screenHeight - buttonSize - bottomNavHeight;
                    const double minY = 50.0;

                    return AnimatedPositioned(
                      duration: _isSnapping
                          ? const Duration(milliseconds: 300)
                          : Duration.zero,
                      curve: Curves.easeOutCubic,
                      right: _aiButtonX.clamp(0.0, screenWidth - buttonSize),
                      bottom: _aiButtonY.clamp(minY, maxY),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            _aiButtonX -= details.delta.dx;
                            _aiButtonY -= details.delta.dy;
                            // Clamp within screen bounds
                            _aiButtonX = _aiButtonX.clamp(0.0, screenWidth - buttonSize);
                            _aiButtonY = _aiButtonY.clamp(minY, maxY);
                          });
                        },
                        onPanEnd: (details) {
                          _snapToNearestEdge(screenWidth, buttonSize);
                        },
                        child: AnimatedBuilder(
                          animation: _fabAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _fabAnimation.value,
                              child: child,
                            );
                          },
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Directionality(
                                    textDirection: isArabicNotifier.value
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: const AiChatScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: buttonSize,
                              height: buttonSize,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00BFA5)
                                        .withValues(alpha: 0.4),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.auto_awesome,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF1E1E1E) : const Color(0xFF0F172A),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: ValueListenableBuilder<bool>(
                  valueListenable: isArabicNotifier,
                  builder: (context, isArabic, child) {
                    return NavigationBarTheme(
                      data: NavigationBarThemeData(
                        backgroundColor: isDark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFF0F172A),
                        indicatorColor: isDark
                            ? const Color(0xFF1A3A35)
                            : const Color(0xFFE0F2F1),
                        labelTextStyle:
                            WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const TextStyle(
                                color: Color(0xFF00BFA5),
                                fontWeight: FontWeight.bold,
                                fontSize: 11);
                          }
                          return const TextStyle(
                              color: Colors.white70, fontSize: 11);
                        }),
                        iconTheme:
                            WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const IconThemeData(
                                color: Color(0xFF00BFA5));
                          }
                          return const IconThemeData(color: Colors.white70);
                        }),
                      ),
                      child: NavigationBar(
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        destinations: [
                          NavigationDestination(
                            icon: const Icon(Icons.person_outline),
                            selectedIcon: const Icon(Icons.person),
                            label: isArabic ? 'حسابي' : 'Profile',
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.chat_bubble_outline),
                            selectedIcon: const Icon(Icons.chat_bubble),
                            label: isArabic ? 'محادثة' : 'Chat',
                          ),
                          NavigationDestination(
                            icon:
                                const Icon(Icons.medical_services_outlined),
                            selectedIcon:
                                const Icon(Icons.medical_services),
                            label: isArabic ? 'صحة' : 'Health',
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.home_outlined),
                            selectedIcon: const Icon(Icons.home),
                            label: isArabic ? 'الرئيسية' : 'Home',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
