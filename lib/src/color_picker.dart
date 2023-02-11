import 'package:color_picker/src/hex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_utils.dart';

enum ColorSpace {
  hex('HEX');

  const ColorSpace(this.name);
  final String name;
}

class ColorPicker extends StatefulWidget {
  final Color initialColor;
  final int initialAlpha;
  final ColorSpace initialColorSpace;
  final ValueChanged<Color>? onChange;

  const ColorPicker({
    super.key,
    required this.initialColor,
    this.initialColorSpace = ColorSpace.hex,
    this.initialAlpha = 100,
    this.onChange,
  }) : assert(initialAlpha >= 0 && initialAlpha <= 100);

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

    widget.onChange?.call(alphaColor);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 24,
          width: 24,
          color: alphaColor,
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Flexible(
          flex: 1,
          child: DropdownButton(
            value: widget.initialColorSpace,
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
        const SizedBox.square(
          dimension: 8,
        ),
        Flexible(
          flex: 3,
          child: HexColorPicker(
            initialColor: widget.initialColor,
            onChanged: (value) => onValuesChange(value, alpha),
          ),
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Flexible(
          flex: 1,
          child: TextFormField(
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            maxLength: 3,
            initialValue: '100',
            decoration: const InputDecoration(
              suffixText: '%',
              counterText: '',
            ),
            inputFormatters: [
              // TODO: allow all inputs and fallback to current value if invalid
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isEmpty) return;
              onValuesChange(rawColor, int.parse(value));
            },
          ),
        ),
      ],
    );
  }
}
