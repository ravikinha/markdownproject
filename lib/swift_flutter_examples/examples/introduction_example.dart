import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class IntroductionExample extends StatelessWidget {
  const IntroductionExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Introduction to swift_flutter',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'SwiftUI-like state management for Flutter with zero boilerplate',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'Why Choose swift_flutter?',
            [
              _buildFeatureCard(
                '🎯 Automatic Dependency Tracking',
                'No need to manually track dependencies. The library automatically knows which widgets need to rebuild when state changes.',
                isDark,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                '🚀 Two Flexible Patterns',
                'Choose the pattern that fits your needs: Direct Pattern for quick development or Controller Pattern for team projects.',
                isDark,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                '⚡ Performance Optimized',
                'Built-in optimizations prevent unnecessary rebuilds and improve app performance.',
                isDark,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                '🎨 Swift-like Extensions',
                '80+ convenient extension methods that make your code more readable and expressive.',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Live Example: Reactive Counter',
            [
              _buildCodeBlock(
                '''final counter = swift(0);

// In your widget
Swift(
  builder: (context) => Text(
    'Count: \${counter.value}',
    style: TextStyle(fontSize: 24),
  ),
)

// Update anywhere
counter.value++;''',
                isDark,
              ),
              const SizedBox(height: 24),
              _CounterDemo(),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Who Should Use swift_flutter?',
            [
              _buildTextCard('Beginners: Simple API that\'s easy to learn', isDark),
              const SizedBox(height: 8),
              _buildTextCard('Experienced Developers: Powerful features for complex applications', isDark),
              const SizedBox(height: 8),
              _buildTextCard('Teams: Enforced patterns ensure code consistency', isDark),
            ],
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF1E1E1E),
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFeatureCard(String title, String description, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF3C3C3C) : const Color(0xFFDDDDDD),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextCard(String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF3C3C3C) : const Color(0xFFDDDDDD),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
        ),
      ),
    );
  }

  Widget _buildCodeBlock(String code, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF007ACC),
          width: 1.5,
        ),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(
          fontFamily: 'Consolas, Monaco, Courier New, monospace',
          fontSize: 13,
          color: Color(0xFFD7BA7D),
          height: 1.5,
        ),
      ),
    );
  }
}

class _CounterDemo extends StatelessWidget {
  final counter = swift(0);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF252526)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF007ACC),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Swift(
            builder: (context) => Text(
              'Count: ${counter.value}',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => counter.value--,
                child: const Text('-'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => counter.value++,
                child: const Text('+'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

