import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(text: TextSpan(
            text: 'Avaruussää @ ilmatieteen laitos',
            style: Theme.of(context).textTheme.bodySmall,
            recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrlString('https://www.ilmatieteenlaitos.fi/revontulet-ja-avaruussaa'),
          ),
      ),],
      ),
    );
  }
}
