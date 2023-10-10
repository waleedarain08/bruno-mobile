import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../view_models/faqs_blogs_news_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FaqsBlogsNewsViewModel>().clearWebView();
      context.read<FaqsBlogsNewsViewModel>().setWebView(url: "https://brunos.kitchen/blog/");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FaqsBlogsNewsViewModel>(
        builder: (_, faqsBlogsNewsViewModel, __) {
      return Scaffold(
        appBar: const AppBarWithBackWidget(
            heading: 'Blogs', showPuppy: false, showCart: false),
        body:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: WebViewWidget(
                  controller: faqsBlogsNewsViewModel.getWebViewController,
                ),
        ),
      );
    });
  }
}
