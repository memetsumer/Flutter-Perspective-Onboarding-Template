import 'package:flutter/material.dart';

import '/helpers/utils.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            HexColor("e684ae"),
            HexColor("79cbca"),
            HexColor("77a1d3"),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
              tileMode: TileMode.clamp)),
    );
  }
}
