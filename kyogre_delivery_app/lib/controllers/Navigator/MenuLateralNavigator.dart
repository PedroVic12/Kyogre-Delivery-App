import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO -> Navigator Getx
// TODO -> Backend and database Usage

class ItemMenuLateral {
  final String title;
  final IconData icon;
  final String route;

  ItemMenuLateral({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class MenuLateralController {
  var selectedIndex = 0;

  void selectMenu(int index) {
    selectedIndex = index;
  }
}

class MenuLateralNavegacaoDash extends StatelessWidget {
  final MenuLateralController _controller = MenuLateralController();

  final List<ItemMenuLateral> _menuItems = [
    ItemMenuLateral(title: 'Página 1', icon: Icons.home, route: '/'),

    ItemMenuLateral(
        title: 'Excel Database Cardapio', icon: Icons.home, route: '/database'),

    ItemMenuLateral(
        title: 'DashBoard Page',
        icon: Icons.account_balance_wallet_sharp,
        route: '/dash'),

    ItemMenuLateral(
        title: 'Splash',
        icon: CupertinoIcons.moon_stars_fill,
        route: '/splash'),
    ItemMenuLateral(
        title: 'NEW Cardapio Digital ROBO',
        icon: CupertinoIcons.shopping_cart,
        route: '/pedido/:id'),
    ItemMenuLateral(
        title: 'Google Maps Pedido',
        icon: Icons.location_on_rounded,
        route: '/mapaPedido'),
    ItemMenuLateral(
        title: 'Cardapio Digital QR',
        icon: Icons.fastfood_rounded,
        route: '/cardapioQR'),
    ItemMenuLateral(
        title: 'Tela de Cadastro',
        icon: Icons.fastfood_rounded,
        route: '/authScreen'),
    ItemMenuLateral(
        title: 'Atendimento ao Cliente',
        icon: Icons.screenshot_monitor_sharp,
        route: '/atendimento'),

    //ItemMenuLateral( title: 'Grid Style', icon: Icons.abc_outlined, route: '/layoutDesign'),
    //ItemMenuLateral(title: 'Caos Page', icon: Icons.ac_unit_sharp, route: '/caosPage')
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: ListView.builder(
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = _menuItems[index];

          return ListTile(
            leading: Icon(
              menuItem.icon,
              color: _controller.selectedIndex == index
                  ? Colors.white
                  : Colors.grey,
            ),
            title: Text(
              menuItem.title,
              style: TextStyle(
                color: _controller.selectedIndex == index
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
            onTap: () {
              _controller.selectMenu(index);
              //Get.toNamed(menuItem.route);
            },
          );
        },
      ),
    );
  }
}
