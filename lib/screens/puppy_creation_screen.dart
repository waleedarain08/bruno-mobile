import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
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
              showCart: true),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                          top: 40, bottom: 20, left: 20, right: 20)
                      .w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: context
                                .read<PuppyViewModel>()
                                .getRouteToPuppyFrom ==
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
                      Center(
                          child: black24w500Centre(
                              data: 'Tell Us About Your Pooch!')),
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
                          visible:
                              puppyViewModel.getPuppyNameFieldError.isNotEmpty,
                          child: orange14w400(
                              data: puppyViewModel.getPuppyNameFieldError)),
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
                                            image: puppyViewModel.getPuppyImage,
                                            size: 100.h)
                                        : SvgPicture.asset(
                                            cameraImage,
                                            height: 102.h,
                                          )
                                    : SizedBox(
                                        height: 100.h,
                                        width: 100.h,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              CustomColors.greyColor,
                                          backgroundImage: Image.file(File(
                                                  puppyViewModel
                                                      .getImageFile!.path))
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
                      /* Visibility(
                          visible:
                              puppyViewModel.getPuppyImageFieldError.isNotEmpty,
                          child: orange14w400(
                              data: puppyViewModel.getPuppyImageFieldError)),*/
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                          width: 307.w,
                          child: lightBlack14w400Centre(
                              data:
                                  'Proud parent of multiple pups? We\'ve got you covered! You can easily add more pet profiles to your account once you have finished signing up.')),
                      SizedBox(
                        height: 30.h,
                      ),
                      black18w500(
                          data:
                              '${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'} is a?'),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: customSquareButton(
                                text: 'Boy',
                                onPressed: () {
                                  puppyViewModel.setPuppyGender(Puppy.boy.text);
                                },
                                colored: puppyViewModel.getPuppyGender ==
                                    Puppy.boy.text),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: customSquareButton(
                                text: 'Girl',
                                onPressed: () {
                                  puppyViewModel
                                      .setPuppyGender(Puppy.girl.text);
                                },
                                colored: puppyViewModel.getPuppyGender ==
                                    Puppy.girl.text),
                          )
                        ],
                      ),
                      /*  SizedBox(
                        height: 40.h,
                      ),
                      black18w500(
                          data:
                              'Is ${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'} spayed/neutered?'),
                      SizedBox(
                        height: 24.h,
                      ),
                      InkWell(
                        onTap: () {
                          descriptionDialog(
                              context: context,
                              description:
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic',
                              height: 300, title: 'Description');
                        },
                        child: Row(
                          children: [
                            lightBlack14w400Centre(data: 'Why does this matter'),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Icon(
                              Icons.help,
                              size: 16,
                            )
                          ],
                        ),
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
                                  puppyViewModel.setPuppyIsSpayNeuter(true);
                                },
                                colored: puppyViewModel.getPuppyIsSpayNeuter),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: customSquareButton(
                                text: 'No',
                                onPressed: () {
                                  puppyViewModel.setPuppyIsSpayNeuter(false);
                                },
                                colored: !puppyViewModel.getPuppyIsSpayNeuter),
                          )
                        ],
                      ),*/
                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 5,
                          spreadRadius: 2,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20).w,
                      child: customButton(
                          text: 'Next',
                          onPressed: () {
                            puppyViewModel.getBreedslist.clear();
                            if (puppyViewModel.puppyCreationValidation()) {
                              puppyViewModel
                                  .callPuppyBreedsApi()
                                  .then((value) => {
                                        if (value)
                                          {
                                            Navigator.pushNamed(
                                                context, puppyAdditionalRoute)
                                          }
                                      });
                            }
                          },
                          colored: true),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
