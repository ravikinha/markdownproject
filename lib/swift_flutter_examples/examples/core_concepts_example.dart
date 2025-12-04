import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class CoreConceptsExample extends StatelessWidget {
  const CoreConceptsExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Core Concepts',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Understanding the fundamental concepts of swift_flutter',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'What is Reactive State Management?',
            [
              Text(
                'Reactive state management means that when your data changes, the UI automatically updates to reflect those changes. You don\'t need to manually call setState() or manage widget rebuilds.',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 24),
              _buildComparison(isDark),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Key Concepts',
            [
              _buildConceptCard(
                '1. SwiftValue',
                'A reactive container that holds a value and automatically tracks which widgets depend on it.',
                'final counter = swift(0);  // Creates a SwiftValue<int>',
                isDark,
              ),
              const SizedBox(height: 16),
              _buildConceptCard(
                '2. Swift Widget',
                'A special widget that automatically rebuilds when any SwiftValue it depends on changes.',
                '''Swift(
  builder: (context) => Text('Count: \${counter.value}'),
)''',
                isDark,
              ),
              const SizedBox(height: 16),
              _buildConceptCard(
                '3. Automatic Dependency Tracking',
                'When you access .value inside a Swift widget\'s builder, swift_flutter automatically tracks that dependency.',
                '// Just access .value - tracking happens automatically!',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Live Example',
            [
              _CounterComparisonDemo(),
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

  Widget _buildComparison(bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildCodeCard(
            'Traditional Approach',
            '''class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Count: \${counter.value}');
  }
}''',
            isDark,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildCodeCard(
            'swift_flutter Approach',
            '''class CounterWidget extends StatelessWidget {
  final counter = swift(0);
  
  @override
  Widget build(BuildContext context) {
    return Swift(
      builder: (context) => Column(
        children: [
          Text('Count: \${counter.value}'),
          ElevatedButton(
            onPressed: () => counter.value++,
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}''',
            isDark,
            highlight: true,
          ),
        ),
      ],
    );
  }

  Widget _buildCodeCard(String title, String code, bool isDark, {bool highlight = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFF007ACC).withOpacity(0.1) : (isDark ? const Color(0xFF252526) : Colors.white),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: highlight ? const Color(0xFF007ACC) : (isDark ? const Color(0xFF3C3C3C) : const Color(0xFFDDDDDD)),
          width: highlight ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 12),
          SelectableText(
            code,
            style: const TextStyle(
              fontFamily: 'Consolas, Monaco, Courier New, monospace',
              fontSize: 12,
              color: Color(0xFFD7BA7D),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConceptCard(String title, String description, String code, bool isDark) {
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
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'Consolas, Monaco, Courier New, monospace',
                fontSize: 12,
                color: Color(0xFFD7BA7D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterComparisonDemo extends StatelessWidget {
  final counter = swift(0);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white,
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
          const SizedBox(height: 16),
          Text(
            'Notice: No setState() needed!',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }
}
