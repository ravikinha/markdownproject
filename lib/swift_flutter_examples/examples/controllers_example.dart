import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class ControllersExample extends StatelessWidget {
  const ControllersExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Controller Pattern',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enforced separation of concerns - views can only read, controllers modify state',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'Why Use Controllers?',
            [
              _buildFeatureCard('Enforced Separation', 'Views can\'t accidentally modify state', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('Business Logic', 'Centralize logic in controllers', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('Shared State', 'Easy to share state across multiple views', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('Team Collaboration', 'Clear boundaries between UI and logic', isDark),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Creating a Controller',
            [
              _buildCodeBlock(
                '''class CounterController extends SwiftController {
  final counter = swift(0);
  
  void increment() => counter.value++;
  void decrement() => counter.value--;
  void reset() => counter.value = 0;
}

// Using the controller
class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = CounterController();
    
    return Swift(
      builder: (context) => Column(
        children: [
          Text('Count: \${controller.counter.value}'),
          ElevatedButton(
            onPressed: controller.increment,
            child: Text('Increment'),
          ),
        ],
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
            'Live Example',
            [
              _ControllerDemo(),
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
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF007ACC), size: 24),
          const SizedBox(width: 12),
          Expanded(
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
        ],
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

class CounterController extends SwiftController {
  final counter = swift(0);
  
  void increment() => counter.value++;
  void decrement() => counter.value--;
  void reset() => counter.value = 0;
}

class _ControllerDemo extends StatelessWidget {
  final controller = CounterController();

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
              'Count: ${controller.counter.value}',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: controller.increment,
                icon: const Icon(Icons.add),
                label: const Text('Increment'),
              ),
              ElevatedButton.icon(
                onPressed: controller.decrement,
                icon: const Icon(Icons.remove),
                label: const Text('Decrement'),
              ),
              ElevatedButton.icon(
                onPressed: controller.reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'State is managed by the controller, not the view!',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? const Color(0xFF858585) : const Color(0xFF616161),
            ),
          ),
        ],
      ),
    );
  }
}
