import 'package:flutter/material.dart';
import 'package:recall/src/utils/styles.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Data Found!',
        style: h2,
      ),
    );
  }
}
