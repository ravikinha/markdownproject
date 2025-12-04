import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_launch_by_notfication/screen_launch_by_notfication.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Complete example demonstrating screen_launch_by_notification package
/// This example shows how to:
/// 1. Initialize notifications
/// 2. Use SwiftFlutterMaterial for automatic routing
/// 3. Handle notification launches with dynamic routing
/// 4. Send test notifications
/// 5. Handle deep links

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await NotificationService.initialize();

  runApp(const NotificationExampleApp());
}

class NotificationExampleApp extends StatefulWidget {
  const NotificationExampleApp({super.key});

  @override
  State<NotificationExampleApp> createState() => _NotificationExampleAppState();
}

class _NotificationExampleAppState extends State<NotificationExampleApp> {
  bool _isInitialized = false;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    if (_isInitialized || _isInitializing) return;
    
    setState(() {
      _isInitializing = true;
    });

    try {
      await NotificationService.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isInitializing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized && _isInitializing) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Initializing notifications...',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SwiftFlutterMaterial(
      materialApp: MaterialApp(
        title: 'Screen Launch by Notification Example',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/notification': (context) {
            // Get route arguments if passed
            final args = ModalRoute.of(context)?.settings.arguments;
            return NotificationScreen(
              payload: args is Map<String, dynamic> ? args : null,
            );
          },
          '/chat': (context) {
            // Get route arguments if passed
            final args = ModalRoute.of(context)?.settings.arguments;
            if (args is Map<String, dynamic>) {
              return ChatScreen(
                chatId: args['chatId']?.toString(),
                senderName: args['senderName']?.toString(),
                message: args['message']?.toString(),
              );
            }
            return const ChatScreen();
          },
          '/order': (context) {
            // Get route arguments if passed
            final args = ModalRoute.of(context)?.settings.arguments;
            if (args is Map<String, dynamic>) {
              return OrderScreen(
                orderId: args['orderId']?.toString(),
                orderStatus: args['orderStatus']?.toString(),
              );
            }
            return const OrderScreen();
          },
        },
      ),
      // Dynamic routing based on notification payload
      onNotificationLaunch: ({required isFromNotification, required payload}) {
        print('📱 App launched from notification: $isFromNotification');
        print('📦 Payload: $payload');

        // Check for chat notification
        if (payload.containsKey('chatnotification')) {
          print('💬 Routing to chat screen');
          return SwiftRouting(
            route: '/chat',
            payload: {
              'chatId': payload['chatId']?.toString(),
              'senderName': payload['senderName']?.toString(),
              'message': payload['message']?.toString(),
            },
          );
        }

        // Check for order notification
        if (payload.containsKey('orderId')) {
          print('📦 Routing to order screen');
          return SwiftRouting(
            route: '/order',
            payload: {
              'orderId': payload['orderId']?.toString(),
              'orderStatus': payload['orderStatus']?.toString(),
            },
          );
        }

        // Default: route to notification screen when launched from notification
        if (isFromNotification) {
          print('🔔 Routing to notification screen');
          return SwiftRouting(
            route: '/notification',
            payload: payload.isNotEmpty ? payload : null,
          );
        }

        // Return null to use initialRoute from MaterialApp
        print('🏠 Using default initialRoute');
        return null;
      },
      // Deep link handling
      onDeepLink: ({required url, required route, required queryParams}) {
        print('🔗 Deep link received: $url');
        print('📍 Route: $route');
        print('📦 Query params: $queryParams');

        // Handle product deep links: notificationapp://product?id=123
        if (route == '/product') {
          final productId = queryParams['id'] ?? queryParams['productId'];
          if (productId != null) {
            return SwiftRouting(
              route: '/notification',
              payload: {
                'type': 'product',
                'productId': productId,
                'source': 'deeplink',
                ...queryParams,
              },
            );
          }
        }

        // Handle path-based product routes: notificationapp://product/123
        if (route.startsWith('/product/')) {
          final productId = route.split('/').last;
          return SwiftRouting(
            route: '/notification',
            payload: {
              'type': 'product',
              'productId': productId,
              'source': 'deeplink',
            },
          );
        }

        // Return null to skip navigation for unknown routes
        return null;
      },
    );
  }
}

// ============================================================================
// Notification Service
// ============================================================================

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static final ScreenLaunchByNotfication _screenLaunch =
      ScreenLaunchByNotfication();

  /// Initialize notification service
  static Future<void> initialize() async {
    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Combined initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize the plugin
    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions (Android 13+)
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Request permissions (iOS)
    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Handle notification tap
  static void _onNotificationTapped(NotificationResponse response) {
    // Store payload in native code for consistency
    if (response.payload != null && response.payload!.isNotEmpty) {
      _screenLaunch.storeNotificationPayload(response.payload!);
    }
  }

  /// Send a notification with payload
  static Future<void> sendNotification({
    required String title,
    required String body,
    required Map<String, dynamic> payload,
  }) async {
    // Create notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'test_notification_channel',
      'Test Notifications',
      channelDescription: 'Channel for test notifications',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // Convert payload to JSON string
    final payloadString = jsonEncode(payload);

    // Store notification payload using the plugin before sending
    await _screenLaunch.storeNotificationPayload(payloadString);

    // Show notification with payload
    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      platformChannelSpecifics,
      payload: payloadString,
    );
  }
}

// ============================================================================
// Screens
// ============================================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate splash screen delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications_active, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Notification Example',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSending = false;

  Future<void> _sendTestNotification(String type) async {
    setState(() {
      _isSending = true;
    });

    try {
      Map<String, dynamic> payload;
      String title;
      String body;

      switch (type) {
        case 'chat':
          payload = {
            'title': 'New Chat Message',
            'body': 'You have a new message from John',
            'timestamp': DateTime.now().millisecondsSinceEpoch,
            'type': 'chat',
            'chatnotification': true,
            'chatId': '12345',
            'senderName': 'John Doe',
            'message': 'Hey, how are you?',
          };
          title = 'New Chat Message';
          body = 'You have a new message from John';
          break;
        case 'order':
          payload = {
            'title': 'Order Update',
            'body': 'Your order #12345 has been shipped',
            'timestamp': DateTime.now().millisecondsSinceEpoch,
            'type': 'order',
            'orderId': '12345',
            'orderStatus': 'shipped',
          };
          title = 'Order Update';
          body = 'Your order #12345 has been shipped';
          break;
        default:
          payload = {
            'title': 'Test Notification',
            'body': 'This is a test notification payload',
            'timestamp': DateTime.now().millisecondsSinceEpoch,
            'type': 'test',
          };
          title = 'Test Notification';
          body = 'Tap to open app from notification';
      }

      await NotificationService.sendNotification(
        title: title,
        body: body,
        payload: payload,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${type.toUpperCase()} notification sent! Close the app and tap the notification to test.',
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.home, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Test different notification types',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Chat Notification Button
            ElevatedButton.icon(
              onPressed: _isSending ? null : () => _sendTestNotification('chat'),
              icon: _isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.chat),
              label: const Text('Send Chat Notification'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 15),
            // Order Notification Button
            ElevatedButton.icon(
              onPressed: _isSending ? null : () => _sendTestNotification('order'),
              icon: _isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.shopping_bag),
              label: const Text('Send Order Notification'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 15),
            // General Notification Button
            ElevatedButton.icon(
              onPressed: _isSending ? null : () => _sendTestNotification('general'),
              icon: _isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.notifications_active),
              label: const Text('Send General Notification'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Instructions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '1. Tap any button to send a test notification\n'
                '2. Close the app completely\n'
                '3. Tap the notification from the system tray\n'
                '4. The app will open directly to the relevant screen',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  final Map<String, dynamic>? payload;

  const NotificationScreen({super.key, this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.notifications, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Notification Received!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (payload != null && payload!.isNotEmpty) ...[
              const Text(
                'Payload:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  JsonEncoder.withIndent('  ').convert(payload),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ] else
              const Text(
                'No payload received',
                style: TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String? chatId;
  final String? senderName;
  final String? message;

  const ChatScreen({
    super.key,
    this.chatId,
    this.senderName,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat ${chatId ?? 'Unknown'}'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.chat, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Chat Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (senderName != null) ...[
              Text('From: $senderName', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
            ],
            if (message != null) ...[
              Text('Message: $message', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
            ],
            if (chatId != null)
              Text('Chat ID: $chatId', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderScreen extends StatelessWidget {
  final String? orderId;
  final String? orderStatus;

  const OrderScreen({
    super.key,
    this.orderId,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ${orderId ?? 'Unknown'}'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.shopping_bag, size: 80, color: Colors.orange),
            const SizedBox(height: 20),
            const Text(
              'Order Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (orderId != null)
              Text('Order ID: $orderId', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            if (orderStatus != null)
              Text('Status: $orderStatus', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

