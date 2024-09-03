import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/controllers/Navigator/menu_controller.dart';
import 'package:kyogre_delivery_app/templates/Screens/OverViewCards/OverViewCardLarge.dart';
import 'package:kyogre_delivery_app/templates/Screens/OverViewCards/OverViewCardMedium.dart';
import 'package:kyogre_delivery_app/templates/Screens/OverViewCards/OverViewCardSmall.dart';
import 'package:kyogre_delivery_app/templates/responsividade/ResponsiveWidget.dart';
import 'package:kyogre_delivery_app/widgets/CustomText.dart';

// TODO -> 1:51

class OverViewPage extends StatelessWidget {
  const OverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: CustomText(
                text: MenuControler.activeItem,
                size: 20,
                weight: FontWeight.bold,
              ),
            )
          ],
        ),
        Expanded(
            child: ListView(
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomSize(context))
                OverviewCardsMediumScreen()
              else
                OverViewCardsLarge()
            else
              OverViewCardsSmallScreen()
          ],
        ))
      ],
    );
  }
}
