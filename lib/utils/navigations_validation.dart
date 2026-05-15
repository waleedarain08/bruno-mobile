import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../route_generator.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/cart_view_model.dart';
import '../view_models/plans_view_model.dart';
import '../widgets/dialogs/discription_dialog.dart';
import 'enums.dart';

navigateToMonthlyPlans({required BuildContext context}) {
  if (context
      .read<CartViewModel>()
      .checkCartForPlanValidation(planType: Plans.monthly.text)) {
    context.read<PlansViewModel>().setPlanType(Plans.monthly);
    context.read<PlansViewModel>().clearPlanData();
    Navigator.pushNamed(context, monthlyPlanRoute);
  } else {
    Navigator.pushNamed(context, cartRoute);
    descriptionDialog(
        context: context,
        description:
            'To add new plan for ${context.read<AuthViewModel>().getAuthResponse.data!.pet!.name} you have to remove current ${context.read<AuthViewModel>().getAuthResponse.data!.pet!.name} plan from shopping bag',
        height: 180.h,
        title: 'New Plan Creation');
  }
}
