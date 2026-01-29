// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/screens/home_screen.dart';
import 'package:brunos_kitchen/screens/profile_screen.dart';
import 'package:brunos_kitchen/screens/shop_screen.dart';
import 'package:brunos_kitchen/view_models/plans_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../utils/enums.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  int _homeViewIndex = kIsWeb ? 1 : 0;

  Widget getHomeView(int index) {
    Widget _widget = Container();
    if (index == 0) {
      _widget = const HomeScreen();
    } else if (index == 1) {
      _widget = const ShopScreen();
    } else if (index == 2) {
      _widget = const ProfileScreen();
    }
    return _widget;
  }

  int get getHomeViewIndex => _homeViewIndex;

  void setHomeViewIndex(int value) {
    _homeViewIndex = value;
    if (_homeViewIndex == 1) {
      navigatorKey.currentContext!
          .read<PlansViewModel>()
          .setPlanType(Plans.product.text);
    }
    notifyListeners();
  }
}
