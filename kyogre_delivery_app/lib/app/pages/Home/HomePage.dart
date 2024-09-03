import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/app/pages/DashBoard/DashboardTemplate.dart';
import 'package:kyogre_delivery_app/controllers/Navigator/CapitaoNavigator.dart';

class HomePage extends StatelessWidget {
  final Function(bool) onThemeChange;

  const HomePage({Key? key, required this.onThemeChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                NavigationManager.navigateTo(context, '/dash');
              },
            ),
            ListTile(
              title: Text('Cardápio Manager'),
              onTap: () {
                NavigationManager.navigateTo(context, '/CardapioManager');
              },
            ),
            ListTile(
              title: Text('Switch Theme'),
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (bool value) {
                  onThemeChange(value);
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: NavigationManager.textNavigate(
          context,
          DashboardTemplate(), // Exemplo de página que você pode navegar
          'Ir para Dashboard',
        ),
      ),
    );
  }
}
