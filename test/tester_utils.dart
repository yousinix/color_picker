import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension TesterUtils on WidgetTester {
  /// Pumps widget after wrapping it with [MaterialApp] and [Scaffold].
  Future<void> pumpMaterialWidget(Widget widget) async {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }

  /// Taps on a widget and runs [pumpAndSettle] after.
  Future<void> fineTap(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
  }

  /// Taps on a Dropdown of type [T],
  /// then taps on its child item of label [itemLabel].
  Future<void> updateDropdown<T>(String itemLabel) async {
    final dropdown = find.byType(DropdownButton<T>);
    await fineTap(dropdown);

    final targetItem = find.descendant(
      of: dropdown,
      matching: find.text(itemLabel),
    );
    await fineTap(targetItem);
  }
}
