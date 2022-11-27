import 'package:flutter/material.dart';

class KCircularLoader extends StatelessWidget {
  final double? height;
  final double? width;
  const KCircularLoader({Key? key, this.height = 30, this.width = 30,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: const CircularProgressIndicator()
    );
  }
}
