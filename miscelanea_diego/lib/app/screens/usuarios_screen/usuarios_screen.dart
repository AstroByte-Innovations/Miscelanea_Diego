import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/Widgets/usuario_edit.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/Widgets/usuario_form.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/Widgets/usuario_view.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/usuarios_controller.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class UsuariosScreen extends StatefulWidget {
  final Usuario usuario;
  const UsuariosScreen({super.key, required this.usuario});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final UsuariosController controller = UsuariosController();
  List<Usuario> _usuarios = [];

  Future<void> _cargar() async {
    _usuarios = await controller.cargarUsuarios();
    setState(() {});
  }

  @override
  void initState() {
    _cargar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        background: Theme.of(context).colorScheme.primary,
        key: _sideMenuKey,
        menu: Menu.buildMenu(context, widget.usuario),
        type: SideMenuType.slideNRotate,
        child: Scaffold(
          appBar: GlobalWidgets.appBar(_sideMenuKey, 'Usuarios'),
          body: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) {
              if (didPop) {
                return;
              }
              _showBackDialog();
            },
            child: Column(children: [
              const SearchBar(),
              Expanded(
                  child: ListView.builder(
                      itemCount: _usuarios.length,
                      itemBuilder: (context, index) {
                        return UsuarioView(
                            usuario: _usuarios[index],
                            onPress: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UsuarioEdit(
                                              user: _usuarios[index])))
                                  .then((value) {
                                if (value != null) {
                                  _cargar();
                                }
                              });
                            });
                      }))
            ]),
          ),
          floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) {
                  return const UsuarioForm();
                })).then((value) {
                  if (value != null) {
                    _cargar();
                  }
                });
              },
              child: const Icon(Icons.add)),
        ));
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
