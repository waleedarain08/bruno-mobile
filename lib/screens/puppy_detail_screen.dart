import 'package:brunos_kitchen/utils/custom_buttons.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/widgets/dialogs/discription_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

import '../utils/custom_colors.dart';
import '../utils/enums.dart';
import '../utils/images.dart';
import '../utils/widget_utils.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/puppy_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/bottomSheet/image_taking_bottom_sheet_widget.dart';
import '../widgets/bottom_button.dart';
import '../widgets/circular_network_image_widget.dart';
import '../widgets/dialogs/delete_pet_confirmation_dialog.dart';

class PuppyDetailScreen extends StatelessWidget {
  const PuppyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PuppyViewModel>(builder: (_, puppyViewModel, __) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBarWithBackWidget(
              heading: toBeginningOfSentenceCase(
                  '${puppyViewModel.getPuppyDetail!.name} Detail'),
              showPuppy: false,
              showCart: true),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Visibility(
                            visible: puppyViewModel.getPuppyDetail!.isDefault!,
                            child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: CustomColors.orangeColor),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 2)
                                      .w,
                                  child: white12w400(data: 'Primary'),
                                )),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: !puppyViewModel.getIsPuppyEdit,
                                  child: InkWell(
                                    onTap: () {
                                      deletePetConfirmationDialog(
                                        context: context,
                                        name: puppyViewModel
                                            .getPuppyDetail!.name!,
                                      );
                                    },
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        //color: CustomColors.orangeColor,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.75,
                                              color: CustomColors.orangeColor),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10).w,
                                        child: const Icon(
                                          Icons.delete_outline,
                                          size: 20,
                                          color: CustomColors.orangeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                  onTap: () async {
                                    /*await puppyViewModel
                                        .callPuppyBreedsApi()
                                        .then((value) {
                                      if (value) {*/
                                    puppyViewModel.setIsPuppyEdit();
                                    /* }
                                    });*/
                                  },
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: puppyViewModel.getIsPuppyEdit
                                          ? CustomColors.orangeColor
                                          : null,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0.75,
                                            color: CustomColors.orangeColor),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10).w,
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: puppyViewModel.getIsPuppyEdit
                                            ? CustomColors.whiteColor
                                            : CustomColors.orangeColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 130.h,
                        width: 130.h,
                        child: Stack(
                          children: [
                            puppyViewModel.getImageFile != null &&
                                    puppyViewModel.getIsPuppyEdit
                                ? SizedBox(
                                    height: 130.h,
                                    width: 130.h,
                                    child: CircleAvatar(
                                      backgroundColor: CustomColors.greyColor,
                                      backgroundImage: Image.file(File(
                                              puppyViewModel
                                                  .getImageFile!.path))
                                          .image,
                                    ),
                                  )
                                : puppyViewModel
                                        .getPuppyDetail!.media!.isNotEmpty
                                    ? circularNetworkImageWidget(
                                        image: puppyViewModel
                                            .getPuppyDetail!.media!,
                                        size: 130.h)
                                    : SizedBox(
                                        height: 130.h,
                                        width: 130.h,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              CustomColors.yellowColor,
                                          child: SvgPicture.asset(dogFace),
                                        ),
                                      ),
                            Visibility(
                              visible: puppyViewModel.getIsPuppyEdit,
                              child: InkWell(
                                onTap: () {
                                  imageTakingBottomSheetWidget();
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: CustomColors.orangeColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10).w,
                                      child: const Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: CustomColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      _buildPuppyDetails(context, puppyViewModel),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ),
              ),
              // Visibility(
              //   visible: MediaQuery.of(context).viewInsets.bottom == 0 &&
              //       puppyViewModel.getIsPuppyEdit,
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
              //         child: customButton(
              //             text: 'Update',
              //             onPressed: () {
              //               /*  if (puppyViewModel
              //                   .puppyAdditionalCreationValidation()) {*/
              //               puppyViewModel
              //                   .callEditPuppyApi()
              //                   .then((value) async => {
              //                         if (value)
              //                           {
              //                             await context
              //                                 .read<AuthViewModel>()
              //                                 .callSplash(showLoader: true),
              //                           }
              //                       });
              //               /*}*/
              //             },
              //             colored: true),
              //       ),
              //     ),
              //   ),
              // ),
              BottomButton(
                title: 'Update',
                onTap: () {
                  puppyViewModel.callEditPuppyApi().then((value) async => {
                        if (value)
                          {
                            await context
                                .read<AuthViewModel>()
                                .callSplash(showLoader: true),
                          }
                      });
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPuppyDetails(
    BuildContext context,
    PuppyViewModel puppyViewModel,
  ) {
    return SizedBox(
      width:
          context.isBiggerThanMobile ? MediaQuery.widthOf(context) * 0.5 : null,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Visibility(
            visible: puppyViewModel.getIsPuppyEdit,
            replacement:
                black24w500Centre(data: puppyViewModel.getPuppyDetail!.name!),
            child: Column(
              children: [
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
                    child: orange14w400(
                        data: puppyViewModel.getPuppyNameFieldError)),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Visibility(
            visible: puppyViewModel.getIsPuppyEdit,
            replacement: grey14w400(
                data: '( ${puppyViewModel.getPuppyDetail!.breed!} )'),
            child: Column(
              children: [
                TextField(
                  controller: puppyViewModel.getPuppyBreedController,
                  scrollPadding: const EdgeInsets.only(bottom: 150).w,
                  onChanged: (value) {
                    puppyViewModel.searchBreeds(value);
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      /*suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 25,
                                    ),*/
                      contentPadding: const EdgeInsets.all(20.0).w,
                      hintText: 'Enter Your Pet\'s Breed'),
                ),
                Visibility(
                  visible: puppyViewModel.getBreedslist.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0).w,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColors.orangeColor,
                          width: 1.5,
                        ),
                        color: CustomColors.orangeColorTint,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 200.h,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(5).w,
                          itemCount: puppyViewModel.getBreedslist.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                onTap: () {
                                  puppyViewModel.getPuppyBreedController.text =
                                      puppyViewModel.getBreedslist[index].name!;
                                  puppyViewModel.setBreedsList([]);
                                },
                                title: black12w500Centre(
                                    data: puppyViewModel
                                        .getBreedslist[index].name!),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !puppyViewModel.getPuppyDetail!.isDefault! &&
                !puppyViewModel.getIsPuppyEdit,
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    black16w500(data: 'Set As Primary'),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        activeTrackColor: CustomColors.orangeColor,
                        value: puppyViewModel.getPuppyDetail!.isDefault!,
                        onChanged: (isDefault) {
                          puppyViewModel
                              .callDefaultPuppyApi()
                              .then((value) async => {
                                    if (value)
                                      {
                                        puppyViewModel
                                            .setIsDefaultPuppyTrueFalse(
                                                isDefault),
                                        context
                                            .read<AuthViewModel>()
                                            .callSplash(showLoader: true),
                                        Navigator.pop(context)
                                      }
                                  });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: black14w500(data: 'Gender')),
              Visibility(
                visible: puppyViewModel.getIsPuppyEdit,
                replacement: black14w500(
                    data: toBeginningOfSentenceCase(
                        puppyViewModel.getPuppyDetail!.gender)!),
                child: Expanded(
                  child: Row(
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
                              puppyViewModel.setPuppyGender(Puppy.girl.text);
                            },
                            colored: puppyViewModel.getPuppyGender ==
                                Puppy.girl.text),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const Divider(),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              black14w500(
                  data: 'Your ${puppyViewModel.getPuppyDetail!.name} is'),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: () {
                  descriptionDialog(
                    context: context,
                    height: 300.h,
                    title: 'Check Weight',
                    description:
                        'Select Underweight if you believe your dog needs to gain some more weight, the calculated daily portion will be slightly increased. \n\nSelect Ideal Weight if you believe your dog’s wight is ideal.\n\nSelect Overweight if you believe your dog needs to lose some weight, the calculated daily portion will be slightly decreased.',
                  );
                },
                child: const Icon(
                  Icons.info,
                  size: 16,
                ),
              ),
              const Spacer(),
              Visibility(
                visible: !puppyViewModel.getIsPuppyEdit,
                child: black14w500(
                    data: toBeginningOfSentenceCase(
                        puppyViewModel.getPuppyDetail!.actualWeight! ==
                                PuppyWeight.idealWeight.value
                            ? 'ideal Weight'
                            : puppyViewModel.getPuppyDetail!.actualWeight! ==
                                    PuppyWeight.underweight.value
                                ? 'underWeight'
                                : 'overWeight')!),
              ),
            ],
          ),
          Visibility(
            visible: puppyViewModel.getIsPuppyEdit,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0).w,
              child: Row(
                children: [
                  Expanded(
                    child: customSquareButton(
                        text: 'Underweight',
                        onPressed: () {
                          puppyViewModel.setPuppyActualWeight(
                              PuppyWeight.underweight.value);
                        },
                        colored: puppyViewModel.getPuppyActualWeight ==
                            PuppyWeight.underweight.value),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: customSquareButton(
                        text: 'Ideal Weight',
                        onPressed: () {
                          puppyViewModel.setPuppyActualWeight(
                              PuppyWeight.idealWeight.value);
                        },
                        colored: puppyViewModel.getPuppyActualWeight ==
                            PuppyWeight.idealWeight.value),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: customSquareButton(
                        text: 'Overweight',
                        onPressed: () {
                          puppyViewModel.setPuppyActualWeight(
                              PuppyWeight.overweight.value);
                        },
                        colored: puppyViewModel.getPuppyActualWeight ==
                            PuppyWeight.overweight.value),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const Divider(),
          SizedBox(
            height: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              black14w500(
                  data: 'How old is ${puppyViewModel.getPuppyDetail!.name}?'),
              SizedBox(
                height: 5.h,
              ),
              puppyViewModel.getIsPuppyEdit
                  ? Row(
                      children: [
                        const Spacer(),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<int>(
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              fontSize: 14.sp,
                              color: CustomColors
                                  .blackColor, // <-- TextFormField input color
                            ),
                            buttonStyleData: ButtonStyleData(
                              height: 40.h,
                              width: 70.w,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10).w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),

                                //  color: Colors.redAccent,
                              ),
                              // elevation: 2,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 70.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                //  color: Colors.redAccent,
                              ),
                              offset: const Offset(0, -10),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: WidgetStateProperty.all<double>(6),
                                thumbVisibility:
                                    WidgetStateProperty.all<bool>(true),
                              ),
                            ),
                            // borderRadius: BorderRadius.circular(15.0),
                            /* hint: Text(
                                    'Year',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                      ),*/
                            value: puppyViewModel.getPuppyYear,
                            onChanged: (newValue) {
                              puppyViewModel.setPuppyYear(newValue!);
                            },
                            items:
                                puppyViewModel.getListOfYear.map((int years) {
                              return DropdownMenuItem<int>(
                                value: years,
                                child: Text(years.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                        black14w500(data: ' Years '),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<int>(
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              fontSize: 14.sp,
                              color: CustomColors
                                  .blackColor, // <-- TextFormField input color
                            ),
                            buttonStyleData: ButtonStyleData(
                              height: 40.h,
                              width: 70.w,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10).w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),

                                //  color: Colors.redAccent,
                              ),
                              // elevation: 2,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 70.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                //  color: Colors.redAccent,
                              ),
                              offset: const Offset(0, -10),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: WidgetStateProperty.all<double>(6),
                                thumbVisibility:
                                    WidgetStateProperty.all<bool>(true),
                              ),
                            ),
                            // borderRadius: BorderRadius.circular(15.0),
                            /* hint: Text(
                                    'Year',
                                    style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                    ),
                                  ),*/
                            value: puppyViewModel.getPuppyMonths,
                            onChanged: (newValue) {
                              puppyViewModel.setPuppyMonths(newValue!);
                            },
                            items: puppyViewModel.getListOfMonths
                                .map((int months) {
                              return DropdownMenuItem<int>(
                                value: months,
                                child: Text(months.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                        black14w500(data: ' Months'),
                      ],
                    )
                  : Row(
                      children: [
                        const Spacer(),
                        Visibility(
                          visible: puppyViewModel.getPuppyDetail!.year != 0,
                          child: black14w500(
                              data:
                                  '${puppyViewModel.getPuppyDetail!.year} Years'),
                        ),
                        Visibility(
                          visible: puppyViewModel.getPuppyDetail!.month != 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10).w,
                            child: black14w500(
                                data:
                                    '${puppyViewModel.getPuppyDetail!.month} Months'),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const Divider(),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              black14w500(
                  data:
                      '${puppyViewModel.getPuppyDetail!.name} is still a puppy?'),
              puppyViewModel.getIsPuppyEdit
                  ? Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: CustomColors.orangeColor,
                      value: puppyViewModel.getDogIsPuppy,
                      onChanged: (value) {
                        puppyViewModel.setDogIsPuppy(value!);
                      })
                  : black14w500(
                      data: puppyViewModel.getPuppyDetail!.isPuppy == true
                          ? 'Yes'
                          : 'No'),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const Divider(),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: black14w500(data: 'Current Weight')),
              Visibility(
                visible: puppyViewModel.getIsPuppyEdit,
                replacement: black14w500(
                    data: puppyViewModel.getPuppyDetail!.currentWeight! != 0
                        ? '${puppyViewModel.getPuppyDetail!.currentWeight!.toString()} KG'
                        : 'N/A'),
                child: Row(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<int>(
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          fontSize: 14.sp,
                          color: CustomColors
                              .blackColor, // <-- TextFormField input color
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 40.h,
                          width: 70.w,
                          padding: const EdgeInsets.only(left: 10, right: 10).w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black26,
                            ),

                            //  color: Colors.redAccent,
                          ),
                          // elevation: 2,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 70.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            //  color: Colors.redAccent,
                          ),
                          offset: const Offset(0, -10),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: WidgetStateProperty.all<double>(6),
                            thumbVisibility:
                                WidgetStateProperty.all<bool>(true),
                          ),
                        ),
                        // borderRadius: BorderRadius.circular(15.0),
                        /* hint: Text(
                                    'Year',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                      ),*/
                        value: puppyViewModel.getPuppyCurrentWeight,
                        onChanged: (newValue) {
                          puppyViewModel.setPuppyCurrentWeight(newValue!);
                        },
                        items: puppyViewModel.getListOfWeight.map((int weight) {
                          return DropdownMenuItem<int>(
                            value: weight,
                            child: Text(weight.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    black14w500(data: 'KG')
                    /* IntrinsicWidth(
                                    child: TextField(
                                      controller:
                                          puppyViewModel.getPuppyCurrentWeight,
                                      */ /*onChanged: (text) {
                                    puppyViewModel.setPuppyCurrentWeight(int.parse(text));
                          },*/ /*
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0).w,
                                          hintText: 'Weight in KG'),
                                    ),
                                  ),*/
                    /*   SizedBox(
                                    height: 5.h,
                                  ),
                                  Visibility(
                                      visible: puppyViewModel
                                          .getCurrentWeightFieldError.isNotEmpty,
                                      child: orange14w400(
                                          data: puppyViewModel
                                              .getCurrentWeightFieldError)),*/
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const Divider(),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              black14w500(data: 'Activity Level'),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: () {
                  descriptionDialog(
                      context: context,
                      height: 250.h,
                      title: 'Activity Level',
                      description:
                          'Less Active (less than 30 minutes of exercise per day)\n\nActive (30 to 120 minutes of exercise per day)\n\nVery Active (more than 120 minutes per day)');
                },
                child: const Icon(
                  Icons.info,
                  size: 16,
                ),
              ),
              const Spacer(),
              Visibility(
                visible: !puppyViewModel.getIsPuppyEdit,
                child: black14w500(
                    data: toBeginningOfSentenceCase(
                        puppyViewModel.getPuppyDetail!.activityLevel!)!),
              ),
            ],
          ),
          Visibility(
            visible: puppyViewModel.getIsPuppyEdit,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0).w,
              child: Row(
                children: [
                  Expanded(
                    child: customSquareButton(
                        text: 'Less Active',
                        onPressed: () {
                          puppyViewModel
                              .setPuppyActivityLevel(Puppy.lessActive.text);
                        },
                        colored: puppyViewModel.getPuppyActivityLevel ==
                            Puppy.lessActive.text),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: customSquareButton(
                        text: 'Active',
                        onPressed: () {
                          puppyViewModel
                              .setPuppyActivityLevel(Puppy.active.text);
                        },
                        colored: puppyViewModel.getPuppyActivityLevel ==
                            Puppy.active.text),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: customSquareButton(
                        text: 'Very Active',
                        onPressed: () {
                          puppyViewModel
                              .setPuppyActivityLevel(Puppy.veryActive.text);
                        },
                        colored: puppyViewModel.getPuppyActivityLevel ==
                            Puppy.veryActive.text),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const Divider(),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              black14w500(data: 'Feeding Routine Per Day'),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: () {
                  descriptionDialog(
                      context: context,
                      height: 200.h,
                      title: 'Feeding Routine per Day',
                      description:
                          'We will prepare and portion your meals in an adequate number of servings to ensure you get a hassle-fee and zero-waste feeding experience.');
                },
                child: const Icon(
                  Icons.info,
                  size: 16,
                ),
              ),
              const Spacer(),
              Visibility(
                visible: !puppyViewModel.getIsPuppyEdit,
                child: black14w500(
                    data: puppyViewModel.getPuppyDetail!.feedingRoutine!
                        .toString()),
              ),
            ],
          ),
          Visibility(
            visible: puppyViewModel.getIsPuppyEdit,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0).w,
              child: Row(
                children: [
                  Expanded(
                    child: customSquareButton(
                        text: '1',
                        onPressed: () {
                          puppyViewModel.setFeedingRoutine(1);
                        },
                        colored: puppyViewModel.getFeedingRoutine == 1),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: customSquareButton(
                        text: '2',
                        onPressed: () {
                          puppyViewModel.setFeedingRoutine(2);
                        },
                        colored: puppyViewModel.getFeedingRoutine == 2),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: customSquareButton(
                        text: '3',
                        onPressed: () {
                          puppyViewModel.setFeedingRoutine(3);
                        },
                        colored: puppyViewModel.getFeedingRoutine == 3),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: customSquareButton(
                        text: '4',
                        onPressed: () {
                          puppyViewModel.setFeedingRoutine(4);
                        },
                        colored: puppyViewModel.getFeedingRoutine == 4),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: customSquareButton(
                        text: '5',
                        onPressed: () {
                          puppyViewModel.setFeedingRoutine(5);
                        },
                        colored: puppyViewModel.getFeedingRoutine == 5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
