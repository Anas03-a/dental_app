import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleDetailScreen({super.key, required this.article});

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
          body: CustomScrollView(
            slivers: [
              // Hero Header
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                backgroundColor:
                    isDark ? const Color(0xFF1E1E1E) : article['color'],
                leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          (article['color'] as Color),
                          (article['color'] as Color).withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              article['icon'] as IconData,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              t(article['titleEn'], article['titleAr']),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Article Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Meta info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMetaItem(
                              Icons.access_time,
                              t(article['readTime'], article['readTimeAr']),
                              t('Read Time', 'وقت القراءة'),
                              subtitleColor,
                              textColor,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: isDark
                                  ? Colors.white12
                                  : Colors.grey.shade200,
                            ),
                            _buildMetaItem(
                              Icons.calendar_today,
                              article['date'],
                              t('Published', 'تاريخ النشر'),
                              subtitleColor,
                              textColor,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: isDark
                                  ? Colors.white12
                                  : Colors.grey.shade200,
                            ),
                            _buildMetaItem(
                              Icons.favorite,
                              '124',
                              t('Likes', 'إعجاب'),
                              subtitleColor,
                              textColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Content
                      Text(
                        t(article['contentEn'], article['contentAr']),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Share Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: article['color'] as Color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            shadowColor:
                                (article['color'] as Color).withValues(alpha: 0.4),
                          ),
                          icon:
                              const Icon(Icons.share, color: Colors.white),
                          label: Text(
                            t('Share Article', 'مشاركة المقال'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(t(
                                    'Article shared!', 'تمت مشاركة المقال!')),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
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

  Widget _buildMetaItem(
    IconData icon,
    String value,
    String label,
    Color subtitleColor,
    Color textColor,
  ) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF00BFA5), size: 20),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: subtitleColor, fontSize: 10),
        ),
      ],
    );
  }
}
