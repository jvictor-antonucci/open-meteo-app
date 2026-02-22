import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SearchInputOverlay extends StatefulWidget {
  final FocusNode focusNode;
  final LayerLink layerLink;
  final Function(String suggestion) onSelect;
  final List<String> suggestions;
  final bool isShowingRecent;

  const SearchInputOverlay({
    super.key,
    required this.focusNode,
    required this.layerLink,
    required this.onSelect,
    required this.suggestions,
    required this.isShowingRecent,
  });

  @override
  State<SearchInputOverlay> createState() => _SearchInputOverlayState();
}

class _SearchInputOverlayState extends State<SearchInputOverlay> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.focusNode.unfocus,
        child: CompositedTransformFollower(
          link: widget.layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 58),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 12,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: widget.layerLink.leaderSize?.width ?? 0,
                constraints: const BoxConstraints(maxHeight: 360),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: widget.suggestions.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'No cities found',
                          style: textStyles.labelMedium?.apply(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                            child: Row(
                              children: [
                                Icon(
                                  widget.isShowingRecent
                                      ? LucideIcons.clock
                                      : LucideIcons.search,
                                  size: 18,
                                  color: colors.onSurfaceVariant,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.isShowingRecent
                                      ? 'RECENT SEARCHES'
                                      : 'SUGGESTIONS',
                                  style: textStyles.labelSmall?.apply(
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          Flexible(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shrinkWrap: true,
                              itemCount: widget.suggestions.length,
                              itemBuilder: (_, index) => _SuggestionItem(
                                suggestion: widget.suggestions[index],
                                onSelect: widget.onSelect,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  final String suggestion;
  final Function(String suggestion) onSelect;

  const _SuggestionItem({required this.suggestion, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = theme.textTheme;

    return InkWell(
      onTap: () => onSelect(suggestion),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              LucideIcons.clock,
              size: 20,
              color: colors.secondaryContainer.withAlpha(100),
            ),
            const SizedBox(width: 8),
            Text(
              suggestion,
              style: textStyles.labelSmall?.apply(
                color: colors.secondaryContainer.withAlpha(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
