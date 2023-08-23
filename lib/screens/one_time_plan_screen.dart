import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/custom_font_style.dart';
import '../utils/images.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/food_discribed_grid_chip_widget.dart';

class OneTimePlanScreen extends StatelessWidget {
  const OneTimePlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackWidget(
        heading: 'OneTime Order', showPuppy: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Image.asset(
                  buyBulits2,
                  height: 57.h,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              black24w500Centre(
                  data: 'Let’s Feed Your Beloved Labby'),
              SizedBox(
                height: 10.h,
              ),
              lightBlack14w400Centre(data: 'Pick from any of our Bruno-approved delightful dishes below'),
              SizedBox(
                height: 30.h,
              ),
              black18w500(
                  data: 'Recommended Dishes'),
              GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.w, vertical: 20.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: (1 / 1.5)),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return foodDescribedGridChipWidget();
                },
              ),
              black18w500(
                  data: 'Try our canine-crafted combos'),
              GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.w, vertical: 20.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: (1 / 1.5)),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return foodDescribedGridChipWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
