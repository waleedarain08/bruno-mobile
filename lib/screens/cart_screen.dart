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
          alignment: Alignment.topLeft,
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
        if (context.isBiggerThanMobile)
          Positioned.fill(
            left: 0.5.sw + 20.w,
            right: 20.w,
            top: 20.w,
            bottom: 0,
            child: _buildBottomButton(context, cartViewModel),
          )
        else
          _buildBottomButton(context, cartViewModel),
      ],
    );
  }

  LabeledBottomButton _buildBottomButton(
    BuildContext context,
    CartViewModel cartViewModel,
  ) {
    return LabeledBottomButton(
      height: context.isBiggerThanMobile ? double.infinity : null,
      label: Expanded(
        flex: context.isBiggerThanMobile ? 1 : 0,
        child: Column(
          children: [
            orange14w500(
                data:
                    'Total Amount: AED ${cartViewModel.getCartTotalPrice.toStringAsFixed(2)}'),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
      buttonText: 'Next',
      onTap: () {
        if (!context.read<AuthViewModel>().getAuthResponse.data!.isGuest!) {
          Navigator.pushNamed(context, checkOutRoute);
        } else {
          context.read<AuthViewModel>().clearFieldsData();
          context.read<AuthViewModel>().setRegisterRouteFrom(Screens.cart.text);
          Navigator.pushNamed(context, registerUserRoute);
        }
      },
    );
  }
}
