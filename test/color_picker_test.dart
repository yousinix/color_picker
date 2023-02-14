import 'package:color_picker/src/color_picker.dart';
import 'package:color_picker/src/pickers/hex_color_picker.dart';
import 'package:color_picker/src/utils/color_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'tester_utils.dart';

void main() {
  group(
    "ColorSpace Dropdown",
    () {
      testWidgets(
        'displays default ColorSpace (HEX)',
        (tester) async {
          await tester.pumpMaterialWidget(
            const ColorPicker(
              initialColor: Colors.black,
            ),
          );

          expect(
            find.text(ColorSpace.hex.name),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'displays initial ColorSpace (RGB)',
        (tester) async {
          const colorSpace = ColorSpace.rgb;

          await tester.pumpMaterialWidget(
            const ColorPicker(
              initialColor: Colors.black,
              initialColorSpace: colorSpace,
            ),
          );

          expect(
            find.text(colorSpace.name).hitTestable(),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'changes child color picker on change',
        (tester) async {
          await tester.pumpMaterialWidget(
            const ColorPicker(
              initialColor: Colors.black,
              initialColorSpace: ColorSpace.rgb,
            ),
          );

          await tester.updateDropdown<ColorSpace>(
            ColorSpace.hex.name,
          );

          expect(
            find.byType(HexColorPicker),
            findsOneWidget,
          );
        },
      );
    },
  );
}
