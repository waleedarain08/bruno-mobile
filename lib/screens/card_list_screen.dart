import 'package:brunos_kitchen/utils/food_category_list_data.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/view_models/card_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/images.dart';
import '../view_models/puppy_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/card_vertical_list_chip_widget.dart';
import '../widgets/orders_vertical_list_chip_widget.dart';
import '../widgets/puppy_vertical_list_chip_widget.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({Key? key}) : super(key: key);

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CardViewModel>().callCardsApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CardViewModel>(builder: (_, cardViewModel, __) {
      return Scaffold(
        appBar: const AppBarWithBackWidget(
            heading: 'Payment', showPuppy: false, showCart: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    cardViewModel.setIsCardAdd(true);
                    Navigator.pushNamed(context, addCardRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: CustomColors.lightGreyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: ShapeDecoration(
                                  color: CustomColors.greyColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(293),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.credit_card,color: CustomColors.whiteColor,),
                                )),
                            SizedBox(
                              width: 10.w,
                            ),
                            lightBlack14w400Centre(data: 'Add new card'),
                            const Spacer(),
                            Container(
                              decoration: ShapeDecoration(
                                color: CustomColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.75,
                                      color: CustomColors.greyMediumColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: CustomColors.orangeColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: black16w500(
                      data:'Available Cards'),
                ),
                cardViewModel.getCardResponse.data != null
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cardViewModel.getCardResponse.data!.length,
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        itemBuilder: (BuildContext context, int index) {
                          return cardVerticalListChipWidget(
                              cardDetail:
                                  cardViewModel.getCardResponse.data![index]);
                        },
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      );
    });
  }
}