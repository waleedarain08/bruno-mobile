import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';

class WebSizedBox extends StatelessWidget {
  final Widget child;
  const WebSizedBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: context.webSize,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
