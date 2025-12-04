import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class AdvancedPatternsExample extends StatelessWidget {
  const AdvancedPatternsExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Advanced Patterns',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Advanced techniques and patterns for complex applications',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'Shared State Pattern',
            [
              _buildCodeBlock(
                '''// Create a shared controller
class AppController extends SwiftController {
  final user = swift<User?>(null);
  final theme = swift(ThemeMode.light);
}

// Use in multiple views
final appController = AppController();

// View 1
Swift(builder: (context) => Text(appController.user.value?.name ?? 'Guest'));

// View 2
Swift(builder: (context) => Switch(
  value: appController.theme.value == ThemeMode.dark,
  onChanged: (value) => appController.theme.value = value ? ThemeMode.dark : ThemeMode.light,
));''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Computed Dependencies',
            [
              _buildCodeBlock(
                '''final firstName = swift('John');
final lastName = swift('Doe');
final age = swift(25);

// Computed from multiple values
final fullName = Computed(() => '\${firstName.value} \${lastName.value}');
final canVote = Computed(() => age.value >= 18);
final greeting = Computed(() => 
  'Hello \${fullName.value}, you \${canVote.value ? "can" : "cannot"} vote'
);''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Nested Controllers',
            [
              _buildCodeBlock(
                '''class UserController extends SwiftController {
  final name = swift('John');
  final email = swift('john@example.com');
}

class AppController extends SwiftController {
  final userController = UserController();
  final isLoggedIn = swift(false);
}

// Usage
final app = AppController();
Swift(builder: (context) => Text(app.userController.name.value));''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Live Example: Advanced State',
            [
              _AdvancedPatternsDemo(),
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

class _AdvancedPatternsDemo extends StatelessWidget {
  final firstName = swift('John');
  final lastName = swift('Doe');
  final age = swift(25);

  _AdvancedPatternsDemo() {
    // Computed values
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fullName = Computed(() => '${firstName.value} ${lastName.value}');
    final canVote = Computed(() => age.value >= 18);
    final greeting = Computed(() => 
      'Hello ${fullName.value}, you ${canVote.value ? "can" : "cannot"} vote'
    );

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
            builder: (context) => Column(
              children: [
                Text(
                  greeting.value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Full Name:', fullName.value, isDark),
                _buildInfoRow('Age:', '${age.value}', isDark),
                _buildInfoRow('Can Vote:', canVote.value ? 'Yes' : 'No', isDark),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => age.value = (age.value - 1).clamp(0, 100),
                child: const Text('- Age'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => age.value = (age.value + 1).clamp(0, 100),
                child: const Text('+ Age'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }
}
