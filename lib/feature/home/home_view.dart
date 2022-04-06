import 'package:crypto_mobile/feature/hw2/hw2_home_view.dart';
import 'package:crypto_mobile/widgets/custom_app_bar.dart';
import 'package:crypto_mobile/widgets/navigate_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
              'Select the homework',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            NavigateButton(hwName: 'Hw 1', widget: SizedBox()),
            NavigateButton(hwName: 'Hw 2', widget: Hw2HomeView()),
            NavigateButton(hwName: 'Hw 3', widget: SizedBox()),
          ],
        ),
      ),
    );
  }
}


