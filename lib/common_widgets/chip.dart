import 'package:flutter/material.dart';

class BasicChip extends StatelessWidget {
  final String label;

  const BasicChip({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).listTileTheme.subtitleTextStyle,
      ),
    );
  }
}

class GenericActionChip extends StatelessWidget {
  final Widget label;
  final Widget avatar;
  final Function() onPressed;

  const GenericActionChip({
    required this.label,
    required this.avatar,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: avatar,
      label: label,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.only(right: 8.0),
      onPressed: () async => onPressed(),
    );
  }
}

class GenericChoiceChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final bool showCheckmark;
  final Function(bool selected) onSelected;

  const GenericChoiceChip({
    required this.label,
    this.selected = false,
    this.showCheckmark = false,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: label,
      selected: selected,
      showCheckmark: showCheckmark,
      // Workaround: https://github.com/flutter/flutter/issues/67797
      visualDensity: const VisualDensity(
        horizontal: -4.0,
        vertical: -4.0,
      ),
      onSelected: (bool selected) => onSelected(selected),
    );
  }
}

class GenericChipGroup extends StatelessWidget {
  final List<Widget> children;
  final WrapAlignment alignment;

  const GenericChipGroup({
    required this.children,
    this.alignment = WrapAlignment.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0, // gap between adjacent chips
      alignment: alignment,
      runSpacing: 4.0, // gap between lines
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: children,
    );
  }
}
