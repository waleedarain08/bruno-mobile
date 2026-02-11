import 'package:brunos_kitchen/widgets/web_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../view_models/faqs_blogs_news_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/bottom_button.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/dialogs/discription_dialog.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FaqsBlogsNewsViewModel>(
        builder: (_, faqsBlogsNewsViewModel, __) {
      return SafeArea(
        child: CustomScaffold(
          appBar: const AppBarWithBackWidget(
            heading: 'Feedback Form',
            showPuppy: false,
            showCart: false,
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20).w,
                child: WebSizedBox(
                  child: Column(
                    children: [
                      TextField(
                        controller: faqsBlogsNewsViewModel.getFeedbackTitle,
                        onChanged: (text) {},
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20.0)
                              .w,

                          /*  prefixIcon: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SvgPicture.asset(userIcon),
                              )*/
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: faqsBlogsNewsViewModel.getFeedbackDesc,
                        onChanged: (text) {},
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15.0)
                              .w,

                          /* prefixIcon: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SvgPicture.asset(userIcon),
                              )*/
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                title: 'Submit',
                onTap: () async {
                  if (faqsBlogsNewsViewModel.validateFeedbackForm()) {
                    await faqsBlogsNewsViewModel.callAddFeedbackApi();
                  } else {
                    descriptionDialog(
                        context: context,
                        description: 'Kindly fill all fields',
                        height: 160.h,
                        title: 'Alert');
                  }
                },
              ),
              // Visibility(
              //   visible: MediaQuery.of(context).viewInsets.bottom == 0,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Container(
              //       decoration: const BoxDecoration(
              //         color: CustomColors.whiteColor,
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(30.0),
              //           topRight: Radius.circular(30.0),
              //         ),
              //         boxShadow: [
              //           BoxShadow(
              //             offset: Offset(0, 0),
              //             blurRadius: 5,
              //             spreadRadius: 2,
              //             color: Colors.black12,
              //           ),
              //         ],
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(20).w,
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 20).w,
              //           child: customButton(
              //             colored: true,
              //             text: 'Submit',
              //             onPressed: () async {
              //               if (faqsBlogsNewsViewModel.validateFeedbackForm()) {
              //                 await faqsBlogsNewsViewModel.callAddFeedbackApi();
              //               } else {
              //                 descriptionDialog(
              //                     context: context,
              //                     description: 'Kindly fill all fields',
              //                     height: 160.h,
              //                     title: 'Alert');
              //               }
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}
