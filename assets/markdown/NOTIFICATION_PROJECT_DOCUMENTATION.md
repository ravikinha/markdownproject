# screen_launch_by_notfication - Complete Project Documentation

## 📦 Package Information

- **Package Name:** `screen_launch_by_notfication`
- **Version:** 2.1.0
- **Pub.dev:** [https://pub.dev/packages/screen_launch_by_notfication](https://pub.dev/packages/screen_launch_by_notfication)
- **GitHub:** [https://github.com/ravikinha/screen_launch_by_notfication](https://github.com/ravikinha/screen_launch_by_notfication)
- **Documentation:** [https://swiftflutter.com/dynamicnotification](https://swiftflutter.com/dynamicnotification)
- **License:** MIT

---

## 🎯 Project Overview

`screen_launch_by_notfication` is a Flutter plugin that solves a critical limitation: **Flutter cannot detect if an app was launched by tapping a notification**. This plugin bridges that gap by leveraging native Android and iOS capabilities to detect notification launches and retrieve notification payloads, enabling you to:

- ✅ Skip splash screens when opened from notifications
- ✅ Route directly to notification-specific screens
- ✅ Retrieve notification payload data
- ✅ Work seamlessly with `flutter_local_notifications`
- ✅ Handle all app states (killed, background, foreground)

### The Problem

Flutter by default cannot detect whether the app was launched by tapping a notification. However, Android & iOS natively can detect this even when the app is:
- ❌ Killed (terminated)
- ❌ In background
- ❌ Not running at all

### The Solution

This plugin uses a native-first approach:

1. **Native code captures** the notification launch event
2. **Native code saves** a flag and payload in SharedPreferences/UserDefaults
3. **Flutter reads** the flag via MethodChannel before `runApp()`
4. **Flutter decides** the initial screen → splash / home / notification screen

---

## ✨ Features

### Core Features

- **🔔 Notification Launch Detection** - Know when your app was opened from a notification
- **📦 Payload Retrieval** - Get all notification data including custom payload
- **🚀 Splash Screen Bypass** - Route directly to notification screens when opened from notification
- **📱 Cross-Platform** - Works on both Android and iOS
- **🔄 All App States** - Detects notification taps when app is killed, in background, or foreground
- **🔌 Plugin Integration** - Works seamlessly with `flutter_local_notifications`

### Version 2.1.0 Features (Latest)

- **🔄 Real-time Navigation** - Automatically navigates when notification is tapped while app is running
- **🎯 Dynamic Routing** - `onNotificationLaunch` callback works for both initial launch and runtime taps
- **📡 Event Stream Support** - `getNotificationStream()` method for listening to notification events
- **🎨 Custom Tap Handler** - `onNotificationTap` callback for custom handling of runtime notification taps
- **🚀 Enhanced Navigation** - Better navigator handling with retry logic for MaterialApp and GetMaterialApp
- **📦 Better Example** - Reorganized example app with multiple screens and organized file structure

### Version 2.0.0 Features

- **🎉 MaterialApp/GetMaterialApp Support** - Accepts `MaterialApp` or `GetMaterialApp` instances
- **✨ Zero Native Setup** - Plugin handles all native code automatically - no need to modify MainActivity or AppDelegate
- **🚀 GetX Navigation** - Full support for GetX navigation with `GetMaterialApp`
- **🎯 Simplified API** - Pass your existing `MaterialApp` or `GetMaterialApp` widget
- **🔧 Better Integration** - Works seamlessly with existing app structure without code duplication
- **📦 Self-Contained** - All native implementation in plugin itself - works for all projects out of the box

### Version 1.1.0 Features

- **🎨 SwiftFlutterMaterial Widget** - Automatic notification-based routing widget
- **🔙 Smart Back Navigation** - Navigates to home instead of exiting app
- **📊 Payload Access** - Routes can access notification payload via `routesWithPayload`
- **🛡️ Error Handling** - Robust error handling with fallback mechanisms
- **📱 iOS Compatibility** - iOS 13+ support with version checks

---

## 📥 Installation

### Step 1: Add Dependency

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  screen_launch_by_notfication: ^2.1.0
  flutter_local_notifications: ^19.5.0  # Recommended for sending notifications
  get: ^4.6.6  # Required only if using GetMaterialApp
```

### Step 2: Install

```bash
flutter pub get
```

### Step 3: Platform Setup

**🎉 Zero Native Setup Required!** The plugin handles everything automatically.

#### Android Setup

**No native code setup needed!** Just ensure you have the required dependencies in your `android/app/build.gradle.kts`:

```kotlin
android {
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}
```

#### iOS Setup

**No native code setup needed!** The plugin automatically handles all notification detection and payload storage.

If you need to request notification permissions in your app (if you haven't already):

```swift
import UserNotifications

// In your AppDelegate or wherever you request permissions
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
  if granted {
    DispatchQueue.main.async {
      UIApplication.shared.registerForRemoteNotifications()
    }
  }
}
```

**Note:** The plugin automatically handles all notification detection and payload storage. No need to modify `AppDelegate.swift` or `MainActivity.kt`!

---

## 🚀 Quick Start

### Method 1: Using SwiftFlutterMaterial Widget (Recommended)

The easiest way to use this plugin - simply wrap your existing `MaterialApp` or `GetMaterialApp`:

#### With MaterialApp

```dart
import 'package:flutter/material.dart';
import 'package:screen_launch_by_notfication/screen_launch_by_notfication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SwiftFlutterMaterial(
      materialApp: MaterialApp(
        title: 'My App',
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => SplashScreen(),
        '/notification': (_) => NotificationScreen(),
          '/chatPage': (_) => ChatScreen(),
        '/home': (_) => HomeScreen(),
      },
      ),
      onNotificationLaunch: ({required isFromNotification, required payload}) {
        // Works for both initial launch AND runtime notification taps
        if (payload.containsKey('chatnotification')) {
          return '/chatPage';  // Route to chat screen
        }
        if (isFromNotification) {
          return '/notification';  // Route to notification screen
        }
        return null;  // Use initialRoute from MaterialApp
      },
    );
  }
}
```

#### With GetMaterialApp

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_launch_by_notfication/screen_launch_by_notfication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SwiftFlutterMaterial(
      getMaterialApp: GetMaterialApp(
        title: 'My App',
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/splash', page: () => SplashScreen()),
          GetPage(name: '/notification', page: () => NotificationScreen()),
          GetPage(name: '/chatPage', page: () => ChatScreen()),
          GetPage(name: '/home', page: () => HomeScreen()),
        ],
      ),
      onNotificationLaunch: ({required isFromNotification, required payload}) {
        // Dynamic routing based on payload
        if (payload.containsKey('chatnotification')) {
          return '/chatPage';
        }
        if (isFromNotification) {
          return '/notification';
        }
        return null;  // Use initialRoute from GetMaterialApp
      },
    );
  }
}
```

### Method 2: Manual Implementation

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:screen_launch_by_notfication/screen_launch_by_notfication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final screenLaunchByNotfication = ScreenLaunchByNotfication();
  final result = await screenLaunchByNotfication.isFromNotification();
  
  final bool openFromNotification = result['isFromNotification'] ?? false;
  final String payload = result['payload'] ?? '{}';

  String initialRoute = openFromNotification
      ? "/notificationScreen"
      : "/normalSplash";

  runApp(MyApp(initialRoute: initialRoute, notificationPayload: payload));
}
```

---

## 📚 Complete Setup Guide

### Android Implementation

**🎉 Zero Native Setup Required!** The plugin handles everything automatically.

Just ensure you have the required dependencies in your `android/app/build.gradle.kts`:

```kotlin
android {
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}
```

**Note:** The plugin automatically handles all notification detection and payload storage. No need to modify `MainActivity.kt`!

### iOS Implementation

**🎉 Zero Native Setup Required!** The plugin handles everything automatically.

If you need to request notification permissions in your app (if you haven't already):

```swift
import UserNotifications

// In your AppDelegate or wherever you request permissions
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
  if granted {
    DispatchQueue.main.async {
      UIApplication.shared.registerForRemoteNotifications()
    }
  }
}
```

**Note:** The plugin automatically handles all notification detection and payload storage. No need to modify `AppDelegate.swift`!

---

## 📖 API Reference

### ScreenLaunchByNotfication Class

#### `isFromNotification()`

Checks if the app was launched from a notification tap.

**Returns:** `Future<Map<String, dynamic>>`
- `isFromNotification` (bool): Whether the app was opened from a notification
- `payload` (String): The notification payload as a JSON string

**Example:**
```dart
final result = await screenLaunchByNotfication.isFromNotification();
if (result['isFromNotification'] == true) {
  final payload = jsonDecode(result['payload']);
  print('Opened from notification with payload: $payload');
}
```

#### `storeNotificationPayload(String payload)`

Stores notification payload in native storage for later retrieval.

**Parameters:**
- `payload` (String): JSON string containing the notification payload

**Returns:** `Future<bool>` - `true` if successful

**Example:**
```dart
final payload = jsonEncode({'title': 'Test', 'body': 'Message'});
await screenLaunchByNotfication.storeNotificationPayload(payload);
```

### SwiftFlutterMaterial Widget

A widget that wraps `MaterialApp` or `GetMaterialApp` and automatically handles notification-based routing.

#### Constructor Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `materialApp` | `MaterialApp?` | No* | Your existing `MaterialApp` widget |
| `getMaterialApp` | `GetMaterialApp?` | No* | Your existing `GetMaterialApp` widget |
| `onNotificationLaunch` | `NotificationRouteCallback?` | No | Callback to determine route based on notification (works for both initial launch and runtime taps) |
| `onNotificationTap` | `OnNotificationTapCallback?` | No | Custom callback for handling notification taps when app is already running |

*Either `materialApp` or `getMaterialApp` must be provided (not both).

#### Example Usage

```dart
// With MaterialApp
SwiftFlutterMaterial(
  materialApp: MaterialApp(
    title: 'My App',
    initialRoute: '/splash',
    routes: {
      '/splash': (_) => SplashScreen(),
      '/notification': (_) => NotificationScreen(),
      '/home': (_) => HomeScreen(),
    },
  ),
  onNotificationLaunch: ({required isFromNotification, required payload}) {
    if (isFromNotification) {
      return '/notification';
    }
    return null; // Use initialRoute from MaterialApp
  },
)

// With GetMaterialApp
SwiftFlutterMaterial(
  getMaterialApp: GetMaterialApp(
    title: 'My App',
    initialRoute: '/splash',
    getPages: [
      GetPage(name: '/splash', page: () => SplashScreen()),
      GetPage(name: '/notification', page: () => NotificationScreen()),
      GetPage(name: '/home', page: () => HomeScreen()),
    ],
  ),
  onNotificationLaunch: ({required isFromNotification, required payload}) {
    if (isFromNotification) {
      return '/notification';
    }
    return null; // Use initialRoute from GetMaterialApp
  },
)
```

---

## 💡 Usage Examples

### Example 1: Basic Notification Detection

```dart
import 'package:screen_launch_by_notfication/screen_launch_by_notfication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final plugin = ScreenLaunchByNotfication();
  final result = await plugin.isFromNotification();
  
  if (result['isFromNotification'] == true) {
    print('App opened from notification!');
    print('Payload: ${result['payload']}');
  }
  
  runApp(MyApp());
}
```

### Example 2: With flutter_local_notifications

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:screen_launch_by_notfication/screen_launch_by_notfication.dart';

final FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
final ScreenLaunchByNotfication launchPlugin = ScreenLaunchByNotfication();

Future<void> sendNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'Channel Name',
    channelDescription: 'Channel Description',
    importance: Importance.high,
    priority: Priority.high,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  const NotificationDetails details = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  final payload = jsonEncode({
    'title': 'Test Notification',
    'body': 'This is a test',
    'timestamp': DateTime.now().millisecondsSinceEpoch,
  });

  // Store payload before sending
  await launchPlugin.storeNotificationPayload(payload);

  await notifications.show(
    DateTime.now().millisecondsSinceEpoch.remainder(100000),
    'Test Notification',
    'Tap to open app',
    details,
    payload: payload,
  );
}
```

### Example 3: Complete App with SwiftFlutterMaterial

```dart
import 'package:flutter/material.dart';
import 'package:screen_launch_by_notfication/screen_launch_by_notfication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SwiftFlutterMaterial(
      materialApp: MaterialApp(
        title: 'My App',
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/notification': (_) {
            final payload = ModalRoute.of(_)?.settings.arguments as Map<String, dynamic>?;
            return NotificationScreen(payload: payload);
          },
          '/chat': (_) {
            final payload = ModalRoute.of(_)?.settings.arguments as Map<String, dynamic>?;
            return ChatScreen(payload: payload);
          },
          '/orders': (_) {
            final payload = ModalRoute.of(_)?.settings.arguments as Map<String, dynamic>?;
            return OrdersScreen(payload: payload);
          },
          '/home': (_) => const HomeScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
      onNotificationLaunch: ({required isFromNotification, required payload}) {
        if (isFromNotification) {
          // Custom logic based on payload
          if (payload['type'] == 'message') {
            return '/chat';
          } else if (payload['type'] == 'order') {
            return '/orders';
          }
          return '/notification';
        }
        return null; // Use initialRoute from MaterialApp
      },
    );
  }
}
```

---

## 🔧 Configuration

### Android Configuration

1. **Minimum SDK:** Android 5.0 (API 21)
2. **Target SDK:** Latest
3. **No Native Setup Required:** Plugin handles everything automatically

### iOS Configuration

1. **Minimum iOS:** iOS 10.0
2. **No Native Setup Required:** Plugin handles everything automatically
3. **Permissions:** Notification permissions should be requested in your app if not already done

---

## 🎯 How It Works

### Flow Diagram

```
User Taps Notification
        ↓
Native Code Captures Event (Android/iOS)
        ↓
Save Flag: openFromNotification = true
Save Payload: notificationPayload = {...}
        ↓
Flutter Starts
        ↓
Read Flag via MethodChannel (before runApp())
        ↓
Check: isFromNotification?
        ↓
    Yes → Route to Notification Screen (Skip Splash)
    No  → Route to Normal Splash Screen
```

### Technical Details

1. **Native Detection:**
   - Android: Checks Intent extras and action
   - iOS: Checks UNNotificationResponse and launchOptions

2. **Storage:**
   - Android: SharedPreferences
   - iOS: UserDefaults

3. **Communication:**
   - MethodChannel: `launch_channel`
   - Methods: `isFromNotification`, `storeNotificationPayload`

4. **Payload Format:**
   - Stored as JSON string
   - Parsed in Flutter using `jsonDecode()`

---

## 🐛 Troubleshooting

### Issue: App exits when pressing back from notification screen

**Solution:** Handle back navigation in your route screens or use `WillPopScope`:

```dart
WillPopScope(
  onWillPop: () async {
    Navigator.pushReplacementNamed(context, '/home');
    return false;
  },
  child: YourNotificationScreen(),
)
```

### Issue: Payload is empty

**Solution:** Ensure you're storing the payload before sending the notification:

```dart
await screenLaunchByNotfication.storeNotificationPayload(payload);
await flutterLocalNotificationsPlugin.show(..., payload: payload);
```

### Issue: iOS build error with `.banner`

**Solution:** Already fixed in version 1.1.0. The code uses version checks:
- iOS 14+: Uses `.banner`
- iOS 13: Uses `.alert`

### Issue: Android build error

**Solution:** Ensure your `android/app/build.gradle.kts` has the correct compile options:

```kotlin
android {
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}
```

### Issue: Notification not detected

**Checklist:**
1. ✅ Plugin is properly added to `pubspec.yaml` (version 2.0.0+)
2. ✅ Notification includes payload
3. ✅ `storeNotificationPayload` is called before sending notification
4. ✅ App is completely closed (not just in background) when testing
5. ✅ `onNotificationLaunch` callback is properly defined in `SwiftFlutterMaterial`

---

## 📋 Requirements

- **Flutter SDK:** `>=3.3.0`
- **Dart SDK:** `^3.10.0`
- **Android:** Minimum SDK 21 (Android 5.0)
- **iOS:** Minimum iOS 10.0
- **flutter_local_notifications:** `^19.5.0` (recommended)

---

## 🔗 Links & Resources

- **Pub.dev Package:** [https://pub.dev/packages/screen_launch_by_notfication](https://pub.dev/packages/screen_launch_by_notfication)
- **GitHub Repository:** [https://github.com/ravikinha/screen_launch_by_notfication](https://github.com/ravikinha/screen_launch_by_notfication)
- **Documentation:** [https://swiftflutter.com/dynamicnotification](https://swiftflutter.com/dynamicnotification)
- **Issues:** [https://github.com/ravikinha/screen_launch_by_notfication/issues](https://github.com/ravikinha/screen_launch_by_notfication/issues)

---

## 📝 Version History

### Version 2.1.0 (Current)

- ✅ **Real-time Navigation** - Automatically navigates when notification is tapped while app is running
- ✅ **Dynamic Routing** - `onNotificationLaunch` callback works for both initial launch and runtime taps
- ✅ **Event Stream Support** - `getNotificationStream()` method for listening to notification events
- ✅ **Custom Tap Handler** - `onNotificationTap` callback for custom handling of runtime notification taps
- ✅ **Enhanced Navigation** - Better navigator handling with retry logic for MaterialApp and GetMaterialApp
- ✅ **Better Example** - Reorganized example app with multiple screens and organized file structure

### Version 2.0.0

- ✅ **Major API Update** - `SwiftFlutterMaterial` now accepts `MaterialApp` or `GetMaterialApp` instances
- ✅ **Zero Native Setup** - Plugin handles all native code automatically - no need to modify MainActivity or AppDelegate
- ✅ **GetMaterialApp Support** - Full support for GetX navigation with `GetMaterialApp`
- ✅ **Simplified API** - Pass your existing `MaterialApp` or `GetMaterialApp` widget
- ✅ **Better Integration** - Works seamlessly with existing app structure without code duplication
- ✅ **Self-Contained Plugin** - All native implementation in plugin itself - works for all projects out of the box
- ✅ **Flexible Configuration** - Use `onNotificationLaunch` callback to customize routing based on notification status and payload

### Version 1.1.0

- ✅ Added `SwiftFlutterMaterial` widget for automatic notification-based routing
- ✅ Enhanced back navigation handling - navigates to home route instead of exiting app
- ✅ Added `homeRoute` parameter for custom back navigation destination
- ✅ Added `routesWithPayload` for routes that need access to notification payload
- ✅ Improved iOS compatibility (iOS 13+ support)
- ✅ Better error handling and fallback mechanisms

### Version 1.0.0

- ✅ Initial release
- ✅ Detect if app was launched by tapping a notification
- ✅ Retrieve notification payload (works with flutter_local_notifications)
- ✅ Skip splash screens when opened from notification
- ✅ Support for Android and iOS
- ✅ Store notification payload for later retrieval

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 💬 Support

- **Documentation:** [swiftflutter.com/dynamicnotification](https://swiftflutter.com/dynamicnotification)
- **GitHub Issues:** [https://github.com/ravikinha/screen_launch_by_notfication/issues](https://github.com/ravikinha/screen_launch_by_notfication/issues)
- **Email:** (Add your support email if available)

---

## 🎓 Best Practices

1. **Always store payload before sending notification:**
   ```dart
   await screenLaunchByNotfication.storeNotificationPayload(payload);
   await notifications.show(..., payload: payload);
   ```

2. **Use SwiftFlutterMaterial for automatic routing:**
   - Reduces boilerplate code
   - Handles edge cases automatically
   - Provides better user experience

3. **Handle errors gracefully:**
   ```dart
   try {
     final result = await screenLaunchByNotfication.isFromNotification();
     // Handle result
   } catch (e) {
     // Fallback to default route
   }
   ```

4. **Test on all app states:**
   - App killed (terminated)
   - App in background
   - App in foreground

5. **Use meaningful payload structure:**
   ```dart
   final payload = jsonEncode({
     'type': 'message',
     'id': '123',
     'title': 'New Message',
     'body': 'You have a new message',
   });
   ```

---

## 📊 Project Statistics

- **Total Files:** 90+
- **Lines of Code:** ~2000+
- **Platforms:** Android, iOS
- **Dependencies:** flutter_local_notifications (recommended)
- **License:** MIT
- **Maintainer:** ravikinha

---

## 🌟 Features Comparison

| Feature | Without Plugin | With Plugin |
|---------|---------------|-------------|
| Detect notification launch | ❌ No | ✅ Yes |
| Get notification payload | ❌ No | ✅ Yes |
| Skip splash on notification | ❌ No | ✅ Yes |
| Works when app is killed | ❌ No | ✅ Yes |
| Automatic routing | ❌ Manual | ✅ Automatic |
| Back navigation handling | ❌ Manual | ✅ Automatic |

---

## 🚀 Getting Started Checklist

- [ ] Add dependency to `pubspec.yaml`
- [ ] Run `flutter pub get`
- [ ] Initialize `flutter_local_notifications` (if using)
- [ ] Use `SwiftFlutterMaterial` widget with your `MaterialApp` or `GetMaterialApp`
- [ ] Define `onNotificationLaunch` callback for dynamic routing
- [ ] Test on both platforms
- [ ] Test all app states (killed, background, foreground)
- [ ] Test notification taps while app is running

---

## 📱 Example App

A complete example app is included in the `example/` directory. It demonstrates:

- Basic notification detection
- Using `SwiftFlutterMaterial` widget
- Sending test notifications
- Displaying notification payload
- Handling back navigation

To run the example:

```bash
cd example
flutter run
```

---

## 🎯 Use Cases

1. **E-commerce Apps:** Route to order details when notification is tapped
2. **Social Media Apps:** Navigate to specific chat or post
3. **News Apps:** Open specific article from notification
4. **Messaging Apps:** Go directly to conversation
5. **Task Management:** Open specific task or project
6. **Any app with notifications:** Skip splash and go directly to relevant content

---

## 📖 Additional Resources

- [Flutter Notification Guide](https://flutter.dev/docs/development/packages-and-plugins/developing-packages)
- [flutter_local_notifications Documentation](https://pub.dev/packages/flutter_local_notifications)
- [Android Notification Best Practices](https://developer.android.com/develop/ui/views/notifications)
- [iOS User Notifications](https://developer.apple.com/documentation/usernotifications)

---

**Made with ❤️ by the SwiftFlutter team**

For more information, visit: [swiftflutter.com/dynamicnotification](https://swiftflutter.com/dynamicnotification)

