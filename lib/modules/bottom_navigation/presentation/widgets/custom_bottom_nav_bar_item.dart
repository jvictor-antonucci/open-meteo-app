import 'package:flutter/material.dart';
import 'package:open_meteo_app/core/theme/open_meteo_app_font_theme.dart';

class CustomBottomNavBarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const CustomBottomNavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  State<CustomBottomNavBarItem> createState() => _CustomBottomNavBarItemState();
}

class _CustomBottomNavBarItemState extends State<CustomBottomNavBarItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colors = theme.colorScheme;

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: widget.isSelected
            ? colors.secondaryContainer
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(
            widget.icon,
            color: widget.isSelected
                ? colors.onSecondaryContainer
                : colors.onSurfaceVariant,
            size: 26,
          ),
          AnimatedSize(
            duration: kThemeAnimationDuration,
            curve: Curves.easeInOut,
            child: widget.isSelected
                ? Text(
                    widget.label,
                    style: CustomTextStyles.navLabel.apply(
                      color: colors.onSecondaryContainer,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
