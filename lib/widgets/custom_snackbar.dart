import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required String text,
    required Duration duration,
  }) : super(
          key: key,
          duration: duration,
          backgroundColor: AppColors.kSnackbarColor,
          content: Text(
            text,
            style: const TextStyle(
              color: AppColors.kSnackbarTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        );
}
