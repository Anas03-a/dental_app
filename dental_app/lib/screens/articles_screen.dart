import 'package:flutter/material.dart';
import '../language_notifier.dart';
import '../theme_notifier.dart';
import 'article_detail_screen.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  static final List<Map<String, dynamic>> articles = [
    {
      'titleEn': 'Benefits of Brushing Your Teeth',
      'titleAr': 'فوائد تنظيف الأسنان بالفرشاة',
      'summaryEn':
          'Discover the amazing benefits of regular brushing and how it protects your oral health.',
      'summaryAr':
          'اكتشف الفوائد المذهلة للتنظيف المنتظم بالفرشاة وكيف يحمي صحة فمك.',
      'contentEn':
          'Brushing your teeth twice daily is the cornerstone of good oral hygiene. It removes plaque, prevents cavities, and keeps your gums healthy. Using fluoride toothpaste strengthens enamel and fights bacteria that cause decay.\n\nRegular brushing also prevents bad breath and keeps your smile bright. Dentists recommend brushing for at least two minutes each time, covering all surfaces of every tooth.\n\nHere are some key benefits:\n\n• Removes plaque buildup\n• Prevents cavities and tooth decay\n• Keeps gums healthy and prevents gingivitis\n• Freshens breath\n• Whitens teeth naturally\n• Reduces the risk of heart disease\n• Saves money on dental treatments',
      'contentAr':
          'تنظيف أسنانك مرتين يومياً هو حجر الأساس لنظافة الفم الجيدة. يزيل البلاك ويمنع التسوس ويحافظ على صحة لثتك. استخدام معجون أسنان بالفلورايد يقوي المينا ويحارب البكتيريا المسببة للتسوس.\n\nالتنظيف المنتظم يمنع أيضاً رائحة الفم الكريهة ويحافظ على ابتسامتك مشرقة. ينصح أطباء الأسنان بالتنظيف لمدة دقيقتين على الأقل في كل مرة.\n\nإليك بعض الفوائد الرئيسية:\n\n• إزالة تراكم البلاك\n• منع التسوس وتآكل الأسنان\n• الحفاظ على صحة اللثة ومنع التهابها\n• إنعاش رائحة الفم\n• تبييض الأسنان بشكل طبيعي\n• تقليل خطر أمراض القلب\n• توفير المال على علاجات الأسنان',
      'icon': Icons.brush,
      'color': const Color(0xFF4CAF50),
      'readTime': '5 min',
      'readTimeAr': '5 دقائق',
      'date': '2026-10-05',
    },
    {
      'titleEn': 'The Importance of Dental Floss',
      'titleAr': 'أهمية خيط الأسنان',
      'summaryEn':
          'Learn why dental floss is essential and how to use it correctly for optimal dental health.',
      'summaryAr':
          'تعرف على أهمية خيط الأسنان وكيفية استخدامه بشكل صحيح لصحة أسنان مثالية.',
      'contentEn':
          'Dental floss reaches areas your toothbrush cannot, removing food particles and plaque between teeth. Flossing daily can prevent gum disease, cavities, and bad breath.\n\nStudies show that flossing can reduce the risk of gum disease by up to 40%. It is especially important for maintaining the health of spaces between teeth where cavities often start.\n\nTips for effective flossing:\n\n• Use about 18 inches of floss\n• Gently curve the floss around each tooth\n• Move the floss up and down against the tooth surface\n• Use a clean section of floss for each tooth\n• Floss at least once daily, preferably before bedtime',
      'contentAr':
          'يصل خيط الأسنان إلى مناطق لا تصلها فرشاة أسنانك، حيث يزيل بقايا الطعام والبلاك بين الأسنان. استخدام الخيط يومياً يمنع أمراض اللثة والتسوس ورائحة الفم الكريهة.\n\nتُظهر الدراسات أن استخدام الخيط يقلل من خطر أمراض اللثة بنسبة تصل إلى 40%. وهو مهم بشكل خاص للحفاظ على صحة المسافات بين الأسنان.\n\nنصائح لاستخدام فعال:\n\n• استخدم حوالي 45 سم من الخيط\n• لف الخيط بلطف حول كل سن\n• حرك الخيط لأعلى ولأسفل على سطح السن\n• استخدم قسماً نظيفاً من الخيط لكل سن\n• استخدم الخيط مرة واحدة يومياً على الأقل',
      'icon': Icons.health_and_safety,
      'color': const Color(0xFF2196F3),
      'readTime': '4 min',
      'readTimeAr': '4 دقائق',
      'date': '2026-10-03',
    },
    {
      'titleEn': 'Foods That Strengthen Your Teeth',
      'titleAr': 'أطعمة تقوي أسنانك',
      'summaryEn':
          'Discover the best foods for strong, healthy teeth and a beautiful smile.',
      'summaryAr':
          'اكتشف أفضل الأطعمة لأسنان قوية وصحية وابتسامة جميلة.',
      'contentEn':
          'Your diet plays a crucial role in dental health. Certain foods can actually strengthen your teeth and protect against decay.\n\nCalcium-rich foods like dairy products, leafy greens, and almonds help build strong enamel. Vitamin C from fruits supports healthy gums, while crunchy vegetables like carrots and celery naturally clean teeth.\n\nBest foods for dental health:\n\n• Cheese and yogurt (calcium and probiotics)\n• Leafy greens (calcium and folic acid)\n• Apples and carrots (natural teeth cleaners)\n• Nuts and seeds (minerals)\n• Green tea (antioxidants)\n• Fish (vitamin D and omega-3)\n• Water (rinses away food particles)',
      'contentAr':
          'يلعب نظامك الغذائي دوراً حاسماً في صحة الأسنان. بعض الأطعمة يمكن أن تقوي أسنانك وتحميها من التسوس.\n\nالأطعمة الغنية بالكالسيوم مثل منتجات الألبان والخضروات الورقية واللوز تساعد في بناء مينا قوية. فيتامين سي من الفواكه يدعم صحة اللثة.\n\nأفضل الأطعمة لصحة الأسنان:\n\n• الجبن والزبادي (الكالسيوم والبروبيوتيك)\n• الخضروات الورقية (الكالسيوم وحمض الفوليك)\n• التفاح والجزر (منظفات طبيعية للأسنان)\n• المكسرات والبذور (المعادن)\n• الشاي الأخضر (مضادات الأكسدة)\n• الأسماك (فيتامين د وأوميغا 3)\n• الماء (يشطف بقايا الطعام)',
      'icon': Icons.restaurant,
      'color': const Color(0xFFFF9800),
      'readTime': '6 min',
      'readTimeAr': '6 دقائق',
      'date': '2026-09-28',
    },
    {
      'titleEn': 'When to Visit the Dentist',
      'titleAr': 'متى تزور طبيب الأسنان',
      'summaryEn':
          'Know the warning signs that indicate you need to see a dentist immediately.',
      'summaryAr':
          'تعرف على العلامات التحذيرية التي تشير إلى حاجتك لزيارة طبيب الأسنان فوراً.',
      'contentEn':
          'Regular dental checkups are essential, but sometimes you need to visit the dentist urgently. Knowing the warning signs can save your teeth.\n\nWarning signs that require immediate attention:\n\n• Persistent toothache\n• Bleeding gums when brushing\n• Sensitivity to hot or cold\n• Swollen or tender gums\n• Bad breath that won\'t go away\n• Loose teeth\n• Jaw pain or clicking\n• White spots on teeth\n\nDentists recommend visiting at least twice a year for regular checkups and professional cleaning.',
      'contentAr':
          'الفحوصات الدورية ضرورية، لكن أحياناً تحتاج لزيارة طبيب الأسنان بشكل عاجل. معرفة العلامات التحذيرية يمكن أن تنقذ أسنانك.\n\nعلامات تحذيرية تتطلب اهتماماً فورياً:\n\n• ألم أسنان مستمر\n• نزيف اللثة عند التنظيف\n• حساسية للحرارة أو البرودة\n• تورم أو ألم في اللثة\n• رائحة فم كريهة لا تختفي\n• أسنان متخلخلة\n• ألم أو طقطقة في الفك\n• بقع بيضاء على الأسنان\n\nينصح أطباء الأسنان بالزيارة مرتين سنوياً على الأقل.',
      'icon': Icons.local_hospital,
      'color': const Color(0xFFF44336),
      'readTime': '4 min',
      'readTimeAr': '4 دقائق',
      'date': '2026-09-25',
    },
    {
      'titleEn': 'Children\'s Dental Care Guide',
      'titleAr': 'دليل العناية بأسنان الأطفال',
      'summaryEn':
          'A comprehensive guide for parents on how to take care of their children\'s dental health.',
      'summaryAr':
          'دليل شامل للآباء حول كيفية العناية بصحة أسنان أطفالهم.',
      'contentEn':
          'Children\'s dental care starts even before the first tooth appears. Proper oral hygiene habits established early will last a lifetime.\n\nKey tips for children\'s dental care:\n\n• Start cleaning gums with a soft cloth before teeth appear\n• Begin brushing with a small, soft-bristled brush when the first tooth comes in\n• Use fluoride toothpaste in a pea-sized amount for children over 2\n• Schedule the first dental visit by age 1\n• Limit sugary snacks and drinks\n• Make brushing fun with songs and timers\n• Lead by example - brush together as a family',
      'contentAr':
          'تبدأ العناية بأسنان الأطفال حتى قبل ظهور السن الأول. عادات النظافة الصحيحة المبكرة تستمر مدى الحياة.\n\nنصائح رئيسية للعناية بأسنان الأطفال:\n\n• ابدأ بتنظيف اللثة بقطعة قماش ناعمة قبل ظهور الأسنان\n• ابدأ بالتنظيف بفرشاة صغيرة ناعمة عند ظهور أول سن\n• استخدم معجون بالفلورايد بحجم حبة البازلاء للأطفال فوق سنتين\n• حدد أول زيارة لطبيب الأسنان بحلول عمر سنة\n• قلل الوجبات والمشروبات السكرية\n• اجعل التنظيف ممتعاً بالأغاني والمؤقتات\n• كن قدوة - نظفوا أسنانكم معاً كعائلة',
      'icon': Icons.child_care,
      'color': const Color(0xFF9C27B0),
      'readTime': '7 min',
      'readTimeAr': '7 دقائق',
      'date': '2026-09-20',
    },
    {
      'titleEn': 'Teeth Whitening: Facts & Myths',
      'titleAr': 'تبييض الأسنان: حقائق وخرافات',
      'summaryEn':
          'Separate fact from fiction about teeth whitening methods and their effectiveness.',
      'summaryAr':
          'افصل الحقائق عن الخرافات حول طرق تبييض الأسنان وفعاليتها.',
      'contentEn':
          'Teeth whitening is one of the most popular cosmetic dental procedures. But there are many myths surrounding it.\n\nFacts:\n• Professional whitening is safe when done correctly\n• Results can last 1-3 years with proper care\n• Not all teeth respond equally to whitening\n\nMyths:\n• Whitening damages enamel (False - professional treatments are safe)\n• Home remedies like lemon juice work (False - they can damage enamel)\n• Whitening is permanent (False - touch-ups are needed)\n• Anyone can whiten their teeth (False - some conditions prevent it)',
      'contentAr':
          'تبييض الأسنان هو من أكثر إجراءات تجميل الأسنان شيوعاً. لكن هناك العديد من الخرافات حوله.\n\nحقائق:\n• التبييض المهني آمن عند إجرائه بشكل صحيح\n• النتائج يمكن أن تستمر 1-3 سنوات مع العناية المناسبة\n• لا تستجيب جميع الأسنان بالتساوي للتبييض\n\nخرافات:\n• التبييض يتلف المينا (خطأ - العلاجات المهنية آمنة)\n• العلاجات المنزلية مثل عصير الليمون فعالة (خطأ)\n• التبييض دائم (خطأ - يحتاج لإعادة كل فترة)\n• أي شخص يمكنه تبييض أسنانه (خطأ - بعض الحالات تمنع ذلك)',
      'icon': Icons.auto_awesome,
      'color': const Color(0xFF00BCD4),
      'readTime': '5 min',
      'readTimeAr': '5 دقائق',
      'date': '2026-09-15',
    },
  ];

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
              t('Dental Articles', 'مقالات طب الأسنان'),
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
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return _buildArticleCard(
                  context, article, isDark, cardColor, textColor, subtitleColor);
            },
          ),
        );
      },
    );
  }

  Widget _buildArticleCard(
    BuildContext context,
    Map<String, dynamic> article,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleDetailScreen(article: article),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(16),
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
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: (article['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  article['icon'] as IconData,
                  color: article['color'] as Color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t(article['titleEn'], article['titleAr']),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      t(article['summaryEn'], article['summaryAr']),
                      style: TextStyle(color: subtitleColor, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 14, color: subtitleColor),
                        const SizedBox(width: 4),
                        Text(
                          t(article['readTime'], article['readTimeAr']),
                          style:
                              TextStyle(color: subtitleColor, fontSize: 11),
                        ),
                        const SizedBox(width: 15),
                        Icon(Icons.calendar_today,
                            size: 14, color: subtitleColor),
                        const SizedBox(width: 4),
                        Text(
                          article['date'],
                          style:
                              TextStyle(color: subtitleColor, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: subtitleColor),
            ],
          ),
        ),
      ),
    );
  }
}
