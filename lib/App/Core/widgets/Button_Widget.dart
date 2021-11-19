import 'package:flutter/material.dart';
import 'package:todo_app/App/Core/utils/Colors.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final TextStyle buttonStyle;
  final VoidCallback onPressed;
  final double buttonWidth;
  const ButtonWidget({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonStyle,
    required this.buttonWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: 45,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              whiteColor60,
              indigoColor.withOpacity(0.3),
            ],
          ),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: buttonStyle,
          ),
          style: ButtonStyle(),
        ),
      ),
    );
  }
}
