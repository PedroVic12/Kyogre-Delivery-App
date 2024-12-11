import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagensFirebaseCardapio extends StatelessWidget {
  const ImagensFirebaseCardapio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagens do Cardápio'),
      ),
      body: FutureBuilder<List<String>>(
        future: _fetchImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar imagens: ${snapshot.error}'));
          } else {
            final images = snapshot.data;
            return ListView.builder(
              itemCount: images!.length,
              itemBuilder: (context, index) {
                return Image.network(images[index]);
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> _fetchImages() async {
    // Lógica para buscar imagens do Firebase Storage
    // Exemplo: retornar uma lista de URLs de imagens
    return [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
      // Adicione mais URLs conforme necessário
    ];
  }
}
