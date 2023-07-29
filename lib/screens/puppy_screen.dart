import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../main.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/images.dart';
import '../widgets/app_bar_with_back_widget.dart';

class PuppyScreen extends StatelessWidget {
  const PuppyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackWidget(
        heading: 'My Puppy',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  dogFace,
                  height: 102.h,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                  child: black24w500Centre(data: 'Tell us about your pooch!')),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: black14w400Centre(
                    data:
                        'Within a moment, we\'ll whip up a custom meal plan tailored to suit your doggo\'s unique needs'),
              ),
              SizedBox(
                height: 30.h,
              ),
              black14w400Centre(data: 'Pet Name'),
              SizedBox(
                height: 12.h,
              ),
              TextField(
                //controller: nameController,
                onChanged: (text) {},
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20.0), hintText: 'Labby'),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: CustomColors.lightGreyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        cameraImage,
                        height: 102.h,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      black14w400Centre(data: 'Click to select photo'),
                      black14w400Centre(
                          data: '.png . jpeg. max 1 MB file size'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              SizedBox(
                  width: 307.w,
                  child: black14w400Centre(
                      data:
                          'Proud parent of multiple pups? We\'ve got you covered! You can easily add more pet profiles to your account once you have finished signing up.')),
              SizedBox(
                height: 30.h,
              ),
              black18w500(data: 'Labby is a?'),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: customSquareButton(
                        text: 'Boy',
                        onPressed: () {
                          // Navigator.pushNamed(context, otpRoute);
                        },
                        colored: true),
                  ),
                  SizedBox(width: 20.w,),
                  Expanded(
                    child: customSquareButton(
                        text: 'Girl',
                        onPressed: () {
                          // Navigator.pushNamed(context, otpRoute);
                        },
                        colored: false),
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              black18w500(data: 'Is Labby spayed/neutered?'),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  black14w400Centre(data: 'Why does this matter'),
                  const Icon(Icons.help,size: 16,)
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: customSquareButton(
                        text: 'Yes',
                        onPressed: () {
                          // Navigator.pushNamed(context, otpRoute);
                        },
                        colored: true),
                  ),
                  SizedBox(width: 20.w,),
                  Expanded(
                    child: customSquareButton(
                        text: 'No',
                        onPressed: () {
                          // Navigator.pushNamed(context, otpRoute);
                        },
                        colored: false),
                  )
                ],
              ),
              SizedBox(height: 56.h,),
              customButton(
                  text: 'Save',
                  onPressed: () {
                     Navigator.pushNamed(context, puppyAdditionalRoute);
                  },
                  colored: true),
            ],
          ),
        ),
      ),
    );
  }
}
