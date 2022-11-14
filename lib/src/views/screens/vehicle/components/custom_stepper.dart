import 'package:flutter/material.dart';
import 'package:recall/src/models/stepper_data_model.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/views/base/helper.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    Key? key,
    required this.stepperData,
  }) : super(key: key);

  final StepperData stepperData;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: stepperData.isDone ? kActiveColor : kInActiveColor,
                  shape: BoxShape.circle,
                ),
                child: stepperData.iconWidget ??
                    Icon(
                      Icons.check,
                      color: kWhite,
                    ),
              ),
              Expanded(
                child: Container(
                  color: stepperData.isDone ? kActiveColor : kInActiveColor,
                  width: 2,
                ),
              ),
            ],
          ),
          addHorizontalSpace(Dimensions.paddingSizeLarge),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stepperData.title ?? Container(),
                stepperData.content ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
