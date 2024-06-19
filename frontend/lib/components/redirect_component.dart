import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RedirectComponent extends StatelessWidget {
  final String text;
  final String redirectText;
  final void Function() onTap;

  const RedirectComponent({
    super.key,
    required this.text,
    required this.redirectText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
          ),
          text: text,
          children: [
            TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              text: redirectText,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onTap();
                },
            )
          ],
        ),
      ),
    );
  }
}
