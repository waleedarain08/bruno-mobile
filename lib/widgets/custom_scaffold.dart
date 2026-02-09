import 'package:brunos_kitchen/widgets/web_app_bar.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  const CustomScaffold({super.key, required this.body, this.appBar});

  @override
  Widget build(BuildContext context) {
    return WebAppBar(
      child: Scaffold(
        appBar: appBar,
        body: body,
      ),
    );
  }
}
