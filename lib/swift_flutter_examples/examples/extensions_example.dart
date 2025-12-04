import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class ExtensionsExample extends StatelessWidget {
  const ExtensionsExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Swift-like Extensions',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '80+ convenient extension methods for more readable and expressive code',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'Bool Extensions',
            [
              _buildCodeBlock(
                '''// Toggle boolean values
bool flag = true;
flag = flag.toggle(); // false

// Works with SwiftValue too
final isVisible = swift(true);
isVisible.toggle(); // isVisible.value is now false''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Number Extensions',
            [
              _buildCodeBlock(
                '''int count = 10;
count = count.add(5);      // 15
count = count.sub(3);      // 12
count = count.mul(2);      // 24

double price = 100.0;
price = price.applyPercent(20);  // 120.0 (add 20%)
price = price.discount(10);       // 108.0 (subtract 10%)
price = price.tax(5);             // 113.4 (add 5% tax)

int value = 150;
value = value.clamped(min: 0, max: 100); // 100
bool inRange = value.isBetween(0, 100);   // true''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'String Extensions',
            [
              _buildCodeBlock(
                '''String text = 'hello world';
text = text.capitalized;        // 'Hello world'
text = text.capitalizeWords;    // 'Hello World'
text = text.trimmed;            // Removes whitespace

bool isValid = text.isEmail;    // Check if email
bool isPhone = text.isPhone;    // Check if phone number''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Live Example: Using Extensions',
            [
              _ExtensionsDemo(),
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

class _ExtensionsDemo extends StatelessWidget {
  final counter = swift(10);
  final price = swift(100.0);
  final isVisible = swift(true);
  final text = swift('hello world');

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
                _buildRow('Counter:', '${counter.value}', isDark),
                _buildRow('Price:', '\$${price.value.toStringAsFixed(2)}', isDark),
                _buildRow('Visible:', isVisible.value ? 'Yes' : 'No', isDark),
                _buildRow('Text:', text.value, isDark),
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
                onPressed: () => counter.value += 5,
                child: const Text('Add 5'),
              ),
              ElevatedButton(
                onPressed: () => price.value = price.value * 1.1,
                child: const Text('Add 10%'),
              ),
              ElevatedButton(
                onPressed: () => isVisible.value = !isVisible.value,
                child: const Text('Toggle'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (text.value.isNotEmpty) {
                    text.value = text.value[0].toUpperCase() + text.value.substring(1);
                  }
                },
                child: const Text('Capitalize'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isDark) {
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
