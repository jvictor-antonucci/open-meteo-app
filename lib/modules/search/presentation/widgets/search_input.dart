import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_meteo_app/core/theme/open_meteo_app_font_theme.dart';
import 'package:open_meteo_app/modules/search/presentation/widgets/search_input_overlay.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _overlayController = OverlayPortalController();
  final _layerLink = LayerLink();

  final List<String> _recentSearches = [
    'San Francisco',
    'Tokyo',
    'London',
    'Paris',
    'Sydney',
  ];

  final List<String> _allCities = [
    'San Francisco',
    'Tokyo',
    'London',
    'Paris',
    'Sydney',
    'New York',
    'Barcelona',
    'Berlin',
    'Amsterdam',
    'Dubai',
  ];

  List<String> _suggestions = [];
  bool _isShowingRecent = true;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayController.show();
        _updateSuggestions(_controller.text);
      } else {
        _overlayController.hide();
      }
    });

    _controller.addListener(() {
      _updateSuggestions(_controller.text);
    });
  }

  void _updateSuggestions(String query) {
    setState(() {
      if (query.isEmpty) {
        _isShowingRecent = true;
        _suggestions = _recentSearches;
      } else {
        _isShowingRecent = false;
        _suggestions = _allCities
            .where((c) => c.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _onSelect(String city) {
    _controller.text = city;
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (_) => SearchInputOverlay(
          focusNode: _focusNode,
          layerLink: _layerLink,
          onSelect: _onSelect,
          suggestions: _suggestions,
          isShowingRecent: _isShowingRecent,
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: colors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            style: CustomTextStyles.hint.apply(color: colors.primary),
            decoration: InputDecoration(
              hintText: 'Search cities...',
              hintStyle: CustomTextStyles.hint.apply(color: colors.primary),
              prefixIcon: Icon(LucideIcons.search, color: colors.primary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
    );
  }
}
