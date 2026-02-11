import 'package:brunos_kitchen/utils/custom_colors.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../utils/custom_font_style.dart';
import '../view_models/address_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/listChips/address_vertical_list_chip_widget.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AddressViewModel>().callAllAddressApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressViewModel>(
        builder: (context, addressViewModel, child) {
      return SafeArea(
        child: CustomScaffold(
          appBar: const AppBarWithBackWidget(
              heading: 'Address', showPuppy: false, showCart: true),
          floatingActionButton: FloatingActionButton(
            backgroundColor: CustomColors.orangeColor,
            onPressed: () {
              addressViewModel.setIsAddressAdd(true);
              Navigator.pushNamed(context, addAddressRoute);
            },
            child: const Icon(Icons.add),
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: context.webSize,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                    child: black18w500(data: 'Select Address'),
                  ),
                  addressViewModel.getAllAddressResponse.data != null
                      ? Expanded(
                          child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            itemCount: addressViewModel
                                .getAllAddressResponse.data!.length,
                            padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 40)
                                .w,
                            itemBuilder: (BuildContext context, int index) {
                              return addressVerticalListChipWidget(
                                  addressDetail: addressViewModel
                                      .getAllAddressResponse.data![index]);
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
