import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';

class DebugToolExample extends StatelessWidget {
  const DebugToolExample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Debug Tool',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Built-in network interceptor, WebSocket tracker, and log capture for comprehensive debugging',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),

          _buildSection(
            'Features',
            [
              _buildFeatureCard('Network Interceptor', 'Track all HTTP requests and responses', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('WebSocket Tracker', 'Monitor WebSocket connections', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('Log Capture', 'Capture and view application logs', isDark),
              const SizedBox(height: 12),
              _buildFeatureCard('Zero Overhead', 'Full DevTools integration with zero performance impact', isDark),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Usage',
            [
              _buildCodeBlock(
                '''// Enable debug tools in development
if (kDebugMode) {
  SwiftDebug.enable();
}

// Network requests are automatically tracked
final response = await http.get(Uri.parse('https://api.example.com/data'));

// View in DevTools or debug panel
SwiftDebug.showNetworkLogs();
SwiftDebug.showWebSocketLogs();
SwiftDebug.showApplicationLogs();''',
                isDark,
              ),
            ],
            isDark,
          ),

          const SizedBox(height: 32),

          _buildSection(
            'Benefits',
            [
              _buildInfoCard(
                'Easy Debugging',
                'All network activity is automatically logged and accessible',
                isDark,
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                'Performance Monitoring',
                'Track request times and identify slow endpoints',
                isDark,
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                'Error Tracking',
                'Automatically capture and display network errors',
                isDark,
              ),
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
          const Icon(Icons.bug_report, color: Color(0xFF007ACC), size: 24),
          const SizedBox(width: 12),
          Expanded(
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

  Widget _buildInfoCard(String title, String description, bool isDark) {
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
          const Icon(Icons.info_outline, color: Color(0xFF007ACC), size: 20),
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
}
