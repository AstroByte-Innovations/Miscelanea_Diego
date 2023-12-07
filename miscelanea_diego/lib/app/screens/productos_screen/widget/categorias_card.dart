import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';

class CategoriaCard {
  static Card categoriaEscoger(
      BuildContext context, List<Categoria> categorias) {
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Seleccione una categoria',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: categorias.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color:
                          GlobalWidgets.getColorFondo(categorias[index].color)
                              .color,
                      child: ListTile(
                        title: Text(categorias[index].nombre),
                        onTap: () {
                          Navigator.of(context).pop(categorias[index]);
                        },
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
