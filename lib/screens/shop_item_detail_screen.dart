import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../utils/custom_colors.dart';
import '../utils/images.dart';
import '../widgets/app_bar_with_back_widget.dart';

class ShopItemDetailScreen extends StatelessWidget {
  const ShopItemDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackWidget(
        heading: toBeginningOfSentenceCase('Product Detail'),
        showPuppy: false,showCart: true
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  height: 300.h,
                  decoration: ShapeDecoration(
                    color: CustomColors.lightGreyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: Image.asset(
                        bone,
                        //height: 200.h,
                      ),
                    ),
                  )),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      black14w500(data: 'Unit Price'),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          black24w500Centre(data: '\$140.00'),
                          SizedBox(
                            width: 5.w,
                          ),
                          grey14w400(data: '\$158.33')
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      black14w500(data: 'Quantity'),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.pop(context);
                            },
                            child: Container(
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
                                  Icons.remove,
                                  size: 20,
                                  color: CustomColors.greyColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 40.w,
                              child: Center(child: black18w500(data: '1'))),
                          InkWell(
                            onTap: () {
                              //Navigator.pop(context);
                            },
                            child: Container(
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
                                  color: CustomColors.greyColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Divider(),
              SizedBox(
                height: 24.h,
              ),
              black14w500(data: 'Details'),
              SizedBox(
                height: 8.h,
              ),
              grey14w400(
                  lineHeight: true,
                  data: '•  Materials: 100% cotton, and lining Structured'),
              grey14w400(
                  lineHeight: true,
                  data: '•  Materials: 100% cotton, and lining Structured'),
              grey14w400(
                  lineHeight: true,
                  data: '•  Materials: 100% cotton, and lining Structured'),
              grey14w400(
                  lineHeight: true,
                  data: '•  Materials: 100% cotton, and lining Structured'),
              SizedBox(
                height: 24.h,
              ),
              black14w500(data: 'Store pickup availability'),
              SizedBox(
                height: 8.h,
              ),
              grey14w400(
                  lineHeight: true,
                  data:
                      'Select a size to check store availability and In-Store pickup options.'),
              SizedBox(
                height: 40.h,
              ),
              Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: CustomColors.orangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            white18w500(data: '\$280'),
                            SizedBox(
                              height: 5.h,
                            ),
                            whiteTint14w400(data: 'Total Price')
                          ],
                        ),
                        Spacer(),
                        white18w500(data: 'Add to cart')
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}