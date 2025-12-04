import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LibrariesPage extends StatelessWidget {
  const LibrariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLoading = swift(false);
    final markdownContent = swift<String?>(null);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF252526) : const Color(0xFF007ACC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Our Libraries',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Swift(
        builder: (context) {
          if (markdownContent.value != null) {
            // Show markdown content
            return Stack(
              children: [
                // Watermark
                Positioned.fill(
                  child: Center(
                    child: Opacity(
                      opacity: 0.03,
                      child: Image.asset(
                        'assets/images/swift_flutter_logo.png',
                        width: 500,
                        height: 500,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      ),
                    ),
                  ),
                ),
                // Content
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                  child: Markdown(
                    data: markdownContent.value!,
                    styleSheet: MarkdownStyleSheet(
                      h1: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                        height: 1.3,
                        letterSpacing: -0.5,
                      ),
                      h1Padding: const EdgeInsets.only(bottom: 20, top: 8),
                      h2: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: isDark ? const Color(0xFFE8E8E8) : const Color(0xFF2D2D30),
                        height: 1.4,
                        letterSpacing: -0.3,
                      ),
                      h2Padding: const EdgeInsets.only(bottom: 14, top: 24),
                      h3: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF3C3C3C),
                        height: 1.4,
                        letterSpacing: -0.2,
                      ),
                      h3Padding: const EdgeInsets.only(bottom: 12, top: 18),
                      p: TextStyle(
                        fontSize: 14,
                        height: 1.7,
                        color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                        letterSpacing: 0.1,
                      ),
                      pPadding: const EdgeInsets.only(bottom: 14),
                      code: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Consolas, Monaco, Courier New, monospace',
                        backgroundColor: isDark ? const Color(0xFF2D2D30) : const Color(0xFFE8E8E8),
                        color: isDark ? const Color(0xFFD7BA7D) : const Color(0xFFA31515),
                      ),
                      codeblockDecoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFF007ACC),
                          width: 1.5,
                        ),
                      ),
                      codeblockPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      codeblockAlign: WrapAlignment.start,
                      blockquote: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: isDark ? const Color(0xFF858585) : const Color(0xFF616161),
                      ),
                      blockquoteDecoration: BoxDecoration(
                        color: isDark ? const Color(0xFF252526) : const Color(0xFFF3F3F3),
                        border: const Border(
                          left: BorderSide(color: Color(0xFF007ACC), width: 4),
                        ),
                      ),
                      blockquotePadding: const EdgeInsets.all(14),
                      listBullet: const TextStyle(
                        color: Color(0xFF007ACC),
                        fontWeight: FontWeight.bold,
                      ),
                      strong: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                      ),
                      em: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                      ),
                      a: const TextStyle(
                        color: Color(0xFF007ACC),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selectable: true,
                  ),
                ),
              ],
            );
          }

          // Show libraries list
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Our Libraries',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Explore our collection of Flutter libraries',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? const Color(0xFF858585) : const Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 32),
              _buildLibraryCard(
                context,
                isDark,
                'swift_flutter',
                'SwiftUI-like state management for Flutter',
                Icons.flutter_dash,
                Colors.blue,
                () {
                  // Navigate to /swiftflutter route
                  Navigator.pushNamed(context, '/swiftflutter');
                },
              ),
              const SizedBox(height: 16),
              _buildLibraryCard(
                context,
                isDark,
                'screen_launch_by_notfication',
                'Detect notification launches and route to specific screens',
                Icons.notifications_active,
                Colors.orange,
                () {
                  // Navigate to /notificationexample route
                  Navigator.pushNamed(context, '/notificationexample');
                },
              ),
              const SizedBox(height: 16),
              _buildLibraryCard(
                context,
                isDark,
                'swift_animations',
                'SwiftUI-like declarative animations with zero boilerplate',
                Icons.auto_awesome,
                Colors.purple,
                () {
                  // Navigate to /swiftanimations route
                  Navigator.pushNamed(context, '/swiftanimations');
                },
              ),
              const SizedBox(height: 16),
              _buildLibraryCard(
                context,
                isDark,
                'swift_liquid',
                'iOS-style liquid animations with spring physics and glass effects',
                Icons.water_drop,
                Colors.cyan,
                () {
                  // Navigate to /swiftliquid route
                  Navigator.pushNamed(context, '/swiftliquid');
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLibraryCard(
    BuildContext context,
    bool isDark,
    String name,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF252526) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? const Color(0xFF3C3C3C) : const Color(0xFFE0E0E0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? const Color(0xFF858585) : const Color(0xFF616161),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDark ? const Color(0xFF858585) : const Color(0xFF616161),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

