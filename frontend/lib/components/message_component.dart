import 'package:flutter/material.dart';

class MessageComponent extends StatelessWidget {
  final String message;
  final String variants;

  const MessageComponent(
      {super.key, required this.message, this.variants = "success"});

  @override
  Widget build(BuildContext context) {
    switch (variants) {
      case "success":
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.red,
          ),
          width: double.infinity,
          // alignment: Alignment.centele,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );

      case "error":
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.red,
          ),
          width: double.infinity,
          // alignment: Alignment.centele,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );

      default:
        throw Exception("Invalid variant");
    }
  }
}
