import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class FormValidationExample extends StatelessWidget {
  const FormValidationExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Validation with SwiftField',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Simple and reactive form validation with automatic error tracking',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'What is SwiftField?',
            [
              _buildFeatureCard('Automatic Validation', 'Tracks validation state automatically', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('Error Messages', 'Provides error message tracking', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('Built-in Validators', 'Many validators included', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('Reactive Updates', 'UI updates automatically on validation', isDark),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Basic Usage',
            [
              _buildCodeBlock(
                '''final emailField = SwiftField<String>('');

// Add validators
emailField.addValidator((value) {
  if (value.isEmpty) {
    return 'Email is required';
  }
  if (!value.contains('@')) {
    return 'Invalid email format';
  }
  return null; // No error
});

// In your widget
TextField(
  onChanged: (value) => emailField.value = value,
  decoration: InputDecoration(
    errorText: emailField.hasError ? emailField.error : null,
  ),
)''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Live Example: Login Form',
            [
              _FormValidationDemo(),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF3C3C3C) : const Color(0xFFDDDDDD),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.check, color: Color(0xFF007ACC), size: 20),
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

class _FormValidationDemo extends StatelessWidget {
  final emailField = SwiftField<String>('');
  final passwordField = SwiftField<String>('');

  _FormValidationDemo() {
    emailField.addValidator((value) {
      if (value.isEmpty) return 'Email is required';
      if (!value.contains('@')) return 'Invalid email format';
      return null;
    });

    passwordField.addValidator((value) {
      if (value.isEmpty) return 'Password is required';
      if (value.length < 6) return 'Password must be at least 6 characters';
      return null;
    });
  }

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Swift(
            builder: (context) => TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: emailField.error,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                emailField.value = value;
                emailField.markAsTouched();
              },
            ),
          ),
          const SizedBox(height: 16),
          Swift(
            builder: (context) => TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: passwordField.error,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                passwordField.value = value;
                passwordField.markAsTouched();
              },
            ),
          ),
          const SizedBox(height: 24),
          Swift(
            builder: (context) => ElevatedButton(
              onPressed: (emailField.isValid && passwordField.isValid)
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Form is valid!')),
                      );
                    }
                  : null,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
