// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kyogre_delivery_app/app/utils/Fila.dart';
import 'package:kyogre_delivery_app/controllers/Pedido/pedido_controller.dart';

class FilaDeliveryController {
  final Fila FILA_PEDIDOS = Fila();
  final List<dynamic> PEDIDOS_ALERTA_ARRAY = [];
  final PedidoController controller =
      PedidoController(FilaDeliveryController());
  getFila() => FILA_PEDIDOS;
  getTodosPedidos() => FILA_PEDIDOS.todosPedidos();

  void carregarPedidos(List<dynamic> pedidosDoServidor) {
    try {
      print('Número de pedidos no Rayquaza: ${pedidosDoServidor.length}');
      _limparPedidosAntigos();
      _adicionarPedidosNaoExistenteNaFila(pedidosDoServidor);
      _mostrarAlertaSeNecessario();
    } catch (e) {
      print('Erro ao carregar pedidos: $e');
    }
  }

  void inserirPedido(Pedido pedido) {
    try {
      FILA_PEDIDOS.push(pedido);
      FILA_PEDIDOS.refresh();
      print(
          "Pedido inserido. Tamanho da fila agora: ${FILA_PEDIDOS.tamanhoFila()}");
    } catch (e) {
      print('Erro ao inserir pedido: $e');
    }
  }

  void _adicionarPedidoNaFila(dynamic pedido) {
    Pedido novoPedido = Pedido.fromJson(pedido);
    inserirPedido(novoPedido);
    print('\n\nPedido Aceito!');
  }

  Pedido? removerPedido(id) {
    try {
      return FILA_PEDIDOS.pop();
    } catch (e) {
      print('Erro ao remover pedido: $e');
      return null;
    }
  }

  //! UTILS
  Future<void> _mostrarAlerta(
      dynamic pedido, List<String> itensPedido, int pedidoId) async {
    controller.showAlert = true;

    // await Get.to(() => AlertaPedidoWidget(
    //       nomeCliente: pedido['nome_cliente'] ?? '',
    //       enderecoPedido: pedido['endereco'] ?? '',
    //       itensPedido: itensPedido,
    //       btnOkOnPress: () {
    //         _handlePedidoAceito(pedido, pedidoId);
    //       },
    //     ));
  }

  void _limparPedidosAntigos() {
    PEDIDOS_ALERTA_ARRAY.clear();
    print('Tamanho da Fila: ${FILA_PEDIDOS.tamanhoFila()}');
  }

  void _adicionarPedidosNaoExistenteNaFila(List<dynamic> pedidosDoServidor) {
    for (var pedidoJson in pedidosDoServidor) {
      print('Número de pedidos para alerta: ${PEDIDOS_ALERTA_ARRAY.length}');
      final pedido = Pedido.fromJson(pedidoJson);

      if (!_pedidoEstaNaFila(pedido)) {
        PEDIDOS_ALERTA_ARRAY.add(pedidoJson);
      }
    }
  }

  bool _pedidoEstaNaFila(Pedido pedido) {
    return FILA_PEDIDOS.contemPedidoComId(pedido.id);
  }

  void _mostrarAlertaSeNecessario() {
    if (_haPedidosParaAlerta() && !_alertaEstaAtivo()) {
      _exibirAlertaDePedido(PEDIDOS_ALERTA_ARRAY.removeAt(0));
    }
  }

  bool _haPedidosParaAlerta() {
    return PEDIDOS_ALERTA_ARRAY.isNotEmpty;
  }

  bool _alertaEstaAtivo() {
    return controller.showAlert;
  }

  void _exibirAlertaDePedido(dynamic pedido) {
    try {
      showNovoPedidoAlertDialog(pedido);
    } catch (e) {
      print('Erro ao exibir alerta de pedido: $e');
    }
  }

  Future<void> showNovoPedidoAlertDialog(dynamic pedido) async {
    final pedidoId = pedido['id'];

    if (!_alertaJaFoiMostrado(pedidoId)) {
      _configurarEExibirAlerta(pedido, pedidoId);
    }
  }

  bool _alertaJaFoiMostrado(int pedidoId) {
    return controller.pedidosAlertaMostrado.containsKey(pedidoId);
  }

  Future<void> _configurarEExibirAlerta(dynamic pedido, int pedidoId) async {
    final itensPedido = _obterItensDoPedido(pedido);

    print('Pedido ${pedidoId} não esta na Fila, mostrando o alerta...');
    print('isDashPage: ${_estaNaDashPage()}');
    print('SHOW ALERTA: ${controller.showAlert}');
    print(PEDIDOS_ALERTA_ARRAY);

    if (!_alertaEstaAtivo() && _estaNaDashPage()) {
      await _mostrarAlerta(pedido, itensPedido, pedidoId);
    }
  }

  List<String> _obterItensDoPedido(dynamic pedido) {
    return (pedido['carrinho'] as List<dynamic>)
        .map((item) => item['nome'] as String)
        .toList();
  }

  bool _estaNaDashPage() {
    return true;
    //return Get.currentRoute == '/dash';
  }

  void _handlePedidoAceito(dynamic pedido, int pedidoId) {
    _adicionarPedidoNaFila(pedido);
    //Get.back();
    _resetarConfiguracoesDeAlerta(pedidoId);
  }

  void _resetarConfiguracoesDeAlerta(int pedidoId) {
    Future.delayed(const Duration(milliseconds: 200), () {
      controller.showAlert = false;
      controller.pedidosAlertaMostrado[pedidoId] = true;
      _mostrarAlertaSeNecessario();
    });
  }
}
