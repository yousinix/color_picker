import 'package:flutter/material.dart';

import '../widgets/numerical_text_field.dart';

class RgbColorPicker extends StatefulWidget {
  const RgbColorPicker({
    super.key,
    required this.initialColor,
    this.onChanged,
  });

  final Color initialColor;
  final ValueChanged<Color>? onChanged;

  @override
  State<RgbColorPicker> createState() => _RgbColorPickerState();
}

class _RgbColorPickerState extends State<RgbColorPicker> {
  late int red;
  late int green;
  late int blue;

  Color get color => Color.fromARGB(255, red, green, blue);

  @override
  void initState() {
    super.initState();
    red = widget.initialColor.red;
    green = widget.initialColor.green;
    blue = widget.initialColor.blue;
  }

  void onValuesChanged(int newRed, int newGreen, int newBlue) {
    setState(() {
      red = newRed;
      green = newGreen;
      blue = newBlue;
    });

    widget.onChanged?.call(color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumericalTextField(
            max: 255,
            initialValue: red,
            onChanged: (value) {
              onValuesChanged(value, green, blue);
            },
          ),
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Expanded(
          child: NumericalTextField(
            max: 255,
            initialValue: green,
            onChanged: (value) {
              onValuesChanged(red, value, blue);
            },
          ),
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Expanded(
          child: NumericalTextField(
            max: 255,
            initialValue: blue,
            onChanged: (value) {
              onValuesChanged(red, green, value);
            },
          ),
        ),
      ],
    );
  }
}
