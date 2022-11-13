import 'package:flutter/material.dart';
import 'package:recall/src/utils/asset_path.dart';

class KLogo extends StatelessWidget {
  const KLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetPath.logo,
      height: 150,
      width: 150,
    );
  }
}
