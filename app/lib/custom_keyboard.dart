import 'dart:ui';
import 'package:flutter/material.dart';

const double padding = 2;
const double heightOfKey = 50;
const keysList = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];

class CustomKeyBoard extends StatefulWidget {
  const CustomKeyBoard({super.key});

  static getWidthOfKey(BuildContext context) {
    return (MediaQuery.of(context).size.width - (2 * padding)) / keysList[0].length;
  }

  @override
  State<CustomKeyBoard> createState() => _CustomKeyBoardState();
}

class _CustomKeyBoardState extends State<CustomKeyBoard> {
  Map<String, Offset> getKeysWithTheirOffSets({required double widthOfScreen, required double widthOfKey}) {
    Map<String, Offset> keysWithTheirCenters = {};

    for (var rowIndex = 0; rowIndex < keysList.length; rowIndex++) {
      String keys = keysList[rowIndex];

      final heightOffset = (rowIndex * (heightOfKey + (2 * padding))) + (heightOfKey / 2);
      final initalWidthOffset = (widthOfScreen - (keys.length * widthOfKey)) / 2;

      for (var index = 0; index < keys.length; index++) {
        String key = keys[index];
        final offset = Offset(initalWidthOffset + (index * widthOfKey) + (widthOfKey / 2), heightOffset);
        keysWithTheirCenters[key] = offset;
      }
    }

    return keysWithTheirCenters;
  }

  Map<String, Offset>? keysWithTheirCenters;
  double? widthOfScreen;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(width);
    double widthOfKey = CustomKeyBoard.getWidthOfKey(context);

    if (widthOfScreen == null || keysWithTheirCenters == null || width != widthOfScreen) {
      keysWithTheirCenters = getKeysWithTheirOffSets(widthOfScreen: width, widthOfKey: widthOfKey);
      widthOfScreen = width;
    }

    return Stack(
      children: [
        const StaticKeyBoard(),
        IgnorePointer(
          child: Container(
            color: Colors.blue.withOpacity(0.3),
            width: width,
            height: keysList.length * (heightOfKey) + (keysList.length * 2 * padding),
            child: CustomPaint(painter: StrokePainter(keysWithTheirCenters: keysWithTheirCenters!)),
          ),
        ),
      ],
    );
  }
}

class StrokePainter extends CustomPainter {
  StrokePainter({required this.keysWithTheirCenters});
  Map<String, Offset> keysWithTheirCenters;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    List<Offset> keyPoints = keysWithTheirCenters.entries.map((e) => e.value).toList();
    canvas.drawPoints(PointMode.points, keyPoints, paint);

    // String words = "THALA";
    // String words = "WOAHH";
    String words = "HELLO";
    Paint bluePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    List<Offset> wordPoints = [];
    words.split("").forEach((char) {
      if (char == ' ') return;
      char = char.toLowerCase();

      wordPoints.add(keysWithTheirCenters[char]!);
    });

    canvas.drawPoints(PointMode.polygon, wordPoints, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StaticKeyBoard extends StatelessWidget {
  const StaticKeyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    double widthOfKey = CustomKeyBoard.getWidthOfKey(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: keysList
            .map(
              (keys) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: keys.split("").map((key) => KeyBoardKey(widthOfKey: widthOfKey, text: key)).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class KeyBoardKey extends StatelessWidget {
  const KeyBoardKey({super.key, required this.widthOfKey, required this.text});

  final double widthOfKey;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.all(padding),
      child: Container(
        width: widthOfKey - (2 * padding),
        height: heightOfKey,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            splashColor: Colors.red,
            onTap: () {},
            child: Center(child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 20))),
          ),
        ),
      ),
    );
  }
}
