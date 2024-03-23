import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'package:app/main.dart';
import 'package:http/http.dart' as http;

import 'package:app/keyboard.dart';
import 'package:flutter/material.dart';

class CustomKeyBoard extends StatefulWidget {
  const CustomKeyBoard({super.key, required this.setTextFunction});

  final void Function(TextStateFunction) setTextFunction;

  static getWidthOfKey(BuildContext context) {
    return (MediaQuery.of(context).size.width - (2 * KeyBoard.padding)) / KeyBoard.keysList[0].length;
  }

  @override
  State<CustomKeyBoard> createState() => _CustomKeyBoardState();
}

class _CustomKeyBoardState extends State<CustomKeyBoard> {
  Map<String, Offset>? keysWithTheirCenters;
  double? widthOfScreen;

  List<Offset?> gestures = [];
  void onUpdate(Offset localPosition, BuildContext context) async {
    widget.setTextFunction(({required gestureController, required mainTextController, required setState}) {
      gestureController.text = KeyBoard.getTextForOffset(
        context: context,
        text: gestureController.text,
        offset: localPosition,
      );
      setState(() {});
    });

    setState(() => gestures.add(Offset(localPosition.dx, localPosition.dy)));
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() => gestures.isNotEmpty ? gestures.removeAt(0) : null);
  }

  void onPanEnd(_) async {
    widget.setTextFunction(({required gestureController, required mainTextController, required setState}) {
      final uri = Uri.http("localhost:8000", "/", {"gesture": gestureController.text});
      http.get(uri).then((value) =>
          setState(() => mainTextController.text = "${mainTextController.text} ${jsonDecode(value.body)["pred"]}"));
      gestureController.text = "";
    });

    setState(() => gestures.add(null));
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => gestures.removeRange(0, gestures.length));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double widthOfKey = CustomKeyBoard.getWidthOfKey(context);

    if (widthOfScreen == null || keysWithTheirCenters == null || width != widthOfScreen) {
      keysWithTheirCenters = KeyBoard.getKeysWithTheirOffSets(widthOfScreen: width, widthOfKey: widthOfKey);
      widthOfScreen = width;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.grey.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GestureDetector(
          onPanEnd: onPanEnd,
          onPanStart: (details) => onUpdate(details.localPosition, context),
          onPanUpdate: (details) => onUpdate(details.localPosition, context),
          child: Stack(
            children: [
              const StaticKeyBoard(),
              IgnorePointer(
                child: SizedBox(
                  width: width,
                  height: KeyBoard.heightOfEntireKeyBoard,
                  child: CustomPaint(
                    painter: StrokePainter(keysWithTheirCenters: keysWithTheirCenters!, gesture: gestures),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StrokePainter extends CustomPainter {
  StrokePainter({required this.keysWithTheirCenters, required this.gesture});
  Map<String, Offset> keysWithTheirCenters;

  List<Offset?> gesture;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint paint = Paint()
    //   ..color = Colors.red
    //   ..strokeWidth = 5
    //   ..strokeCap = StrokeCap.round;

    // List<Offset> keyPoints = keysWithTheirCenters.entries.map((e) => e.value).toList();
    // for (var i = 0; i < KeyBoard.keysList.length; i++) {
    //   keyPoints.add(Offset(2, i * KeyBoard.heightOfKey));
    //   keyPoints.add(Offset(2, (i * KeyBoard.heightOfKey) + KeyBoard.heightOfKey / 2));
    // }
    // canvas.drawPoints(PointMode.points, keyPoints, paint);

    // String words = "THALA";
    // String words = "WOAHH";
    // String words = "HELLO";
    // Paint bluePaint = Paint()
    //   ..color = Colors.blue
    //   ..strokeWidth = 10
    //   ..strokeCap = StrokeCap.round;

    // List<Offset> wordPoints = [];
    // words.split("").forEach((char) {
    //   if (char == ' ') return;
    //   char = char.toLowerCase();

    //   wordPoints.add(keysWithTheirCenters[char]!);
    // });

    // canvas.drawPoints(PointMode.polygon, wordPoints, bluePaint);

    Paint gesturePaint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < gesture.length - 1; i++) {
      if (gesture[i] != null && gesture[i + 1] != null) {
        canvas.drawLine(gesture[i]!, gesture[i + 1]!, gesturePaint..strokeWidth = 10 * (i / gesture.length) + 1);
      } else if (gesture[i] != null && gesture[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [gesture[i]!], gesturePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class StaticKeyBoard extends StatelessWidget {
  const StaticKeyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: KeyBoard.keysList
            .map(
              (keys) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: keys.split("").map((key) => KeyBoardKey(text: key)).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class KeyBoardKey extends StatelessWidget {
  const KeyBoardKey({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: KeyBoard.heightOfKey,
      padding: const EdgeInsets.all(KeyBoard.padding),
      child: Container(
        width: KeyBoard.widthOfKey(context) - (2 * KeyBoard.padding),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            // splashColor: Colors.red,
            onTap: () {},
            child: Center(child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 20))),
          ),
        ),
      ),
    );
  }
}
