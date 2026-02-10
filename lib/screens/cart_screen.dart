import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/enums.dart';
import '../utils/widget_utils.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/labeled_bottom_button.dart';
import '../widgets/listChips/cart_vertical_list_chip_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPop() {
    context.read<CartViewModel>().setSelectedIndex(null);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, cartViewModel, child) {
      return SafeArea(
        child: CustomScaffold(
          appBar: const AppBarWithBackWidget(
            heading: 'Shopping Bag',
            showPuppy: false,
            showCart: false,
          ),
          body: Center(
            child: _buildItems(
              context,
              cartViewModel,
            ),
          ),
        ),
      );
    });
  }

  RenderObjectWidget _buildItems(
    BuildContext context,
    CartViewModel cartViewModel,
  ) {
    if (cartViewModel.getCartList.isEmpty) {
      return Center(
        child: black24w500Centre(data: 'Shopping Bag is Empty'),
      );
    }
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: context.isBiggerThanMobile
                ? MediaQuery.widthOf(context) * 0.5
                : null,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cartViewModel.getCartList.length,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 200,
              ).w,
              itemBuilder: (BuildContext context, int index) {
                return cartVerticalListChipWidget(
                  cartDetail: cartViewModel.getCartList[index],
                  itemIndex: index,
                );
              },
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Container(
        //     width: doub,
        //     decoration: const BoxDecoration(
        //       color: CustomColors.whiteColor,
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(30.0),
        //         topRight: Radius.circular(30.0),
        //       ),
        //       boxShadow: [
        //         BoxShadow(
        //           offset: Offset(0, 0),
        //           blurRadius: 5,
        //           spreadRadius: 2,
        //           color: Colors.black12,
        //         ),
        //       ],
        //     ),
        //     child: Container(
        //       width: context.isBiggerThanMobile ? 0.2.sw : null,
        //       padding: const EdgeInsets.all(20).w,
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           orange14w500(
        //               data:
        //                   'Total Amount: AED ${cartViewModel.getCartTotalPrice.toStringAsFixed(2)}'),
        //           SizedBox(
        //             height: 10.h,
        //           ),
        //           customButton(
        //               text: 'Next',
        //               onPressed: () {
        //                 if (!context
        //                     .read<AuthViewModel>()
        //                     .getAuthResponse
        //                     .data!
        //                     .isGuest!) {
        //                   Navigator.pushNamed(context, checkOutRoute);
        //                 } else {
        //                   context.read<AuthViewModel>().clearFieldsData();
        //                   context
        //                       .read<AuthViewModel>()
        //                       .setRegisterRouteFrom(Screens.cart.text);
        //                   Navigator.pushNamed(context, registerUserRoute);
        //                 }
        //               },
        //               colored: true),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        LabeledBottomButton(
          label: Column(
            children: [
              orange14w500(
                  data:
                      'Total Amount: AED ${cartViewModel.getCartTotalPrice.toStringAsFixed(2)}'),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
          buttonText: 'Next',
          onTap: () {
            if (!context.read<AuthViewModel>().getAuthResponse.data!.isGuest!) {
              Navigator.pushNamed(context, checkOutRoute);
            } else {
              context.read<AuthViewModel>().clearFieldsData();
              context
                  .read<AuthViewModel>()
                  .setRegisterRouteFrom(Screens.cart.text);
              Navigator.pushNamed(context, registerUserRoute);
            }
          },
        ),
      ],
    );
  }
}
