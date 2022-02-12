import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TriggerNotificationPage extends StatelessWidget {
  const TriggerNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Lottie.asset(
                'assets/json/14584-well-done.json',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Success to active notification!'),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
