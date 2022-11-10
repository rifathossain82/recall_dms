import 'package:flutter/material.dart';

class KBadge extends StatelessWidget {
  final Color? bgColor;
  final double right;
  final double top;
  final Widget child;

  const KBadge({Key? key, this.bgColor, required this.right, required this.top, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: right,
          top: top,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: bgColor ?? Colors.red,
            ),
            constraints: BoxConstraints(
              minWidth: 5,
              minHeight: 5,
            ),
          ),
        )
      ],
    );
  }
}