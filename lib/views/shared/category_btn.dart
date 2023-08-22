import 'package:flutter/material.dart';
import 'package:valenki/views/shared/app_style.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.buttonColor,
    required this.label,
    required this.onPress,
  });
  final Color buttonColor;
  final String label;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonColor,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: appStyle(
              20,
              buttonColor,
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
