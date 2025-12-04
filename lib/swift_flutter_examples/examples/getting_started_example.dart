import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class GettingStartedExample extends StatelessWidget {
  const GettingStartedExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Getting Started',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Install and set up swift_flutter in your project',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'Step 1: Add Dependency',
            [
              _buildCodeBlock(
                '''dependencies:
  flutter:
    sdk: flutter
  swift_flutter: ^2.3.0''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Step 2: Install Package',
            [
              _buildCodeBlock(
                '''flutter pub get''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Step 3: Import the Library',
            [
              _buildCodeBlock(
                '''import 'package:swift_flutter/swift_flutter.dart';''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Step 4: Your First Example',
            [
              _buildCodeBlock(
                '''import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final counter = swift(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swift Flutter')),
      body: Center(
        child: Swift(
          builder: (context) => Text(
            'Count: \${counter.value}',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Try It Live',
            [
              _CounterExample(),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'Consolas, Monaco, Courier New, monospace',
                fontSize: 13,
                color: Color(0xFFD7BA7D),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.copy, size: 18, color: Colors.white70),
              onPressed: () {
                // Copy functionality would go here
              },
              tooltip: 'Copy code',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterExample extends StatelessWidget {
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
          FloatingActionButton(
            onPressed: () => counter.value++,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

