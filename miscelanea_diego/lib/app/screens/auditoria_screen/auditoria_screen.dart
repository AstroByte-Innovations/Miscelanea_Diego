import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/auditoria_screen/auditoria_controller.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class AuditoriaScreen extends StatefulWidget {
  final Usuario usuarioGlobal;
  const AuditoriaScreen({super.key, required this.usuarioGlobal});

  @override
  State<AuditoriaScreen> createState() => _AuditoriaScreenState();
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  List<Auditoria> _auditorias = [];
  AuditoriasController controller = AuditoriasController();

  Future<void> _cargar() async {
    _auditorias = await controller.cargarAuditorias();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        background: Theme.of(context).colorScheme.primary,
        key: _sideMenuKey,
        menu: Menu.buildMenu(context, widget.usuarioGlobal),
        type: SideMenuType.slideNRotate,
        child: Scaffold(
            appBar: GlobalWidgets.appBar(_sideMenuKey, 'Auditoria'),
            body: PopScope(
              canPop: false,
              child: ListView.builder(
                  itemCount: _auditorias.length,
                  itemBuilder: (context, index) {
                    return AuditoriaView(
                      auditoria: _auditorias[index],
                    );
                  }),
              onPopInvoked: (bool didPop) {
                if (didPop) {
                  return;
                }
                _showBackDialog();
              },
            )));
  }

  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Desea salir?'),
          content: const Text(
            'Los cambios que no haya guardado se perderán.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Salir'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class AuditoriaView extends StatelessWidget {
  final Auditoria auditoria;
  const AuditoriaView({super.key, required this.auditoria});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: auditoria.accion == 'Creacion'
            ? Colors.green.shade200
            : auditoria.accion == 'Actualizacion'
                ? Colors.yellow.shade200
                : auditoria.accion == 'Eliminacion'
                    ? Colors.red.shade200
                    : Colors.white,
        leading: auditoria.accion == 'Creacion'
            ? const Icon(Icons.add)
            : auditoria.accion == 'Actualizacion'
                ? const Icon(Icons.edit)
                : auditoria.accion == 'Eliminacion'
                    ? const Icon(Icons.delete)
                    : Container(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${auditoria.accion} ${auditoria.tipoRegistro}'),
            Text(auditoria.registro),
            Text(
              auditoria.fecha.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
