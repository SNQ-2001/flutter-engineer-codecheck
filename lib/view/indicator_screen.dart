import 'package:flutter/material.dart';

class IndicatorScreen extends StatelessWidget {
  const IndicatorScreen({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
              ],
            ),
          )
        : Container();
  }
}
