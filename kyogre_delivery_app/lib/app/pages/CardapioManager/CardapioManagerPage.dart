import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/app/repository/cardapio_reposiotry.dart';
import 'package:kyogre_delivery_app/controllers/Navigator/CapitaoNavigator.dart';
import 'package:kyogre_delivery_app/controllers/cardapio/cardapio_diolog_cadatro.dart';
import 'package:kyogre_delivery_app/controllers/cardapio_manager_controller.dart';
import 'package:kyogre_delivery_app/database/storage_services.dart';
import 'package:kyogre_delivery_app/widgets/CarrousselWidget.dart';
import 'package:kyogre_delivery_app/widgets/CustomText.dart';

class CardapioManagerPage extends StatelessWidget {
  final manager = CardapioManager();
  final repository = CardapioRepository();

  final navigator = NavigationManager();

  CardapioManagerPage({super.key});

  // separar o collection e categoria
  // cada produto com adicional ser tratado diferente

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CARDAPIO DIGITAL DE {RUBY} 2'),
      ),
      body: ListView(
        children: [
          TextButton(onPressed: () {}, child: const Text("Procurar Produto")),
          TextButton(
              onPressed: () {
                NavigationManager.navigateToPage(context,
                    ImagensFirebaseCardapio()); // Navegar para a página inicial
              },
              child: const CustomText(
                text: "Galeria produtos",
                color: Colors.red,
              )),
          Container(
            height: 500, // Defina a altura da lista horizontal
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Lista na direção horizontal
              itemCount: repository.categoriasCardapio.length,
              itemBuilder: (context, index) {
                var produtoCardapio = repository.arrayProdutos[index];
                var categoriasCardapio = repository.categoriasCardapio[index];
                return Container(
                  width: 250, // Largura de cada contêiner
                  margin: const EdgeInsets.all(
                      12), // Espaçamento ao redor de cada contêiner
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? Colors.blue
                        : Colors.green, // Cores alternadas para os contêineres
                    borderRadius:
                        BorderRadius.circular(10), // Borda arredondada
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      botoesSuperior(context, categoriasCardapio),
                      cardProduct(produtoCardapio),
                    ],
                  ),
                );
              },
            ),
          ),
          //showImagensCardapio()
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            manager.criarCategoria();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CadastroDialog(produto: "produto");
              },
            );
          },
          tooltip: 'Criar Categoria',
          child: const Text('Criar Categoria')), //
    );
  }

  Widget cardProduct(
    produtoCardapio,
  ) {
    //Future<List<String>> categoriasMongoDB =
    //  mongoServiceDB.getCategorias("cardapio-ruby");

    //print(categoriasMongoDB);

    bool categoriaExiste = true;

    // Se a categoria existir, exibir o card do produto; caso contrário, retornar um container vazio
    return categoriaExiste
        ? Card(
            elevation: 5, // Elevação do card
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(child: Placeholder()),
                title: Text(
                  '${produtoCardapio["NOME"]}',
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("R\$ ${produtoCardapio["PRECO"].toString()} reais"),
                  ],
                ),
                trailing: CircleAvatar(
                  child: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "Editar",
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.edit),
                                ),
                                Text("Editar Produto"),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: "Deletar",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.delete_forever_rounded),
                            ),
                            Text("Deletar Produto"),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (String newValue) {},
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  Widget botoesSuperior(BuildContext context, produto) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withBlue(10),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              print("Deletar Categoria");
              manager.showAlertDialog(context, produto);
            },
            child: const Icon(
              CupertinoIcons.minus_circle_fill,
              color: Colors.white,
              size: 24,
            ),
          ),
          CustomText(
            text: produto,
            color: Colors.white,
            size: 18,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CadastroDialog(produto: produto);
                },
              );
            },
            child: const Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}

class ImagensFirebaseCardapio extends StatefulWidget {
  const ImagensFirebaseCardapio({super.key});

  @override
  State<ImagensFirebaseCardapio> createState() =>
      _ImagensFirebaseCardapioState();
}

class _ImagensFirebaseCardapioState extends State<ImagensFirebaseCardapio> {
  final controller = FirebaseServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchImagens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Produtos'),
      ),
      body: ListView.builder(
        itemCount: controller.imagensUrls.length,
        itemBuilder: (context, index) {
          final String urlImg = controller.imagensUrls[index];

          return Image.network(urlImg);
          // return ListTile(
          //   title: Text(controller.imagensUrls[index]),
          //   trailing: IconButton(
          //     icon: const Icon(Icons.delete),
          //     onPressed: () {
          //       controller.deleteImagem(controller.imagensUrls[index]);
          //       setState(() {});
          //     },
          //   ),
          // );
        },
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.uploadImage();
          },
          tooltip: 'Upload Imagem',
          child: const Text('Upload Imagem')), //
    );
  }
}
