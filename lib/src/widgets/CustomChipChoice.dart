import 'package:flutter/material.dart'
    show FilterChip, ThemeData, Theme, Brightness;
import 'package:flutter/widgets.dart';

/// Easy way to provide a single or multiple choice chips.
class CustomChipsChoice<T> extends StatelessWidget {
  /// List of option item
  final List<CustomChipsChoiceOption<T>> options;

  /// Choice item config
  final CustomChipsChoiceItemConfig itemConfig;

  /// Builder for custom choice item
  final CustomChipsChoiceBuilder<T> itemBuilder;

  /// Whether the chips is wrapped or scrollable
  final bool isWrapped;

  /// List padding
  final EdgeInsetsGeometry padding;

  final T _value;
  final List<T> _values;
  final CustomChipsChoiceChanged<T> _onChangedSingle;
  final CustomChipsChoiceChanged<List<T>> _onChangedMultiple;
  final bool _isMultiChoice;

  /// Costructor for single choice
  CustomChipsChoice.single({
    Key key,
    @required T value,
    @required this.options,
    @required CustomChipsChoiceChanged<T> onChanged,
    this.itemConfig = const CustomChipsChoiceItemConfig(),
    this.itemBuilder,
    this.isWrapped = false,
    this.padding,
  })  : assert(onChanged != null),
        assert(options != null),
        assert(isWrapped != null),
        _isMultiChoice = false,
        _value = value,
        _values = null,
        _onChangedMultiple = null,
        _onChangedSingle = onChanged,
        super(key: key);

  /// Constructor for multiple choice
  CustomChipsChoice.multiple({
    Key key,
    @required List<T> value,
    @required this.options,
    @required CustomChipsChoiceChanged<List<T>> onChanged,
    this.itemConfig = const CustomChipsChoiceItemConfig(),
    this.itemBuilder,
    this.isWrapped = false,
    this.padding,
  })  : assert(onChanged != null),
        assert(options != null),
        assert(isWrapped != null),
        _isMultiChoice = true,
        _value = null,
        _values = value ?? [],
        _onChangedSingle = null,
        _onChangedMultiple = onChanged,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWrapped == true ? _listWrapped(context) : _listScrollable(context);
  }

  Widget _listScrollable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: _choiceItems(context),
      ),
    );
  }

  Widget _listWrapped(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
      child: Wrap(
        spacing: itemConfig.spacing, // gap between adjacent chips
        runSpacing: itemConfig.runSpacing, // gap between lines
        children: _choiceItems(context),
      ),
    );
  }

  List<Widget> _choiceItems(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return List<Widget>.generate(options.length, _choiceItemsGenerator(theme))
        .where((e) => e != null)
        .toList();
  }

  Widget Function(int) _choiceItemsGenerator(ThemeData theme) {
    return (int i) {
      CustomChipsChoiceOption<T> item = options[i];
      bool selected =
          _isMultiChoice ? _values.contains(item.value) : _value == item.value;
      return item.hidden == false
          ? itemBuilder?.call(item, selected, _select(item.value)) ??
              _CustomChipsChoiceItem(
                item: item,
                config: itemConfig,
                selected: selected,
                selectedColor: itemConfig.selectedColor ?? theme.primaryColor,
                unselectedColor:
                    itemConfig.unselectedColor ?? theme.unselectedWidgetColor,
                onSelect: _select(item.value),
                isWrapped: isWrapped,
              )
          : null;
    };
  }

  Function(bool selected) _select(T value) {
    return (bool selected) {
      if (_isMultiChoice) {
        List<T> values = List.from(_values ?? []);
        if (selected) {
          values.add(value);
        } else {
          values.remove(value);
        }
        _onChangedMultiple?.call(values);
      } else {
        _onChangedSingle?.call(value);
      }
    };
  }
}

// Default choice item
class _CustomChipsChoiceItem<T> extends StatelessWidget {
  final CustomChipsChoiceOption<T> item;
  final CustomChipsChoiceItemConfig config;
  final Color selectedColor;
  final Color unselectedColor;
  final Function(bool selected) onSelect;
  final bool selected;
  final bool isWrapped;

  _CustomChipsChoiceItem({
    Key key,
    @required this.item,
    @required this.config,
    @required this.onSelect,
    @required this.selected,
    this.selectedColor,
    this.unselectedColor,
    this.isWrapped = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = selected
        ? config.selectedBrightness == Brightness.dark
        : config.unselectedBrightness == Brightness.dark;

    final Color textColor = isDark
        ? const Color(0xFFFFFFFF)
        : selected
            ? selectedColor
            : unselectedColor;

    final double borderOpacity = selected
        ? config.selectedBorderOpacity
        : config.unselectedBorderOpacity;

    final Color borderColor = isDark
        ? const Color(0x00000000)
        : textColor.withOpacity(borderOpacity ?? .2);

    final Color checkmarkColor = isDark ? textColor : selectedColor;

    final Color backgroundColor =
        isDark ? unselectedColor : const Color(0x00000000);

    final Color selectedBackgroundColor =
        isDark ? selectedColor : const Color(0x00000000);

    return Padding(
      padding: config.margin ?? isWrapped
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(5),
      child: FilterChip(
        label: Text(
          item.label,
          style: config?.labelStyle?.copyWith(color: textColor) ??
              TextStyle(color: textColor),
        ),
        avatar: item.avatar,
        shape: config.shapeBuilder?.call(selected) ??
            StadiumBorder(
              side: BorderSide(color: borderColor),
            ),
        clipBehavior: config.clipBehavior ?? Clip.none,
        elevation: config.elevation,
        pressElevation: config.pressElevation,
        shadowColor: unselectedColor,
        selectedShadowColor: selectedColor,
        backgroundColor: backgroundColor,
        selectedColor: selectedBackgroundColor,
        checkmarkColor: checkmarkColor,
        showCheckmark: config.showCheckmark == true,
        selected: selected,
        onSelected:
            item.disabled == false ? (_selected) => onSelect(_selected) : null,
      ),
    );
  }
}

/// Choice option
class CustomChipsChoiceOption<T> {
  /// Value to return
  final T value;

  /// Represent as primary text
  final String label;

  /// Represent as chips avatar
  final Widget avatar;

  /// Whether the choice is disabled or not
  final bool disabled;

  /// Whether the choice is hidden or displayed
  final bool hidden;

  /// This prop is useful for choice builder
  final dynamic meta;

  /// Default Constructor
  CustomChipsChoiceOption({
    @required this.value,
    @required this.label,
    this.avatar,
    this.disabled = false,
    this.hidden = false,
    this.meta,
  })  : assert(disabled != null),
        assert(hidden != null);

  /// Helper to create option list from any list
  static List<CustomChipsChoiceOption<R>> listFrom<R, E>({
    @required List<E> source,
    @required _CustomChipsChoiceOptionProp<E, R> value,
    @required _CustomChipsChoiceOptionProp<E, String> label,
    _CustomChipsChoiceOptionProp<E, Widget> avatar,
    _CustomChipsChoiceOptionProp<E, bool> disabled,
    _CustomChipsChoiceOptionProp<E, bool> hidden,
    _CustomChipsChoiceOptionProp<E, dynamic> meta,
  }) =>
      source
          .asMap()
          .map((index, item) => MapEntry(
              index,
              CustomChipsChoiceOption<R>(
                value: value?.call(index, item),
                label: label?.call(index, item),
                avatar: avatar?.call(index, item),
                disabled: disabled?.call(index, item) ?? false,
                hidden: hidden?.call(index, item) ?? false,
                meta: meta?.call(index, item),
              )))
          .values
          .toList()
          .cast<CustomChipsChoiceOption<R>>();
}

/// Choice item configuration
class CustomChipsChoiceItemConfig {
  /// choice item margin
  final EdgeInsetsGeometry margin;

  /// How much space to place between children in a run in the main axis.
  /// When [CustomChipsChoice.isWrapped] is [true]
  final double spacing;

  /// How much space to place between the runs themselves in the cross axis.
  /// When [CustomChipsChoice.isWrapped] is [true]
  final double runSpacing;

  /// Chips elevation
  final double elevation;

  /// Longpress chips elevation
  final double pressElevation;

  /// whether the chips use checkmark or not
  final bool showCheckmark;

  /// label style
  final TextStyle labelStyle;

  /// Selected item color
  final Color selectedColor;

  /// Unselected item color
  final Color unselectedColor;

  /// Brightness for selected chip
  final Brightness selectedBrightness;

  /// Brightness for unselected chip
  final Brightness unselectedBrightness;

  /// Opacity for selected chip border, only effect when
  /// [selectedBrightness] is [Brightness.light]
  final double selectedBorderOpacity;

  /// Opacity for unselected chip border, only effect when
  /// [unselectedBrightness] is [Brightness.light]
  final double unselectedBorderOpacity;

  /// Chips clip behavior
  final Clip clipBehavior;

  /// Chips shape builder
  final CustomChipsChoiceShapeBuilder shapeBuilder;

  /// Default Constructor
  const CustomChipsChoiceItemConfig({
    this.margin,
    this.spacing = 10.0,
    this.runSpacing = 0,
    this.elevation = 0,
    this.pressElevation = 0,
    this.showCheckmark = true,
    this.labelStyle = const TextStyle(),
    this.selectedColor,
    this.unselectedColor,
    this.selectedBrightness = Brightness.light,
    this.unselectedBrightness = Brightness.light,
    this.selectedBorderOpacity,
    this.unselectedBorderOpacity,
    this.clipBehavior,
    this.shapeBuilder,
  });
}

/// Builder for option prop
typedef R _CustomChipsChoiceOptionProp<T, R>(int index, T item);

/// Builder for chips shape border
typedef ShapeBorder CustomChipsChoiceShapeBuilder(bool selected);

/// Callback when the value changed
typedef void CustomChipsChoiceChanged<T>(T value);

/// Builder for custom choice item
typedef Widget CustomChipsChoiceBuilder<T>(
  CustomChipsChoiceOption<T> item,
  bool selected,
  Function(bool selected) select,
);
