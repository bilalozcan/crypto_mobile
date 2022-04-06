import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    Key? key,
    required this.hwName,
    required this.widget,
  }) : super(key: key);

  final String hwName;
  final Widget widget;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        ),
        child: Text(hwName),
      );
}
