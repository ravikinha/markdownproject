import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:swift_flutter/swift_flutter.dart';
import 'notification_example_page.dart';

class NotificationDocumentationPage extends StatelessWidget {
  const NotificationDocumentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLoading = swift(true);
    final markdownContent = swift<String?>(null);

    // Load markdown content
    Future.microtask(() async {
      try {
        final content = await rootBundle.loadString(
          'assets/markdown/NOTIFICATION_PROJECT_DOCUMENTATION.md',
        );
        markdownContent.value = content;
      } catch (e) {
        markdownContent.value = 'Error loading documentation: $e';
      } finally {
        isLoading.value = false;
      }
    });

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
          'screen_launch_by_notfication',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_circle_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationExamplePage()),
              );
            },
            tooltip: 'View Example',
          ),
        ],
      ),
      body: Swift(
        builder: (context) {
          if (isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF007ACC), strokeWidth: 3),
            );
          }

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
                  data: markdownContent.value ?? 'No content available',
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
                      fontSize: 13.5,
                      fontFamily: 'Consolas, Monaco, "Courier New", monospace',
                      backgroundColor: isDark ? const Color(0xFF252526) : const Color(0xFFE8E8E8),
                      color: isDark ? const Color(0xFFD4D4D4) : const Color(0xFFA31515),
                      letterSpacing: 0.2,
                    ),
                    codeblockDecoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isDark ? const Color(0xFF3C3C3C) : const Color(0xFF3C3C3C),
                        width: 1,
                      ),
                    ),
                    codeblockPadding: const EdgeInsets.all(16),
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
        },
      ),
    );
  }
}

