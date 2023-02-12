import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericalTextField extends StatelessWidget {
  const NumericalTextField({
    super.key,
    required this.min,
    required this.max,
    required this.initialValue,
    this.onChanged,
  }) : assert(initialValue >= min && initialValue <= max);

  final int min;
  final int max;
  final int initialValue;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: '$initialValue',
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        NumericalRangeFormatter(min, max),
      ],
      onChanged: (value) {
        if (value.isEmpty) return;
        onChanged?.call(int.parse(value));
      },
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  NumericalRangeFormatter(this.min, this.max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue(
        text: min.toString(),
      );
    } else if (int.parse(newValue.text) > max) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
