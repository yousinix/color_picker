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
  final ColorSpace initialColorSpace;
  final ValueChanged<Color>? onChange;

  const ColorPicker({
    super.key,
    required this.initialColor,
    this.initialColorSpace = ColorSpace.hex,
    this.onChange,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late ColorSpace space;
  late Color color;
  late int alpha;

  @override
  void initState() {
    super.initState();
    space = widget.initialColorSpace;
    color = widget.initialColor;
    alpha = 100;
  }

  void onValuesChange(Color hexColor, int alphaPercent) {
    final newAlpha = (alphaPercent / 100 * 255).round();
    final newColor = hexColor.withAlpha(newAlpha);

    widget.onChange?.call(newColor);
    setState(() => color = newColor);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 24,
          width: 24,
          color: color,
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
          child: TextFormField(
            maxLength: 6,
            initialValue: widget.initialColor.toHex(
              leadingHashSign: false,
            ),
            decoration: const InputDecoration(
              prefixText: '#',
              counterText: '',
            ),
            inputFormatters: [
              // TODO: allow all inputs and fallback to current value if invalid
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9a-fA-F]'),
              ),
            ],
            onChanged: (value) {
              if (value.length != 6) return;
              onValuesChange(ColorUtils.fromHex(value), alpha);
            },
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
              onValuesChange(color, int.parse(value));
            },
          ),
        ),
      ],
    );
  }
}
