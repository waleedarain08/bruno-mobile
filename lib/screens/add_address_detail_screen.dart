import 'package:brunos_kitchen/utils/custom_colors.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../utils/custom_buttons.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
import '../view_models/address_view_model.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/dialogs/address_label_dialog.dart';

class AddAddressDetailScreen extends StatefulWidget {
  const AddAddressDetailScreen({super.key});

  @override
  State<AddAddressDetailScreen> createState() => _AddAddressDetailScreenState();
}

class _AddAddressDetailScreenState extends State<AddAddressDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AddressViewModel>().setUserNameNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressViewModel>(
        builder: (context, addressViewModel, child) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                          top: 30, bottom: 120, left: 20, right: 20)
                      .w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BackButtonWidget(),
                      SizedBox(
                        height: 26.h,
                      ),
                      Center(child: black24w500Centre(data: 'Add Address')),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: lightBlack14w400Centre(
                            data: 'Add you address details below'),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      TextField(
                        enabled: false,
                        controller: addressViewModel.getAddressController,
                        onChanged: (text) {},
                        //keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(16).w,
                          //hintText: 'Address',
                          prefixIcon: SvgPicture.asset(mapPin,
                              height: 5, width: 5, fit: BoxFit.scaleDown),
                        ),
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller:
                                  addressViewModel.getFlatHouseNumberController,
                              onChanged: (text) {},
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0).w,
                                hintText: 'Flat/House No#',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 18.w,
                          ),
                          Expanded(
                            child: TextField(
                              controller: addressViewModel.getStreetController,
                              onChanged: (text) {},
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0).w,
                                hintText: 'Street',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: addressViewModel.getAreaController,
                              onChanged: (text) {},
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0).w,
                                hintText: 'Area',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 18.w,
                          ),
                          Expanded(
                            child: TextField(
                              controller: addressViewModel.getFloorController,
                              onChanged: (text) {},
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0).w,
                                hintText: 'Floor/Unit#',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      black14w500(data: 'Delivery Instructions'),
                      SizedBox(
                        height: 5.h,
                      ),
                      grey12w500(
                          data: 'Give us more information about your address'),
                      SizedBox(
                        height: 19.h,
                      ),
                      TextField(
                        controller:
                            addressViewModel.getDeliveryInstructionController,
                        keyboardType: TextInputType.multiline,
                        maxLength: 300,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20).w,
                          hintText: 'Note to rider - eg. landmark',
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9a-zA-Z]")),
                        ],
                        controller: addressViewModel.getContactNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20.0).w,
                          hintText: 'Contact Person Name ',
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        controller: addressViewModel.getContactNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20.0).w,
                          hintText: 'Contact person number ',
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          black14w500(data: 'Set default address'),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeTrackColor: CustomColors.orangeColor,
                              value: addressViewModel.getIsDefault,
                              onChanged: (value) {
                                addressViewModel.setIsDefault(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      black18w500(data: 'Add Label'),
                      SizedBox(
                        height: 23.h,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              //   addressViewModel.callLocation(context);
                              addressViewModel
                                  .setSelectedLabel(AddressLabels.home.text);
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: addressViewModel.getSelectedLabel ==
                                            AddressLabels.home.text
                                        ? CustomColors.orangeColor
                                        : CustomColors.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color:
                                            addressViewModel.getSelectedLabel ==
                                                    AddressLabels.home.text
                                                ? CustomColors.orangeColor
                                                : CustomColors.lightGreyColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10).w,
                                    child: SvgPicture.asset(
                                      homeAddressIcon,
                                      width: 24.w,
                                      color:
                                          addressViewModel.getSelectedLabel ==
                                                  AddressLabels.home.text
                                              ? CustomColors.whiteColor
                                              : CustomColors.orangeColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                addressViewModel.getSelectedLabel ==
                                        AddressLabels.home.text
                                    ? orange14w400(data: 'Home')
                                    : lightBlack14w400Centre(data: 'Home'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          InkWell(
                            onTap: () {
                              //   addressViewModel.callLocation(context);
                              addressViewModel
                                  .setSelectedLabel(AddressLabels.work.text);
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: addressViewModel.getSelectedLabel ==
                                            AddressLabels.work.text
                                        ? CustomColors.orangeColor
                                        : CustomColors.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color:
                                            addressViewModel.getSelectedLabel ==
                                                    AddressLabels.work.text
                                                ? CustomColors.orangeColor
                                                : CustomColors.lightGreyColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10).w,
                                    child: SvgPicture.asset(
                                      workAddressIcon,
                                      width: 24.w,
                                      color:
                                          addressViewModel.getSelectedLabel ==
                                                  AddressLabels.work.text
                                              ? CustomColors.whiteColor
                                              : CustomColors.orangeColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                addressViewModel.getSelectedLabel ==
                                        AddressLabels.work.text
                                    ? orange14w400(data: 'Work')
                                    : lightBlack14w400Centre(data: 'Work'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          InkWell(
                            onTap: () {
                              //   addressViewModel.callLocation(context);
                              addressViewModel
                                  .setSelectedLabel(AddressLabels.partner.text);
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: addressViewModel.getSelectedLabel ==
                                            AddressLabels.partner.text
                                        ? CustomColors.orangeColor
                                        : CustomColors.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color:
                                            addressViewModel.getSelectedLabel ==
                                                    AddressLabels.partner.text
                                                ? CustomColors.orangeColor
                                                : CustomColors.lightGreyColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10).w,
                                    child: SvgPicture.asset(
                                      partnerAddressIcon,
                                      width: 24.w,
                                      color:
                                          addressViewModel.getSelectedLabel ==
                                                  AddressLabels.partner.text
                                              ? CustomColors.whiteColor
                                              : CustomColors.orangeColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                addressViewModel.getSelectedLabel ==
                                        AddressLabels.partner.text
                                    ? orange14w400(data: 'Partner')
                                    : lightBlack14w400Centre(data: 'Partner'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          InkWell(
                            onTap: () {
                              //   addressViewModel.callLocation(context);
                              addressLabelDialog(context: context);
                              addressViewModel
                                  .setSelectedLabel(AddressLabels.other.text);
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: addressViewModel.getSelectedLabel ==
                                            AddressLabels.other.text
                                        ? CustomColors.orangeColor
                                        : CustomColors.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color:
                                            addressViewModel.getSelectedLabel ==
                                                    AddressLabels.other.text
                                                ? CustomColors.orangeColor
                                                : CustomColors.lightGreyColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10).w,
                                    child: SvgPicture.asset(
                                      otherAddressIcon,
                                      width: 24.w,
                                      color:
                                          addressViewModel.getSelectedLabel ==
                                                  AddressLabels.other.text
                                              ? CustomColors.whiteColor
                                              : CustomColors.orangeColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                addressViewModel.getSelectedLabel ==
                                        AddressLabels.other.text
                                    ? orange14w400(
                                        data: addressViewModel.getOtherLabel)
                                    : lightBlack14w400Centre(
                                        data: addressViewModel.getOtherLabel),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                      padding: const EdgeInsets.all(20.0).w,
                      child: customButton(
                          text: 'Add',
                          onPressed: () async {
                            await addressViewModel
                                .callCreateAddressApi()
                                .then((value) {
                              context
                                  .read<AuthViewModel>()
                                  .callSplash(showLoader: true);
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                              /*
                                      if (value) {
                                        context
                                            .read<AuthViewModel>()
                                            .setSelectedAddress(addressViewModel
                                                .getAllAddressResponse
                                                .data!
                                                .defaultAddress!);
                                      }
          */
                            });
                            /*Navigator.pushNamedAndRemoveUntil(
                              context,
                              bottomNavigationRoute,
                              ModalRoute.withName(splashRoute));*/
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
