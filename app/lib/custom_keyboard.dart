import 'dart:ui';

import 'package:flutter/material.dart';

class KeyBoard {
  static const double padding = 2;
  static const double heightOfKey = 50;
  static const keysList = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];

  static double get heightOfEntireKeyBoard => keysList.length * (heightOfKey) + (keysList.length * 2 * padding);
  static double widthOfKey(BuildContext context) {
    return (MediaQuery.of(context).size.width - (2 * padding)) / keysList[0].length;
  }

  static Map<String, Offset> getKeysWithTheirOffSets({required double widthOfScreen, required double widthOfKey}) {
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
}

class CustomKeyBoard extends StatefulWidget {
  const CustomKeyBoard({super.key});

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
  void onUpdate(Offset localPosition) => setState(() => gestures.add(Offset(localPosition.dx, localPosition.dy)));

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double widthOfKey = CustomKeyBoard.getWidthOfKey(context);

    if (widthOfScreen == null || keysWithTheirCenters == null || width != widthOfScreen) {
      keysWithTheirCenters = KeyBoard.getKeysWithTheirOffSets(widthOfScreen: width, widthOfKey: widthOfKey);
      widthOfScreen = width;
    }

    return ClipRRect(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: GestureDetector(
          onPanStart: (details) => onUpdate(details.localPosition),
          onPanDown: (_) => setState(() => gestures.add(null)),
          onPanUpdate: (details) => onUpdate(details.localPosition),
          child: Stack(
            children: [
              const StaticKeyBoard(),
              Container(
                width: width,
                color: Colors.blue.withOpacity(0.3),
                height: KeyBoard.heightOfEntireKeyBoard,
                child: CustomPaint(
                  painter: StrokePainter(keysWithTheirCenters: keysWithTheirCenters!, gesture: gestures),
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
    //   ..strokeWidth = 10
    //   ..strokeCap = StrokeCap.round;

    // List<Offset> keyPoints = keysWithTheirCenters.entries.map((e) => e.value).toList();
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
      ..color = Colors.red
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < gesture.length - 1; i++) {
      if (gesture[i] != null && gesture[i + 1] != null) {
        canvas.drawLine(gesture[i]!, gesture[i + 1]!, gesturePaint);
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
      padding: const EdgeInsets.all(KeyBoard.padding),
      child: Container(
        width: KeyBoard.widthOfKey(context) - (2 * KeyBoard.padding),
        height: KeyBoard.heightOfKey,
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
// import 'dart:ui';

// import 'package:flutter/material.dart';

// class KeyBoard {
//   static const double padding = 2;
//   static const double heightOfKey = 50;
//   static const keysList = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];

//   static double get heightOfEntireKeyBoard => keysList.length * (heightOfKey) + (keysList.length * 2 * padding);
//   static double widthOfKey(BuildContext context) {
//     return (MediaQuery.of(context).size.width - (2 * padding)) / keysList[0].length;
//   }

//   static Map<String, Offset> getKeysWithTheirOffSets({required double widthOfScreen, required double widthOfKey}) {
//     Map<String, Offset> keysWithTheirCenters = {};

//     for (var rowIndex = 0; rowIndex < keysList.length; rowIndex++) {
//       String keys = keysList[rowIndex];

//       final heightOffset = (rowIndex * (heightOfKey + (2 * padding))) + (heightOfKey / 2);
//       final initalWidthOffset = (widthOfScreen - (keys.length * widthOfKey)) / 2;

//       for (var index = 0; index < keys.length; index++) {
//         String key = keys[index];
//         final offset = Offset(initalWidthOffset + (index * widthOfKey) + (widthOfKey / 2), heightOffset);
//         keysWithTheirCenters[key] = offset;
//       }
//     }

//     return keysWithTheirCenters;
//   }
// }

// // class TimedOffset {
// //   DateTime createdAt;
// //   Point

// // }

// class CustomKeyBoard extends StatefulWidget {
//   const CustomKeyBoard({super.key});

//   static getWidthOfKey(BuildContext context) {
//     return (MediaQuery.of(context).size.width - (2 * KeyBoard.padding)) / KeyBoard.keysList[0].length;
//   }

//   @override
//   State<CustomKeyBoard> createState() => _CustomKeyBoardState();
// }

// class _CustomKeyBoardState extends State<CustomKeyBoard> {
//   Map<String, Offset>? keysWithTheirCenters;
//   double? widthOfScreen;

//   List<Offset?> gestures = [];
//   void onUpdate(Offset localPosition) => setState(() => gestures.add(Offset(localPosition.dx, localPosition.dy)));

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     double widthOfKey = CustomKeyBoard.getWidthOfKey(context);

//     if (widthOfScreen == null || keysWithTheirCenters == null || width != widthOfScreen) {
//       keysWithTheirCenters = KeyBoard.getKeysWithTheirOffSets(widthOfScreen: width, widthOfKey: widthOfKey);
//       widthOfScreen = width;
//     }

//     return GestureDetector(
//       onPanStart: (details) => onUpdate(details.localPosition),
//       onPanDown: (_) => setState(() => gestures.add(null)),
//       onPanUpdate: (details) => onUpdate(details.localPosition),
//       child: Stack(
//         children: [
//           const StaticKeyBoard(),
//           Container(
//             width: width,
//             color: Colors.blue.withOpacity(0.3),
//             height: KeyBoard.heightOfEntireKeyBoard,
//             child: CustomPaint(
//               painter: StrokePainter(keysWithTheirCenters: keysWithTheirCenters!, gesture: gestures),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class StrokePainter extends CustomPainter {
//   StrokePainter({required this.keysWithTheirCenters, required this.gesture});
//   Map<String, Offset> keysWithTheirCenters;

//   List<Offset?> gesture;

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Paint paint = Paint()
//     //   ..color = Colors.red
//     //   ..strokeWidth = 10
//     //   ..strokeCap = StrokeCap.round;

//     // List<Offset> keyPoints = keysWithTheirCenters.entries.map((e) => e.value).toList();
//     // canvas.drawPoints(PointMode.points, keyPoints, paint);

//     // String words = "THALA";
//     // String words = "WOAHH";
//     // String words = "HELLO";
//     // Paint bluePaint = Paint()
//     //   ..color = Colors.blue
//     //   ..strokeWidth = 10
//     //   ..strokeCap = StrokeCap.round;

//     // List<Offset> wordPoints = [];
//     // words.split("").forEach((char) {
//     //   if (char == ' ') return;
//     //   char = char.toLowerCase();

//     //   wordPoints.add(keysWithTheirCenters[char]!);
//     // });

//     // canvas.drawPoints(PointMode.polygon, wordPoints, bluePaint);

//     Paint gesturePaint = Paint()
//       ..color = Colors.red
//       ..strokeWidth = 10
//       ..strokeCap = StrokeCap.round;

//     for (var i = 0; i < gesture.length - 1; i++) {
//       if (gesture[i] != null && gesture[i + 1] != null) {
//         canvas.drawLine(gesture[i]!, gesture[i + 1]!, gesturePaint);
//       } else if (gesture[i] != null && gesture[i + 1] == null) {
//         canvas.drawPoints(PointMode.points, [gesture[i]!], gesturePaint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class StaticKeyBoard extends StatelessWidget {
//   const StaticKeyBoard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         children: KeyBoard.keysList
//             .map(
//               (keys) => Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: keys.split("").map((key) => KeyBoardKey(text: key)).toList(),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }

// class KeyBoardKey extends StatelessWidget {
//   const KeyBoardKey({super.key, required this.text});

//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: Colors.red,
//       padding: const EdgeInsets.all(KeyBoard.padding),
//       child: Container(
//         width: KeyBoard.widthOfKey(context) - (2 * KeyBoard.padding),
//         height: KeyBoard.heightOfKey,
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.7),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(5),
//             splashColor: Colors.red,
//             onTap: () {},
//             child: Center(child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 20))),
//           ),
//         ),
//       ),
//     );
//   }
// }
