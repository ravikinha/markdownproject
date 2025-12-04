import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'notification_example.dart' as notification_app;

class NotificationExamplePage extends StatelessWidget {
  const NotificationExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF252526) : const Color(0xFF007ACC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Screen Launch by Notification',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Notification Launch Detection',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Detect when your app is launched from a notification and route directly to the relevant screen. Skip splash screens and provide instant access to notification content.',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 32),

              // Launch Example Button
              Container(
                width: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.play_circle_outline, size: 32, color: Color(0xFF007ACC)),
                        const SizedBox(width: 12),
                        Text(
                          'Run Example App',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Launch the complete notification example app to see dynamic routing in action. Send test notifications and see how the app routes to different screens based on notification payload.',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const notification_app.NotificationExampleApp(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.launch),
                        label: const Text('Launch Example App'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007ACC),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Quick Start Section
              _buildSectionTitle('Quick Start', isDark),
              const SizedBox(height: 16),
              _buildCodeBlock(
                '''import 'package:screen_launch_by_notfication/screen_launch_by_notfication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwiftFlutterMaterial(
      materialApp: MaterialApp(
        routes: {
          '/home': (_) => HomeScreen(),
          '/notification': (_) => NotificationScreen(),
        },
      ),
      onNotificationLaunch: ({required isFromNotification, required payload}) {
        if (isFromNotification) {
          return SwiftRouting(
            route: '/notification',
            payload: payload,
          );
        }
        return null; // Use default route
      },
    );
  }
}''',
                isDark,
              ),

              const SizedBox(height: 32),

              // Features Section
              _buildSectionTitle('Key Features', isDark),
              const SizedBox(height: 16),
              _buildFeatureCard(
                '🔔 Notification Detection',
                'Detect when app is launched from notification tap',
                isDark,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                '🚀 Dynamic Routing',
                'Route directly to notification-specific screens',
                isDark,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                '📦 Payload Access',
                'Access notification payload data in your screens',
                isDark,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                '🔄 All App States',
                'Works when app is killed, in background, or foreground',
                isDark,
              ),

              const SizedBox(height: 32),

              // Usage Example
              _buildSectionTitle('Usage Example', isDark),
              const SizedBox(height: 16),
              _buildCodeBlock(
                '''// Send notification with payload
final payload = {
  'type': 'chat',
  'chatId': '12345',
  'senderName': 'John Doe',
};

await NotificationService.sendNotification(
  title: 'New Message',
  body: 'You have a new message',
  payload: payload,
);

// Handle routing based on payload
onNotificationLaunch: ({required isFromNotification, required payload}) {
  if (payload.containsKey('chatId')) {
    return SwiftRouting(
      route: '/chat',
      payload: {
        'chatId': payload['chatId'],
        'senderName': payload['senderName'],
      },
    );
  }
  return null;
}''',
                isDark,
              ),

              const SizedBox(height: 32),

              // Deep Link Support
              _buildSectionTitle('Deep Link Support', isDark),
              const SizedBox(height: 16),
              _buildCodeBlock(
                '''// Handle deep links
onDeepLink: ({required url, required route, required queryParams}) {
  if (route == '/product') {
    return SwiftRouting(
      route: '/product',
      payload: {
        'productId': queryParams['id'],
      },
    );
  }
  return null;
}''',
                isDark,
              ),

              const SizedBox(height: 32),

              // Installation
              _buildSectionTitle('Installation', isDark),
              const SizedBox(height: 16),
              _buildCodeBlock(
                '''dependencies:
  screen_launch_by_notfication: ^2.2.0
  flutter_local_notifications: ^19.5.0''',
                isDark,
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: isDark ? Colors.white : const Color(0xFF1E1E1E),
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
                Clipboard.setData(ClipboardData(text: code));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Code copied to clipboard!'),
                    duration: Duration(seconds: 2),
                  ),
                );
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

