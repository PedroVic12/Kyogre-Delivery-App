import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/controllers/Pedido/fila_delivery_controller.dart';
import 'package:kyogre_delivery_app/controllers/Pedido/pedido_controller.dart';
import 'package:kyogre_delivery_app/controllers/Pedido/pikachu_controller.dart';
import 'package:kyogre_delivery_app/widgets/CustomText.dart';

class CardPedido extends StatefulWidget {
  final String status_pedido;
  const CardPedido({Key? key, required this.status_pedido}) : super(key: key);

  @override
  State<CardPedido> createState() => _CardPedidoState();
}

class _CardPedidoState extends State<CardPedido> {
  late final FilaDeliveryController filaDeliveryController;
  late final PikachuController pikachu;
  late final PedidoController controller;

  @override
  void initState() {
    super.initState();
    filaDeliveryController = FilaDeliveryController();
    pikachu = PikachuController();
    controller = PedidoController(filaDeliveryController);
  }

  @override
  Widget build(BuildContext context) {
    final todosPedidos = filaDeliveryController.getTodosPedidos();

    if (todosPedidos.isEmpty) {
      return Center(
        child: Text('A fila está vazia'),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: todosPedidos.length,
        itemBuilder: (context, index) {
          final pedido = todosPedidos[index];
          pikachu.cout(pedido.carrinho);

          var currentIndex = controller.getStatusIndex(pedido.status);

          for (var item in pedido.carrinho) {
            print('${item.quantidade} - ${item.nome}');
          }

          return Dismissible(
            key: Key(pedido.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            onDismissed: (direction) {
              filaDeliveryController.removerPedido(
                  pedido.id); // Passar o id do pedido para remover
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Pedido concluído!")),
              );
            },
            child: Card(
              elevation: 20.0,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: CupertinoListTile(
                  title: CustomText(
                    text: 'Cliente: ${pedido.nome_cliente}',
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text:
                              "Status Cliente = ${pedido.status} - Index $currentIndex"),
                      Divider(color: Colors.black, indent: 2.0),
                      CustomText(text: 'Itens do Pedido:'),
                      SizedBox(height: 8),
                      for (var item in pedido.carrinho)
                        CustomText(
                          text: '${item.quantidade}x ${item.nome}',
                          color: CupertinoColors.systemRed,
                          weight: FontWeight.bold,
                          size: 15,
                        ),
                      SizedBox(height: 8),
                      CustomText(
                          text: 'Total a Pagar: R\$ ${pedido.totalPagar} Reais',
                          weight: FontWeight.bold),
                      CustomText(
                          text: 'Forma de pagamento: ${pedido.formaPagamento}'),
                      SizedBox(height: 8),
                      CustomText(
                          text: 'Endereço: ${pedido.endereco}',
                          weight: FontWeight.bold),
                      CustomText(text: 'Complemento: ${pedido.complemento}'),
                      Divider(color: Colors.black, indent: 2.0),
                      botaoDashBoard(pedido.status)
                    ],
                  ),
                  trailing: popUpConfig(pedido, context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget popUpConfig(pedido, context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                actions: [
                  CupertinoDialogAction(
                    child: const CustomText(
                      text: 'Fechar',
                      weight: FontWeight.bold,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
                title: CustomText(text: 'Configurações'),
                content: Container(
                  height: 100, // Defina uma altura fixa para o ListView
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Material(
                        color: Colors.grey.shade300,
                        child: ListTile(
                          focusColor: Colors.green,
                          leading: Icon(Icons.add),
                          title: Column(
                            children: [
                              Divider(),
                              Text(
                                index == 0 ? 'Cancelar Pedido' : 'Resetar',
                              ),
                            ],
                          ),
                          onTap: () {
                            if (index == 0) {
                              // Implementar cancelamento de pedido
                            } else if (index == 1) {
                              // Implementar reset de pedido
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          icon: Icon(Icons.settings),
        ),
        CustomText(
          text: "ID Pedido:\n${pedido.id}",
        ),
      ],
    );
  }

  Widget botaoDashBoard(String statusPedido) {
    String txtBtn = "";
    if (statusPedido == "Producao") {
      txtBtn = "Avançar Pedido!";
    } else if (statusPedido == "Entrega") {
      txtBtn = "Despachar Pedido";
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightGreenAccent,
      ),
      onPressed: () {
        // Implementar lógica do botão
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText(
            text: txtBtn,
            color: Colors.black,
            weight: FontWeight.bold,
          ),
          Icon(
            Icons.arrow_circle_right,
            size: 32,
          ),
        ],
      ),
    );
  }
}
