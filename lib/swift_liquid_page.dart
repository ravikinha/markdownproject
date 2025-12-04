import 'package:flutter/material.dart';
import 'package:swift_liquid/swift_liquid.dart';

class SwiftLiquidPage extends StatefulWidget {
  const SwiftLiquidPage({super.key});

  @override
  State<SwiftLiquidPage> createState() => _SwiftLiquidPageState();
}

class _SwiftLiquidPageState extends State<SwiftLiquidPage> {
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
          'Swift Liquid',
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
                'iOS-style Liquid Animations',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Fluid interactions with spring physics, beautiful modals, and glass effects. Add liquid tap effects to any widget with zero boilerplate.',
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
      'Gesture Extension',
      'Bottom Sheet',
      'Popover',
      'Menu',
      'Glass Container',
      'Buttons',
      'Accessibility',
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
                    : (isDark ? const Color(0xFF2D2D30) : const Color(0xFFE8E8E8)),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF007ACC)
                      : (isDark ? const Color(0xFF3C3C3C) : const Color(0xFFD0D0D0)),
                ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
        return _buildGestureExtensionDemo(isDark);
      case 1:
        return _buildBottomSheetDemo(isDark);
      case 2:
        return _buildPopoverDemo(isDark);
      case 3:
        return _buildMenuDemo(isDark);
      case 4:
        return _buildGlassContainerDemo(isDark);
      case 5:
        return _buildButtonsDemo(isDark);
      case 6:
        return _buildAccessibilityDemo(isDark);
      default:
        return const SizedBox();
    }
  }

  Widget _buildGestureExtensionDemo(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Gesture Extension', isDark),
        const SizedBox(height: 16),
        _buildCodeBlock(
          '''// Add liquid effects to any widget
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
)
.sGestureDetector(
  onPressed: () => print('Tapped!'),
  onLongPress: () => print('Long pressed!'),
)''',
          isDark,
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Live Demo', isDark),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.favorite, color: Colors.white, size: 48),
            ).sGestureDetector(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Container tapped!')),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Tap Me',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ).sGestureDetector(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button tapped!')),
                );
              },
            ),
            Card(
              color: Colors.orange,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Card',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ).sGestureDetector(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Card tapped!')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomSheetDemo(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Bottom Sheet', isDark),
        const SizedBox(height: 16),
        _buildCodeBlock(
          '''showSModalBottomSheet(
  context: context,
  child: YourContent(),
  enableDrag: true,
)''',
          isDark,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            showSModalBottomSheet(
              context: context,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Bottom Sheet',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text('Drag down to dismiss'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Text('Show Bottom Sheet'),
        ),
      ],
    );
  }

  Widget _buildPopoverDemo(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Popover', isDark),
        const SizedBox(height: 16),
        _buildCodeBlock(
          '''showSPopover(
  context: context,
  child: YourContent(),
  position: Offset(x, y),
)''',
          isDark,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
            final position = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
            final size = renderBox?.size ?? Size.zero;

            showSPopover(
              context: context,
              position: Offset(position.dx + size.width / 2, position.dy + size.height + 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 200,
                child: const Text(
                  'This is a popover with glass effect!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          },
          child: const Text('Show Popover'),
        ),
      ],
    );
  }

  Widget _buildMenuDemo(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Menu', isDark),
        const SizedBox(height: 16),
        _buildCodeBlock(
          '''showSMenu(
  context: context,
  items: [
    SPopupMenuItem(title: 'Edit', onTap: () {}),
    SPopupMenuItem(title: 'Delete', destructive: true, onTap: () {}),
  ],
)''',
          isDark,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
            final position = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
            final size = renderBox?.size ?? Size.zero;

            showSMenu(
              context: context,
              position: Offset(position.dx + size.width / 2, position.dy + size.height + 10),
              items: [
                SPopupMenuItem(
                  title: 'Edit',
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit tapped')),
                    );
                  },
                ),
                SPopupMenuItem(
                  title: 'Share',
                  icon: Icons.share,
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share tapped')),
                    );
                  },
                ),
                SPopupMenuItem(
                  title: 'Delete',
                  icon: Icons.delete,
                  destructive: true,
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Delete tapped')),
                    );
                  },
                ),
              ],
            );
          },
          child: const Text('Show Menu'),
        ),
      ],
    );
  }

  Widget _buildGlassContainerDemo(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Glass Container', isDark),
        const SizedBox(height: 16),
        _buildCodeBlock(
          '''SContainer(
  width: 200,
  padding: EdgeInsets.all(16),
  borderRadius: 20,
  child: Text('Glass Container'),
)''',
          isDark,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SContainer(
              width: 150,
              height: 150,
              alignment: Alignment.center,
              child: const Text('Glass!'),
            ),
            SContainer(
              width: 150,
              height: 150,
              color: Colors.blue.withAlpha(150),
              alignment: Alignment.center,
              child: const Text(
                'Colored',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SContainer(
              width: 150,
              height: 150,
              color: Colors.purple.withAlpha(150),
              borderRadius: 40.0,
              alignment: Alignment.center,
              child: const Text(
                'Rounded',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonsDemo(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Buttons', isDark),
        const SizedBox(height: 16),
        _buildCodeBlock(
          '''SIconButton(
  icon: Icons.favorite,
  onPressed: () {},
)

SCloseButton(
  onPressed: () {},
)''',
          isDark,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SIconButton(
              icon: Icons.favorite,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Favorite tapped')),
                );
              },
            ),
            SIconButton(
              icon: Icons.share,
              backgroundColor: Colors.blue,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Share tapped')),
                );
              },
            ),
            SCloseButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Close tapped')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccessibilityDemo(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Accessibility', isDark),
        const SizedBox(height: 16),
        _buildCodeBlock(
          '''SAccessibility.button(
  label: 'Save',
  onPressed: () {},
  child: Button(),
)

SAccessibility.announce(context, 'Saved!');''',
          isDark,
        ),
        const SizedBox(height: 24),
        SAccessibility.button(
          label: 'Save Changes',
          hint: 'Double tap to save',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Changes saved!')),
            );
            SAccessibility.announce(context, 'Changes saved successfully');
          },
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saving...')),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : const Color(0xFF1E1E1E),
      ),
    );
  }

  Widget _buildCodeBlock(String code, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFF1E1E1E),
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
        ),
      ),
    );
  }
}

