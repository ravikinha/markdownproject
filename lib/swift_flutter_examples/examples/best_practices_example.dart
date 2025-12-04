import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class BestPracticesExample extends StatelessWidget {
  const BestPracticesExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Best Practices',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Guidelines and recommendations for building maintainable applications',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildPracticeCard(
            '1. Use Controllers for Business Logic',
            'Separate your business logic from UI by using controllers. This makes your code more testable and maintainable.',
            '''// ✅ Good
class UserController extends SwiftController {
  final user = swift<User?>(null);
  void login(String email, String password) { /* ... */ }
}

// ❌ Avoid
class UserView extends StatelessWidget {
  final user = swift<User?>(null);
  void login() { /* business logic here */ }
}''',
            isDark,
          ),

          const SizedBox(height: 24),

          _buildPracticeCard(
            '2. Use Computed for Derived State',
            'Use Computed values for calculations and derived state instead of manually updating values.',
            '''// ✅ Good
final price = swift(100.0);
final quantity = swift(2);
final total = Computed(() => price.value * quantity.value);

// ❌ Avoid
final total = swift(0.0);
void updateTotal() {
  total.value = price.value * quantity.value;
}''',
            isDark,
          ),

          const SizedBox(height: 24),

          _buildPracticeCard(
            '3. Keep SwiftValues at Appropriate Scope',
            'Declare SwiftValues at the appropriate scope - widget level for local state, controller level for shared state.',
            '''// ✅ Good - Local state
class CounterWidget extends StatelessWidget {
  final counter = swift(0); // Widget-level
  // ...
}

// ✅ Good - Shared state
class AppController extends SwiftController {
  final user = swift<User?>(null); // Controller-level
}''',
            isDark,
          ),

          const SizedBox(height: 24),

          _buildPracticeCard(
            '4. Use Swift Widget for Reactive UI',
            'Always wrap reactive UI in Swift widget to enable automatic dependency tracking.',
            '''// ✅ Good
Swift(
  builder: (context) => Text('Count: \${counter.value}'),
)

// ❌ Avoid
Text('Count: \${counter.value}') // Won't update automatically''',
            isDark,
          ),

          const SizedBox(height: 24),

          _buildPracticeCard(
            '5. Handle Async Operations with SwiftFuture',
            'Use SwiftFuture for async operations to automatically handle loading and error states.',
            '''// ✅ Good
final dataFuture = SwiftFuture<String>();
dataFuture.value = fetchData();

Swift(
  builder: (context) {
    if (dataFuture.isLoading) return CircularProgressIndicator();
    if (dataFuture.hasError) return Text('Error');
    return Text(dataFuture.data ?? '');
  },
)''',
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeCard(String title, String description, String code, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFF007ACC), size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 16),
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
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
