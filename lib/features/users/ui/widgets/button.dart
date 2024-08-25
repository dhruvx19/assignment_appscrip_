
import 'package:flutter/material.dart';

class PurplePrimaryActionButton extends StatelessWidget {
  const PurplePrimaryActionButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.enabled = true,
  });
  final void Function()? onPressed;
  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            padding: MaterialStateProperty.all(
              const EdgeInsets.only(right: 64, left: 64),
            ),
            backgroundColor: enabled ? MaterialStateProperty.all(const Color(0xff3F1364)) : MaterialStateProperty.all(Colors.grey),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
          ),
          onPressed: enabled ? onPressed : null,
          child: Text(
            text,
            style: const TextStyle(fontSize:15,  color: Colors.white),
          ),
        ),
      ),
    );
  }
}