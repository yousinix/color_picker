import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PercentagePicker extends StatelessWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;

  const PercentagePicker({
    super.key,
    required this.initialValue,
    this.onChanged,
  }) : assert(initialValue >= 0 && initialValue <= 100);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      maxLength: 3,
      initialValue: '$initialValue',
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
        onChanged?.call(int.parse(value));
      },
    );
  }
}
