import 'package:app/custom_keyboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Swiping',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text("Smart Swiping")),
      body: const Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Expanded(child: Center(child: Text(textEditingController.text))),
          Expanded(child: SizedBox()),
          MainBody(),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

typedef TextStateFunction = void Function({
  required TextEditingController gestureController,
  required TextEditingController mainTextController,
  required void Function(void Function()) setState,
});

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  final TextEditingController gestureController = TextEditingController();
  final TextEditingController mainTextController = TextEditingController();

  void setText(TextStateFunction fn) {
    fn(gestureController: gestureController, mainTextController: mainTextController, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text("Text: ${mainTextController.text}"),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text("Gesture: ${gestureController.text}"),
        ),
        CustomKeyBoard(setTextFunction: setText),
      ],
    );
  }
}
