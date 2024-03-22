import 'package:flutter/material.dart';

// Same implementaion from keyboard.py

class KeyBoard {
  static const double padding = 2;
  static const double heightOfKey = 50;
  static const keysList = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];

  static double get heightOfEntireKeyBoard => keysList.length * (heightOfKey) + (keysList.length * 2 * padding);
  static double widthOfScreen(BuildContext context) => MediaQuery.of(context).size.width;
  static double widthOfKey(BuildContext context) {
    return (widthOfScreen(context) - (2 * padding)) / keysList[0].length;
  }

  static Map<String, Offset> getKeysWithTheirOffSets({required double widthOfScreen, required double widthOfKey}) {
    Map<String, Offset> keysWithTheirCenters = {};

    for (var rowIndex = 0; rowIndex < keysList.length; rowIndex++) {
      String keys = keysList[rowIndex];

      final heightOffset = (rowIndex * (heightOfKey)) + (heightOfKey / 2);
      final initalWidthOffset = (widthOfScreen - (keys.length * widthOfKey)) / 2;

      for (var index = 0; index < keys.length; index++) {
        String key = keys[index];
        final offset = Offset(initalWidthOffset + (index * widthOfKey) + (widthOfKey / 2), heightOffset);
        keysWithTheirCenters[key] = offset;
      }
    }

    return keysWithTheirCenters;
  }

  static String getNearestKeyFromPoint(Offset offset, BuildContext context) {
    int rowIndex = (offset.dy ~/ (heightOfKey + (2 * padding)));
    rowIndex = rowIndex >= 0 ? rowIndex : 0;
    rowIndex = rowIndex < keysList.length ? rowIndex : keysList.length - 1;

    String keys = keysList[rowIndex];

    double initialWidthOffset =
        rowIndex == 0 ? padding : (widthOfScreen(context) - padding - (keys.length * widthOfKey(context))) / 2;

    int keyIndex = (offset.dx - initialWidthOffset) ~/ widthOfKey(context);
    keyIndex = keyIndex >= 0 ? keyIndex : 0;
    keyIndex = keys.length > keyIndex ? keyIndex : keys.length - 1;
    String key = keys[keyIndex];

    return key;
  }

  static String addKeyAndReturnText(String text, String key) {
    if (text.isEmpty || text[text.length - 1].compareTo(key) != 0) {
      text = "$text$key";
    }
    return text;
  }

  static getTextForOffset({
    required BuildContext context,
    required String text,
    required Offset offset,
  }) {
    String key = getNearestKeyFromPoint(offset, context);
    return addKeyAndReturnText(text, key);
  }
}
