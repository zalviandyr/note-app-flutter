import 'package:flutter/material.dart';
import 'package:note_app/configs/configs.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final double iconSize;
  final bool isLoading;

  const SecondaryButton(
      {required this.onPressed, required this.icon, this.iconSize = 35.0})
      : this.isLoading = false;

  const SecondaryButton.loading({this.iconSize = 35.0})
      : this.onPressed = null,
        this.icon = null,
        this.isLoading = true;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 50.0,
      onPressed: isLoading ? () {} : onPressed,
      color: Theme.of(context).buttonColor,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: isLoading
          ? SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            )
          : Icon(
              icon,
              size: iconSize,
              color: Theme.of(context).accentColor,
            ),
    );
  }
}
