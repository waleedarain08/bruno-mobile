import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../view_models/faqs_blogs_news_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/listChips/news_blog_vertical_list_chip_widget.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FaqsBlogsNewsViewModel>().callBlogsApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FaqsBlogsNewsViewModel>(
        builder: (_, faqsBlogsNewsViewModel, __) {
      return SafeArea(
        child: CustomScaffold(
          appBar: const AppBarWithBackWidget(
              heading: 'Blogs', showPuppy: false, showCart: false),
          body: faqsBlogsNewsViewModel.getBlogsNewsResponse.data != null
              ? Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: context.webSize,
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      itemCount: faqsBlogsNewsViewModel
                          .getBlogsNewsResponse.data!.length,
                      padding: const EdgeInsets.symmetric(vertical: 20).w,
                      itemBuilder: (BuildContext context, int index) {
                        return newsBlogsVerticalListChipWidget(
                            data: faqsBlogsNewsViewModel
                                .getBlogsNewsResponse.data![index]);
                      },
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      );
    });
  }
}
