import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';
import 'package:swift_liquid/swift_liquid.dart';
import 'package:video_player/video_player.dart';

class ProductsPage extends StatefulWidget {
  final SwiftValue<ThemeMode> themeMode;
  
  ProductsPage({
    super.key,
    SwiftValue<ThemeMode>? themeMode,
  }) : themeMode = themeMode ?? swift(ThemeMode.light);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.asset('assets/backgroundvideo.mp4');
      await _videoController!.initialize();
      _videoController!.setLooping(true);
      _videoController!.setVolume(0.0); // Mute the video
      _videoController!.play();
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      // If video fails to load, continue without it
      if (mounted) {
        setState(() {
          _isVideoInitialized = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Swift(
      builder: (context) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: isDark ? const Color(0xFF252526).withValues(alpha: 0.9) : const Color(0xFF007ACC).withValues(alpha: 0.9),
          elevation: 0,
          title: Row(
            children: [
              Image.asset(
                'assets/images/swift_flutter_logo.png',
                height: 24,
                errorBuilder: (context, error, stackTrace) => Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.school, size: 18, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'SwiftFlutter Products',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                widget.themeMode.value == ThemeMode.light ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => widget.themeMode.value = widget.themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
              tooltip: 'Toggle theme',
            ),
          ],
        ),
        body: Stack(
          children: [
            // Background Video
            if (_isVideoInitialized && _videoController != null)
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController!.value.size.width,
                    height: _videoController!.value.size.height,
                    child: VideoPlayer(_videoController!),
                  ),
                ),
              )
            else
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            // Dark overlay for better text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.4),
                      Colors.black.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              ),
            ),
            // Content on top
            SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Our Products',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -1,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Explore our collection of Flutter libraries and tools',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.9),
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 2),
                      blurRadius: 6,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Products Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 1200 ? 3 : constraints.maxWidth > 800 ? 2 : 1;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                    children: [
                      _buildProductCard(
                        context,
                        isDark,
                        'swift_flutter',
                        'SwiftUI-like state management for Flutter',
                        'Reactive state management with zero boilerplate. Build Flutter apps with SwiftUI-like simplicity.',
                        Icons.flutter_dash,
                        Colors.blue,
                        () => Navigator.pushNamed(context, '/swiftflutter'),
                      ),
                      _buildProductCard(
                        context,
                        isDark,
                        'swift_animations',
                        'Declarative animations with zero boilerplate',
                        'SwiftUI-like declarative animations. No controllers, no ticker providers, no mixins!',
                        Icons.auto_awesome,
                        Colors.purple,
                        () => Navigator.pushNamed(context, '/swiftanimations'),
                      ),
                      _buildProductCard(
                        context,
                        isDark,
                        'swift_liquid',
                        'iOS-style liquid animations',
                        'Fluid interactions with spring physics, beautiful modals, and glass effects.',
                        Icons.water_drop,
                        Colors.cyan,
                        () => Navigator.pushNamed(context, '/swiftliquid'),
                      ),
                      _buildProductCard(
                        context,
                        isDark,
                        'screen_launch_by_notfication',
                        'Notification-based navigation',
                        'Detect notification launches and route to specific screens automatically.',
                        Icons.notifications_active,
                        Colors.orange,
                        () => Navigator.pushNamed(context, '/notificationexample'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    bool isDark,
    String name,
    String tagline,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return SContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 24,
      enableBlur: true,
      blurSigma: 10.0,
      color: isDark 
          ? Colors.black.withValues(alpha: 0.3) 
          : Colors.white.withValues(alpha: 0.25),
      border: Border.all(
        color: isDark 
            ? Colors.white.withValues(alpha: 0.2) 
            : Colors.white.withValues(alpha: 0.3),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 20,
          spreadRadius: 0,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          spreadRadius: 0,
          offset: const Offset(0, 4),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Name
          Row(
            children: [
              SContainer(
                padding: const EdgeInsets.all(12),
                borderRadius: 16,
                enableBlur: true,
                blurSigma: 8.0,
                color: color.withValues(alpha: 0.2),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.0,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ).sGestureDetector(
                onPressed: () {},
                scaleOnPress: 1.1,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                            color: Colors.black.withValues(alpha: 0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tagline,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: color.withValues(alpha: 0.9),
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 1),
                            blurRadius: 3,
                            color: Colors.black.withValues(alpha: 0.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Description
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.white.withValues(alpha: 0.9),
                shadows: [
                  Shadow(
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Action Button
          SContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            borderRadius: 12,
            enableBlur: true,
            blurSigma: 8.0,
            color: color.withValues(alpha: 0.2),
            border: Border.all(
              color: color.withValues(alpha: 0.4),
              width: 1.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: color,
                ),
              ],
            ),
          ).sGestureDetector(
            onPressed: onTap,
            scaleOnPress: 1.05,
            stretchSensitivity: 1.2,
          ),
        ],
      ),
    ).sGestureDetector(
      onPressed: onTap,
      scaleOnPress: 1.02,
      stretchSensitivity: 0.8,
    );
  }
}

