import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';

class WebSizedBox extends StatelessWidget {
  final Widget child;
  final Alignment? alignment;
  final double? width;
  const WebSizedBox(
      {super.key, required this.child, this.alignment, this.width});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.topCenter,
      child: SizedBox(
        width: width ?? context.webSize,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
