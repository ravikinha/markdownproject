import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class ReactiveStateExample extends StatelessWidget {
  const ReactiveStateExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reactive State with SwiftValue',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'SwiftValue is the heart of swift_flutter - a reactive container that automatically tracks dependencies',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'Creating SwiftValue',
            [
              _buildCodeBlock(
                '''// Basic creation with type inference
final counter = swift(0);           // SwiftValue<int>
final name = swift('John');         // SwiftValue<String>
final isActive = swift(true);       // SwiftValue<bool>
final price = swift(99.99);        // SwiftValue<double>

// Explicit typing for custom types
final user = swift<User>(User(name: 'John'));
final list = swift<List<String>>([]);
final nullable = swift<String?>(null);''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Reading Values',
            [
              _buildCodeBlock(
                '''final counter = swift(0);

// Inside Swift widget - automatically tracks dependencies
Swift(
  builder: (context) => Text('Count: \${counter.value}'),
)

// Outside Swift widget - works but won't trigger rebuilds
print(counter.value);''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Updating Values',
            [
              _buildCodeBlock(
                '''final counter = swift(0);

// Direct assignment
counter.value = 10;

// Using operators
counter.value++;           // Increment
counter.value--;           // Decrement
counter.value += 5;        // Add
counter.value -= 2;        // Subtract
counter.value *= 2;        // Multiply
counter.value ~/= 2;       // Integer divide''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Live Example: Multiple SwiftValues',
            [
              _MultipleValuesDemo(),
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

class _MultipleValuesDemo extends StatelessWidget {
  final counter = swift(0);
  final name = swift('Flutter');
  final isActive = swift(true);

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
            builder: (context) => Column(
              children: [
                Text(
                  'Counter: ${counter.value}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Name: ${name.value}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Status: ',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Icon(
                      isActive.value ? Icons.check_circle : Icons.cancel,
                      color: isActive.value ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => counter.value++,
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () => counter.value--,
                child: const Text('Decrement'),
              ),
              ElevatedButton(
                onPressed: () => name.value = name.value == 'Flutter' ? 'Dart' : 'Flutter',
                child: const Text('Toggle Name'),
              ),
              ElevatedButton(
                onPressed: () => isActive.value = !isActive.value,
                child: const Text('Toggle Status'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
