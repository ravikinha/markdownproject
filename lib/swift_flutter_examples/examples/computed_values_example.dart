import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class ComputedValuesExample extends StatelessWidget {
  const ComputedValuesExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Computed Values',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Derived values that automatically update when their dependencies change',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'What are Computed Values?',
            [
              Text(
                'A computed value is automatically calculated from other reactive values. When any dependency changes, the computed value automatically recalculates.',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 16),
              _buildCodeBlock(
                'final price = swift(100.0);\n'
                'final quantity = swift(2);\n\n'
                '// Computed value - automatically updates when price or quantity changes\n'
                'final total = Computed(() => price.value * quantity.value);\n\n'
                'Swift(\n'
                '  builder: (context) => Text(\'Total: \$\${total.value}\'),\n'
                ')',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Common Use Cases',
            [
              _buildUseCaseCard(
                '1. Calculations',
                '''final price = swift(100.0);
final taxRate = swift(0.1);
final quantity = swift(2);

final subtotal = Computed(() => price.value * quantity.value);
final tax = Computed(() => subtotal.value * taxRate.value);
final total = Computed(() => subtotal.value + tax.value);''',
                isDark,
              ),
              const SizedBox(height: 16),
              _buildUseCaseCard(
                '2. String Formatting',
                '''final hours = swift(2);
final minutes = swift(30);

final timeString = Computed(() => 
  '\${hours.value}h \${minutes.value}m'
);''',
                isDark,
              ),
              const SizedBox(height: 16),
              _buildUseCaseCard(
                '3. Conditional Logic',
                '''final age = swift(25);
final isAdult = Computed(() => age.value >= 18);
final canVote = Computed(() => age.value >= 18 && isAdult.value);''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Live Example: Shopping Cart',
            [
              _ShoppingCartDemo(),
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

  Widget _buildUseCaseCard(String title, String code, bool isDark) {
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
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShoppingCartDemo extends StatelessWidget {
  final price = swift(100.0);
  final quantity = swift(2);
  final taxRate = swift(0.1);

  _ShoppingCartDemo() {
    // Computed values
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final subtotal = Computed(() => price.value * quantity.value);
    final tax = Computed(() => subtotal.value * taxRate.value);
    final total = Computed(() => subtotal.value + tax.value);

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
                _buildRow('Price per item:', '\$${price.value.toStringAsFixed(2)}', isDark),
                _buildRow('Quantity:', '${quantity.value}', isDark),
                _buildRow('Tax rate:', '${(taxRate.value * 100).toStringAsFixed(0)}%', isDark),
                const Divider(height: 24),
                _buildRow('Subtotal:', '\$${subtotal.value.toStringAsFixed(2)}', isDark, bold: true),
                _buildRow('Tax:', '\$${tax.value.toStringAsFixed(2)}', isDark),
                _buildRow('Total:', '\$${total.value.toStringAsFixed(2)}', isDark, bold: true, color: const Color(0xFF007ACC)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => quantity.value = (quantity.value - 1).clamp(1, 10),
                icon: const Icon(Icons.remove),
              ),
              Text(
                'Quantity: ${quantity.value}',
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: () => quantity.value = (quantity.value + 1).clamp(1, 10),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isDark, {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
              color: color ?? (isDark ? Colors.white : const Color(0xFF1E1E1E)),
            ),
          ),
        ],
      ),
    );
  }
}
