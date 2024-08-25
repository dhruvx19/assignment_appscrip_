import 'package:flutter/material.dart';


class UserInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoRow({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 5),
        Text(value),
      ],
    );
  }
}
