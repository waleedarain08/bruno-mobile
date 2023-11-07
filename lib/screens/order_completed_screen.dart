import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../view_models/order_view_model.dart';
import '../widgets/orders_vertical_list_chip_widget.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(builder: (_, orderViewModel, __) {
      return ListView.builder(
        itemCount: orderViewModel.getCompletedOrders.length,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        itemBuilder: (BuildContext context, int index) {
          return ordersVerticalListChipWidget(
              showButtons: false,
              orderListData: orderViewModel.getCompletedOrders[index]);
        },
      );
    });
  }
}
