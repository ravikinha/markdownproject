# Best Practices

This guide covers best practices for building production-ready applications with swift_flutter.

## Code Organization

### 1. Structure Your Project

```
lib/
├── main.dart
├── app.dart
├── features/
│   ├── feature_name/
│   │   ├── controllers/
│   │   ├── views/
│   │   ├── models/
│   │   └── services/
├── shared/
│   ├── widgets/
│   ├── services/
│   └── utils/
└── core/
    ├── constants/
    └── theme/
```

### 2. Naming Conventions

```dart
// Controllers
class UserController extends SwiftController { }
class ShoppingCartController extends SwiftController { }

// SwiftValues
final userName = swift('');
final itemCount = swift(0);

// Computed values
late final Computed<String> displayName;
late final Computed<double> totalPrice;
```

## State Management

### 1. Choose the Right Pattern

**Use Direct Pattern for:**
- Local widget state
- Simple UI state
- Quick prototypes
- Single view usage

**Use Controller Pattern for:**
- Business logic
- Shared state
- Complex state
- Team projects

### 2. Keep State Close to Usage

```dart
// ✅ Good - Local state
class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = swift(0);
    return Swift(
      builder: (context) => Text('${counter.value}'),
    );
  }
}

// ❌ Bad - Unnecessary controller
class CounterWidget extends StatelessWidget {
  final controller = CounterController(); // Overkill for simple counter
  // ...
}
```

### 3. Use Computed for Derived State

```dart
// ✅ Good
final price = swift(100.0);
final quantity = swift(2);
final total = Computed(() => price.value * quantity.value);

// ❌ Bad
final total = swift(0.0);
// Manually update total when price or quantity changes
```

## Performance

### 1. Use Transactions for Batch Updates

```dart
// ✅ Good
Transaction.run(() {
  x.value = 10;
  y.value = 20;
  z.value = 30;
});

// ❌ Bad
x.value = 10;
y.value = 20;
z.value = 30;
```

### 2. Avoid Unnecessary Rebuilds

```dart
// ✅ Good - Only accesses needed values
Swift(
  builder: (context) => Text('${counter.value}'),
)

// ❌ Bad - Accesses all values
Swift(
  builder: (context) => Text('${a.value} ${b.value} ${c.value}'),
)
```

### 3. Memoize Expensive Computations

```dart
// ✅ Good
final expensive = Computed.memoized(() => heavyCalculation());

// ❌ Bad
final expensive = Computed(() => heavyCalculation()); // Recalculates unnecessarily
```

## Error Handling

### 1. Handle All States

```dart
// ✅ Good
Swift(
  builder: (context) => dataFuture.value.when(
    idle: () => Text('Click to load'),
    loading: () => CircularProgressIndicator(),
    success: (data) => DataWidget(data: data),
    error: (error, stack) => ErrorWidget(error: error),
  ),
)

// ❌ Bad
Swift(
  builder: (context) => Text('${dataFuture.value.data}'), // Crashes if error
)
```

### 2. Provide Retry Options

```dart
// ✅ Good
dataFuture.value.when(
  error: (error, stack) => Column(
    children: [
      Text('Error: $error'),
      ElevatedButton(
        onPressed: () => loadData(),
        child: Text('Retry'),
      ),
    ],
  ),
)
```

## Testing

### 1. Test Controllers

```dart
test('CounterController increments', () {
  final controller = CounterController();
  controller.increment();
  expect(controller.counter.value, 1);
});
```

### 2. Test Computed Values

```dart
test('total computes correctly', () {
  final price = swift(100.0);
  final quantity = swift(2);
  final total = Computed(() => price.value * quantity.value);
  
  expect(total.value, 200.0);
});
```

### 3. Test Async Operations

```dart
test('loads data successfully', () async {
  final controller = DataController();
  await controller.loadData();
  
  expect(controller.dataFuture.value.isSuccess, true);
  expect(controller.dataFuture.value.data, isNotNull);
});
```

## Code Quality

### 1. Keep Controllers Focused

```dart
// ✅ Good - Single responsibility
class UserController extends SwiftController {
  final user = swift<User?>(null);
  // User-related logic only
}

// ❌ Bad - Multiple responsibilities
class AppController extends SwiftController {
  final user = swift<User?>(null);
  final products = swift<List<Product>>([]);
  final cart = swift<Cart?>(null);
  // Too many responsibilities
}
```

### 2. Use Meaningful Names

```dart
// ✅ Good
final userName = swift('');
final itemCount = swift(0);
final isLoggedIn = swift(false);

// ❌ Bad
final u = swift('');
final c = swift(0);
final flag = swift(false);
```

### 3. Document Complex Logic

```dart
class ShoppingCartController extends SwiftController {
  // Calculates total including tax and discounts
  // Formula: (subtotal - discount) * (1 + taxRate)
  late final Computed<double> total;
  
  ShoppingCartController() {
    total = Computed(() {
      final subtotal = calculateSubtotal();
      final discount = calculateDiscount();
      final tax = (subtotal - discount) * taxRate;
      return subtotal - discount + tax;
    });
  }
}
```

## Security

### 1. Don't Store Sensitive Data in State

```dart
// ❌ Bad
final password = swift(''); // Don't store passwords in reactive state

// ✅ Good
final passwordController = TextEditingController(); // Use TextEditingController
```

### 2. Validate Input

```dart
// ✅ Good
final emailField = SwiftField<String>('');
emailField.addValidator(Validators.required());
emailField.addValidator(Validators.email());
```

## Accessibility

### 1. Provide Semantic Labels

```dart
Swift(
  builder: (context) => ElevatedButton(
    onPressed: controller.increment,
    child: Text('Increment'),
    semanticsLabel: 'Increment counter',
  ),
)
```

## Maintenance

### 1. Keep Dependencies Updated

Regularly update swift_flutter to get the latest features and bug fixes.

## Debug Tool

swift_flutter includes a powerful debug tool for monitoring network requests, WebSocket connections, and logs. This is especially useful during development.

### Enabling the Debug Tool

Enable the debug tool with a single line in your `main()` function:

```dart
void main() {
  SwiftFlutter.init(debugtool: true);
  runApp(MyApp());
}
```

**⚠️ Important**: You must add `SwiftDebugFloatingButton` to your `Scaffold` to access the debug inspector page:

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Center(child: Text('Hello World')),
      // Add this button to access debug inspector
      floatingActionButton: const SwiftDebugFloatingButton(),
    );
  }
}
```

The floating button will automatically appear when the debug tool is enabled and provides access to the debug inspector page.

### Features

The debug tool provides:

- **Network Interceptor**: Automatically captures all HTTP requests made with `http` and `dio` packages
- **WebSocket Interceptor**: Tracks WebSocket connections, messages, and events
- **Log Interceptor**: Captures all print statements and logs
- **Curl Generator**: Automatically generates curl commands for API testing
- **Modern UI**: Beautiful, responsive interface that works on all devices

### Using the Debug Tool

```dart
import 'package:swift_flutter/swift_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  // Initialize with debug tool enabled
  SwiftFlutter.init(debugtool: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Center(child: Text('Hello World')),
      // ⚠️ IMPORTANT: Add SwiftDebugFloatingButton to access debug inspector
      floatingActionButton: const SwiftDebugFloatingButton(),
    );
  }
}

// Make HTTP requests - automatically intercepted!
final response = await SwiftHttpHelper.intercept(
  () => http.get(Uri.parse('https://api.example.com/data')),
  method: 'GET',
  url: 'https://api.example.com/data',
);

// Use swiftPrint() for log interception
swiftPrint('This will appear in the debug tool');
```

**Note**: The `SwiftDebugFloatingButton` is required to access the debug inspector page. Without it, you won't be able to view the captured network requests, logs, or WebSocket connections.

### Debug Tool Tabs

- **HTTP Tab**: View all HTTP requests with request/response details, headers, and body
- **WebSocket Tab**: Monitor WebSocket connections and messages in real-time
- **Logs Tab**: Browse all captured logs with filtering by type
- **Curl Tab**: Copy curl commands for easy API testing

### Best Practices for Debug Tool

1. **Enable Only in Development**: The debug tool should be disabled in production builds
2. **Use Conditional Initialization**: 
   ```dart
   SwiftFlutter.init(debugtool: kDebugMode);
   ```
3. **Monitor Network Requests**: Use it to debug API calls and network issues
4. **Track WebSocket Events**: Monitor real-time connections and messages
5. **Review Logs**: Check captured logs to understand app behavior

### Production Considerations

Always disable the debug tool in production:

```dart
import 'package:flutter/foundation.dart';

void main() {
  SwiftFlutter.init(debugtool: kDebugMode); // Only enabled in debug mode
  runApp(MyApp());
}
```

This ensures zero overhead in production builds while providing powerful debugging capabilities during development.

### 2. Follow Breaking Changes

Check the changelog when updating to new versions.

### 3. Use Linting

Enable Flutter lints to catch common issues:

```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml
```

## Common Pitfalls

### 1. Modifying State Outside Swift Widget

```dart
// ❌ Bad - Won't trigger rebuilds
void someFunction() {
  counter.value = 10; // No rebuild
}

// ✅ Good - Modify inside Swift widget or controller
Swift(
  builder: (context) => ElevatedButton(
    onPressed: () => counter.value = 10, // Triggers rebuild
    child: Text('Reset'),
  ),
)
```

### 2. Forgetting to Use Swift Widget

```dart
// ❌ Bad - No reactivity
Widget build(BuildContext context) {
  final counter = swift(0);
  return Text('${counter.value}'); // Won't update
}

// ✅ Good - Uses Swift widget
Widget build(BuildContext context) {
  final counter = swift(0);
  return Swift(
    builder: (context) => Text('${counter.value}'), // Updates automatically
  );
}
```

### 3. Creating SwiftValue in build()

```dart
// ❌ Bad - Creates new instance on every build
Widget build(BuildContext context) {
  final counter = swift(0); // New instance each time
  return Swift(builder: (context) => Text('${counter.value}'));
}

// ✅ Good - Create once
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late final counter = swift(0);
  
  @override
  Widget build(BuildContext context) {
    return Swift(builder: (context) => Text('${counter.value}'));
  }
}
```

## Summary

1. **Organize** your code with clear structure
2. **Choose** the right pattern for your use case
3. **Optimize** performance with transactions and memoization
4. **Handle** errors gracefully
5. **Test** your code thoroughly
6. **Maintain** code quality with good practices
7. **Avoid** common pitfalls

Following these best practices will help you build maintainable, performant, and reliable Flutter applications with swift_flutter.

---

**Previous**: [Advanced Patterns ←](09_advanced_patterns.md)

**Congratulations!** You've completed the swift_flutter learning guide. You now have a solid understanding of reactive state management with swift_flutter. Start building amazing Flutter apps! 🚀

