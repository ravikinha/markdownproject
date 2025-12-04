import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class AsyncStateExample extends StatelessWidget {
  const AsyncStateExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Async State with SwiftFuture',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Automatic handling of loading, success, and error states for async operations',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'What is SwiftFuture?',
            [
              Text(
                'SwiftFuture is a reactive wrapper around Future that automatically tracks loading, success, and error states. It eliminates the need for manual state management of async operations.',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                ),
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Basic Usage',
            [
              _buildCodeBlock(
                '''final dataFuture = SwiftFuture<String>();

// Load data
dataFuture.value = fetchData();

// In your widget
Swift(
  builder: (context) {
    if (dataFuture.isLoading) {
      return CircularProgressIndicator();
    }
    if (dataFuture.hasError) {
      return Text('Error: \${dataFuture.error}');
    }
    return Text('Data: \${dataFuture.data}');
  },
)''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Live Example: Data Loading',
            [
              _AsyncDataDemo(),
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

class _AsyncDataDemo extends StatelessWidget {
  final dataFuture = SwiftFuture<String>();

  _AsyncDataDemo() {
    _loadData();
  }

  Future<void> _loadData() async {
    dataFuture.execute(() => _simulateDataFetch());
  }

  Future<String> _simulateDataFetch() async {
    await Future.delayed(const Duration(seconds: 2));
    if (DateTime.now().millisecond % 3 == 0) {
      throw Exception('Failed to load data');
    }
    return 'Data loaded successfully!';
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
        children: [
          Swift(
            builder: (context) {
              if (dataFuture.isLoading) {
                return const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading data...'),
                  ],
                );
              }
              if (dataFuture.isError) {
                return Column(
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${dataFuture.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    dataFuture.data ?? 'No data',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadData,
            child: const Text('Reload Data'),
          ),
        ],
      ),
    );
  }
}
