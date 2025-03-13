import 'package:flutter/material.dart';
import 'package:note_app/configs/configs.dart';

void showErrorSnackbar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: Pallette.danger,
        behavior: SnackBarBehavior.floating,
      ),
    );

void showInfoSnackbar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: Pallette.info,
        behavior: SnackBarBehavior.floating,
      ),
    );
