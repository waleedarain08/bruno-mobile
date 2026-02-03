import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';

class ColumnRowWidget extends StatelessWidget {
  final List<Widget> children;
  const ColumnRowWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    if (context.isBiggerThanMobile) {
      return Column(
        children: children,
      );
    }
    return Row(
      children: children,
    );
  }
}
