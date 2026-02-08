import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/enums.dart';
import '../utils/images.dart';
import '../view_models/puppy_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/bottomSheet/image_taking_bottom_sheet_widget.dart';
import '../widgets/bottom_button.dart';
import '../widgets/circular_network_image_widget.dart';

class PuppyCreationScreen extends StatelessWidget {
  const PuppyCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PuppyViewModel>(builder: (_, puppyViewModel, __) {
      return SafeArea(
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: AppBarWithBackWidget(
            heading: context.read<PuppyViewModel>().getRouteToPuppyFrom ==
                    Screens.home.text
                ? 'Add pet'
                : 'My Pets',
            showPuppy: false,
            showCart: true,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ).w,
                child: _buildBody(context, puppyViewModel),
              ),
              BottomButton(
                title: 'Next',
                onTap: () {
                  puppyViewModel.getBreedslist.clear();
                  if (puppyViewModel.puppyCreationValidation()) {
                    puppyViewModel.callPuppyBreedsApi().then(
                          (value) => {
                            if (value)
                              {
                                Navigator.pushNamed(
                                  context,
                                  puppyAdditionalRoute,
                                )
                              }
                          },
                        );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBody(
    BuildContext context,
    PuppyViewModel puppyViewModel,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: context.read<PuppyViewModel>().getRouteToPuppyFrom ==
                Screens.home.text,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0).w,
              child: Center(
                child: Image.asset(
                  buyBulits1,
                  height: 57.h,
                ),
              ),
            ),
          ),
          Center(
            child: SvgPicture.asset(
              dogFace,
              height: 102.h,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Center(child: black24w500Centre(data: 'Tell Us About Your Pooch!')),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: lightBlack14w400Centre(
                data:
                    'Within a moment, we\'ll whip up a custom meal plan tailored to suit your doggo\'s unique needs'),
          ),
          SizedBox(
            height: 30.h,
          ),
          if (context.isBiggerThanMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildLeftSide(context, puppyViewModel)),
                VerticalDivider(
                  width: 40.w,
                ),
                Expanded(child: _buildRightSide(context, puppyViewModel)),
              ],
            )
          else ...{
            _buildLeftSide(context, puppyViewModel),
            SizedBox(
              height: 30.h,
            ),
            _buildRightSide(context, puppyViewModel),
          },
          SizedBox(
            height: 100.h,
          ),
        ],
      ),
    );
  }

  Widget _buildLeftSide(BuildContext context, PuppyViewModel puppyViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lightBlack14w400Centre(data: 'Pet Name'),
        SizedBox(
          height: 12.h,
        ),
        TextField(
          controller: puppyViewModel.getPuppyNameController,
          onChanged: (text) {},
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0).w,
              hintText: 'Entre Your Pet\'s Name'),
        ),
        SizedBox(
          height: 5.h,
        ),
        Visibility(
            visible: puppyViewModel.getPuppyNameFieldError.isNotEmpty,
            child: orange14w400(data: puppyViewModel.getPuppyNameFieldError)),
        SizedBox(
          height: 15.h,
        ),
        InkWell(
          onTap: () {
            imageTakingBottomSheetWidget();
          },
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: CustomColors.lightGreyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  puppyViewModel.getImageFile == null
                      ? puppyViewModel.getPuppyImage.isNotEmpty
                          ? circularNetworkImageWidget(
                              image: puppyViewModel.getPuppyImage, size: 100.h)
                          : SvgPicture.asset(
                              cameraImage,
                              height: 102.h,
                            )
                      : SizedBox(
                          height: 100.h,
                          width: 100.h,
                          child: CircleAvatar(
                            backgroundColor: CustomColors.greyColor,
                            backgroundImage: Image.file(
                                    File(puppyViewModel.getImageFile!.path))
                                .image,
                          ),
                        ),
                  SizedBox(
                    height: 14.h,
                  ),
                  lightBlack14w400Centre(
                      data: 'Click to select photo (Optional)'),
                  lightBlack14w400Centre(
                      data: '.png . jpeg. max 1 MB file size'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
            width: context.isBiggerThanMobile ? null : 307.w,
            child: lightBlack14w400Centre(
                data:
                    'Proud parent of multiple pups? We\'ve got you covered! You can easily add more pet profiles to your account once you have finished signing up.')),
      ],
    );
  }

  Widget _buildRightSide(BuildContext context, PuppyViewModel puppyViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        black18w500(
            data:
                '${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'} is a?'),
        SizedBox(
          height: 16.h,
        ),
        if (context.isBiggerThanMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customSquareButton(
                text: 'Boy',
                onPressed: () {
                  puppyViewModel.setPuppyGender(Puppy.boy.text);
                },
                colored: puppyViewModel.getPuppyGender == Puppy.boy.text,
              ),
              SizedBox(
                height: 20.h,
              ),
              customSquareButton(
                text: 'Girl',
                onPressed: () {
                  puppyViewModel.setPuppyGender(Puppy.girl.text);
                },
                colored: puppyViewModel.getPuppyGender == Puppy.girl.text,
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                child: customSquareButton(
                  text: 'Boy',
                  onPressed: () {
                    puppyViewModel.setPuppyGender(Puppy.boy.text);
                  },
                  colored: puppyViewModel.getPuppyGender == Puppy.boy.text,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: customSquareButton(
                  text: 'Girl',
                  onPressed: () {
                    puppyViewModel.setPuppyGender(Puppy.girl.text);
                  },
                  colored: puppyViewModel.getPuppyGender == Puppy.girl.text,
                ),
              )
            ],
          ),
      ],
    );
  }
}
