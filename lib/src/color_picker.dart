import 'package:flutter/material.dart';

import 'pickers/hex_color_picker.dart';
import 'pickers/hsl_color_picker.dart';
import 'pickers/rgb_color_picker.dart';
import 'utils/color_space.dart';
import 'utils/color_utils.dart';
import 'widgets/numerical_text_field.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.initialColor,
    this.initialColorSpace = ColorSpace.hex,
    this.initialAlpha = 100,
    this.onChanged,
  }) : assert(initialAlpha >= 0 && initialAlpha <= 100);

  final Color initialColor;
  final int initialAlpha;
  final ColorSpace initialColorSpace;
  final ValueChanged<Color>? onChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  /// Current [ColorSpace].
  late ColorSpace space;

  /// Current alpha percentage.
  late int alpha;

  /// Current [Color] with full alpha.
  late Color rawColor;

  /// A derived [Color] from [rawColor] and the current [alpha] value.
  Color get alphaColor => rawColor.withAlphaPercent(alpha);

  @override
  void initState() {
    super.initState();
    space = widget.initialColorSpace;
    alpha = widget.initialAlpha;
    rawColor = widget.initialColor;
  }

  void onValuesChange(Color newColor, int newAlpha) {
    setState(() {
      alpha = newAlpha;
      rawColor = newColor;
    });

    widget.onChanged?.call(alphaColor);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 32,
          width: 32,
          color: alphaColor,
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: space,
              items: ColorSpace.values
                  .map((x) => DropdownMenuItem(
                        value: x,
                        child: Text(x.name),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() => space = value);
              },
            ),
          ),
        ),
        const SizedBox.square(
          dimension: 16,
        ),
        SizedBox(
          width: 120,
          child: {
            ColorSpace.hex: HexColorPicker(
              initialColor: rawColor,
              onChanged: (value) => onValuesChange(value, alpha),
            ),
            ColorSpace.rgb: RgbColorPicker(
              initialColor: rawColor,
              onChanged: (value) => onValuesChange(value, alpha),
            ),
            ColorSpace.hsl: HslColorPicker(
              initialColor: rawColor,
              onChanged: (value) => onValuesChange(value, alpha),
            ),
          }[space]!,
        ),
        const SizedBox.square(
          dimension: 16,
        ),
        SizedBox(
          width: 48,
          child: NumericalTextField(
            hint: 'A',
            suffix: '%',
            max: 100,
            initialValue: widget.initialAlpha,
            onChanged: (value) => onValuesChange(rawColor, value),
          ),
        ),
      ],
    );
  }
}
