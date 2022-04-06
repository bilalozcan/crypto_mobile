import 'package:crypto_mobile/feature/hw2/hw2_question1_view.dart';
import 'package:crypto_mobile/feature/hw2/hw2_question2_view.dart';
import 'package:crypto_mobile/widgets/custom_app_bar.dart';
import 'package:crypto_mobile/widgets/navigate_button.dart';
import 'package:flutter/material.dart';

class Hw2HomeView extends StatelessWidget {
  const Hw2HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Crypto Homework'),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Select the question',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            NavigateButton(hwName: 'Question 1', widget: Hw2Question1View()),
            NavigateButton(hwName: 'Question 2', widget: Hw2Question2View()),
          ],
        ),
      ),
    );
  }
}
