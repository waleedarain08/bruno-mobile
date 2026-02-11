import 'package:brunos_kitchen/view_models/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../utils/custom_font_style.dart';
import '../utils/widget_utils.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/listChips/orders_vertical_list_chip_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderViewModel>().callOrderListApi();
    });

    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(_getActiveTabIndex);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  void _getActiveTabIndex() {
    setState(() {
      _selectedIndex = tabController!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(builder: (_, orderViewModel, __) {
      return SafeArea(
        child: CustomScaffold(
          appBar: const AppBarWithBackWidget(
              heading: 'My Orders', showPuppy: false, showCart: false),
          body: orderViewModel.getOrderResponse!.data?.isEmpty ?? false
              ? Center(
                  child: black24w500Centre(data: 'No orders yet'),
                )
              : Center(
                  child: SizedBox(
                    width: context.webSize,
                    child: ListView.builder(
                      itemCount: orderViewModel.getOrderResponse!.data!.length,
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 30).w,
                      itemBuilder: (BuildContext context, int index) {
                        return ordersVerticalListChipWidget(
                            showButtons: false,
                            orderListData:
                                orderViewModel.getOrderResponse!.data![index]);
                      },
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
