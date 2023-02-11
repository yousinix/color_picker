import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RgbColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color>? onChanged;

  const RgbColorPicker({
    super.key,
    required this.initialColor,
    this.onChanged,
  });

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
          child: TextFormField(
            maxLength: 3,
            initialValue: '$red',
            decoration: const InputDecoration(
              counterText: '',
            ),
            inputFormatters: [
              // TODO: allow all inputs and fallback to current value if invalid
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isEmpty) return;
              onValuesChanged(int.parse(value), green, blue);
            },
          ),
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Expanded(
          child: TextFormField(
            maxLength: 3,
            initialValue: '$green',
            decoration: const InputDecoration(
              counterText: '',
            ),
            inputFormatters: [
              // TODO: allow all inputs and fallback to current value if invalid
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isEmpty) return;
              onValuesChanged(red, int.parse(value), blue);
            },
          ),
        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Expanded(
          child: TextFormField(
            maxLength: 3,
            initialValue: '$blue',
            decoration: const InputDecoration(
              counterText: '',
            ),
            inputFormatters: [
              // TODO: allow all inputs and fallback to current value if invalid
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isEmpty) return;
              onValuesChanged(red, green, int.parse(value));
            },
          ),
        ),
      ],
    );
  }
}
