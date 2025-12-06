import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swift_animations/swift_animations.dart';

class SwiftAnimationsPage extends StatefulWidget {
  const SwiftAnimationsPage({super.key});

  @override
  State<SwiftAnimationsPage> createState() => _SwiftAnimationsPageState();
}

class _SwiftAnimationsPageState extends State<SwiftAnimationsPage> {
  int selectedDemo = 0;
  
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
          'Swift Animations',
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
                'SwiftUI-like Declarative Animations',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Zero boilerplate - No controllers, no ticker providers, no mixins! Animations automatically start when widgets come into view.',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 32),
              
              // Demo Selector
              _buildDemoSelector(isDark),
              const SizedBox(height: 24),
              
              // Selected Demo
              _buildSelectedDemo(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoSelector(bool isDark) {
    final demos = [
      'Fade In',
      'Scale',
      'Rotate',
      'Bounce',
      'Pulse',
      'Slide In Top',
      'Slide In Left',
      'Complex',
      'Fade In Scale',
      'Delayed',
      'Repeat Count',
      'Staggered',
      'Custom Slide',
      'Spring iOS',
      'Spring Gentle',
      'Spring Bouncy',
      'Spring Custom',
      'Gesture Detector',
      'Navigation',
      'Code Editor',
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: demos.asMap().entries.map((entry) {
        final index = entry.key;
        final title = entry.value;
        final isSelected = index == selectedDemo;
        
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() => selectedDemo = index),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF007ACC)
                    : (isDark ? const Color(0xFF2D2D30) : const Color(0xFFF3F3F3)),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF007ACC)
                      : (isDark ? const Color(0xFF3C3C3C) : const Color(0xFFDDDDDD)),
                ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242)),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSelectedDemo(bool isDark) {
    switch (selectedDemo) {
      case 0:
        return _FadeInDemo(isDark: isDark);
      case 1:
        return _ScaleDemo(isDark: isDark);
      case 2:
        return _RotateDemo(isDark: isDark);
      case 3:
        return _BounceDemo(isDark: isDark);
      case 4:
        return _PulseDemo(isDark: isDark);
      case 5:
        return _SlideInTopDemo(isDark: isDark);
      case 6:
        return _SlideInLeftDemo(isDark: isDark);
      case 7:
        return _ComplexDemo(isDark: isDark);
      case 8:
        return _FadeInScaleDemo(isDark: isDark);
      case 9:
        return _DelayedDemo(isDark: isDark);
      case 10:
        return _RepeatCountDemo(isDark: isDark);
      case 11:
        return _StaggeredDemo(isDark: isDark);
      case 12:
        return _CustomSlideDemo(isDark: isDark);
      case 13:
        return _SpringIOSDemo(isDark: isDark);
      case 14:
        return _SpringGentleDemo(isDark: isDark);
      case 15:
        return _SpringBouncyDemo(isDark: isDark);
      case 16:
        return _SpringCustomDemo(isDark: isDark);
      case 17:
        return _GestureDetectorDemo(isDark: isDark);
      case 18:
        return _NavigationDemo(isDark: isDark);
      case 19:
        return _CodeEditorDemo(isDark: isDark);
      default:
        return _FadeInDemo(isDark: isDark);
    }
  }
}

// Individual Demo Widgets

class _FadeInDemo extends StatelessWidget {
  final bool isDark;
  const _FadeInDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Fade In Animation',
      description: 'Widget fades in from transparent to opaque when it becomes visible',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.blue,
)
  .animate()
  .fadeIn()
  .duration(1.s)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      )
          .animate()
          .fadeIn()
          .duration(1.s),
    );
  }
}

class _ScaleDemo extends StatelessWidget {
  final bool isDark;
  const _ScaleDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Scale Animation',
      description: 'Widget scales from 1.0 to target value with repeat',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.green,
)
  .animate()
  .scale(1.2)
  .duration(1.s)
  .repeat(reverse: true)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.green,
      )
          .animate()
          .scale(1.2)
          .duration(1.s)
          .repeat(reverse: true),
    );
  }
}

class _RotateDemo extends StatelessWidget {
  final bool isDark;
  const _RotateDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Rotate Animation',
      description: 'Widget rotates 360 degrees continuously',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.orange,
)
  .animate()
  .rotate(360)
  .duration(2.s)
  .repeat(reverse: false)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.orange,
      )
          .animate()
          .rotate(360)
          .duration(2.s)
          .repeat(reverse: false),
    );
  }
}

class _BounceDemo extends StatelessWidget {
  final bool isDark;
  const _BounceDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Bounce Animation',
      description: 'Widget bounces with elastic effect and scale',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.red,
)
  .animate()
  .bounce()
  .scale(1.3)
  .duration(1.s)
  .repeat(reverse: true)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      )
          .animate()
          .bounce()
          .scale(1.3)
          .duration(1.s)
          .repeat(reverse: true),
    );
  }
}

class _PulseDemo extends StatelessWidget {
  final bool isDark;
  const _PulseDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Pulse Animation',
      description: 'Widget pulses with smooth easing effect',
      code: '''Icon(
  Icons.favorite,
  size: 50,
  color: Colors.pink,
)
  .animate()
  .pulse()
  .scale(1.3)
  .duration(0.8.s)
  .repeat(reverse: true)''',
      child: const Icon(
        Icons.favorite,
        size: 50,
        color: Colors.pink,
      )
          .animate()
          .pulse()
          .scale(1.3)
          .duration(0.8.s)
          .repeat(reverse: true),
    );
  }
}

class _SlideInTopDemo extends StatelessWidget {
  final bool isDark;
  const _SlideInTopDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Slide In Top',
      description: 'Widget slides in from the top with fade effect',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.purple,
)
  .animate()
  .slideInTop()
  .fadeIn()
  .duration(0.8.s)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.purple,
      )
          .animate()
          .slideInTop()
          .fadeIn()
          .duration(0.8.s),
    );
  }
}

class _SlideInLeftDemo extends StatelessWidget {
  final bool isDark;
  const _SlideInLeftDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Slide In Left',
      description: 'Widget slides in from the left side with fade',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.teal,
)
  .animate()
  .slideInLeft()
  .fadeIn()
  .duration(0.8.s)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.teal,
      )
          .animate()
          .slideInLeft()
          .fadeIn()
          .duration(0.8.s),
    );
  }
}

class _ComplexDemo extends StatelessWidget {
  final bool isDark;
  const _ComplexDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Complex Animation',
      description: 'Multiple animations chained together: fade, scale, slide, and rotate',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.indigo,
)
  .animate()
  .fadeIn()
  .scale(1.2)
  .slideInBottom()
  .rotate(180)
  .duration(1.5.s)
  .curve(Curves.easeInOut)
  .repeat(reverse: true)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.indigo,
      )
          .animate()
          .fadeIn()
          .scale(1.2)
          .slideInBottom()
          .rotate(180)
          .duration(1.5.s)
          .curve(Curves.easeInOut)
          .repeat(reverse: true),
    );
  }
}

class _FadeInScaleDemo extends StatelessWidget {
  final bool isDark;
  const _FadeInScaleDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Fade In Scale',
      description: 'Combined fade and scale animation in one method',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.amber,
)
  .animate()
  .fadeInScale(1.2)
  .duration(1.s)
  .repeat(reverse: true)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.amber,
      )
          .animate()
          .fadeInScale(1.2)
          .duration(1.s)
          .repeat(reverse: true),
    );
  }
}

class _DelayedDemo extends StatelessWidget {
  final bool isDark;
  const _DelayedDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Delayed Animation',
      description: 'Animation starts after a delay when widget becomes visible',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.cyan,
)
  .animate()
  .fadeIn()
  .scale(1.3)
  .delay(500.ms)
  .duration(1.s)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.cyan,
      )
          .animate()
          .fadeIn()
          .scale(1.3)
          .delay(500.ms)
          .duration(1.s),
    );
  }
}

class _RepeatCountDemo extends StatelessWidget {
  final bool isDark;
  const _RepeatCountDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Repeat Count (Fixed in v1.2.1)',
      description: 'Animation repeats a specific number of times - Now properly respects the count instead of infinite loop',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.deepOrange,
)
  .animate()
  .scale(1.4)
  .duration(0.6.s)
  .repeatCount(3, reverse: true)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.deepOrange,
      )
          .animate()
          .scale(1.4)
          .duration(0.6.s)
          .repeatCount(3, reverse: true),
    );
  }
}

class _StaggeredDemo extends StatelessWidget {
  final bool isDark;
  const _StaggeredDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Staggered Animations',
      description: 'Multiple items animate with different delays for cascading effect',
      code: '''Row(
  children: [
    Container(width: 60, height: 60, color: Colors.red)
      .animate()
      .fadeIn()
      .scale(1.2)
      .delay(0.ms)
      .duration(0.5.s)
      .repeat(reverse: true),
    Container(width: 60, height: 60, color: Colors.green)
      .animate()
      .fadeIn()
      .scale(1.2)
      .delay(200.ms)
      .duration(0.5.s)
      .repeat(reverse: true),
    Container(width: 60, height: 60, color: Colors.blue)
      .animate()
      .fadeIn()
      .scale(1.2)
      .delay(400.ms)
      .duration(0.5.s)
      .repeat(reverse: true),
  ],
)''',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Container(
            width: 60,
            height: 60,
            color: Colors.red,
          )
              .animate()
              .fadeIn()
              .scale(1.2)
              .delay(0.ms)
              .duration(0.5.s)
              .repeat(reverse: true),
          Container(
            width: 60,
            height: 60,
            color: Colors.green,
          )
              .animate()
              .fadeIn()
              .scale(1.2)
              .delay(200.ms)
              .duration(0.5.s)
              .repeat(reverse: true),
          Container(
            width: 60,
            height: 60,
            color: Colors.blue,
          )
              .animate()
              .fadeIn()
              .scale(1.2)
              .delay(400.ms)
              .duration(0.5.s)
              .repeat(reverse: true),
        ],
      ),
    );
  }
}

class _CustomSlideDemo extends StatelessWidget {
  final bool isDark;
  const _CustomSlideDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Custom Slide',
      description: 'Custom slide animation with specific X and Y offsets',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.pink,
)
  .animate()
  .slideX(50)
  .slideY(30)
  .duration(1.s)
  .repeat(reverse: true)''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.pink,
      )
          .animate()
          .slideX(50)
          .slideY(30)
          .duration(1.s)
          .repeat(reverse: true),
    );
  }
}

// Spring Physics Demos

class _SpringIOSDemo extends StatelessWidget {
  final bool isDark;
  const _SpringIOSDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Spring iOS Animation',
      description: 'iOS-style snappy spring animation with less bounce',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.blue,
)
  .animate()
  .fadeIn()
  .scale(1.3)
  .springIOS()''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      )
          .animate()
          .fadeIn()
          .scale(1.3)
          .springIOS(),
    );
  }
}

class _SpringGentleDemo extends StatelessWidget {
  final bool isDark;
  const _SpringGentleDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Spring Gentle Animation',
      description: 'Gentle spring animation with smooth bounce',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.green,
)
  .animate()
  .fadeIn()
  .scale(1.3)
  .springGentle()''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.green,
      )
          .animate()
          .fadeIn()
          .scale(1.3)
          .springGentle(),
    );
  }
}

class _SpringBouncyDemo extends StatelessWidget {
  final bool isDark;
  const _SpringBouncyDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Spring Bouncy Animation',
      description: 'Bouncy spring animation with high bounce effect',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.orange,
)
  .animate()
  .fadeIn()
  .scale(1.3)
  .springBouncy()''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.orange,
      )
          .animate()
          .fadeIn()
          .scale(1.3)
          .springBouncy(),
    );
  }
}

class _SpringCustomDemo extends StatelessWidget {
  final bool isDark;
  const _SpringCustomDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Spring Custom Animation',
      description: 'Custom spring animation with configurable mass, stiffness, and damping',
      code: '''Container(
  width: 100,
  height: 100,
  color: Colors.purple,
)
  .animate()
  .fadeIn()
  .scale(1.3)
  .spring(
    mass: 1.0,
    stiffness: 300.0,
    damping: 20.0,
  )''',
      child: Container(
        width: 100,
        height: 100,
        color: Colors.purple,
      )
          .animate()
          .fadeIn()
          .scale(1.3)
          .spring(
            mass: 1.0,
            stiffness: 300.0,
            damping: 20.0,
          ),
    );
  }
}

class _GestureDetectorDemo extends StatelessWidget {
  final bool isDark;
  const _GestureDetectorDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Gesture Detector',
      description: 'Liquid tap effects with spring physics - Tap and drag to see the effect!',
      code: '''Container(
  width: 120,
  height: 120,
  decoration: BoxDecoration(
    color: Colors.teal,
    borderRadius: BorderRadius.circular(20),
  ),
)
  .sGestureDetector(
    onPressed: () => print('Tapped!'),
    onLongPress: () => print('Long pressed!'),
    scaleOnPress: 1.1,
  )''',
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(20),
        ),
      )
          .sGestureDetector(
            onPressed: () {
              // Tap feedback
            },
            onLongPress: () {
              // Long press feedback
            },
            scaleOnPress: 1.1,
          ),
    );
  }
}

class _NavigationDemo extends StatelessWidget {
  final bool isDark;
  const _NavigationDemo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      isDark: isDark,
      title: 'Navigation Animations (New in v1.2.1)',
      description: 'Platform-specific navigation animations with fluent API - iOS, Android, and Web styles',
      code: '''// iOS-style navigation (slide from right)
swift.push(NextPage())
  .ios()
  .duration(500)
  .curve(Curves.easeInOut)
  .go(context);

// Android-style navigation (fade + slide up)
swift.push(NextPage())
  .android()
  .duration(500)
  .go(context);

// Web-style navigation (fade)
swift.push(NextPage())
  .web()
  .duration(300)
  .go(context);

// Push replacement
swift.pushReplacement(HomePage())
  .ios()
  .duration(300)
  .go(context);

// Push named route
swift.pushNamed('/details')
  .android()
  .duration(400)
  .go(context, arguments: {'id': 123});''',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D30) : const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Icon(Icons.navigation, size: 40, color: Color(0xFF007ACC)),
                const SizedBox(height: 8),
                Text(
                  'Navigation Features',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '• iOS-style slide transitions\n• Android-style fade + slide\n• Web-style fade transitions\n• Push, replace, and remove routes',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Code Editor Demo with Interactive Builder
class _CodeEditorDemo extends StatefulWidget {
  final bool isDark;
  const _CodeEditorDemo({required this.isDark});

  @override
  State<_CodeEditorDemo> createState() => _CodeEditorDemoState();
}

class _CodeEditorDemoState extends State<_CodeEditorDemo> {
  // Animation properties
  double _width = 100;
  double _height = 100;
  Color _color = Colors.purple;
  double _scale = 1.2;
  double _rotate = 0;
  bool _fadeIn = true;
  bool _slideInTop = false;
  bool _slideInBottom = false;
  bool _slideInLeft = false;
  bool _slideInRight = false;
  bool _bounce = false;
  bool _pulse = false;
  double _duration = 1.0;
  bool _repeat = false;
  bool _reverse = false;
  double _delay = 0.0;
  int _repeatCount = 1;
  double _slideX = 0;
  double _slideY = 0;
  
  String _durationUnit = 's'; // 'ms', 's', 'm'
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateCode();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _updateCode() {
    _codeController.text = _generateCode();
  }

  void _runCode() {
    setState(() {
      // Rebuild with current settings
      _updateCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Code Editor',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: widget.isDark ? Colors.white : const Color(0xFF1E1E1E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Adjust properties below, edit the code, and run to see your custom animation',
          style: TextStyle(
            fontSize: 14,
            color: widget.isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls Panel
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: widget.isDark ? const Color(0xFF252526) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF007ACC),
                    width: 1.5,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection('Size', [
                        _buildSlider('Width', _width, 50, 300, (v) {
                          setState(() {
                            _width = v;
                            _updateCode();
                          });
                        }),
                        _buildSlider('Height', _height, 50, 300, (v) {
                          setState(() {
                            _height = v;
                            _updateCode();
                          });
                        }),
                      ]),
                      const SizedBox(height: 20),
                      _buildSection('Color', [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.purple,
                            Colors.red,
                            Colors.teal,
                            Colors.indigo,
                            Colors.pink,
                            Colors.amber,
                            Colors.cyan,
                            Colors.deepOrange,
                          ].map((color) => _buildColorButton(color)).toList(),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      _buildSection('Transform', [
                        _buildSlider('Scale', _scale, 0.5, 2.0, (v) {
                          setState(() {
                            _scale = v;
                            _updateCode();
                          });
                        }),
                        _buildSlider('Rotate (degrees)', _rotate, 0, 360, (v) {
                          setState(() {
                            _rotate = v;
                            _updateCode();
                          });
                        }),
                      ]),
                      const SizedBox(height: 20),
                      _buildSection('Effects', [
                        _buildCheckbox('Fade In', _fadeIn, (v) {
                          setState(() {
                            _fadeIn = v;
                            _updateCode();
                          });
                        }),
                        _buildCheckbox('Slide In Top', _slideInTop, (v) {
                          setState(() {
                            _slideInTop = v;
                            if (v) {
                              _slideInBottom = false;
                              _slideInLeft = false;
                              _slideInRight = false;
                            }
                            _updateCode();
                          });
                        }),
                        _buildCheckbox('Slide In Bottom', _slideInBottom, (v) {
                          setState(() {
                            _slideInBottom = v;
                            if (v) {
                              _slideInTop = false;
                              _slideInLeft = false;
                              _slideInRight = false;
                            }
                            _updateCode();
                          });
                        }),
                        _buildCheckbox('Slide In Left', _slideInLeft, (v) {
                          setState(() {
                            _slideInLeft = v;
                            if (v) {
                              _slideInTop = false;
                              _slideInBottom = false;
                              _slideInRight = false;
                            }
                            _updateCode();
                          });
                        }),
                        _buildCheckbox('Slide In Right', _slideInRight, (v) {
                          setState(() {
                            _slideInRight = v;
                            if (v) {
                              _slideInTop = false;
                              _slideInBottom = false;
                              _slideInLeft = false;
                            }
                            _updateCode();
                          });
                        }),
                        _buildCheckbox('Bounce', _bounce, (v) {
                          setState(() {
                            _bounce = v;
                            if (v) _pulse = false;
                            _updateCode();
                          });
                        }),
                        _buildCheckbox('Pulse', _pulse, (v) {
                          setState(() {
                            _pulse = v;
                            if (v) _bounce = false;
                            _updateCode();
                          });
                        }),
                      ]),
                      const SizedBox(height: 20),
                      _buildSection('Custom Slide', [
                        _buildSlider('Slide X', _slideX, -100, 100, (v) {
                          setState(() {
                            _slideX = v;
                            _updateCode();
                          });
                        }),
                        _buildSlider('Slide Y', _slideY, -100, 100, (v) {
                          setState(() {
                            _slideY = v;
                            _updateCode();
                          });
                        }),
                      ]),
                      const SizedBox(height: 20),
                      _buildSection('Duration', [
                        Row(
                          children: [
                            Expanded(
                              child: _buildSlider('Duration', _duration, 0.1, 5.0, (v) {
                                setState(() {
                                  _duration = v;
                                  _updateCode();
                                });
                              }),
                            ),
                            const SizedBox(width: 16),
                            DropdownButton<String>(
                              value: _durationUnit,
                              items: ['ms', 's', 'm'].map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              )).toList(),
                              onChanged: (v) {
                                setState(() {
                                  _durationUnit = v!;
                                  _updateCode();
                                });
                              },
                            ),
                          ],
                        ),
                        _buildSlider('Delay', _delay, 0, 2000, (v) {
                          setState(() {
                            _delay = v;
                            _updateCode();
                          });
                        }),
                      ]),
                      const SizedBox(height: 20),
                      _buildSection('Repeat', [
                        _buildCheckbox('Repeat', _repeat, (v) {
                          setState(() {
                            _repeat = v;
                            _updateCode();
                          });
                        }),
                        if (_repeat)
                          _buildCheckbox('Reverse', _reverse, (v) {
                            setState(() {
                              _reverse = v;
                              _updateCode();
                            });
                          }),
                        if (!_repeat)
                          _buildSlider('Repeat Count', _repeatCount.toDouble(), 1, 10, (v) {
                            setState(() {
                              _repeatCount = v.round();
                              _updateCode();
                            });
                          }),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            // Preview, Code Editor, and Run Button
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Preview
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: widget.isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF007ACC),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: _buildPreviewWidget(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Code Editor
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 300),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF007ACC),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF252526),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Code Editor',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Builder(
                                    builder: (context) => IconButton(
                                      icon: const Icon(Icons.copy, size: 18, color: Colors.white70),
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(text: _codeController.text));
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
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    onPressed: _runCode,
                                    icon: const Icon(Icons.play_arrow, size: 16),
                                    label: const Text('Run'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF007ACC),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _codeController,
                            maxLines: null,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              color: Color(0xFFD7BA7D),
                              height: 1.5,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: 'Edit code here...',
                              hintStyle: TextStyle(color: Color(0xFF666666)),
                            ),
                            onChanged: (value) {
                              // Code edited - could add parsing here if needed
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreviewWidget() {
    Widget widget = Container(
      width: _width,
      height: _height,
      color: _color,
    );

    var builder = widget.animate();

    if (_fadeIn) {
      builder = builder.fadeIn();
    }
    if (_scale != 1.0) {
      builder = builder.scale(_scale);
    }
    if (_rotate != 0) {
      builder = builder.rotate(_rotate);
    }
    if (_slideInTop) {
      builder = builder.slideInTop();
    }
    if (_slideInBottom) {
      builder = builder.slideInBottom();
    }
    if (_slideInLeft) {
      builder = builder.slideInLeft();
    }
    if (_slideInRight) {
      builder = builder.slideInRight();
    }
    if (_slideX != 0 || _slideY != 0) {
      if (_slideX != 0) builder = builder.slideX(_slideX);
      if (_slideY != 0) builder = builder.slideY(_slideY);
    }
    if (_bounce) {
      builder = builder.bounce();
    }
    if (_pulse) {
      builder = builder.pulse();
    }

    // Duration
    switch (_durationUnit) {
      case 'ms':
        builder = builder.duration(_duration.round().ms);
        break;
      case 'm':
        builder = builder.duration(_duration.round().m);
        break;
      default:
        builder = builder.duration(_duration.s);
    }

    // Delay
    if (_delay > 0) {
      builder = builder.delay(_delay.round().ms);
    }

    // Repeat
    if (_repeat) {
      builder = builder.repeat(reverse: _reverse);
    } else if (_repeatCount > 1) {
      builder = builder.repeatCount(_repeatCount, reverse: _reverse);
    }

    return builder;
  }

  String _generateCode() {
    final buffer = StringBuffer();
    buffer.writeln('Container(');
    buffer.writeln('  width: $_width,');
    buffer.writeln('  height: $_height,');
    buffer.writeln('  color: ${_colorToCode(_color)},');
    buffer.writeln(')');
    buffer.writeln('  .animate()');
    
    if (_fadeIn) {
      buffer.writeln('  .fadeIn()');
    }
    if (_scale != 1.0) {
      buffer.writeln('  .scale($_scale)');
    }
    if (_rotate != 0) {
      buffer.writeln('  .rotate($_rotate)');
    }
    if (_slideInTop) {
      buffer.writeln('  .slideInTop()');
    }
    if (_slideInBottom) {
      buffer.writeln('  .slideInBottom()');
    }
    if (_slideInLeft) {
      buffer.writeln('  .slideInLeft()');
    }
    if (_slideInRight) {
      buffer.writeln('  .slideInRight()');
    }
    if (_slideX != 0) {
      buffer.writeln('  .slideX($_slideX)');
    }
    if (_slideY != 0) {
      buffer.writeln('  .slideY($_slideY)');
    }
    if (_bounce) {
      buffer.writeln('  .bounce()');
    }
    if (_pulse) {
      buffer.writeln('  .pulse()');
    }
    
    // Duration
    switch (_durationUnit) {
      case 'ms':
        buffer.writeln('  .duration(${_duration.round()}.ms)');
        break;
      case 'm':
        buffer.writeln('  .duration(${_duration.round()}.m)');
        break;
      default:
        buffer.writeln('  .duration($_duration.s)');
    }
    
    // Delay
    if (_delay > 0) {
      buffer.writeln('  .delay(${_delay.round()}.ms)');
    }
    
    // Repeat
    if (_repeat) {
      buffer.writeln('  .repeat(reverse: $_reverse)');
    } else if (_repeatCount > 1) {
      buffer.writeln('  .repeatCount($_repeatCount, reverse: $_reverse)');
    }
    
    return buffer.toString();
  }

  String _colorToCode(Color color) {
    if (color == Colors.blue) return 'Colors.blue';
    if (color == Colors.green) return 'Colors.green';
    if (color == Colors.orange) return 'Colors.orange';
    if (color == Colors.purple) return 'Colors.purple';
    if (color == Colors.red) return 'Colors.red';
    if (color == Colors.teal) return 'Colors.teal';
    if (color == Colors.indigo) return 'Colors.indigo';
    if (color == Colors.pink) return 'Colors.pink';
    if (color == Colors.amber) return 'Colors.amber';
    if (color == Colors.cyan) return 'Colors.cyan';
    if (color == Colors.deepOrange) return 'Colors.deepOrange';
    return 'Colors.purple';
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: widget.isDark ? Colors.white : const Color(0xFF1E1E1E),
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: widget.isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
              ),
            ),
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF007ACC),
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
          activeColor: const Color(0xFF007ACC),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label, bool value, ValueChanged<bool> onChanged) {
    return CheckboxListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: widget.isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
        ),
      ),
      value: value,
      onChanged: (v) => onChanged(v ?? false),
      activeColor: const Color(0xFF007ACC),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildColorButton(Color color) {
    final isSelected = _color == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _color = color;
          _updateCode();
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}

// Reusable Demo Card - matches swift_flutter style
class _DemoCard extends StatelessWidget {
  final bool isDark;
  final String title;
  final String description;
  final String code;
  final Widget child;

  const _DemoCard({
    required this.isDark,
    required this.title,
    required this.description,
    required this.code,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFFCCCCCC) : const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Preview
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: child),
              ),
              const SizedBox(width: 24),
              // Code
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SelectableText(
                          code,
                          style: const TextStyle(
                            fontFamily: 'monospace',
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
