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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Smart Swiping"),
      ),
      body: const Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Expanded(child: Center(child: Text(textEditingController.text))),
          Expanded(child: SizedBox()),
          Center(child: CustomKeyBoard()),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
