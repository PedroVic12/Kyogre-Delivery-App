import 'package:flutter/material.dart';
import 'package:kyogre_delivery_app/database/storage_services.dart';

class DashboardTemplate extends StatelessWidget {
  const DashboardTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class GaleriaFotosCardapio extends StatefulWidget {
  const GaleriaFotosCardapio({super.key});

  @override
  State<GaleriaFotosCardapio> createState() => _GaleriaFotosCardapioState();
}

class _GaleriaFotosCardapioState extends State<GaleriaFotosCardapio> {
  final controllerFotos = FirebaseServices();
  @override
  void initState() {
    super.initState();
    controllerFotos.fetchImagens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Fotos do Cardápio'),
      ),
      body: const Placeholder(),
    );
  }
}
