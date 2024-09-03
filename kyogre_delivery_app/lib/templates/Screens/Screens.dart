import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/controllers/Navigator/MenuLateralNavigator.dart';
import 'package:kyogre_delivery_app/templates/Screens/OverViewCards/OverViewCardLarge.dart';
import 'package:kyogre_delivery_app/templates/Screens/OverViewCards/OverViewCardSmall.dart';
import 'package:kyogre_delivery_app/widgets/NightWolfAppBar.dart';

class LargePage extends StatelessWidget {
  LargePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NightWolfAppBar(
          drawerKey: _drawerKey,
        ),
        drawer: Drawer(
          key: _drawerKey,
          // Adicione os itens do menu lateral aqui
        ),
        body: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: MenuLateralNavegacaoDash()),
              Expanded(
                  flex: 4,
                  child: Container(
                    child: OverViewCardsLarge(),
                    constraints: BoxConstraints.expand(),
                    color: CupertinoColors.systemYellow,
                  )),
            ],
          ),
        ));
  }
}

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: MenuLateralNavegacaoDash()),
        Expanded(
            flex: 4,
            child: Container(
              child: OverViewCardsLarge(),
              constraints: BoxConstraints.expand(),
              color: CupertinoColors.activeOrange,
            )),
      ],
    );
  }
}

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.activeGreen,
      constraints: BoxConstraints.expand(),
      child: OverViewCardsSmallScreen(),
    );
  }
}
