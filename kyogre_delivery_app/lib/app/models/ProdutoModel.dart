class ProdutoModel {
  final String nome;
  final String descricao;
  final List<String> adicionais;
  final String imagemUrl;
  final List<double> preco;

  ProdutoModel({
    required this.nome,
    required this.descricao,
    required this.adicionais,
    required this.imagemUrl,
    required this.preco,
  });

  // Converter o modelo para um mapa para o Firestore
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
      'adicionais': adicionais,
      'imagemUrl': imagemUrl,
      'preco': preco,
    };
  }

  // Criar o modelo a partir de um mapa do Firestore
  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      nome: map['nome'],
      descricao: map['descricao'],
      adicionais: List<String>.from(map['adicionais']),
      imagemUrl: map['imagemUrl'],
      preco: List<double>.from(map['preco']),
    );
  }
}
