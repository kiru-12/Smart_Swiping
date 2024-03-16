import 'package:flutter/material.dart';

const double padding = 2;
const double heightOfKey = 50;
const keysList = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];

class CustomKeyBoard extends StatelessWidget {
  const CustomKeyBoard({super.key});

  static getWidthOfKey(BuildContext context) =>
      (MediaQuery.of(context).size.width - (2 * padding)) / keysList[0].length;

  @override
  Widget build(BuildContext context) {
    double widthOfKey = getWidthOfKey(context);

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
      width: widthOfKey - (2 * padding),
      height: heightOfKey,
      margin: const EdgeInsets.all(padding),
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
    );
  }
}
