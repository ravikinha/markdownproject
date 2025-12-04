import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';
import 'examples/introduction_example.dart';
import 'examples/getting_started_example.dart';
import 'examples/core_concepts_example.dart';
import 'examples/reactive_state_example.dart';
import 'examples/debug_tool_example.dart';
import 'examples/computed_values_example.dart';
import 'examples/controllers_example.dart';
import 'examples/async_state_example.dart';
import 'examples/form_validation_example.dart';
import 'examples/extensions_example.dart';
import 'examples/advanced_patterns_example.dart';
import 'examples/best_practices_example.dart';

class SwiftFlutterExamplePage extends StatefulWidget {
  const SwiftFlutterExamplePage({super.key});

  @override
  State<SwiftFlutterExamplePage> createState() => _SwiftFlutterExamplePageState();
}

class _SwiftFlutterExamplePageState extends State<SwiftFlutterExamplePage> {
  int selectedChapterIndex = 0;

  final chapters = [
    ChapterInfo(
      title: 'Introduction',
      icon: Icons.info_outline,
      widget: const IntroductionExample(),
    ),
    ChapterInfo(
      title: 'Getting Started',
      icon: Icons.play_arrow,
      widget: const GettingStartedExample(),
    ),
    ChapterInfo(
      title: 'Core Concepts',
      icon: Icons.lightbulb_outline,
      widget: const CoreConceptsExample(),
    ),
    ChapterInfo(
      title: 'Reactive State',
      icon: Icons.autorenew,
      widget: const ReactiveStateExample(),
    ),
    ChapterInfo(
      title: 'Debug Tool',
      icon: Icons.bug_report,
      widget: const DebugToolExample(),
    ),
    ChapterInfo(
      title: 'Computed Values',
      icon: Icons.calculate,
      widget: const ComputedValuesExample(),
    ),
    ChapterInfo(
      title: 'Controllers',
      icon: Icons.settings,
      widget: const ControllersExample(),
    ),
    ChapterInfo(
      title: 'Async State',
      icon: Icons.cloud_download,
      widget: const AsyncStateExample(),
    ),
    ChapterInfo(
      title: 'Form Validation',
      icon: Icons.verified,
      widget: const FormValidationExample(),
    ),
    ChapterInfo(
      title: 'Extensions',
      icon: Icons.extension,
      widget: const ExtensionsExample(),
    ),
    ChapterInfo(
      title: 'Advanced Patterns',
      icon: Icons.architecture,
      widget: const AdvancedPatternsExample(),
    ),
    ChapterInfo(
      title: 'Best Practices',
      icon: Icons.star,
      widget: const BestPracticesExample(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 900;

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
          'swift_flutter Examples',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: isMobile
          ? Column(
              children: [
                _buildMobileChapterSelector(isDark),
                Expanded(child: chapters[selectedChapterIndex].widget),
              ],
            )
          : Row(
              children: [
                _buildSidebar(isDark),
                Container(width: 1, color: isDark ? const Color(0xFF2D2D30) : const Color(0xFFDDDDDD)),
                Expanded(child: chapters[selectedChapterIndex].widget),
              ],
            ),
    );
  }

  Widget _buildSidebar(bool isDark) {
    return Container(
      width: 280,
      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF3F3F3),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'Chapters',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                letterSpacing: 0.5,
              ),
            ),
          ),
          const Divider(height: 24),
          ...chapters.asMap().entries.map((entry) {
            final index = entry.key;
            final chapter = entry.value;
            final isSelected = index == selectedChapterIndex;

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() => selectedChapterIndex = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? const Color(0xFF007ACC).withOpacity(0.2) : const Color(0xFF007ACC).withOpacity(0.1))
                        : Colors.transparent,
                    border: Border(
                      left: BorderSide(
                        color: isSelected ? const Color(0xFF007ACC) : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        chapter.icon,
                        size: 20,
                        color: isSelected
                            ? const Color(0xFF007ACC)
                            : (isDark ? const Color(0xFF858585) : const Color(0xFF616161)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          chapter.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected
                                ? (isDark ? Colors.white : const Color(0xFF1E1E1E))
                                : (isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMobileChapterSelector(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF2D2D30) : const Color(0xFFDDDDDD),
          ),
        ),
      ),
      child: DropdownButton<int>(
        value: selectedChapterIndex,
        isExpanded: true,
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: isDark ? Colors.white : const Color(0xFF1E1E1E)),
        items: chapters.asMap().entries.map((entry) {
          return DropdownMenuItem<int>(
            value: entry.key,
            child: Row(
              children: [
                Icon(entry.value.icon, size: 20, color: const Color(0xFF007ACC)),
                const SizedBox(width: 12),
                Text(entry.value.title),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => selectedChapterIndex = value);
          }
        },
      ),
    );
  }
}

class ChapterInfo {
  final String title;
  final IconData icon;
  final Widget widget;

  ChapterInfo({
    required this.title,
    required this.icon,
    required this.widget,
  });
}

