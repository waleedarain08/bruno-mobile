import 'package:accordion/accordion.dart';
import 'package:brunos_kitchen/models/responses/faqs_blogs_news_response.dart';
import 'package:brunos_kitchen/view_models/faqs_blogs_news_view_model.dart';
import 'package:brunos_kitchen/widgets/web_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/custom_scaffold.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FaqsBlogsNewsViewModel>().callFaqsApi();
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
            heading: 'FAQ',
            showPuppy: false,
            showCart: false,
          ),
          body: faqsBlogsNewsViewModel.getFaqsResponse.data != null
              ? WebSizedBox(
                  child: Accordion(
                    disableScrolling: false,
                    paddingListHorizontal: 20,
                    maxOpenSections: 2,
                    headerBackgroundColorOpened: Colors.black54,
                    scaleWhenAnimating: true,
                    openAndCloseAnimation: true,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                    // sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    children: [
                      for (FaqsBlogsNewsData item
                          in faqsBlogsNewsViewModel.getFaqsResponse.data!)
                        AccordionSection(
                          // isOpen: false,
                          //flipRightIconIfOpen: true,
                          rightIcon: const Icon(Icons.keyboard_arrow_down),
                          // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                          headerBackgroundColor:
                              CustomColors.greyMediumLightColor,
                          headerBackgroundColorOpened:
                              CustomColors.greyMediumLightColor,
                          header: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: lightBlack14w400Centre(
                                    data: item.title!, left: true)),
                          ),
                          content: black12w500Centre(
                              data: item.description!, centre: false),
                          contentBackgroundColor:
                              CustomColors.greyMediumLightColor,
                          contentHorizontalPadding: 20,
                          contentBorderWidth: 1,
                          // onOpenSection: () => print('onOpenSection ...'),
                          // onCloseSection: () => print('onCloseSection ...'),
                        )
                    ],
                  ),
                )
              : const SizedBox(),
        ),
      );
    });
  }
}
