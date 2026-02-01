import 'package:brunos_kitchen/utils/custom_font_style.dart';
import 'package:brunos_kitchen/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../models/recipe_model.dart';
import '../route_generator.dart';
import '../utils/calculations.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/enums.dart';
import '../view_models/cart_view_model.dart';
import '../view_models/plans_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/carousels/product_carousel_widget.dart';
import '../widgets/dialogs/discription_dialog.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool addStandardRecipe = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansViewModel>(builder: (context, plansViewModel, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBarWithBackWidget(
            heading: toBeginningOfSentenceCase(
                '${plansViewModel.getSelectedRecipe.name}'),
            showPuppy: false,
            showCart: context.read<CartViewModel>().getSelectedIndex == null,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0).w,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (context.isBiggerThanMobile)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 0.15.sw),
                            SizedBox(
                              width: 430.w,
                              height: 400.h,
                              child: ProductCarouselWidget(
                                productImages: plansViewModel.getProductImages,
                              ),
                            ),
                            Expanded(
                              child: _buildProductDetails(plansViewModel),
                            ),
                            SizedBox(width: 0.15.sw),
                          ],
                        )
                      else ...{
                        SizedBox(
                          height: 300.h,
                          child: ProductCarouselWidget(
                            productImages: plansViewModel.getProductImages,
                          ),
                        ),
                        _buildProductDetails(plansViewModel),
                      },
                      SizedBox(
                        height: 24.h,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20).w,
                        child: Html(
                            // lineHeight: true,
                            data:
                                plansViewModel.getSelectedRecipe.description!),
                      ),
                      SizedBox(
                        height: 120.h,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      context.read<CartViewModel>().getViewCartItemDetail ==
                          false,
                  child: Align(
                    alignment: context.isBiggerThanMobile
                        ? Alignment.centerRight
                        : Alignment.center,
                    child: Container(
                      width: context.isBiggerThanMobile ? 0.35.sw : null,
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20).w,
                        child: InkWell(
                          onTap: () {
                            if (context
                                    .read<CartViewModel>()
                                    .getSelectedIndex ==
                                null) {
                              if (context
                                  .read<CartViewModel>()
                                  .checkProductValidation(
                                      recipe:
                                          plansViewModel.getSelectedRecipe)) {
                                final List<RecipeModel> recipeList = [];
                                plansViewModel.setProductModel();
                                recipeList
                                    .add(plansViewModel.getSelectedRecipe);
                                final num planTotalPrice =
                                    calculatePlanTotal(listOfItems: recipeList);
                                final int planTotalWeight =
                                    calculateProductWeightTotal(
                                        listOfItems: recipeList);
                                context.read<CartViewModel>().addToCartList(
                                      CartModel(
                                          recipes: recipeList,
                                          pet: null,
                                          /*
                                      deliveryDate: '03 Oct 2023',
                            */
                                          planType: plansViewModel.getPlanType,
                                          planTotal: planTotalPrice,
                                          pouchesDetail: [],
                                          totalWeight: [planTotalWeight],
                                          planDiscountedPrice: planTotalPrice,
                                          planDiscountPer: 0),
                                    );

                                Navigator.pushNamedAndRemoveUntil(context,
                                    bottomNavigationRoute, (route) => false);

                                /* EasyLoading.showToast(
                                    '${plansViewModel.getPlanType} Successfully Added To\nShopping Bag',
                                    toastPosition: EasyLoadingToastPosition.center);*/
                              } else {
                                Navigator.pushNamed(context, cartRoute);
                                descriptionDialog(
                                    context: context,
                                    description:
                                        '${plansViewModel.getSelectedRecipe.name} is already added to shopping bag',
                                    height: 180.h,
                                    title: 'Alert');
                              }
                            } else {
                              final List<RecipeModel> recipeList = [];
                              plansViewModel.setProductModel();
                              recipeList.add(plansViewModel.getSelectedRecipe);
                              final num planTotalPrice =
                                  calculatePlanTotal(listOfItems: recipeList);
                              final int planTotalWeight =
                                  calculateProductWeightTotal(
                                      listOfItems: recipeList);
                              context.read<CartViewModel>().addToCartList(
                                    CartModel(
                                        recipes: recipeList,
                                        pet: null,
                                        /*
                                    deliveryDate: '03 Oct 2023',
                            */
                                        planType: plansViewModel.getPlanType,
                                        planTotal: planTotalPrice,
                                        pouchesDetail: [],
                                        totalWeight: [planTotalWeight],
                                        planDiscountedPrice: planTotalPrice,
                                        planDiscountPer: 0),
                                  );
                              Navigator.pushNamedAndRemoveUntil(context,
                                  cartRoute, (Route route) => route.isFirst);
                            }
                            // }
                          },
                          child: Container(
                              height: 120.h,
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                color: CustomColors.orangeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15)
                                    .w,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        white18w500(
                                            data:
                                                'AED ${(plansViewModel.getSelectedRecipe.pricePerKG! * plansViewModel.getQuantity).toStringAsFixed(2)}'),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        whiteTint14w400(data: 'Total Price')
                                      ],
                                    ),
                                    const Spacer(),
                                    white18w500(data: 'Add to shopping bag')
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProductDetails(PlansViewModel plansViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.h,
        ),
        Visibility(
          visible: plansViewModel.getSelectedRecipe.details!.isNotEmpty ||
              plansViewModel.getSelectedRecipe.weight != 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: plansViewModel.getSelectedRecipe.details!.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      black14w500(data: 'Brand'),
                      SizedBox(
                        height: 10.h,
                      ),
                      black24w500Centre(
                          data: plansViewModel.getSelectedRecipe.details!)
                    ],
                  ),
                ),
                Visibility(
                  visible: plansViewModel.getSelectedRecipe.weight != 0,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24.h,
                      ),
                      black24w500Centre(
                          data:
                              '${plansViewModel.getSelectedRecipe.weight!.toString()} ${plansViewModel.getSelectedRecipe.unit}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // if (context.isBiggerThanMobile)
        //   Spacer()
        // else
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  black14w500(
                      data: plansViewModel.getSelectedRecipe.category ==
                              ProductCategories.standardRecipes.text
                          ? 'Pouch Price'
                          : 'Unit Price'),
                  SizedBox(
                    height: 15.h,
                  ),
                  black24w500Centre(
                      data:
                          'AED ${plansViewModel.getSelectedRecipe.pricePerKG!.toStringAsFixed(2)}')
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  black14w500(data: 'Quantity'),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: context
                                .read<CartViewModel>()
                                .getViewCartItemDetail ==
                            false,
                        child: InkWell(
                          onTap: () {
                            plansViewModel.minusQuantity();
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              color: CustomColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.75,
                                    color: CustomColors.greyMediumColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10).w,
                              child: const Icon(
                                Icons.remove,
                                size: 20,
                                color: CustomColors.greyColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Center(
                          child: black18w500(
                            data: plansViewModel.getQuantity.toString(),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: context
                                .read<CartViewModel>()
                                .getViewCartItemDetail ==
                            false,
                        child: InkWell(
                          onTap: () {
                            plansViewModel.addQuantity();
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              color: CustomColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.75,
                                    color: CustomColors.greyMediumColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10).w,
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: CustomColors.greyColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        if (plansViewModel.getSelectedRecipe.selectedItemSize != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                context.read<CartViewModel>().getViewCartItemDetail
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          black14w500(data: 'Size'),
                          SizedBox(
                            height: 20.h,
                          ),
                          black18w500(
                            data: plansViewModel
                                .getSelectedRecipe.selectedItemSize!.name!,
                          )
                        ],
                      )
                    : Visibility(
                        visible: context
                                .read<CartViewModel>()
                                .getViewCartItemDetail ==
                            false,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0).w,
                          child: black14w500(
                            data: 'Select Option',
                          ),
                        ),
                      ),
                Visibility(
                  visible:
                      context.read<CartViewModel>().getViewCartItemDetail ==
                          false,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      for (var sizes in plansViewModel.getSelectedRecipe.sizes!)
                        Visibility(
                          visible: sizes.stock != 0,
                          child: SizedBox(
                            width: context.isBiggerThanMobile ? null : 100.w,
                            child: customSquareButton(
                              text: '${sizes.name}',
                              onPressed: () {
                                plansViewModel.setSelectedItemSize(sizes);
                              },
                              colored: plansViewModel
                                          .getSelectedRecipe.selectedItemSize ==
                                      sizes
                                  ? true
                                  : false,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
