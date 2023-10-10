import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/faqs_blogs_news_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/news_vertical_list_chip_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FaqsBlogsNewsViewModel>().callBlogsNewsApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FaqsBlogsNewsViewModel>(builder: (_, faqsBlogsNewsViewModel, __) {
      return Scaffold(
        appBar: const AppBarWithBackWidget(
            heading: 'News Updates', showPuppy: false, showCart: false),
        body: faqsBlogsNewsViewModel.getBlogsNewsResponse.data != null
            ? ListView.builder(
             // physics: NeverScrollableScrollPhysics(),
             // shrinkWrap: true,
              itemCount: faqsBlogsNewsViewModel.getBlogsNewsResponse.data!.length,
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (BuildContext context, int index) {
                return newsVerticalListChipWidget(data: faqsBlogsNewsViewModel.getBlogsNewsResponse.data![index]);
              },
            )
            : const SizedBox(),
      );
    });  }
}