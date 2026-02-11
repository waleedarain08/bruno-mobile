import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:brunos_kitchen/widgets/web_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_models/faqs_blogs_news_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/carousels/recipes_carousel_widget.dart';

class BlogsNewsDetailScreen extends StatelessWidget {
  const BlogsNewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FaqsBlogsNewsViewModel>(
        builder: (_, faqsBlogsNewsViewModel, __) {
      return SafeArea(
        child: CustomScaffold(
          appBar: const AppBarWithBackWidget(
            heading: 'Detail',
            showPuppy: false,
            showCart: false,
          ),
          body: WebSizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 20, right: 20).w,
                  child: black18w500(
                      data: faqsBlogsNewsViewModel.getSelectedBlogNews.title!),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                    height: 200.h,
                    child: RecipesCarouselWidget(
                      recipesImages:
                          faqsBlogsNewsViewModel.getSelectedBlogNews.media!,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10).w,
                  child: Html(
                    data:
                        faqsBlogsNewsViewModel.getSelectedBlogNews.description,
                    onLinkTap: (url, _, __) async {
                      final uri = Uri.parse(url!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
