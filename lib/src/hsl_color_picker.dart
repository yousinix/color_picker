import 'package:flutter/material.dart';

import 'numerical_text_field.dart';

class HslColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color>? onChanged;

  const HslColorPicker({
    super.key,
    required this.initialColor,
    this.onChanged,
  });

  @override
  State<HslColorPicker> createState() => _HslColorPickerState();
}

class _HslColorPickerState extends State<HslColorPicker> {
  late int hue;
  late int saturation;
  late int lightness;

  Color get color => HSLColor.fromAHSL(
        1,
        hue.toDouble(),
        saturation / 100,
        lightness / 100,
      ).toColor();

  @override
  void initState() {
    super.initState();
    final hslColor = HSLColor.fromColor(widget.initialColor);

    hue = hslColor.hue.toInt();
    saturation = (hslColor.saturation * 100).round();
    lightness = (hslColor.lightness * 100).round();
  }

  void onValuesChanged(int newHue, int newSaturation, int newLightness) {
    setState(() {
      hue = newHue;
      saturation = newSaturation;
      lightness = newLightness;
    });

    widget.onChanged?.call(color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumericalTextField(
            min: 0,
            max: 360,
            initialValue: hue,
            onChanged: (value) {
              onValuesChanged(value, saturation, lightness);
            },
          ),
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Expanded(
          child: NumericalTextField(
            min: 0,
            max: 100,
            initialValue: saturation,
            onChanged: (value) {
              onValuesChanged(hue, value, lightness);
            },
          ),
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Expanded(
          child: NumericalTextField(
            min: 0,
            max: 100,
            initialValue: lightness,
            onChanged: (value) {
              onValuesChanged(hue, saturation, value);
            },
          ),
        ),
      ],
    );
  }
}
