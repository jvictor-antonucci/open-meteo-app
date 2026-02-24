import 'package:flutter/material.dart';
import 'package:open_meteo_app/modules/bottom_navigation/presentation/widgets/custom_bottom_nav_bar_item.dart';

class CustomBottomNavBar extends StatefulWidget {
  final List<BottomNavBarItem> items;
  final Function(int index) onTap;
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colors = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.items.length, (index) {
            final item = widget.items[index];
            final isSelected = widget.currentIndex == index;

            return GestureDetector(
              onTap: () => widget.onTap.call(index),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: CustomBottomNavBarItem(
                  icon: item.icon,
                  label: item.label,
                  isSelected: isSelected,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class BottomNavBarItem {
  final IconData icon;
  final String label;

  const BottomNavBarItem({required this.icon, required this.label});
}
