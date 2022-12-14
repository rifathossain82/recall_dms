import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';

Widget addVerticalSpace(double space) {
  return SizedBox(height: space);
}

Widget addHorizontalSpace(double space) {
  return SizedBox(width: space);
}

String? customDateFormat(DateTime tm) {
  DateTime today = DateTime.now();
  String? month;
  String? day;
  switch (tm.month) {
    case 1:
      month = "January";
      break;
    case 2:
      month = "February";
      break;
    case 3:
      month = "March";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "June";
      break;
    case 7:
      month = "July";
      break;
    case 8:
      month = "August";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "October";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "December";
      break;
  }

  Duration difference = today.difference(tm);

  if (difference.inDays == 0 && tm.day == today.day) {
    day = "Today";
  } else if (difference.inDays == 0 && tm.day != today.day) {
    day = "Tomorrow";
  } else if (difference.inDays == 1) {
    day = "Yesterday";
  } else {
    switch (tm.weekday) {
      case 1:
        day = "Monday";
        break;
      case 2:
        day = "Tuesday";
        break;
      case 3:
        day = "Wednesday";
        break;
      case 4:
        day = "Thursday";
        break;
      case 5:
        day = "Friday";
        break;
      case 6:
        day = "Saturday";
        break;
      case 7:
        day = "Sunday";
        break;
    }
  }

  return '$day, ${tm.day} $month ${tm.year}';
}

void kSnackBar({required String message, required Color bgColor}) {
  Get.showSnackbar(
    GetSnackBar(
      backgroundColor: bgColor,
      message: message,
      maxWidth: 1170,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10),
      borderRadius: 5,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}

Future<bool?> kConfirmDialog({
  required BuildContext context,
  required String title,
  required String negativeActionText,
  required String positiveActionText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          icon: Icon(Icons.question_mark, color: mainColor,),
          title: Text(
            title,
            style: h2.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text(
                negativeActionText,
                style: h4.copyWith(
                  color: kGrey,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text(
                positiveActionText,
                style: h4.copyWith(
                  color: mainColor,
                ),
              ),
            ),
          ],
        );
      });
}

void kPrint(dynamic data) {
  if (kDebugMode) {
    print(data);
  }
}

/// to check internet connection
Future<bool> get hasInternet async {
  var result = await (Connectivity().checkConnectivity());
  if (result == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
