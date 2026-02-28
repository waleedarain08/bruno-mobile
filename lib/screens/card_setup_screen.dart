import 'dart:developer';

import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../widgets/app_bar_with_back_widget.dart';

class CardSetupScreen extends StatelessWidget {
  final String url;
  final String successUrl;
  const CardSetupScreen._({required this.url, required this.successUrl});

  static Future<Map<String, dynamic>?> authorize({
    required String url,
    required String successUrl,
  }) async {
    return await Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (_) => CardSetupScreen._(
          url: url,
          successUrl: successUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const AppBarWithBackWidget(
        heading: 'Add new card',
        showPuppy: false,
        showCart: false,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri.uri(
            Uri.parse(url),
          ),
        ),
        onLoadStart: (_, uri) {
          log('URL: $uri PARAMS: ${uri?.queryParameters}');
          if (uri?.toString().startsWith(successUrl) ?? false) {
            final params = uri?.queryParameters;
            Navigator.pop(context, params);
          }
        },
      ),
    );
  }
}
