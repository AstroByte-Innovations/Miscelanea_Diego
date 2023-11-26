import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/Widgets/usuario_form.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/Widgets/usuario_view.dart';
import 'package:miscelanea_diego/app/screens/usuarios_screen/usuarios_controller.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final UsuariosController controller = UsuariosController();
  List<Usuario> _usuarios = [];

  Future<void> _cargar() async {
    _usuarios = await controller.cargarUsuarios();
    print(_usuarios);
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
        menu: Menu.buildMenu(context),
        type: SideMenuType.slideNRotate,
        child: Scaffold(
          appBar: GlobalWidgets.appBar(_sideMenuKey, 'Usuarios'),
          body: Column(children: [
            const SearchBar(),
            Expanded(
                child: ListView.builder(
                    itemCount: _usuarios.length,
                    itemBuilder: (context, index) {
                      return UsuarioView(
                          usuario: _usuarios[index], onPress: () {});
                    }))
          ]),
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
}
