import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/view_models/address_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/custom_colors.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/dialogs/delete_address_confirmation_dialog.dart';

class AddressDetailScreen extends StatelessWidget {
  const AddressDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressViewModel>(builder: (_, addressViewModel, __) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBarWithBackWidget(
            heading: toBeginningOfSentenceCase('Address Detail'),
            showPuppy: false,
            showCart: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: addressViewModel.getEditAddress.isDefault!,
                        child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: CustomColors.orangeColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2).w,
                              child: white12w400(data: 'Default'),
                            )),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              deleteAddressConfirmationDialog(context: context);
                            },
                            child: Container(
                              decoration: ShapeDecoration(
                                //color: CustomColors.orangeColor,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.75,
                                      color: CustomColors.orangeColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child:  Padding(
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        //liteModeEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        mapType: MapType.terrain,
                        onCameraMove: (position) {
                          addressViewModel.setInitialCameraPosition(LatLng(
                              position.target.latitude,
                              position.target.longitude));
                        },
                        onCameraIdle: () {
                          addressViewModel.getMapMovement();
                        },
                        initialCameraPosition: CameraPosition(
                            target: addressViewModel.getInitialCameraPosition),
                        markers: <Marker>{
                          Marker(
                            /* onDragEnd: ((newPosition) {
                              addressViewModel.updateMapCameraPosition(LatLng(
                                  newPosition.latitude, newPosition.longitude));
                            }),*/
                            //draggable: false,
                            markerId: const MarkerId("1"),
                            position: LatLng(
                                double.parse(addressViewModel
                                    .getEditAddress.coordinates![0]),
                                double.parse(addressViewModel
                                    .getEditAddress.coordinates![1])),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueOrange),
                            infoWindow: const InfoWindow(
                              title: '',
                            ),
                          )
                        },
                        onMapCreated: addressViewModel.getUserLocation,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !addressViewModel.getEditAddress.isDefault!,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            black16w500(data: 'Set As Default'),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                activeTrackColor: CustomColors.orangeColor,
                                value: addressViewModel.getEditAddress.isDefault!,
                                onChanged: (isDefault) {
                                  addressViewModel
                                      .callDefaultAddressApi()
                                      .then((value) async => {
                                            if (value)
                                              {
                                                addressViewModel
                                                    .setIsDefaultAddressTrueFalse(
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
                      black14w500(data: 'Address:'),
                      SizedBox(
                        width: 40.w,
                      ),
                      Flexible(
                          child: black14w500(
                              data: toBeginningOfSentenceCase(
                                  addressViewModel.getEditAddress.address)!))
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
                      black14w500(data: 'Street:'),
                      SizedBox(
                        width: 40.w,
                      ),
                      Flexible(
                        child: black14w500(
                            data:
                                addressViewModel.getEditAddress.street!.isNotEmpty
                                    ? toBeginningOfSentenceCase(
                                        addressViewModel.getEditAddress.street)!
                                    : 'N/A'),
                      )
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
                      black14w500(data: 'Area:'),
                      SizedBox(
                        width: 40.w,
                      ),
                      Flexible(
                        child: black14w500(
                            data: addressViewModel.getEditAddress.area!.isNotEmpty
                                ? toBeginningOfSentenceCase(
                                    addressViewModel.getEditAddress.area)!
                                : 'N/A'),
                      )
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
                      black14w500(data: 'Floor:'),
                      SizedBox(
                        width: 40.w,
                      ),
                      Flexible(
                        child: black14w500(
                            data:
                                addressViewModel.getEditAddress.floor!.isNotEmpty
                                    ? toBeginningOfSentenceCase(
                                        addressViewModel.getEditAddress.floor)!
                                    : 'N/A'),
                      )
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
                      black14w500(data: 'Building Name/Number:'),
                      SizedBox(
                        width: 40.w,
                      ),
                      Flexible(
                        child: black14w500(
                            data: addressViewModel
                                    .getEditAddress.flatHouseNumber!.isNotEmpty
                                ? toBeginningOfSentenceCase(addressViewModel
                                    .getEditAddress.flatHouseNumber)!
                                : 'N/A'),
                      )
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
                      black14w500(data: 'Label'),
                      black14w500(data: addressViewModel.getEditAddress.label!)
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
                      black14w500(data: 'Contact Name'),
                      black14w500(
                          data: addressViewModel
                                  .getEditAddress.contactName!.isNotEmpty ||
                          addressViewModel
                              .getEditAddress.contactName == null
                              ? addressViewModel.getEditAddress.contactName!
                              : 'N/A')
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
                      black14w500(data: 'Contact Number'),
                      black14w500(
                          data: addressViewModel
                              .getEditAddress.contactNumber!.isNotEmpty ||
                          addressViewModel
                              .getEditAddress.contactNumber == null
                              ? addressViewModel.getEditAddress.contactNumber!
                              : 'N/A')
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
                      black14w500(data: 'Delivery Instructions:'),
                      SizedBox(
                        width: 40.w,
                      ),
                      Flexible(
                          child: black14w500(
                              data: addressViewModel.getEditAddress
                                      .deliveryInstruction!.isNotEmpty
                                  ? toBeginningOfSentenceCase(addressViewModel
                                      .getEditAddress.deliveryInstruction)!
                                  : 'N/A'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
