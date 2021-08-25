import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final bool isLoading;

  const PrimaryButton({required this.onPressed, required this.label})
      : this.isLoading = false;

  const PrimaryButton.loading()
      : this.onPressed = null,
        this.label = null,
        this.isLoading = true;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? () {} : onPressed,
      color: Theme.of(context).buttonColor,
      minWidth: 250.0,
      height: 36.0,
      child: isLoading
          ? SizedBox(
              width: 23.0,
              height: 23.0,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Text(
              label!,
              style: Theme.of(context).textTheme.button,
            ),
    );
  }
}
