import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/app/design/CardPedido.dart';
import 'package:kyogre_delivery_app/app/design/InfoCardSmall.dart';

class OverViewCardsSmallScreen extends StatelessWidget {
  const OverViewCardsSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
              title: 'Em processo', value: '7', isActive: true, onTap: () {}),
          SizedBox(height: _width / 64),
          CardPedido(
            status_pedido: "Finalizado",
          ),
          InfoCardSmall(
              title: 'Pedidos Concluidos',
              value: '10',
              isActive: true,
              onTap: () {}),
          SizedBox(height: _width / 64),
          InfoCardSmall(
              title: 'Esta sendo preparado',
              value: '10',
              isActive: true,
              onTap: () {}),
          SizedBox(height: _width / 64),
          InfoCardSmall(
              title: 'Pedidos Cancelados ',
              value: '10',
              isActive: true,
              onTap: () {}),
          SizedBox(height: _width / 64),
        ],
      ),
    );
  }
}
