import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/screens/login/Widgets/login_global.dart';
import 'package:miscelanea_diego/app/screens/login/Widgets/login_user.dart';
import 'package:miscelanea_diego/app/screens/login/login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController controller = LoginController();
  List<Usuario> _usuarios = [];

  Future<void> _cargar() async {
    _usuarios = await controller.obtenerUsuarios();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: MediaQuery.of(context).size.height / 6,
              child: const Center(
                child: Text(
                  'Bienvenido de vuelta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Seleccione un usuario para iniciar sesión.',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _usuarios.length,
                itemBuilder: (context, index) {
                  return _UserView(_usuarios[index]);
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const LoginGlobal();
                  }));
                },
                icon: const Icon(
                  Icons.keyboard,
                  size: 30,
                ))
          ],
        ));
  }
}

class _UserView extends StatelessWidget {
  final Usuario usuario;
  const _UserView(this.usuario);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: FilledButton.icon(
          style: const ButtonStyle(alignment: Alignment.bottomLeft),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginUser(usuario: usuario);
            }));
          },
          icon: const Icon(
            Icons.person,
            size: 30,
          ),
          label: Column(
            children: [
              Text(
                usuario.nombreUsuario,
                style: const TextStyle(fontSize: 20),
              ),
              Text('${usuario.nombre} ${usuario.apellidoPaterno}')
            ],
          )),
    );
  }
}
