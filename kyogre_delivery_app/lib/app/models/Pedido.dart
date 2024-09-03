class Pedido {
  final int id;
  final String nome_cliente;
  final String telefone;
  final String endereco;
  final String complemento;
  final String formaPagamento;
  String status;
  final List<ItemPedido> carrinho;
  final double totalPagar;

  Pedido({
    required this.id,
    required this.nome_cliente,
    required this.telefone,
    required this.endereco,
    required this.complemento,
    required this.formaPagamento,
    required this.status,
    required this.carrinho,
    required this.totalPagar,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    var listaCarrinho = json['carrinho'] as List;
    List<ItemPedido> carrinhoLista =
        listaCarrinho.map((i) => ItemPedido.fromJson(i)).toList();

    return Pedido(
      id: json['id'] as int,
      nome_cliente: json['nome_cliente'] as String,
      telefone: json['telefone'] as String,
      endereco: json['endereco'] as String,
      complemento: json['complemento'] as String,
      formaPagamento: json['forma_pagamento'] as String,
      status: json['status'] as String,
      carrinho: carrinhoLista,
      totalPagar: (json['total_pagar'] as num).toDouble(),
    );
  }
}

class ItemPedido {
  final int quantidade;
  final String nome;
  final double preco;

  ItemPedido({
    required this.quantidade,
    required this.nome,
    required this.preco,
  });

  factory ItemPedido.fromJson(Map<String, dynamic> json) {
    return ItemPedido(
      quantidade: json['quantidade'] as int,
      nome: json['nome'] as String,
      preco: (json['preco'] as num).toDouble(),
    );
  }
}
