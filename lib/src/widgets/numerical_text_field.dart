import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [TextField] that accepts numbers from 0 to [max]
class NumericalTextField extends StatelessWidget {
  const NumericalTextField({
    super.key,
    required this.max,
    required this.initialValue,
    this.onChanged,
  }) : assert(initialValue >= 0 && initialValue <= max);

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
        MaxNumberTextInputFormatter(max),
      ],
      onChanged: (value) {
        if (value.isEmpty) return;
        onChanged?.call(int.parse(value));
      },
    );
  }
}

class MaxNumberTextInputFormatter extends TextInputFormatter {
  MaxNumberTextInputFormatter(this.max);

  final int max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final value = int.tryParse(newValue.text);

    if (newValue.text.isEmpty || (value != null && value < max)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
