import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/enums.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:brunos_kitchen/view_models/puppy_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/images.dart';
import '../utils/navigations_validation.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/bottom_button.dart';
import '../widgets/dialogs/discription_dialog.dart';
import '../widgets/dialogs/scaling_image_dialog.dart';

class PuppyCreationAdditionalScreen extends StatefulWidget {
  const PuppyCreationAdditionalScreen({super.key});

  @override
  State<PuppyCreationAdditionalScreen> createState() =>
      _PuppyCreationAdditionalScreenState();
}

class _PuppyCreationAdditionalScreenState
    extends State<PuppyCreationAdditionalScreen> {
  final FocusNode _nodeText1 = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PuppyViewModel>(builder: (_, puppyViewModel, __) {
      return SafeArea(
        child: Scaffold(
          appBar: const AppBarWithBackWidget(
            heading: /*context.read<PuppyViewModel>().getRouteToPuppyFrom ==
                      Screens.home.text
                  ? */
                'Add Pet' /*: 'My Pets'*/,
            showPuppy: false,
            showCart: true,
          ),
          body: Stack(
            children: [
              if (context.isBiggerThanMobile)
                _buildBody(context, puppyViewModel)
              else
                KeyboardActions(
                  config: _buildConfig(context),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 40,
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ).w,
                    child: _buildBody(context, puppyViewModel),
                  ),
                ),
              BottomButton(
                title: 'Save',
                onTap: () {
                  puppyViewModel.callRegisterPuppyApi().then(
                        (value) async => {
                          if (value)
                            {
                              await context
                                  .read<AuthViewModel>()
                                  .callSplash(showLoader: true),
                              Navigator.of(context)
                                ..pop()
                                ..pop(),
                              puppyViewModel.getRouteToPuppyFrom ==
                                      Screens.home.text
                                  ? Navigator.pushNamed(
                                      context, choosePlanRoute)
                                  : puppyViewModel.getRouteToPuppyFrom ==
                                          Screens.shop.text
                                      ? navigateToMonthlyPlans(context: context)
                                      : Navigator.pushNamed(
                                          context,
                                          puppyConfirmationRoute,
                                        ),
                            }
                        },
                      );
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Padding _buildBody(BuildContext context, PuppyViewModel puppyViewModel) {
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
          Center(child: black24w500Centre(data: 'Additional Information')),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: lightBlack14w400Centre(
                data:
                    'In less than a minute, we’ll create a unique meal plan designed to meet your dog’s needs.'),
          ),
          SizedBox(
            height: 30.h,
          ),
          if (context.isBiggerThanMobile)
            Expanded(
              child: Row(
                children: [
                  Expanded(child: _buildLeftSide(puppyViewModel)),
                  VerticalDivider(width: 40.w),
                  Expanded(child: _buildRightSide(puppyViewModel)),
                ],
              ),
            )
          else ...{
            _buildLeftSide(puppyViewModel),
            SizedBox(
              height: 24.h,
            ),
            _buildRightSide(puppyViewModel),
          },
          SizedBox(
            height: 110.h,
          ),
        ],
      ),
    );
  }

  Widget _buildLeftSide(PuppyViewModel puppyViewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          black18w500(
              data:
                  'Which Breed type is ${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'}?'),
          SizedBox(
            height: 8.h,
          ),
          lightBlack14w400Centre(
              data: 'Currently serving 300+ breeds and counting.'),
          SizedBox(
            height: 19.h,
          ),
          TextField(
            controller: puppyViewModel.getPuppyBreedController,
            scrollPadding: const EdgeInsets.only(bottom: 150).w,
            onChanged: (value) {
              puppyViewModel.searchBreeds(value);
            },
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0).w,
              hintText: 'Enter Your Pet\'s Breed',
            ),
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
                            data: puppyViewModel.getBreedslist[index].name!),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Visibility(
            visible: puppyViewModel.getPuppyBreedFieldError.isNotEmpty,
            child: orange14w400(
              data: puppyViewModel.getPuppyBreedFieldError,
            ),
          ),
          SizedBox(
            height: 34.h,
          ),
          black18w500(
              data:
                  'How old is ${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet\'s'}?'),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: context.isBiggerThanMobile
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            spacing: context.isBiggerThanMobile ? 10.w : 0,
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
                    width: 80.w,
                    padding: const EdgeInsets.only(left: 14, right: 14).w,
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
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      //  color: Colors.redAccent,
                    ),
                    offset: const Offset(0, -10),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: WidgetStateProperty.all<double>(6),
                      thumbVisibility: WidgetStateProperty.all<bool>(true),
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
                  items: puppyViewModel.getListOfYear.map((int years) {
                    return DropdownMenuItem<int>(
                      value: years,
                      child: Text(years.toString()),
                    );
                  }).toList(),
                ),
              ),
              lightBlack14w400Centre(data: 'Years'),
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
                    width: 80.w,
                    padding: const EdgeInsets.only(left: 14, right: 14).w,
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
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      //  color: Colors.redAccent,
                    ),
                    offset: const Offset(0, -10),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: WidgetStateProperty.all<double>(6),
                      thumbVisibility: WidgetStateProperty.all<bool>(true),
                    ),
                  ),
                  value: puppyViewModel.getPuppyMonths,
                  onChanged: (newValue) {
                    puppyViewModel.setPuppyMonths(newValue!);
                  },
                  items: puppyViewModel.getListOfMonths.map((int months) {
                    return DropdownMenuItem<int>(
                      value: months,
                      child: Text(months.toString()),
                    );
                  }).toList(),
                ),
              ),
              lightBlack14w400Centre(data: 'Months')
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            children: [
              Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: CustomColors.orangeColor,
                  value: puppyViewModel.getDogIsPuppy,
                  onChanged: (value) {
                    puppyViewModel.setDogIsPuppy(value!);
                  }),
              black18w500(
                  data:
                      '${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'} is still a puppy?'),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: () {
                  descriptionDialog(
                    context: context,
                    height: 300.h,
                    title: 'Puppies',
                    description:
                        'Generally, small breeds are considered puppies until they are 10 months old, medium breeds until 12 months old and large breeds until 16 months old.',
                  );
                },
                child: const Icon(
                  Icons.help,
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          black18w500(
              data:
                  'How Much does ${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'} Weigh?'),
          SizedBox(
            height: 9.h,
          ),
          lightBlack14w400Centre(data: 'Not Sure? Give us your best guess.'),
          SizedBox(
            height: 18.h,
          ),
          lightBlack14w400Centre(data: 'Current Weight'),
          SizedBox(
            height: 12.h,
          ),
          Row(
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
                      thumbVisibility: WidgetStateProperty.all<bool>(true),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightSide(PuppyViewModel puppyViewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              black18w500(
                  data:
                      'Is ${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'}?'),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: () {
                  scalingImageDialog(
                    context: context,
                    height: 600.h,
                    title: 'Check Weight',
                  );
                },
                child: const Icon(
                  Icons.help,
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          // if (context.isBiggerThanMobile)
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     spacing: 10.h,
          //     children: [
          //       customSquareButton(
          //         text: 'Underweight',
          //         onPressed: () {
          //           puppyViewModel
          //               .setPuppyActualWeight(PuppyWeight.underweight.value);
          //         },
          //         colored: puppyViewModel.getPuppyActualWeight ==
          //             PuppyWeight.underweight.value,
          //       ),
          //       customSquareButton(
          //         text: 'Ideal Weight',
          //         onPressed: () {
          //           puppyViewModel
          //               .setPuppyActualWeight(PuppyWeight.idealWeight.value);
          //         },
          //         colored: puppyViewModel.getPuppyActualWeight ==
          //             PuppyWeight.idealWeight.value,
          //       ),
          //       customSquareButton(
          //         text: 'Overweight',
          //         onPressed: () {
          //           puppyViewModel
          //               .setPuppyActualWeight(PuppyWeight.overweight.value);
          //         },
          //         colored: puppyViewModel.getPuppyActualWeight ==
          //             PuppyWeight.overweight.value,
          //       ),
          //     ],
          //   )
          // else
          Row(
            children: [
              Expanded(
                child: customSquareButton(
                  text: 'Underweight',
                  onPressed: () {
                    puppyViewModel
                        .setPuppyActualWeight(PuppyWeight.underweight.value);
                  },
                  colored: puppyViewModel.getPuppyActualWeight ==
                      PuppyWeight.underweight.value,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: customSquareButton(
                  text: 'Ideal Weight',
                  onPressed: () {
                    puppyViewModel
                        .setPuppyActualWeight(PuppyWeight.idealWeight.value);
                  },
                  colored: puppyViewModel.getPuppyActualWeight ==
                      PuppyWeight.idealWeight.value,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: customSquareButton(
                  text: 'Overweight',
                  onPressed: () {
                    puppyViewModel
                        .setPuppyActualWeight(PuppyWeight.overweight.value);
                  },
                  colored: puppyViewModel.getPuppyActualWeight ==
                      PuppyWeight.overweight.value,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          black18w500(
              data:
                  '${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'}\'s Activity Level?'),
          SizedBox(
            height: 24.h,
          ),
          // if (context.isBiggerThanMobile)
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     spacing: 10.h,
          //     children: [
          //       customSquareButton(
          //         text: 'Less Active',
          //         onPressed: () {
          //           puppyViewModel.setPuppyActivityLevel(Puppy.lessActive.text);
          //         },
          //         colored: puppyViewModel.getPuppyActivityLevel ==
          //             Puppy.lessActive.text,
          //       ),
          //       customSquareButton(
          //         text: 'Active',
          //         onPressed: () {
          //           puppyViewModel.setPuppyActivityLevel(Puppy.active.text);
          //         },
          //         colored:
          //             puppyViewModel.getPuppyActivityLevel == Puppy.active.text,
          //       ),
          //       customSquareButton(
          //         text: 'Very Active',
          //         onPressed: () {
          //           puppyViewModel.setPuppyActivityLevel(Puppy.veryActive.text);
          //         },
          //         colored: puppyViewModel.getPuppyActivityLevel ==
          //             Puppy.veryActive.text,
          //       ),
          //     ],
          //   )
          // else
          Row(
            children: [
              Expanded(
                child: customSquareButton(
                  text: 'Less Active',
                  onPressed: () {
                    puppyViewModel.setPuppyActivityLevel(Puppy.lessActive.text);
                  },
                  colored: puppyViewModel.getPuppyActivityLevel ==
                      Puppy.lessActive.text,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: customSquareButton(
                  text: 'Active',
                  onPressed: () {
                    puppyViewModel.setPuppyActivityLevel(Puppy.active.text);
                  },
                  colored:
                      puppyViewModel.getPuppyActivityLevel == Puppy.active.text,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: customSquareButton(
                  text: 'Very Active',
                  onPressed: () {
                    puppyViewModel.setPuppyActivityLevel(Puppy.veryActive.text);
                  },
                  colored: puppyViewModel.getPuppyActivityLevel ==
                      Puppy.veryActive.text,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          black18w500(
              data:
                  'How many times a day do you feed ${puppyViewModel.getPuppyNameController.text.isNotEmpty ? puppyViewModel.getPuppyNameController.text : 'Pet'}?'),
          SizedBox(
            height: 24.h,
          ),
          // if (context.isBiggerThanMobile)
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     spacing: 10.h,
          //     children: List.generate(
          //       5,
          //       (index) => customSquareButton(
          //         text: '${index + 1}',
          //         onPressed: () {
          //           puppyViewModel.setFeedingRoutine(index + 1);
          //         },
          //         colored: puppyViewModel.getFeedingRoutine == (index + 1),
          //       ),
          //     ),
          //   )
          // else
          Row(
            spacing: 10.w,
            children: List.generate(
              5,
              (index) => Expanded(
                child: customSquareButton(
                  text: '${index + 1}',
                  onPressed: () {
                    puppyViewModel.setFeedingRoutine(index + 1);
                  },
                  colored: puppyViewModel.getFeedingRoutine == (index + 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
