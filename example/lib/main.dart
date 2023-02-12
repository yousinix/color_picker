import 'package:color_picker/color_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: ColorPicker(
              initialColor: Color(0xFF00FF00),
              onChanged: print,
            ),
          ),
        ),
      ),
    );
  }
}
